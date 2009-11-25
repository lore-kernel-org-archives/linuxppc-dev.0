Return-Path: <nfont@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8110AB6F15
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:05:00 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP6wWJJ022080
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 23:58:32 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP74raC163654
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:04:53 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAP74qaj013860
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:04:53 -0700
Message-ID: <4B0CD70F.6090600@austin.ibm.com>
Date: Wed, 25 Nov 2009 01:04:47 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Kernel handling of Dynamic Logical Partitioning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: gregkh@suse.de, paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

version 2 of the patch set with updates from comments.

The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
platform allows for the addition and removal of resources (i.e. cpus,
memory, pci devices) from a partition. The removal of a resource involves
removing the resource's node from the device tree and then returning the
resource to firmware via the rtas set-indicator call.  To add a resource, it
is first obtained from firmware via the rtas set-indicator call and then a
new device tree node is created using the ibm,configure-coinnector rtas call
and added to the device tree.

The following set of patches implements the needed infrastructure to have the
kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items to 
follow in future patches).  The framework for this is to create a set of probe/release 
sysfs files that will facilitate arch-specific call-outs to handle addition and 
removal of cpus to the system.

-Nathan Fontenot

1/3 - powerpc/pseries kernel DLPAR infrastructure
2/3 - Create probe/release sysfs files and the powerpc handlers
3/3 - powerpc/pseries CPU DLPAR handling 

 arch/powerpc/Kconfig                        |    4 
 arch/powerpc/include/asm/machdep.h          |    5 
 arch/powerpc/include/asm/pSeries_reconfig.h |    1 
 arch/powerpc/kernel/smp.c                   |   17 
 arch/powerpc/kernel/sysfs.c                 |   19 +
 arch/powerpc/platforms/pseries/Makefile     |    2 
 arch/powerpc/platforms/pseries/dlpar.c      |  500 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/reconfig.c   |    2 
 drivers/base/cpu.c                          |   33 +
 include/linux/cpu.h                         |    4
 10 files changed, 581 insertions(+), 6 deletions(-)
