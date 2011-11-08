Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 5A9CB1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 01:58:40 +1100 (EST)
From: Will Deacon <will.deacon@arm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: signal32: fix sigset_t conversion when copying to
 user
Date: Tue,  8 Nov 2011 14:51:19 +0000
Message-Id: <1320763879-12466-1-git-send-email-will.deacon@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC64, put_sigset_t converts a sigset_t to a compat_sigset_t
before copying it to userspace. There is a typo in the case that
we have 4 words to copy, meaning that we corrupt the compat_sigset_t.

It appears that _NSIG_WORDS can't be greater than 2 at the moment
so this code is probably always optimised away anyway.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/powerpc/kernel/signal_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 78b76dc..836a5a1 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -97,7 +97,7 @@ static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
 	compat_sigset_t	cset;
 
 	switch (_NSIG_WORDS) {
-	case 4: cset.sig[5] = set->sig[3] & 0xffffffffull;
+	case 4: cset.sig[6] = set->sig[3] & 0xffffffffull;
 		cset.sig[7] = set->sig[3] >> 32;
 	case 3: cset.sig[4] = set->sig[2] & 0xffffffffull;
 		cset.sig[5] = set->sig[2] >> 32;
-- 
1.7.4.1
