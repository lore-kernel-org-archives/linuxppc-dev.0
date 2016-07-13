Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq18z39YPzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 11:15:15 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id y188so2167338ywf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 18:15:15 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/3] powerpc32: booke: fix the build error when CRASH_DUMP
 is enabled
Date: Wed, 13 Jul 2016 09:14:38 +0800
Message-Id: <1468372480-6453-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1468372480-6453-1-git-send-email-haokexin@gmail.com>
References: <1468372480-6453-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current code, the RELOCATABLE will be forcedly enabled when
enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause the
following build error when CRASH_DUMP=y && ADVANCED_OPTIONS=n
because the select of NONSTATIC_KERNEL doesn't take effect.
  arch/powerpc/include/asm/io.h: In function 'virt_to_phys':
  arch/powerpc/include/asm/page.h:113:26: error: 'virt_phys_offset' undeclared (first use in this function)
   #define VIRT_PHYS_OFFSET virt_phys_offset
                          ^
It doesn't have any strong reasons to make the RELOCATABLE depend on
ADVANCED_OPTIONS. So remove this dependency to fix this issue.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0a4cea451cf2..cb7910b9f10f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -952,7 +952,7 @@ config DYNAMIC_MEMSTART
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on ADVANCED_OPTIONS && FLATMEM && (44x || FSL_BOOKE)
+	depends on FLATMEM && (44x || FSL_BOOKE)
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
-- 
2.8.1
