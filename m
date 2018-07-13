Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Rym72jltzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 02:23:35 +1000 (AEST)
Message-Id: <f0cd8fff8034e9e788eae8efefb90c9c4f3ede4f.1531498345.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1531498345.git.christophe.leroy@c-s.fr>
References: <cover.1531498345.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 1/4] powerpc/mm: prepare kernel for KAsan on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Date: Fri, 13 Jul 2018 16:23:31 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kernel/cputable.c, explicitly use memcpy() in order
to allow GCC to replace it with __memcpy() when KASAN is
selected.

Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
enabled"), memset() can be used before activation of the cache,
so no need to use memset_io() for zeroing the BSS.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cputable.c | 4 ++--
 arch/powerpc/kernel/setup_32.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c8fc9691f8c7..60ee5900bf12 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2183,7 +2183,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
 	struct cpu_spec *t = &the_cpu_spec;
 
 	t = PTRRELOC(t);
-	*t = *s;
+	memcpy(t, s, sizeof(*t));
 
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 }
@@ -2198,7 +2198,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 	old = *t;
 
 	/* Copy everything, then do fixups */
-	*t = *s;
+	memcpy(t, s, sizeof(*t));
 
 	/*
 	 * If we are overriding a previous value derived from the real
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 74457485574b..6a394b9e109e 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -70,10 +70,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 {
 	unsigned long offset = reloc_offset();
 
-	/* First zero the BSS -- use memset_io, some platforms don't have
-	 * caches on yet */
-	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
-			__bss_stop - __bss_start);
+	/* First zero the BSS */
+	memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
 
 	/*
 	 * Identify the CPU type and fix up code sections
-- 
2.13.3
