Return-Path: <mathieu.desnoyers@polymtl.ca>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.polymtl.ca", Issuer "Ca_Cert_Smtp_Poly" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 58086DE2B8
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 06:46:32 +1100 (EST)
Message-Id: <20071030192102.985443792@polymtl.ca>
References: <20071030191557.947156623@polymtl.ca>
Date: Tue, 30 Oct 2007 15:16:02 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, matthew@wil.cx,
	linux-arch@vger.kernel.org, penberg@cs.helsinki.fi, linux-mm@kvack.org,
	Christoph Lameter <clameter@sgi.com>
Subject: [patch 05/28] Add cmpxchg64 and cmpxchg64_local to powerpc
Cc: Paul Mackerras <paulus@samba.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make sure that at least cmpxchg64_local is available on all architectures to use
for unsigned long long values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Acked-by: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@ozlabs.org
---
 include/asm-powerpc/system.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6-lttng/include/asm-powerpc/system.h
===================================================================
--- linux-2.6-lttng.orig/include/asm-powerpc/system.h	2007-09-24 10:50:11.000000000 -0400
+++ linux-2.6-lttng/include/asm-powerpc/system.h	2007-09-24 11:01:04.000000000 -0400
@@ -488,6 +488,12 @@ __cmpxchg_local(volatile void *ptr, unsi
  */
 #define NET_IP_ALIGN	0
 #define NET_SKB_PAD	L1_CACHE_BYTES
+
+#define cmpxchg64	cmpxchg
+#define cmpxchg64_local	cmpxchg_local
+#else
+#include <asm-generic/cmpxchg-local.h>
+#define cmpxchg64_local(ptr,o,n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
 #define arch_align_stack(x) (x)

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
