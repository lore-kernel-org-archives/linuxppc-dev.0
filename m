Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v5LxD0w4rzDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 02:25:19 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc/mm: Return directly after a failed __copy_from_user()
 in sys_subpage_prot()
Message-ID: <5f910c33-c811-2197-0adb-c55f7722c5a7@users.sourceforge.net>
Date: Sat, 21 Jan 2017 16:24:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 16:10:50 +0100

* Return directly after a call of the function "__copy_from_user"
  failed here.

  This issue was detected by using the Coccinelle software.

* Delete the jump label "out2" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/mm/subpage-prot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index d5543514c1df..40309edd7cb7 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -248,9 +248,8 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 			nw = (next - addr) >> PAGE_SHIFT;
 
 		up_write(&mm->mmap_sem);
-		err = -EFAULT;
 		if (__copy_from_user(spp, map, nw * sizeof(u32)))
-			goto out2;
+			return -EFAULT;
 		map += nw;
 		down_write(&mm->mmap_sem);
 
@@ -262,6 +261,5 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 	err = 0;
  out:
 	up_write(&mm->mmap_sem);
- out2:
 	return err;
 }
-- 
2.11.0
