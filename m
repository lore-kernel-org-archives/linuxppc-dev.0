Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmT568MyzDvjM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmT43xKJz9tB1
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:20 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwsLo017838
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:18 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nehfynkg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:18 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 00/11] Enable VAS
Date: Fri, 11 Nov 2016 09:02:45 -0800
Message-Id: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power9 introduces a hardware subsystem referred to as the Virtual
Accelerator Switchboard (VAS). VAS allows kernel subsystems and user
space processes to directly access the Nest Accelerator (NX) engines
which implement compression and encryption algorithms in the hardware.

NX has been in Power processors since Power7+, but access to the NX
engines was through the 'icswx' instruction which is only available
to the kernel/hypervisor. Starting with Power9, access to the NX
engines is provided to both kernel and user space processes through
VAS.

The switchboard (i.e VAS) multiplexes accesses between "receivers" and
"senders", where the "receivers" are typically the NX engines and
"senders" are the kernel subsystems and user processors that wish to
access the receivers (NX engines).  Once a sender is "connected" to
a receiver through the switchboard, the sender submit compression/
encryption requests to the hardware using the new (PowerISA 3.0)
"copy" and "paste" instructions.

In the initial OPAL and PowerNV kernel patchsets, the "senders" can
only be kernel subsystems (eg NX-842 driver). A follow-on patch set 
will allow senders to be user-space processes.

This kernel patch set configures the VAS subsystems and provides
kernel interfaces to drivers like NX-842 to open receive and send
windows in VAS and to submit requests to the NX engine.

This is an RFC patch set that has been tested in a Simics Power9
environment using a modified NX-842 kernel driver and a compression
self-test module from Power8. The corresponding OPAL patchset for
VAS support was posted to skiboot mailing list:

	https://lists.ozlabs.org/pipermail/skiboot/2016-November/005446.html
	
OPAL and kernel patchsets for NX-842 driver will be posted separately.
All four patchsets are needed to effectively use VAS/NX in Power9.

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman
and Haren Myneni.

Sukadev Bhattiprolu (11):
  VAS: Define macros and register fields
  VAS: Define vas_dev_init() and vas_dev_exit()
  VAS: Define helpers for access MMIO regions
  VAS: Define helpers to init window context
  VAS: Define helpers to alloc/free windows
  VAS: Define vas_rx_win_open() and vas_window_close()
  VAS: Define vas_tx_win_open()
  VAS: Define vas_copy_crb() and vas_paste_crb()
  VAS: Define/use vas_print_regs()
  VAS: Create a thread to monitor fault-window
  VAS: Define/use interface to setup irq handling.

 MAINTAINERS                                    |    6 +
 arch/powerpc/include/asm/opal-api.h            |    4 +-
 arch/powerpc/include/asm/opal.h                |    3 +
 arch/powerpc/include/asm/vas.h                 |  139 +++
 arch/powerpc/kernel/process.c                  |    3 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +
 drivers/misc/Kconfig                           |    1 +
 drivers/misc/Makefile                          |    1 +
 drivers/misc/vas/Kconfig                       |   19 +
 drivers/misc/vas/Makefile                      |    3 +
 drivers/misc/vas/copy-paste.h                  |   78 ++
 drivers/misc/vas/vas-internal.h                |  451 ++++++++++
 drivers/misc/vas/vas-window.c                  | 1103 ++++++++++++++++++++++++
 drivers/misc/vas/vas.c                         |  306 +++++++
 14 files changed, 2119 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 drivers/misc/vas/Kconfig
 create mode 100644 drivers/misc/vas/Makefile
 create mode 100644 drivers/misc/vas/copy-paste.h
 create mode 100644 drivers/misc/vas/vas-internal.h
 create mode 100644 drivers/misc/vas/vas-window.c
 create mode 100644 drivers/misc/vas/vas.c

-- 
1.8.3.1
