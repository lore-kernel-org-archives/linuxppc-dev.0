Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfZ4z3wjmzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 00:28:03 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH 1/3] powerpc/corenet: explicitly disable the SDHC controller
 on kmcoge4
Date: Thu, 15 Dec 2016 14:22:26 +0100
Message-Id: <1481808148-16840-2-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1481808148-16840-1-git-send-email-valentin.longchamp@keymile.com>
References: <1481808148-16840-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is not implemented on the kmcoge4 hardware and if not disabled it
leads to error messages with the corenet32_smp_defconfig.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/powerpc/boot/dts/fsl/kmcoge4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
index ae70a24..e103c0f 100644
--- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
@@ -83,6 +83,10 @@
 			};
 		};
 
+		sdhc@114000 {
+			status = "disabled";
+		};
+
 		i2c@119000 {
 			status = "disabled";
 		};
-- 
1.8.3.1
