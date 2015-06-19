Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7B9D1A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 12:27:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C70A42BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J2R6t047775832
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J2QiYU025938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:26:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] powerpc/powernv: Fix PE number for PF
Date: Fri, 19 Jun 2015 12:26:15 +1000
Message-Id: <1434680779-20194-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_PCI_IOV is enabled in kernel configuration, the logic reserving
PEs according to consumed M64 segments in bridge's M64 window won't work
properly. The bridge's M64 window contains VF BARs, which are M64 BARs.
Current code could reserve and pick PE number according to M64 segments
accomodating VF BARs. The patches fix the issue by reserving and picking
PE numbers based on BARs (exclude VF BARs) of PCI devices, instead of
bridge's M64 window.

The code is picked from the patchset "powerpc/powernv: PCI hotplug support",
I'm working on. With the patch applied, the PE number assigned to PF is
correct:

[root@powerio-le11 ~]# lspci -vvs 0005:01:00.0
0005:01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
	Subsystem: IBM Device 04e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 510
	Region 0: Memory at 3ff200000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at 3d4400000000 (64-bit, prefetchable) [size=32M]
	:

[root@powerio-le11 /]# cat /sys/bus/pci/devices/0005:01:00.0/eeh_pe_config_addr
0x40


Gavin Shan (4):
  powerpc/powernv: Allow to reserve one PE for multiple times
  powerpc/powernv: Reserve M64 PEs based on BARs
  powerpc/powernv: Boolean argument for pnv_ioda_setup_bus_PE()
  powerpc/powernv: Pick M64 PEs based on BARs

 arch/powerpc/platforms/powernv/pci-ioda.c | 127 +++++++++++-------------------
 arch/powerpc/platforms/powernv/pci.h      |   5 +-
 2 files changed, 51 insertions(+), 81 deletions(-)

-- 
2.1.0
