Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A14BBB6FB6
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 02:04:16 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 12:04:14 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9DDF438C9C72
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:40 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFhdKa106036
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhUKP032638
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 12:43:30 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V3 0/8] ppc/pnv: Rework on pnv P7IOC initialization 
Date: Mon, 25 Jun 2012 23:43:13 +0800
Message-Id: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
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

The series of patches has been verified on Firebird-L and Juno-IOC-L based on
kernel 3.4.RC6. During the kernel boots, USB HUBs can be detected and initialized
correctly. Also, the disk drive as well as network interfaces can work successfully
after booting into shell environment.

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
	

arch/powerpc/platforms/powernv/pci-ioda.c |  708 ++++++++---------------------
arch/powerpc/platforms/powernv/pci.h      |   21 +-
2 files changed, 213 insertions(+), 516 deletions(-)

Thanks,
Gavin
