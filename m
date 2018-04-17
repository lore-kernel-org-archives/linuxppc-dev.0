Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QHDj2cGnzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 17:38:45 +1000 (AEST)
Message-Id: <cb1d94ed485382a51c34a79f2886ea19821eef31.1523950415.git.christophe.leroy@c-s.fr>
In-Reply-To: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
References: <a04660fd2b51246f8feeb49e49334fc943c1b9e8.1523950415.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  4/7] powerpc/lib: inline memcmp() for small constant sizes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 09:38:41 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In my 8xx configuration, I get 208 calls to memcmp()
Within those 208 calls, about half of them have constant sizes,
46 have a size of 8, 17 have a size of 16, only a few have a
size over 16. Other fixed sizes are mostly 4, 6 and 10.

This patch inlines calls to memcmp() when size
is constant and lower than or equal to 16

In my 8xx configuration, this reduces the number of calls
to memcmp() from 208 to 123

The following table shows the number of TB timeticks to perform
a constant size memcmp() before and after the patch depending on
the size

	Before	After	Improvement
01:	 7577	 5682	25%
02:	41668	 5682	86%
03:	51137	13258	74%
04:	45455	 5682	87%
05:	58713	13258	77%
06:	58712	13258	77%
07:	68183	20834	70%
08:	56819	15153	73%
09:	70077	28411	60%
10:	70077	28411	60%
11:	79546	35986	55%
12:	68182	28411	58%
13:	81440	35986	55%
14:	81440	39774	51%
15:	94697	43562	54%
16:	79546	37881	52%

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/string.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index cf6f495134c3..196ac5d587fb 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -4,6 +4,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/kernel.h>
+
 #define __HAVE_ARCH_STRNCPY
 #define __HAVE_ARCH_STRNCMP
 #define __HAVE_ARCH_MEMSET
@@ -28,10 +30,45 @@ extern void * memchr(const void *,int,__kernel_size_t);
 extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
 
 #ifndef CONFIG_FORTIFY_SOURCE
+static inline int ___memcmp(const void *p,const void *q,__kernel_size_t size, int offset)
+{
+	int dif;
+
+	BUILD_BUG_ON(!size || size > 8);
+
+	p += offset, q += offset;
+	if (size == 1)
+		return *(u8*)p - *(u8*)q;
+	if (size == 2)
+		return be16_to_cpu(*(u16*)p) - be16_to_cpu(*(u16*)q);
+	if (size == 3) {
+		dif = be16_to_cpu(*(u16*)p) - be16_to_cpu(*(u16*)q);
+		if (dif)
+			return dif;
+		return *(u8*)(p + 2) - *(u8*)(q + 2);
+	}
+	if (size == 8) {
+		s64 tmp = be64_to_cpu(*(u64*)p) - be64_to_cpu(*(u64*)q);
+		return tmp >> 32 ? : (int)tmp;
+	}
+
+	dif = be32_to_cpu(*(u32*)p) - be32_to_cpu(*(u32*)q);
+	if (size == 4 || dif)
+		return dif;
+
+	return ___memcmp(p, q, size - 4, 4);
+}
+
 static inline int __memcmp(const void *p,const void *q,__kernel_size_t size)
 {
 	if (unlikely(!size))
 		return 0;
+	if (__builtin_constant_p(size) && size <= 16) {
+		int dif = ___memcmp(p, q, size < 8 ? size : 8, 0);
+		if (size <= 8 || dif)
+			return dif;
+		return ___memcmp(p, q, size - 8, 8);
+	}
 	return memcmp(p, q, size);
 }
 #define memcmp __memcmp
-- 
2.13.3
