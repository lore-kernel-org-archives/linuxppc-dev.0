Return-Path: <tomof@acm.org>
Received: from mo11.iij4u.or.jp (mo11.iij4u.or.jp [210.138.174.79])
	by ozlabs.org (Postfix) with ESMTP id E69CDDDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 14:35:06 +1100 (EST)
Date: Mon, 31 Dec 2007 12:26:09 +0900
To: akpm@linux-foundation.org
Subject: Re: +
	iommu-sg-add-iommu-helper-functions-for-the-free-area-management.patch
	added to -mm tree
From: FUJITA Tomonori <tomof@acm.org>
In-Reply-To: <200712072212.lB7MCKmS006195@imap1.linux-foundation.org>
References: <200712072212.lB7MCKmS006195@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20071231122831H.tomof@acm.org>
Cc: James.Bottomley@steeleye.com, mm-commits@vger.kernel.org, jeff@garzik.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	jens.axboe@oracle.com, tomof@acm.org, balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 07 Dec 2007 14:12:20 -0800
akpm@linux-foundation.org wrote:

> 
> The patch titled
>      iommu sg: add IOMMU helper functions for the free area management
> has been added to the -mm tree.  Its filename is
>      iommu-sg-add-iommu-helper-functions-for-the-free-area-management.patch
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: iommu sg: add IOMMU helper functions for the free area management
> From: FUJITA Tomonori <tomof@acm.org>
> 
> This adds IOMMU helper functions for the free area management.  These
> functions take care of LLD's segment boundary limit for IOMMUs.  They would be
> useful for IOMMUs that use bitmap for the free area management.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: James Bottomley <James.Bottomley@steeleye.com>
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/iommu-helper.h |    7 +++
>  lib/Makefile                 |    1 
>  lib/iommu-helper.c           |   76 +++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)

Andrew, can you replace this patch with the attached patch?

There was a clear bug in the align allocation path though I still wait
for Balbir to test this:

http://marc.info/?l=linux-scsi&m=119881993112939&w=2

Thanks,

=
Subject: [PATCH] add IOMMU helper functions for the free area management

This adds IOMMU helper functions for the free area management.  These
functions take care of LLD's segment boundary limit for IOMMUs.  They would be
useful for IOMMUs that use bitmap for the free area management.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 include/linux/iommu-helper.h |    7 ++++
 lib/Makefile                 |    1 +
 lib/iommu-helper.c           |   80 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/iommu-helper.h
 create mode 100644 lib/iommu-helper.c

diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
new file mode 100644
index 0000000..4dd4c04
--- /dev/null
+++ b/include/linux/iommu-helper.h
@@ -0,0 +1,7 @@
+extern unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
+				      unsigned long start, unsigned int nr,
+				      unsigned long shift,
+				      unsigned long boundary_size,
+				      unsigned long align_mask);
+extern void iommu_area_free(unsigned long *map, unsigned long start,
+			    unsigned int nr);
diff --git a/lib/Makefile b/lib/Makefile
index b6793ed..0e7383f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_SMP) += percpu_counter.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
new file mode 100644
index 0000000..495575a
--- /dev/null
+++ b/lib/iommu-helper.c
@@ -0,0 +1,80 @@
+/*
+ * IOMMU helper functions for the free area management
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+
+static unsigned long find_next_zero_area(unsigned long *map,
+					 unsigned long size,
+					 unsigned long start,
+					 unsigned int nr,
+					 unsigned long align_mask)
+{
+	unsigned long index, end, i;
+again:
+	index = find_next_zero_bit(map, size, start);
+
+	/* Align allocation */
+	index = (index + align_mask) & ~align_mask;
+
+	end = index + nr;
+	if (end >= size)
+		return -1;
+	for (i = index; i < end; i++) {
+		if (test_bit(i, map)) {
+			start = i+1;
+			goto again;
+		}
+	}
+	return index;
+}
+
+static inline void set_bit_area(unsigned long *map, unsigned long i,
+				int len)
+{
+	unsigned long end = i + len;
+	while (i < end) {
+		__set_bit(i, map);
+		i++;
+	}
+}
+
+static inline int is_span_boundary(unsigned int index, unsigned int nr,
+				   unsigned long shift,
+				   unsigned long boundary_size)
+{
+	shift = (shift + index) & (boundary_size - 1);
+	return shift + nr > boundary_size;
+}
+
+unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
+			       unsigned long start, unsigned int nr,
+			       unsigned long shift, unsigned long boundary_size,
+			       unsigned long align_mask)
+{
+	unsigned long index;
+again:
+	index = find_next_zero_area(map, size, start, nr, align_mask);
+	if (index != -1) {
+		if (is_span_boundary(index, nr, shift, boundary_size)) {
+			/* we could do more effectively */
+			start = index + 1;
+			goto again;
+		}
+		set_bit_area(map, index, nr);
+	}
+	return index;
+}
+EXPORT_SYMBOL(iommu_area_alloc);
+
+void iommu_area_free(unsigned long *map, unsigned long start, unsigned int nr)
+{
+	unsigned long end = start + nr;
+
+	while (start < end) {
+		__clear_bit(start, map);
+		start++;
+	}
+}
+EXPORT_SYMBOL(iommu_area_free);
-- 
1.5.3.4
