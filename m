Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC2C6B7EA5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:22:06 +1000 (EST)
Subject: [PATCH-stable] powerpc: Fix incorrect setting of
	__HAVE_ARCH_PTE_SPECIAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: stable <stable@kernel.org>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 17:16:53 +1000
Message-Id: <1253776613.7103.433.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bernhard.weirich@riedel.net,
	RFeany@mrv.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Weirich, Bernhard <Bernhard.Weirich@riedel.net>

The test that decides whether to define __HAVE_ARCH_PTE_SPECIAL on
powerpc is bogus and will end up always defining it, even when
_PAGE_SPECIAL is not supported (in which case it's 0) such as on
8xx or 40x processors.

Signed-off-by: Bernhard Weirich <bernhard.weirich@riedel.net>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pte-common.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Greg: I'm going to fix upstream differently, by having all CPU types
actually support _PAGE_SPECIAL, but I prefer the simple and obvious
fix for -stable.

This should apply to v2.6.30 and v2.6.31


diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index a7e210b..0cd2e34 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -176,7 +176,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #define HAVE_PAGE_AGP
 
 /* Advertise support for _PAGE_SPECIAL */
-#ifdef _PAGE_SPECIAL
+#if _PAGE_SPECIAL != 0
 #define __HAVE_ARCH_PTE_SPECIAL
 #endif
 
