Return-Path: <R1AAHA@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69925B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:50:42 +1000 (EST)
Date: Fri, 22 Jul 2011 15:48:08 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] powerpc/85xx: enable caam crypto driver by default
Message-ID: <20110722154808.a9cabea2.kim.phillips@freescale.com>
In-Reply-To: <20110605173958.1073f245.kim.phillips@freescale.com>
References: <20110605173958.1073f245.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

corenet based SoCs have SEC4 h/w, so enable the SEC4 driver,
caam, and the algorithms it supports, and disable the
SEC2/3 driver, talitos.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
v2: rebase from old e55xx_smp_defconfig file to new corenet & p1023
defconfigs

 arch/powerpc/configs/85xx/p1023rds_defconfig |    1 +
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    5 ++++-
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index 980ff8f..3ff5a81 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -171,3 +171,4 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 10562a5..4311d02 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -185,3 +185,4 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index d322835..c92c204 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -100,5 +100,8 @@ CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_VIRQ_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_TALITOS=y
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
-- 
1.7.6
