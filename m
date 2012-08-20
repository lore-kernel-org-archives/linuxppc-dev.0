Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F68A2C0388
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 23:49:47 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 20 Aug 2012 09:49:44 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 96EED38C806E
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:26 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7KDnQiY066294
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KDnPsn031061
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:26 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V4 0/8] Rework on PowerNV P7IOC initialization 
Date: Mon, 20 Aug 2012 21:49:13 +0800
Message-Id: <1345470561-17785-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rework is done based on Ben's initial ideas on how PE and resource
assignment is done on top of PCI core instead of doing resource assignment
by powernv platform. With the series of patches, the following aspects will
be covered:

	- Only create PE based on PCI bus. Basically, there will be 2 types
	  of PEs built on PCI bus: (A) PE only includes single PCI bus. (B)
	  PE includes the PCI bus as well as its subordinate PCI buses.
	- Make the I/O and MMIO resources of P2P bridge aligned according to
	  the PHB's resource layout. For example, MMIO resource of P2P bridges
	  will be aligned with 16MB if PHB has 16MB M32 segment.
	- The resource allocation will be done on basis of PE.
	- Trivial fixup on the hook of enabling PCI device, PE check etc.

The series of patches has been verified on Firebird-L based on kernel 3.6.RC2. During
the kernel boots, USB HUBs can be detected and initialized correctly. Also, the disk
drive as well as network interfaces can work successfully after booting into shell
environment.

V1 -> V2
	- Add separate field into "struct pci_host_bridge" to trace the minimal
	  alignment of prefetchable MMIO bars for P2P bridges (Benjamin Herrenschmidt)
	- Reduced variable names while measuring the MMIO bars (Benjamin Herrenschmidt)
	- Change the commit log for more clear description on [PATCH 2/8] (Benjamin Herrenschmidt)
	- Change the commit log for more clear description on the types of PCI bus
	  sensitive PEs on [PATCH 5/8] (Richard Yang)

V2 -> V3
	- Rework the sequence of the patches so that it won't break "git bitsect" (Benjamin Herrenschmidt)
	- Cleanup on variables name so that they have shorter length (Benjamin Herrenschmidt)
	- Rework on PE's resource calculation based on the PCI bus (Benjamin Herrenschmidt)
	- Cleanup on changelog (Benjamin Herrenschmidt)

V3 -> V4
	- Rebase to 3.6.RC2
	- The series of patches has been reworked to comply with the generic part
	  "[PATCH v8 0/8] Minimal alignment for p2p bars"	
	- Remove the duplicate assignment for PE number (Richard Yang)

-----

arch/powerpc/platforms/powernv/pci-ioda.c |  694 ++++++++---------------------
arch/powerpc/platforms/powernv/pci.h      |   21 +-
2 files changed, 195 insertions(+), 520 deletions(-)

Thanks,
Gavin
