Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFBzk0vW0zDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 20:54:42 +1100 (AEDT)
Received: by mail-wm0-x230.google.com with SMTP id r141so19479604wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 01:54:41 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jeyu@redhat.com, rusty@rustcorp.com.au, mmarek@suse.com, mpe@ellerman.id.au
Cc: torvalds@linux-foundation.org, arnd@arndb.de, viro@zeniv.linux.org.uk,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 3/3] module: unify absolute krctab definitions for 32-bit
 and 64-bit
Date: Fri,  3 Feb 2017 09:54:07 +0000
Message-Id: <1486115647-27680-4-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486115647-27680-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch introduced a separate inline asm version of the
krcrctab declaration template for use with 64-bit architectures, which
cannot refer to ELF symbols using 32-bit quantities. This declaration
should be equivalent to the C one for 32-bit architectures, but this
needs to be checked first, so unify them in a separate patch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

... which can simply be dropped if it turns out to break anything.

 include/linux/export.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 7473fba6a60c..1a1dfdb2a5c6 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -49,13 +49,6 @@ extern struct module __this_module;
 	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
 	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
 	    "	.previous					\n");
-#elif !defined(CONFIG_64BIT)
-#define __CRC_SYMBOL(sym, sec)						\
-	extern __visible void *__crc_##sym __attribute__((weak));	\
-	static const unsigned long __kcrctab_##sym			\
-	__used								\
-	__attribute__((section("___kcrctab" sec "+" #sym), used))	\
-	= (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-- 
2.7.4
