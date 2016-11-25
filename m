Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ1GG5td2zDvxW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 14:07:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: xinhui.pan@linux.vnet.ibm.com,
	peterz@infradead.org
Subject: [PATCH] powerpc: Fix __cmpxchg() to take a volatile ptr again
Date: Fri, 25 Nov 2016 14:07:09 +1100
Message-Id: <1480043229-2363-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
we removed the volatile from __cmpxchg().

This is leading to warnings such as:

  drivers/gpu/drm/drm_lock.c: In function ‘drm_lock_take’:
  arch/powerpc/include/asm/cmpxchg.h:484:37: warning: passing argument 1
  of ‘__cmpxchg’ discards ‘volatile’ qualifier from pointer target
     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,   \

There doesn't seem to be consensus across architectures whether the
argument is volatile or not, so at least for now put the volatile back.

Fixes: d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cmpxchg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index c12f110261b2..fc46b664c49e 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -14,7 +14,7 @@
 #endif
 
 #define XCHG_GEN(type, sfx, cl)				\
-static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
+static inline u32 __xchg_##type##sfx(volatile void *p, u32 val)	\
 {								\
 	unsigned int prev, prev_mask, tmp, bitoff, off;		\
 								\
@@ -40,7 +40,7 @@ static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
 
 #define CMPXCHG_GEN(type, sfx, br, br2, cl)			\
 static inline							\
-u32 __cmpxchg_##type##sfx(void *p, u32 old, u32 new)		\
+u32 __cmpxchg_##type##sfx(volatile void *p, u32 old, u32 new)	\
 {								\
 	unsigned int prev, prev_mask, tmp, bitoff, off;		\
 								\
@@ -399,7 +399,7 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
 #endif
 
 static __always_inline unsigned long
-__cmpxchg(void *ptr, unsigned long old, unsigned long new,
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
 	switch (size) {
-- 
2.7.4
