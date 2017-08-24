Return-Path: <srs0=xwhe=72=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdF3y4xw8zDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:22 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xdF3y3fGCz8t37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xdF3y02Qhz9t3D
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 16:38:21 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O6ZVWR137018
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:19 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chqf6b60x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:18 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 02:38:18 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 00/12] Enable VAS
Date: Wed, 23 Aug 2017 23:37:56 -0700
Message-Id: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
only be kernel subsystems (eg NX-842 driver) and receivers can only
be the NX-842 engine. Follow-on patch sets will allow senders/receivers
to be user-space processes and receivers to be NX-GZIP engines.

Provides:

	This kernel patch set configures the VAS subsystems and provides
	kernel interfaces to drivers like NX-842 to open receive and send
	windows in VAS and to submit compression requests to the NX engine.

Requires:

	This patch set needs corresponding VAS/NX skiboot patches which
	were merged into skiboot tree. i.e skiboot must include:
	commit b503dcf ("vas: Set mmio enable bits in DD2")

Tests:
        In-kernel compression requests were tested on DD1 and DD2 POWER9
	hardware using compression self-test module and the following
	NX-842 patch set from Haren Myneni:

        https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-July/160620.html

Git Tree:

        https://github.com/sukadev/linux/ 
	Branch: vas-kern-v7

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman
and Haren Myneni.

Changelog[v7]:
	- Drop support for user space send/receive FTW windows (will be
	  posted separately) Simplifies the rx-win-open interface a bit.
	- [Michael Ellerman] Move GET_FIELD/SET_FIELD macros from 
	  uapi/asm/vas.h to asm/vas.h.

Changelog[v6]
	- Add support for user space send/receive FTW windows
	- Add a new, NX-FTW driver which provides the FTW user interface

Changelog[v5]
	- [Ben Herrenschmidt] Make VAS a platform device in the device tree
	  and use the core platform functions to parse the VAS properties.
	  Map the VAS MMIO regions as non-cachable and paste regions as
	  cachable. Use CONFIG_PPC_VAS rather than CONFIG_VAS; Don't assume
	  VAS ids are sequential.
	- Copy the FIFO address as is into LFIFO_BAR (don't shift it).

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


Sukadev Bhattiprolu (12):
  powerpc/vas: Define macros, register fields and structures
  Move GET_FIELD/SET_FIELD to vas.h
  powerpc/vas: Define vas_init() and vas_exit()
  powerpc/vas: Define helpers to access MMIO regions
  powerpc/vas: Define helpers to init window context
  powerpc/vas: Define helpers to alloc/free windows
  powerpc/vas: Define vas_win_paste_addr()
  powerpc/vas: Define vas_win_id()
  powerpc/vas: Define vas_rx_win_open() interface
  powerpc/vas: Define vas_win_close() interface
  powerpc/vas: Define vas_tx_win_open()
  powerpc/vas: Define copy/paste interfaces

 .../devicetree/bindings/powerpc/ibm,vas.txt        |   24 +
 MAINTAINERS                                        |    9 +
 arch/powerpc/include/asm/vas.h                     |  174 +++
 arch/powerpc/platforms/powernv/Kconfig             |   14 +
 arch/powerpc/platforms/powernv/Makefile            |    1 +
 arch/powerpc/platforms/powernv/copy-paste.h        |   74 ++
 arch/powerpc/platforms/powernv/vas-window.c        | 1189 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.c               |  183 +++
 arch/powerpc/platforms/powernv/vas.h               |  500 ++++++++
 drivers/crypto/nx/nx-842-powernv.c                 |    7 +-
 drivers/crypto/nx/nx-842.h                         |    5 -
 11 files changed, 2172 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,vas.txt
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.h

-- 
2.7.4
