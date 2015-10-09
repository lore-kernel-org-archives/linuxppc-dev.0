Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E5661A0248
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 14:01:42 +1100 (AEDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>
CC: <scottwood@freescale.com>, <cmetcalf@ezchip.com>, <leoli@freescale.com>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [PATCH] powerpc: Quick fix upstream main line build error on PowerPC
Date: Fri, 9 Oct 2015 10:55:09 +0800
Message-ID: <1444359309-40375-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

This issue caused on 'commit 990486c8af04 ("strscpy: zero any trailing
garbage bytes in the destination")'.

zero_bytemask is not implemented on PowerPC. So copy the zero_bytemask
of BIG_ENDIAN implementation from include/asm-generic/word-at-a-time.h
to arch/powerpc/include/asm/word-at-a-time.h.

Build message:
lib/string.c: In function 'strscpy':
lib/string.c:209:4: error: implicit declaration of function
	'zero_bytemask' [-Werror=implicit-function-declaration]
	*(unsigned long *)(dest+res) = c & zero_bytemask(data);
cc1: some warnings being treated as errors
make[1]: *** [lib/string.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 5b3a903..d891456 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -40,6 +40,10 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 	return (val + c->high_bits) & ~rhs;
 }
 
+#ifndef zero_bytemask
+#define zero_bytemask(mask) (~1ul << __fls(mask))
+#endif
+
 #else
 
 #ifdef CONFIG_64BIT
-- 
2.1.0.27.g96db324
