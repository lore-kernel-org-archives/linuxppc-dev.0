Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC4C43179
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F98208D5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F98208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GXNB4xg6zDr8V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 01:04:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GXDJ6xSPzDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 00:57:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43GXDJ64Zsz9s3q; Sat, 15 Dec 2018 00:57:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43GXDJ5fXBz9sB5; Sat, 15 Dec 2018 00:57:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/configs: Don't enable PPC_EARLY_DEBUG in defconfigs
Date: Sat, 15 Dec 2018 00:57:11 +1100
Message-Id: <20181214135711.10552-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alistair@popple.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts the remains of commit b9ef7d6b11c1 ("powerpc: Update
default configurations").

That commit was proceeded by a commit which added a config option to
control use of BOOTX for early debug, ie. PPC_EARLY_DEBUG_BOOTX, and
then the update of the defconfigs was intended to not change behaviour
by then enabling the new config option.

However enabling PPC_EARLY_DEBUG had other consequences, notably
causing us to register the udbg console at the end of udbg_early_init().

This means on a system which doesn't have anything that BOOTX can
use (most systems), we register the udbg console very early but the
bootx code just throws everything away, meaning early boot messages
are never printed to the console.

What we want to happen is for the udbg console to only be registered
later (from setup_arch()) once we've setup udbg_putc, and then all
early boot messages will be replayed.

Fixes: b9ef7d6b11c1 ("powerpc: Update default configurations")
Reported-by: Torsten Duwe <duwe@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/maple_defconfig  | 1 -
 arch/powerpc/configs/pmac32_defconfig | 1 -
 arch/powerpc/configs/ppc64_defconfig  | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index f686cc1eac0b..ceb3c770786f 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -246,7 +246,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index f71eddafb02f..c5f2005005d3 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -108,7 +108,6 @@ CONFIG_LATENCYTOP=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 62948d198d7f..50b610b48914 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -297,7 +297,6 @@ CONFIG_LATENCYTOP=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 294a0b9d6038..91fdb619b484 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -376,4 +376,3 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 7ee736f20774..53687c3a70c4 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1155,7 +1155,6 @@ CONFIG_STACK_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
-- 
2.17.2

