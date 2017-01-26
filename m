Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v84M50BgYzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 12:38:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v84M43QrTz9t8j
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2017 12:38:40 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q1cckg122982
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286xbrvw86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:38 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 18:38:37 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v2 00/10] Enable VAS
Date: Wed, 25 Jan 2017 17:37:58 -0800
Message-Id: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

This patch set that has been tested in a Simics Power9 environment using
a modified NX-842 kernel driver and a compression self-test module from
Power8. The corresponding OPAL patchset for VAS support was posted to
skiboot mailing list:

	https://lists.ozlabs.org/pipermail/skiboot/2017-January/006193.html
	
OPAL and kernel patchsets for NX-842 driver will be posted separately.
All four patchsets are needed to effectively use VAS/NX in Power9.

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman
and Haren Myneni.

Changelog[v2]
	- Use vas-id, HVWC, UWC and paste address, entries from device tree
	  rather than defining/computing them in kernel and reorg code.

Sukadev Bhattiprolu (10):
  VAS: Define macros, register fields and structures
  Move GET_FIELD/SET_FIELD to vas.h
  VAS: Define vas_init() and vas_exit()
  VAS: Define helpers for access MMIO regions
  VAS: Define helpers to init window context
  VAS: Define helpers to alloc/free windows
  VAS: Define vas_rx_win_open() interface
  VAS: Define vas_win_close() interface
  VAS: Define vas_tx_win_open()
  VAS: Define copy/paste interfaces

 MAINTAINERS                        |   6 +
 arch/powerpc/include/asm/reg.h     |   1 +
 arch/powerpc/include/asm/vas.h     | 141 ++++++
 drivers/crypto/nx/nx-842-powernv.c |   1 +
 drivers/crypto/nx/nx-842.h         |   5 -
 drivers/misc/Kconfig               |   1 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/vas/Kconfig           |  20 +
 drivers/misc/vas/Makefile          |   3 +
 drivers/misc/vas/copy-paste.h      |  74 +++
 drivers/misc/vas/vas-internal.h    | 467 ++++++++++++++++++
 drivers/misc/vas/vas-window.c      | 950 +++++++++++++++++++++++++++++++++++++
 drivers/misc/vas/vas.c             | 156 ++++++
 13 files changed, 1821 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 drivers/misc/vas/Kconfig
 create mode 100644 drivers/misc/vas/Makefile
 create mode 100644 drivers/misc/vas/copy-paste.h
 create mode 100644 drivers/misc/vas/vas-internal.h
 create mode 100644 drivers/misc/vas/vas-window.c
 create mode 100644 drivers/misc/vas/vas.c

-- 
2.7.4
