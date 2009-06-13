Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20EB9B7202
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 17:13:50 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED51EDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 17:13:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18995.20721.75525.524733@cargo.ozlabs.ibm.com>
Date: Sat, 13 Jun 2009 17:10:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Use generic atomic64_t implementation on 32-bit
	processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 02fccb02e29bc24e84a5b2ea6ea5d63779247408 Mon Sep 17 00:00:00 2001
From: Paul Mackerras <paulus@samba.org>
Date: Sat, 13 Jun 2009 16:24:03 +1000
Subject: 

This makes 32-bit powerpc use the generic atomic64_t implementation.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig              |    1 +
 arch/powerpc/include/asm/atomic.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cdc9a6f..3f0a983 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -125,6 +125,7 @@ config PPC
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
 	select HAVE_SYSCALL_WRAPPERS if PPC64
+	select GENERIC_ATOMIC64 if PPC32
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index b7d2d07..4012483 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -470,6 +470,9 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
 
+#else  /* __powerpc64__ */
+#include <asm-generic/atomic64.h>
+
 #endif /* __powerpc64__ */
 
 #include <asm-generic/atomic-long.h>
-- 
1.6.0.4
