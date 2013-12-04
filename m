Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4FDF2C038B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 17:58:29 +1100 (EST)
Received: by mail-ie0-f182.google.com with SMTP id as1so25942110iec.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 22:58:26 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: mm: optimize for the correctly placed page
Date: Wed,  4 Dec 2013 14:59:08 +0800
Message-Id: <1386140348-7854-4-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The period check of _PAGE_NUMA can probably trigger the check on
the correctly placed page. For this case, we can just insert hpte and
do fast exception return.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 9bf1195..735678c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -965,6 +965,10 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 	const struct cpumask *tmp;
 	int rc, user_region = 0, local = 0;
 	int psize, ssize;
+	pte_t old, new;
+	struct vm_area_struct *vma;
+	int page_nid, target_nid;
+	struct page *test_page;
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
 		ea, access, trap);
@@ -1033,12 +1037,40 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 
 	/* Get PTE and page size from page tables */
 	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
-	if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
+	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
 		goto bail;
 	}
 
+	old = pte_val(*ptep);
+	if (pte_numa(old)) {
+		/* If fail to lock, let do_page_fault() to handle it */
+		if (down_read_trylock(&mm->mmap_sem)) {
+			vma = find_vma(mm, ea);
+			up_read(&mm->mmap_sem);
+			test_page = pte_page(old);
+			page_nid = page_to_nid(test_page);
+			target_nid = numa_migrate_prep(test_page, vma, ea,
+						page_nid);
+			if (target_nid < 0) {
+				new = pte_mknonnuma(old);
+				/* If ptep is modified under us,
+				 * just retry the access
+				 */
+				if (unlikely(cmpxchg(ptep, old, new) != old)) {
+					put_page(test_page);
+					return 0;
+				}
+				put_page(test_page);
+			}
+		} else {
+				put_page(test_page);
+				rc = 1;
+				goto bail;
+		}
+	}
+
 	/* Add _PAGE_PRESENT to the required access perm */
 	access |= _PAGE_PRESENT;
 
-- 
1.8.1.4
