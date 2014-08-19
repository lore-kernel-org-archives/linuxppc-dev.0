Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A1DA1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 07:36:08 +1000 (EST)
Received: by mail-yh0-f49.google.com with SMTP id b6so6208788yha.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:36:06 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Make 256k pages depend on PPC32=n
Date: Tue, 19 Aug 2014 17:36:06 -0400
Message-Id: <1408484166-20711-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

256k pages are not tested on PPC32. On a randconfig I got the following error:

arch/powerpc/kernel/misc_32.S:1171: Error: operand out of range (0x0000000000010000 is not between 0xffffffffffff8000 and 0x0000000000007fff)

Disable 256K pages if PPC32=y

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index da16ffe..6cc518f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -556,7 +556,7 @@ config PPC_64K_PAGES
 
 config PPC_256K_PAGES
 	bool "256k page size" if 44x
-	depends on !STDBINUTILS
+	depends on !PPC32 && !STDBINUTILS
 	help
 	  Make the page size 256k.
 
-- 
1.9.1
