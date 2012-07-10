Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 108AE2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 18:02:55 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 1/1] powerpc: add "memory" attribute for mfmsr()
Date: Tue, 10 Jul 2012 15:59:13 +0800
Message-ID: <1341907153-20516-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add "memory" attribute in inline assembly language as a compiler
barrier to make sure 4.6.x GCC don't reorder mfmsr().

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/reg.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 559da19..578e5a0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1016,7 +1016,8 @@
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
 #define mfmsr()		({unsigned long rval; \
-			asm volatile("mfmsr %0" : "=r" (rval)); rval;})
+			asm volatile("mfmsr %0" : "=r" (rval) : \
+						: "memory"); rval;})
 #ifdef CONFIG_PPC_BOOK3S_64
 #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
 				     : : "r" (v) : "memory")
-- 
1.5.6
