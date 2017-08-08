Return-Path: <srs0=ev05=7k=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRqmN1RmgzDqkQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xRqmN0lzgz8t6s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xRqmM49Ycz9s71
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 09:07:15 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78N4DDi111394
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2017 19:07:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c7kkg8b0w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Aug 2017 19:07:13 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 19:07:12 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 00/17] powerpc/vas: Enable VAS
Date: Tue,  8 Aug 2017 16:06:45 -0700
Message-Id: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 introduces a hardware subsystem referred to as the Virtual
Accelerator Switchboard (VAS). VAS allows kernel subsystems and user
space processes to directly access the Nest Accelerator (NX) engines
which implement compression and encryption algorithms in the hardware.

NX has been in Power processors since Power7+, but access to the NX
engines was through the 'icswx' instruction which is only available
to the kernel/hypervisor. Starting with POWER9, access to the NX
engines is provided to both kernel and user space processes through
VAS.

The switchboard (i.e VAS) multiplexes accesses between "receivers" and
"senders", where the "receivers" are typically the NX engines and the
"senders" are the kernel subsystems and user processors that wish to
access the receivers (NX engines).  Once a sender is "connected" to
a receiver through the switchboard, the senders can submit compression/
encryption requests to the hardware using the new (PowerISA 3.0)
"copy" and "paste" instructions.

Senders can also send "empty" messages to the receiver. If the receiver
is executing a WAIT instruction, this empty message serves to have the
receiver resume from the next instruction. (i.e acts as "wake up" message).
This usage of VAS is referred to as "Fast thread-wakeup".

Provides:

	This patch set:
		- configures the VAS subsystems in the hardware

		- provides kernel interfaces to drivers like NX-842 and
		  NX-FTW (new) to open receive and send/receive windows
		  and to submit copy/paste (i.e compression) requests to
		  the NX engines.

		- implements an NX-FTW driver for the fast thread-wake up
		  mechanism.  It provides the /dev/crypto/nx-ftw device node,
		  and ioctls to allow users to use the FTW mechanism in VAS.

	Follow-on patch set(s) will allow user space processes to submit
	requests to the NX-GZIP engine (and possibly other engines).

Requires:

	This patch set needs corresponding VAS/NX skiboot patches which
	were merged into skiboot tree. i.e skiboot must include:

	commit 3b3c596 (NX: Add P9 NX support for 842 compression engine)

Testing:

	In-kernel compression requests were tested on DD1 POWER9 hardware
	using the following NX-842 patch set from Haren Myneni:
		
	https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-July/160620.html

	The ability to setup user space send/receive windows for FTW was
	tested on DD1 hardware. The actual copy/paste of the empty messages
	is not yet supported in hardware and that functionality was tested
	on DD2 simics software.

Git Tree:

	https://github.com/sukadev/linux/ 	

	Branch: vas-kern-v6

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman,
Robert Blackmore and Haren Myneni.

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

Sukadev Bhattiprolu (17):
  powerpc/vas: Define macros, register fields and structures
  Move GET_FIELD/SET_FIELD to vas.h
  powerpc/vas: Define vas_init() and vas_exit()
  powerpc/vas: Define helpers to access MMIO regions
  powerpc/vas: Define helpers to init window context
  powerpc/vas: Define helpers to alloc/free windows
  powerpc/vas: Define vas_win_paste_addr()
  powerpc/vas: Define vas_win_id()
  powerpc/vas: Define vas_rx_win_open() interface
  powerpc/vas: Define vas_rx_win_open() interface
  powerpc/vas: Define vas_win_close() interface
  powerpc/vas: Define vas_tx_win_open()
  powerpc/vas: Define copy/paste interfaces
  powerpc: Add support for setting SPRN_TIDR
  powerpc/vas: Define window open ioctls API
  powerpc/vas: Implement a simple FTW driver
  VAS: Document FTW API/usage

 .../devicetree/bindings/powerpc/ibm,vas.txt        |   24 +
 Documentation/powerpc/ftw-api.txt                  |  373 ++++++
 MAINTAINERS                                        |   20 +
 arch/powerpc/include/asm/processor.h               |    4 +
 arch/powerpc/include/asm/vas.h                     |  156 +++
 arch/powerpc/include/uapi/asm/vas.h                |   63 +
 arch/powerpc/kernel/process.c                      |   74 ++
 arch/powerpc/platforms/powernv/Kconfig             |   30 +
 arch/powerpc/platforms/powernv/Makefile            |    2 +
 arch/powerpc/platforms/powernv/copy-paste.h        |   74 ++
 arch/powerpc/platforms/powernv/nx-ftw.c            |  486 ++++++++
 arch/powerpc/platforms/powernv/vas-window.c        | 1233 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.c               |  183 +++
 arch/powerpc/platforms/powernv/vas.h               |  500 ++++++++
 drivers/crypto/nx/nx-842-powernv.c                 |    7 +-
 drivers/crypto/nx/nx-842.h                         |    5 -
 16 files changed, 3226 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,vas.txt
 create mode 100644 Documentation/powerpc/ftw-api.txt
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 arch/powerpc/include/uapi/asm/vas.h
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h
 create mode 100644 arch/powerpc/platforms/powernv/nx-ftw.c
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.h

-- 
2.7.4
