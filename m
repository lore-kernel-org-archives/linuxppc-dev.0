Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Implement arch_spin_is_locked() using
 arch_spin_value_unlocked()
Date: Wed, 15 Jan 2014 18:14:29 +1100
Message-Id: <1389770069-28733-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1389770069-28733-1-git-send-email-mpe@ellerman.id.au>
References: <1389770069-28733-1-git-send-email-mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Linus Torvalds <torvalds@osdl.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At a glance these are just the inverse of each other. The one subtlety
is that arch_spin_value_unlocked() takes the lock by value, rather than
as a pointer, which is important for the lockref code.

On the other hand arch_spin_is_locked() doesn't really care, so
implement it in terms of arch_spin_value_unlocked().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/spinlock.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 5162f8c..a30ef69 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -28,8 +28,6 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-#define arch_spin_is_locked(x)		((x)->slock != 0)
-
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
@@ -59,6 +57,11 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 	return lock.slock == 0;
 }
 
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	return !arch_spin_value_unlocked(*lock);
+}
+
 /*
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
-- 
1.8.3.2
