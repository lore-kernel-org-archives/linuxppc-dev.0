Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33F9DDDF10
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 09:42:25 +1000 (EST)
Subject: patch powerpc-fix-size-check-for-hugetlbfs.patch queued to -stable
	tree
To: benh@kernel.crashing.org, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, paulus@samba.org
From: <gregkh@suse.de>
Date: Mon, 13 Aug 2007 16:26:27 -0700
In-Reply-To: <1186551855.938.164.camel@localhost.localdomain>
Message-Id: <20070813234218.4796D14540D0@imap.suse.de>
Cc: stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that we have just queued up the patch titled

     Subject: powerpc: Fix size check for hugetlbfs

to the 2.6.22-stable tree.  Its filename is

     powerpc-fix-size-check-for-hugetlbfs.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From benh@kernel.crashing.org  Mon Aug 13 16:17:09 2007
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 08 Aug 2007 15:44:15 +1000
Subject: powerpc: Fix size check for hugetlbfs
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, stable@kernel.org
Message-ID: <1186551855.938.164.camel@localhost.localdomain>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

My "slices" address space management code that was added in 2.6.22
implementation of get_unmapped_area() doesn't properly check that the
size is a multiple of the requested page size. This allows userland to
create VMAs that aren't a multiple of the huge page size with hugetlbfs
(since hugetlbfs entirely relies on get_unmapped_area() to do that
checking) which leads to a kernel BUG() when such areas are torn down.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-work.orig/arch/powerpc/mm/slice.c	2007-08-08 15:16:06.000000000 +1000
+++ linux-work/arch/powerpc/mm/slice.c	2007-08-08 15:16:41.000000000 +1000
@@ -405,6 +405,8 @@ unsigned long slice_get_unmapped_area(un
 
 	if (len > mm->task_size)
 		return -ENOMEM;
+	if (len & ((1ul << pshift) - 1))
+		return -EINVAL;
 	if (fixed && (addr & ((1ul << pshift) - 1)))
 		return -EINVAL;
 	if (fixed && addr > (mm->task_size - len))


_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable



Patches currently in stable-queue which might be from benh@kernel.crashing.org are

queue-2.6.22/ppc-revert-don-t-complain-if-size-cells-0-in-prom_parse.patch
queue-2.6.22/ppc-revert-add-mdio-to-bus-scan-id-list-for-platforms-with-qe-uec.patch
queue-2.6.22/powerpc-fix-size-check-for-hugetlbfs.patch
