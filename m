Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F19FBDDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 15:44:27 +1000 (EST)
Subject: [PATCH] powerpc: Fix size check for hugetlbfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 15:44:15 +1000
Message-Id: <1186551855.938.164.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My "slices" address space management code that was added in 2.6.22
implementation of get_unmapped_area() doesn't properly check that the
size is a multiple of the requested page size. This allows userland to
create VMAs that aren't a multiple of the huge page size with hugetlbfs
(since hugetlbfs entirely relies on get_unmapped_area() to do that
checking) which leads to a kernel BUG() when such areas are torn down.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This should go to 2.6.22.x stable in addition to current 2.6.23-*

Index: linux-work/arch/powerpc/mm/slice.c
===================================================================
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
