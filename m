Return-Path: <paulus@ozlabs.org>
Date: Mon, 5 Aug 2013 14:11:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Implement __get_user_pages_fast()
Message-ID: <20130805041123.GB19254@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Other architectures have a __get_user_pages_fast(), in addition to the
regular get_user_pages_fast(), which doesn't call get_user_pages() on
failure, and thus doesn't attempt to fault pages in or COW them.  The
generic KVM code uses __get_user_pages_fast() to detect whether a page
for which we have only requested read access is actually writable.

This provides an implementation of __get_user_pages_fast() by
splitting the existing get_user_pages_fast() in two.  With this, the
generic KVM code will get the right answer instead of always
considering such pages non-writable.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/mm/gup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index 49822d9..6936547 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -117,8 +117,8 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	return 1;
 }
 
-int get_user_pages_fast(unsigned long start, int nr_pages, int write,
-			struct page **pages)
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr, len, end;
@@ -135,7 +135,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
 					start, len)))
-		goto slow_irqon;
+		return 0;
 
 	pr_devel("  aligned: %lx .. %lx\n", start, end);
 
@@ -166,30 +166,35 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			 (void *)pgd_val(pgd));
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
-			goto slow;
+			break;
 		if (pgd_huge(pgd)) {
 			if (!gup_hugepte((pte_t *)pgdp, PGDIR_SIZE, addr, next,
 					 write, pages, &nr))
-				goto slow;
+				break;
 		} else if (is_hugepd(pgdp)) {
 			if (!gup_hugepd((hugepd_t *)pgdp, PGDIR_SHIFT,
 					addr, next, write, pages, &nr))
-				goto slow;
+				break;
 		} else if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
-			goto slow;
+			break;
 	} while (pgdp++, addr = next, addr != end);
 
 	local_irq_enable();
 
-	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
+}
 
-	{
-		int ret;
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			struct page **pages)
+{
+	struct mm_struct *mm = current->mm;
+	int nr, ret;
+
+	start &= PAGE_MASK;
+	nr = __get_user_pages_fast(start, nr_pages, write, pages);
+	ret = nr;
 
-slow:
-		local_irq_enable();
-slow_irqon:
+	if (nr < nr_pages) {
 		pr_devel("  slow path ! nr = %d\n", nr);
 
 		/* Try to get the remaining pages with get_user_pages */
@@ -198,7 +203,7 @@ slow_irqon:
 
 		down_read(&mm->mmap_sem);
 		ret = get_user_pages(current, mm, start,
-			(end - start) >> PAGE_SHIFT, write, 0, pages, NULL);
+				     nr_pages - nr, write, 0, pages, NULL);
 		up_read(&mm->mmap_sem);
 
 		/* Have to be a bit careful with return values */
@@ -208,9 +213,9 @@ slow_irqon:
 			else
 				ret += nr;
 		}
-
-		return ret;
 	}
+
+	return ret;
 }
 
 #endif /* __HAVE_ARCH_PTE_SPECIAL */
-- 
1.8.3.1
