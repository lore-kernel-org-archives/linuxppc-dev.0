Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpLmp70kczDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 09:25:30 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/configs: Enable VMX crypto
Date: Tue, 12 Jul 2016 09:25:21 +1000
Message-Id: <1468279521-9720-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

We see big improvements with the VMX crypto functions (often 10x or more),
so enable it as a module.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 2 ++
 arch/powerpc/configs/pseries_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index dce352e..3f6226b 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -310,6 +310,8 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_DEV_NX=y
+CONFIG_CRYPTO_DEV_VMX=y
+CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 99dec9d..1d7eea2 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -313,6 +313,8 @@ CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
+CONFIG_CRYPTO_DEV_VMX=y
+CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
-- 
2.7.4
