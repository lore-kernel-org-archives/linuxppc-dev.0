Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmkz56nb6zDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 18:28:49 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Christophe Leroy <christophe.leroy@c-s.fr>
Date: Sat,  9 Jul 2016 03:28:40 -0500
Message-Id: <1468052920-11810-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/8xx: Force VIRT_IMMR_BASE to be a positive number
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The asm-offsets mechanism generates signed numbers, even if the
input value is explicitly unsigned.  This causes a problem with
older binutils (e.g. 2.23), which sign-extend a negative number
when @h is applied.  Thus, this instruction:

	cmpli   cr0, r11, VIRT_IMMR_BASE@h

resulted in this:

Error: operand out of range (0xfffffff0 is not between 0x00000000 and
0x0000ffff)

By casting to a larger type, we can force the output to be expressed
as a positive number.

Signed-off-by: Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/asm-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 247f640..b89d14c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -754,7 +754,7 @@ int main(void)
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
 
 #ifdef CONFIG_PPC_8xx
-	DEFINE(VIRT_IMMR_BASE, __fix_to_virt(FIX_IMMR_BASE));
+	DEFINE(VIRT_IMMR_BASE, (u64)__fix_to_virt(FIX_IMMR_BASE));
 #endif
 
 	return 0;
-- 
2.7.4
