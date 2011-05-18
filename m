Return-Path: <ericvh@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B78FB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:25:26 +1000 (EST)
Received: by mail-yx0-f179.google.com with SMTP id 4so780924yxp.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 14:25:26 -0700 (PDT)
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] [RFC] enable early TLBs for BG/P
Date: Wed, 18 May 2011 16:24:54 -0500
Message-Id: <1305753895-24845-6-git-send-email-ericvh@gmail.com>
In-Reply-To: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BG/P maps firmware with an early TLB

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 arch/powerpc/include/asm/mmu-44x.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index ca1b90c..2807d6e 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -115,8 +115,12 @@ typedef struct {
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_PPC_EARLY_DEBUG_44x
+#ifndef CONFIG_BGP
 #define PPC44x_EARLY_TLBS	1
-#else
+#else /* CONFIG_BGP */
+#define PPC44x_EARLY_TLBS	2
+#endif /* CONFIG_BGP */
+#else /* CONFIG_PPC_EARLY_DEBUG_44x */
 #define PPC44x_EARLY_TLBS	2
 #define PPC44x_EARLY_DEBUG_VIRTADDR	(ASM_CONST(0xf0000000) \
 	| (ASM_CONST(CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW) & 0xffff))
-- 
1.7.4.1
