Return-Path: <srs0=lfg8=3i=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvV681YjGzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvV680zG1z8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:08 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvV674J5nz9s2s
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 16:14:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V5Dp8c059766
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29h4cppkq4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:04 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 23:14:04 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/11] Enable VAS
Date: Thu, 30 Mar 2017 22:13:33 -0700
Message-Id: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
a receiver through the switchboard, the senders can submit compression/
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

Changelog[v4]
	Comments from Michael Neuling:
	- Move VAS code from drivers/misc/vas to arch/powerpc/platforms/powernv
	  since VAS only provides interfaces to other drivers like NX-842.
	- Drop vas-internal.h and use vas.h in separate dirs for VAS
	  internal, kernel API and user API
	- Rather than create 6 separate device tree properties windows
	  and window context, combine them into 6 "reg" properties.
	- Drop vas_window_reset() since windows are reset/cleared before
	  being assigned to kernel/users.
	- Use ilog2() and radix_enabled() helpers

Changelog[v3]
	- Rebase to v4.11-rc1
	- Add interfaces to initialize send/receive window attributes to
	  defaults that drivers can use (see arch/powerpc/include/asm/vas.h)
	- Modify interface vas_paste() to return 0 or error code
	- Fix a bug in setting Translation Control Mode (0b11 not 0x11)
	- Enable send-window-credit checking 
	- Reorg code  in vas_win_close()
	- Minor reorgs and tweaks to register field settings to make it
	  easier to add support for user space windows.
	- Skip writing to read-only registers
	- Start window indexing from 0 rather than 1

Changelog[v2]
	- Use vas-id, HVWC, UWC and paste address, entries from device tree
	  rather than defining/computing them in kernel and reorg code.

Sukadev Bhattiprolu (11):
  Add Power9 PVR
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

 arch/powerpc/include/asm/reg.h              |    1 +
 arch/powerpc/include/asm/vas.h              |  141 ++++
 arch/powerpc/include/uapi/asm/vas.h         |   33 +
 arch/powerpc/platforms/powernv/Kconfig      |   14 +
 arch/powerpc/platforms/powernv/Makefile     |    1 +
 arch/powerpc/platforms/powernv/copy-paste.h |   74 ++
 arch/powerpc/platforms/powernv/vas-window.c | 1003 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.c        |  145 ++++
 arch/powerpc/platforms/powernv/vas.h        |  470 +++++++++++++
 drivers/crypto/nx/nx-842-powernv.c          |    7 +-
 drivers/crypto/nx/nx-842.h                  |    5 -
 11 files changed, 1886 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 arch/powerpc/include/uapi/asm/vas.h
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.h

-- 
2.7.4
