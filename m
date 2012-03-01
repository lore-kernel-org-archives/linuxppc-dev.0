Return-Path: <anton@samba.org>
Date: Thu, 1 Mar 2012 18:09:53 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 asharma@fb.com, vapier@gentoo.org, eric.dumazet@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] atomic: Allow atomic_inc_not_zero to be overridden
Message-ID: <20120301180953.0f61576f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We want to implement a ppc64 specific version of atomic_inc_not_zero
so wrap it in an ifdef to allow it to be overridden.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/include/linux/atomic.h
===================================================================
--- linux-build.orig/include/linux/atomic.h	2012-02-11 14:59:23.284714257 +1100
+++ linux-build/include/linux/atomic.h	2012-02-11 15:01:14.894764555 +1100
@@ -24,7 +24,9 @@ static inline int atomic_add_unless(atom
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
+#ifndef atomic_inc_not_zero
 #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
+#endif
 
 /**
  * atomic_inc_not_zero_hint - increment if not null
