Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DE6C2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:22:54 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: match variable types to API
Date: Tue, 21 Aug 2012 14:22:28 -0400
Message-Id: <1345573348-28248-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Mackerras <paulus@samba.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Joe MacDonald <joe.macdonald@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe MacDonald <joe.macdonald@windriver.com>

sys_subpage_prot() takes an unsigned long for 'addr' then does some stuff
with it and the result is stored in a signed int, i, which is eventually
used as the size parameter in a copy_from_user call.  Update 'i' to be an
unsigned long as well and since 'nw' is used in a size_t context which,
depending on whether this is 32- or 64-bit may be unsigned int or unsigned
long, switch that to a size_t and always be right.

Finally, since we're in the neighbourhood, make the same changes to
subpage_prot_clear().

Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/mm/subpage-prot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index e4f8f1f..7c415dd 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -95,7 +95,8 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
 	struct mm_struct *mm = current->mm;
 	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 **spm, *spp;
-	int i, nw;
+	unsigned long i;
+	size_t nw;
 	unsigned long next, limit;
 
 	down_write(&mm->mmap_sem);
@@ -144,7 +145,8 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 	struct mm_struct *mm = current->mm;
 	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 **spm, *spp;
-	int i, nw;
+	unsigned long i;
+	size_t nw;
 	unsigned long next, limit;
 	int err;
 
-- 
1.7.11.1
