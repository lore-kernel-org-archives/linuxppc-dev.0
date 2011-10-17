Return-Path: <dpmcgee@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B71DCB70B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 10:05:41 +1100 (EST)
Received: by gyg8 with SMTP id 8so3831988gyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 16:05:38 -0700 (PDT)
From: Dan McGee <dpmcgee@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: remove hack in mmap randomize layout
Date: Mon, 17 Oct 2011 18:05:23 -0500
Message-Id: <1318892723-19401-1-git-send-email-dpmcgee@gmail.com>
In-Reply-To: <20111017.185357.1185691091043314919.davem@davemloft.net>
References: <20111017.185357.1185691091043314919.davem@davemloft.net>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 8a0a9bd4db63bc45e301, this comment in mmap_rnd() does not
hold true as the value returned by get_random_int() will in fact be
different every single call. Remove the comment and simplify the code
back to its original desired form.

This reverts commit a5adc91a4b44b5d1 which is no longer necessary and
also fixes the sparc code that copied this same adjustment.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 arch/powerpc/mm/mmap_64.c        |   14 +++-----------
 arch/sparc/kernel/sys_sparc_64.c |    6 +++---
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/mmap_64.c b/arch/powerpc/mm/mmap_64.c
index 5a783d8..67a42ed 100644
--- a/arch/powerpc/mm/mmap_64.c
+++ b/arch/powerpc/mm/mmap_64.c
@@ -53,14 +53,6 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-/*
- * Since get_random_int() returns the same value within a 1 jiffy window,
- * we will almost always get the same randomisation for the stack and mmap
- * region. This will mean the relative distance between stack and mmap will
- * be the same.
- *
- * To avoid this we can shift the randomness by 1 bit.
- */
 static unsigned long mmap_rnd(void)
 {
 	unsigned long rnd = 0;
@@ -68,11 +60,11 @@ static unsigned long mmap_rnd(void)
 	if (current->flags & PF_RANDOMIZE) {
 		/* 8MB for 32bit, 1GB for 64bit */
 		if (is_32bit_task())
-			rnd = (long)(get_random_int() % (1<<(22-PAGE_SHIFT)));
+			rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
 		else
-			rnd = (long)(get_random_int() % (1<<(29-PAGE_SHIFT)));
+			rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
 	}
-	return (rnd << PAGE_SHIFT) * 2;
+	return rnd << PAGE_SHIFT;
 }
 
 static inline unsigned long mmap_base(void)
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 908b47a..c2c03c8 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -368,11 +368,11 @@ static unsigned long mmap_rnd(void)
 	if (current->flags & PF_RANDOMIZE) {
 		unsigned long val = get_random_int();
 		if (test_thread_flag(TIF_32BIT))
-			rnd = (val % (1UL << (22UL-PAGE_SHIFT)));
+			rnd = (val % (1UL << (23UL-PAGE_SHIFT)));
 		else
-			rnd = (val % (1UL << (29UL-PAGE_SHIFT)));
+			rnd = (val % (1UL << (30UL-PAGE_SHIFT)));
 	}
-	return (rnd << PAGE_SHIFT) * 2;
+	return rnd << PAGE_SHIFT;
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm)
-- 
1.7.7
