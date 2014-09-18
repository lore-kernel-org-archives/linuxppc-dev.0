Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A8781A0926
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:40:25 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org
Subject: [PATCH 1/3] powerpc: Implement load_unaligned_zeropad
Date: Fri, 19 Sep 2014 09:40:19 +1000
Message-Id: <1411083621-12064-2-git-send-email-anton@samba.org>
In-Reply-To: <1411083621-12064-1-git-send-email-anton@samba.org>
References: <1411083621-12064-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a bi-arch and bi-endian version of load_unaligned_zeropad.

Since the fallback case is so rare, a userspace test harness was used
to test this on ppc64le, ppc64 and ppc32:

http://ozlabs.org/~anton/junkcode/test_load_unaligned_zeropad.c

It uses mprotect to force a SEGV across a page boundary, and a SEGV
handler to lookup the exception tables and run the fixup routine.
It also compares the result against a normal load.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/word-at-a-time.h | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 9a5c928..07cc121 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -116,4 +116,44 @@ static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits,
 
 #endif
 
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long ret, offset, tmp;
+
+	asm(
+	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
+	"2:\n"
+	".section .fixup,\"ax\"\n"
+	"3:	"
+#ifdef __powerpc64__
+	"clrrdi		%[tmp], %[addr], 3\n\t"
+	"clrlsldi	%[offset], %[addr], 61, 3\n\t"
+	"ld		%[ret], 0(%[tmp])\n\t"
+#ifdef __BIG_ENDIAN__
+	"sld		%[ret], %[ret], %[offset]\n\t"
+#else
+	"srd		%[ret], %[ret], %[offset]\n\t"
+#endif
+#else
+	"clrrwi		%[tmp], %[addr], 2\n\t"
+	"clrlslwi	%[offset], %[addr], 30, 3\n\t"
+	"lwz		%[ret], 0(%[tmp])\n\t"
+#ifdef __BIG_ENDIAN__
+	"slw		%[ret], %[ret], %[offset]\n\t"
+#else
+	"srw		%[ret], %[ret], %[offset]\n\t"
+#endif
+#endif
+	"b	2b\n"
+	".previous\n"
+	".section __ex_table,\"a\"\n\t"
+		PPC_LONG_ALIGN "\n\t"
+		PPC_LONG "1b,3b\n"
+	".previous"
+	: [tmp] "=&b" (tmp), [offset] "=&r" (offset), [ret] "=&r" (ret)
+	: [addr] "b" (addr), "m" (*(unsigned long *)addr));
+
+	return ret;
+}
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
1.9.1
