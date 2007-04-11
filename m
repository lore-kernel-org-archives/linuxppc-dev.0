Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBD3CDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:29:57 +1000 (EST)
Date: Wed, 11 Apr 2007 03:29:21 -0500 (CDT)
Subject: [PATCH HACK kexec-tools-testing] malloc corruption hack
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: <fastboot@lists.osdl.org>, Sachin Sant <sachinp@in.ibm.com>
Message-Id: <boot-4-kexec-01.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Goyal <vgoyal@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On a system with rtas, a hash table, no pci, and one memory node I
got the following error:

*** glibc detected *** double free or corruption (out): 0x0000000010115800 ***
kexec-reboot: line 9:  2366 Aborted                 \
  ./kexec --mem-max=0x20000000 -l /root/vmlinux --devicetreeblob=dtall.dtb


The problem is count_memory_ranges doesn't count what get_devtree_details
will be adding to the exlcude list.

This is a very gross hack to get around the problem, I post it so others
might benifit until the real problem is fixed.

However, I would also like to point out that the code is deficent, as it
is only looking for the properties in specific directories.  It should
be looking in all directories for the properties, like the reserve code
building the device tree.   TCE (iommu) tables can be attached to any
pci bus.  Also, it allows other ranges to be reserved by just changing
the device tree, instead of adding new searches to kexec-tools.

--- 
Thanks to Sonny for getting a debug envrionment laoded to debug this failure.

--- kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c.orig	2007-04-10 22:29:59.000000000 -0500
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c	2007-04-10 22:30:21.000000000 -0500
@@ -124,6 +124,8 @@ static int count_memory_ranges()
 	}
 	closedir(dir);
 
+	max_memory_ranges += 5;	/* base exclude ranges - kernel, rtas, etc */
+
 	return 0;
 }
 
