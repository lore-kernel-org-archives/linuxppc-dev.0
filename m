Return-Path: <dsafonov@virtuozzo.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20133.outbound.protection.outlook.com [40.107.2.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3Hk92vvVzDvkf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:21 +1100 (AEDT)
From: Dmitry Safonov <dsafonov@virtuozzo.com>
To: <linux-kernel@vger.kernel.org>
CC: <0x7f454c46@gmail.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Andy Lutomirski <luto@amacapital.net>,
 Oleg Nesterov <oleg@redhat.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mm@kvack.org>
Subject: [PATCH 1/7] powerpc/vdso: unify return paths in setup_additional_pages
Date: Tue, 25 Oct 2016 18:51:00 +0300
Message-ID: <20161025155106.29946-2-dsafonov@virtuozzo.com>
In-Reply-To: <20161025155106.29946-1-dsafonov@virtuozzo.com>
References: <20161025155106.29946-1-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Impact: cleanup

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org 
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/powerpc/kernel/vdso.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4111d30badfa..4ffb82a2d9e9 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -154,7 +154,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	struct page **vdso_pagelist;
 	unsigned long vdso_pages;
 	unsigned long vdso_base;
-	int rc;
+	int ret = 0;
 
 	if (!vdso_ready)
 		return 0;
@@ -203,8 +203,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 				      ((VDSO_ALIGNMENT - 1) & PAGE_MASK),
 				      0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
-		rc = vdso_base;
-		goto fail_mmapsem;
+		ret = vdso_base;
+		goto out_up_mmap_sem;
 	}
 
 	/* Add required alignment. */
@@ -227,21 +227,16 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * It's fine to use that for setting breakpoints in the vDSO code
 	 * pages though.
 	 */
-	rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+	ret = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
 				     VM_READ|VM_EXEC|
 				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				     vdso_pagelist);
-	if (rc) {
+	if (ret)
 		current->mm->context.vdso_base = 0;
-		goto fail_mmapsem;
-	}
-
-	up_write(&mm->mmap_sem);
-	return 0;
 
- fail_mmapsem:
+out_up_mmap_sem:
 	up_write(&mm->mmap_sem);
-	return rc;
+	return ret;
 }
 
 const char *arch_vma_name(struct vm_area_struct *vma)
-- 
2.10.0
