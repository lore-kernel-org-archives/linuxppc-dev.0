Return-Path: <jrtc27@jrtc27.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RTt65dGnzF35Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 07:42:00 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id n17-v6so7498493wmh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 14:42:00 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: James Clarke <jrtc27@jrtc27.com>
Subject: [PATCH] powerpc/Makefile: Assemble with -me500 when building for E500
Date: Thu, 12 Jul 2018 22:41:49 +0100
Message-Id: <20180712214149.19587-1-jrtc27@jrtc27.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the assembly files use instructions specific to BookE or E500,
which are rejected with the now-default -mcpu=powerpc, so we must pass
-me500 to the assembler just as we pass -me200 for E200.

Fixes: 4bf4f42a2feb ("powerpc/kbuild: Set default generic machine type for 32-bit compile")
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ea575cb..fb96206d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -243,6 +243,7 @@ endif
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
+cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
 cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
-- 
2.18.0
