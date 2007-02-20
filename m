Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Feb 2007 18:44:13 +1100
Subject: [PATCH 2/5] This is a hack to get_unmapped_area to make the SPE 64K
	code work.
In-Reply-To: <1171957452.861958.803775545202.qpush@grosgo>
Message-Id: <20070220074432.D85DADDD0E@ozlabs.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Though it might prove to not have nasty side effects ...)

The basic idea is that if the filesystem's get_unmapped_area was used,
we skip the hugepage check. That assumes that the only filesytems that
provide a g_u_a callback are either hugetlbfs itself, or filesystems
that have arch specific code that "knows" already not to collide with
hugetlbfs.

A proper fix will be done later, basically by removing the hugetlbfs
hacks completely from get_unmapped_area and calling down to the mm
and/or the filesytem g_u_a implementations for MAX_FIXED as well.

(Note that this will still rely on the fact that filesytems that
provide a g_u_a "know" how to return areas that don't collide with
hugetlbfs, thus the base assumption is the same as this hack)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 mm/mmap.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-cell/mm/mmap.c
===================================================================
--- linux-cell.orig/mm/mmap.c	2007-02-20 18:09:12.000000000 +1100
+++ linux-cell/mm/mmap.c	2007-02-20 18:10:08.000000000 +1100
@@ -1357,14 +1357,17 @@ unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
-	unsigned long ret;
+	unsigned long ret = 0;
+	int fs_area = 0;
 
 	if (!(flags & MAP_FIXED)) {
 		unsigned long (*get_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
 		get_area = current->mm->get_unmapped_area;
-		if (file && file->f_op && file->f_op->get_unmapped_area)
+		if (file && file->f_op && file->f_op->get_unmapped_area) {
 			get_area = file->f_op->get_unmapped_area;
+			fs_area = 1;
+		}
 		addr = get_area(file, addr, len, pgoff, flags);
 		if (IS_ERR_VALUE(addr))
 			return addr;
@@ -1380,7 +1383,7 @@ get_unmapped_area(struct file *file, uns
 		 * can be made suitable for hugepages.
 		 */
 		ret = prepare_hugepage_range(addr, len, pgoff);
-	} else {
+	} else if (!fs_area) {
 		/*
 		 * Ensure that a normal request is not falling in a
 		 * reserved hugepage range.  For some archs like IA-64,
