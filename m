Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B80F81007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 12:41:34 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP1lHno005838
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:47:17 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP1fVD51630432
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:41:31 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAP1fUib019411
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 20:41:30 -0500
Message-ID: <4B0C8B45.6080804@austin.ibm.com>
Date: Tue, 24 Nov 2009 19:41:25 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, lkml@vger.kernel.org
Subject: [PATCH 0/3] Kernel handling of Dynamic Logical Partitioning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
platform allows for the addition and removal of resources (i.e. cpus,
memory, pci devices) from a partition. The removal of a resource involves
removing the resource's node from the device tree and then returning the
resource to firmware via the rtas set-indicator call.  To add a resource, it
is first obtained from firmware via the rtas set-indicator call and then a
new device tree node is created using the ibm,configure-coinnector rtas call
and added to the device tree.

The following set of patches implements the needed infrastructure to have the
kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items 
to follow in future patches).  The framework for this is to create a set of 
probe/release sysfs files that will facilitate arch-specific call-outs to 
handle addition and removal of cpus to the system.

-Nathan Fontenot

1/3 - powerpc/pseries kernel DLPAR infrastructure
2/3 - Create probe/release sysfs files and the powerpc handlers
3/3 - powerpc/pseries CPU DLPAR handling

 arch/powerpc/Kconfig                        |    4 
 arch/powerpc/include/asm/machdep.h          |    5 
 arch/powerpc/include/asm/pSeries_reconfig.h |    1 
 arch/powerpc/kernel/sysfs.c                 |   19 +
 arch/powerpc/platforms/pseries/Makefile     |    2 
 arch/powerpc/platforms/pseries/dlpar.c      |  412 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/reconfig.c   |    2 
 drivers/base/cpu.c                          |   32 ++
 include/linux/cpu.h                         |    4 
 9 files changed, 479 insertions(+), 2 deletions(-)
