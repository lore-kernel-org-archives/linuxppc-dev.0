Return-Path: <walken@google.com>
Received: from mail-da0-f52.google.com (mail-da0-f52.google.com
 [209.85.210.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8C242C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 22:23:20 +1100 (EST)
Received: by mail-da0-f52.google.com with SMTP id f10so701773dak.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2013 03:23:18 -0800 (PST)
Date: Wed, 9 Jan 2013 03:23:13 -0800
From: Michel Lespinasse <walken@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] mm: use vm_unmapped_area() on powerpc architecture
Message-ID: <20130109112313.GA4905@google.com>
References: <1357694895-520-1-git-send-email-walken@google.com>
 <1357694895-520-8-git-send-email-walken@google.com>
 <1357697739.4838.30.camel@pasglop>
 <CANN689EJV_7Q7J4j1ttDxZuqbwD53PAuCHb5DhiE-AVbmNSR7Q@mail.gmail.com>
 <1357702376.4838.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357702376.4838.32.camel@pasglop>
Cc: Rik van Riel <riel@redhat.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2013 at 02:32:56PM +1100, Benjamin Herrenschmidt wrote:
> Ok. I think at least you can move that construct:
> 
> +               if (addr < SLICE_LOW_TOP) {
> +                       slice = GET_LOW_SLICE_INDEX(addr);
> +                       addr = (slice + 1) << SLICE_LOW_SHIFT;
> +                       if (!(available.low_slices & (1u << slice)))
> +                               continue;
> +               } else {
> +                       slice = GET_HIGH_SLICE_INDEX(addr);
> +                       addr = (slice + 1) << SLICE_HIGH_SHIFT;
> +                       if (!(available.high_slices & (1u << slice)))
> +                               continue;
> +               }
> 
> Into some kind of helper. It will probably compile to the same thing but
> at least it's more readable and it will avoid a fuckup in the future if
> somebody changes the algorithm and forgets to update one of the
> copies :-)

All right, does the following look more palatable then ?
(didn't re-test it, though)

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/powerpc/mm/slice.c |  123 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 999a74f25ebe..3e99c149271a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -237,36 +237,69 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 #endif
 }
 
+/*
+ * Compute which slice addr is part of;
+ * set *boundary_addr to the start or end boundary of that slice
+ * (depending on 'end' parameter);
+ * return boolean indicating if the slice is marked as available in the
+ * 'available' slice_mark.
+ */
+static bool slice_scan_available(unsigned long addr,
+				 struct slice_mask available,
+				 int end,
+				 unsigned long *boundary_addr)
+{
+	unsigned long slice;
+	if (addr < SLICE_LOW_TOP) {
+		slice = GET_LOW_SLICE_INDEX(addr);
+		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
+		return !!(available.low_slices & (1u << slice));
+	} else {
+		slice = GET_HIGH_SLICE_INDEX(addr);
+		*boundary_addr = (slice + end) ?
+			((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
+		return !!(available.high_slices & (1u << slice));
+	}
+}
+
 static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 					      unsigned long len,
 					      struct slice_mask available,
 					      int psize)
 {
-	struct vm_area_struct *vma;
-	unsigned long addr;
-	struct slice_mask mask;
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
+	unsigned long addr, found, next_end;
+	struct vm_unmapped_area_info info;
 
-	addr = TASK_UNMAPPED_BASE;
-
-	for (;;) {
-		addr = _ALIGN_UP(addr, 1ul << pshift);
-		if ((TASK_SIZE - len) < addr)
-			break;
-		vma = find_vma(mm, addr);
-		BUG_ON(vma && (addr >= vma->vm_end));
+	info.flags = 0;
+	info.length = len;
+	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
+	info.align_offset = 0;
 
-		mask = slice_range_to_mask(addr, len);
-		if (!slice_check_fit(mask, available)) {
-			if (addr < SLICE_LOW_TOP)
-				addr = _ALIGN_UP(addr + 1,  1ul << SLICE_LOW_SHIFT);
-			else
-				addr = _ALIGN_UP(addr + 1,  1ul << SLICE_HIGH_SHIFT);
+	addr = TASK_UNMAPPED_BASE;
+	while (addr < TASK_SIZE) {
+		info.low_limit = addr;
+		if (!slice_scan_available(addr, available, 1, &addr))
 			continue;
+
+ next_slice:
+		/*
+		 * At this point [info.low_limit; addr) covers
+		 * available slices only and ends at a slice boundary.
+		 * Check if we need to reduce the range, or if we can
+		 * extend it to cover the next available slice.
+		 */
+		if (addr >= TASK_SIZE)
+			addr = TASK_SIZE;
+		else if (slice_scan_available(addr, available, 1, &next_end)) {
+			addr = next_end;
+			goto next_slice;
 		}
-		if (!vma || addr + len <= vma->vm_start)
-			return addr;
-		addr = vma->vm_end;
+		info.high_limit = addr;
+
+		found = vm_unmapped_area(&info);
+		if (!(found & ~PAGE_MASK))
+			return found;
 	}
 
 	return -ENOMEM;
@@ -277,39 +310,39 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 					     struct slice_mask available,
 					     int psize)
 {
-	struct vm_area_struct *vma;
-	unsigned long addr;
-	struct slice_mask mask;
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
+	unsigned long addr, found, prev;
+	struct vm_unmapped_area_info info;
 
-	addr = mm->mmap_base;
-	while (addr > len) {
-		/* Go down by chunk size */
-		addr = _ALIGN_DOWN(addr - len, 1ul << pshift);
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
+	info.align_offset = 0;
 
-		/* Check for hit with different page size */
-		mask = slice_range_to_mask(addr, len);
-		if (!slice_check_fit(mask, available)) {
-			if (addr < SLICE_LOW_TOP)
-				addr = _ALIGN_DOWN(addr, 1ul << SLICE_LOW_SHIFT);
-			else if (addr < (1ul << SLICE_HIGH_SHIFT))
-				addr = SLICE_LOW_TOP;
-			else
-				addr = _ALIGN_DOWN(addr, 1ul << SLICE_HIGH_SHIFT);
+	addr = mm->mmap_base;
+	while (addr > PAGE_SIZE) {
+		info.high_limit = addr;
+		if (!slice_scan_available(addr - 1, available, 0, &addr))
 			continue;
-		}
 
+ prev_slice:
 		/*
-		 * Lookup failure means no vma is above this address,
-		 * else if new region fits below vma->vm_start,
-		 * return with success:
+		 * At this point [addr; info.high_limit) covers
+		 * available slices only and starts at a slice boundary.
+		 * Check if we need to reduce the range, or if we can
+		 * extend it to cover the previous available slice.
 		 */
-		vma = find_vma(mm, addr);
-		if (!vma || (addr + len) <= vma->vm_start)
-			return addr;
+		if (addr < PAGE_SIZE)
+			addr = PAGE_SIZE;
+		else if (slice_scan_available(addr - 1, available, 0, &prev)) {
+			addr = prev;
+			goto prev_slice;
+		}
+		info.low_limit = addr;
 
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start;
+		found = vm_unmapped_area(&info);
+		if (!(found & ~PAGE_MASK))
+			return found;
 	}
 
 	/*

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
