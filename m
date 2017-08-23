Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnF5BbBzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 25/46] powerpc/configs: Add CONFIG_RAS now required for
 CONFIG_EDAC
Date: Wed, 23 Aug 2017 15:37:45 +1000
Message-Id: <1503466686-10932-26-git-send-email-mpe@ellerman.id.au>
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

In commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") CONFIG_EDAC grew
a dependency on CONFIG_RAS. Some of our defconfigs don't have the
latter, which means we lose CONFIG_EDAC, so add CONFIG_RAS to fix
that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/pasemi_defconfig | 1 +
 arch/powerpc/configs/ppc64_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 9d43214a4de4..8cf4a46bef86 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -144,6 +144,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_PASEMI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_RAS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 119273e6ba04..3a1697f97fef 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -264,6 +264,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
+CONFIG_RAS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.7.4
