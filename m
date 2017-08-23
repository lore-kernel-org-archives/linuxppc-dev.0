Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnK4ynKzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 35/46] powerpc/configs/6xx: Turn CONFIG_DRM_RADEON back on
Date: Wed, 23 Aug 2017 15:37:55 +1000
Message-Id: <1503466686-10932-36-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit d92d9c3a1448 ("drm: hide legacy drivers with CONFIG_DRM_LEGACY")
CONFIG_DRM_RADEON was moved behind CONFIG_DRM_LEGACY meaning it
stopped being enabled by ppc6xx_defconfig. Although no one has
noticed, given this is basically a legacy platform, it seems anyone
who is using it probably still wants this driver. So turn it back on
for now.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 60ccfa966ea9..4d845c49e77f 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -744,9 +744,10 @@ CONFIG_MFD_SM501_GPIO=y
 CONFIG_AGP=y
 CONFIG_AGP_UNINORTH=y
 CONFIG_DRM=m
+CONFIG_DRM_RADEON=m
+CONFIG_DRM_LEGACY=y
 CONFIG_DRM_TDFX=m
 CONFIG_DRM_R128=m
-CONFIG_DRM_RADEON=m
 CONFIG_DRM_MGA=m
 CONFIG_DRM_SIS=m
 CONFIG_DRM_VIA=m
-- 
2.7.4
