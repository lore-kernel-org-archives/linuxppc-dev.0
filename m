Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FBC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 16:38:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2084660232
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 16:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084660232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FcGNG4Y9hz3098
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 02:38:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FcGMv145zz2yY7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 May 2021 02:37:59 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FcGMk6w9Qz9sb2;
 Fri,  7 May 2021 18:37:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iZj_GOJ_yNpY; Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FcGMk6109z9sb1;
 Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ADD488B835;
 Fri,  7 May 2021 18:37:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kb8OqGOTT2os; Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 412DD8B81C;
 Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0430B64923; Fri,  7 May 2021 16:37:53 +0000 (UTC)
Message-Id: <2541e4e415505b27db8ccbb8977035c20e408ef4.1620405461.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/8xx: Update mpc885_ads_defconfig to improve CI
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  7 May 2021 16:37:53 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

mpc885_ads_defconfig is used by several CI robots.

A few functionnalities are specific to 8xx and are not covered
by other default configuration, so improve build test coverage
by adding them to mpc885_ads_defconfig.

8xx is the only platform supporting 16k page size in addition
to 4k page size. Considering that 4k page size is widely tested
by other configurations, lets make 16k pages the selection for
8xx, as it has demonstrated in the past to be a weakness.

CONFIG_PIN_TLB is specific to 8xx, select it as it mainly adds
code with removing much.

CONFIG_BDI_SWITCH is specific to PPC32 and adds codes.

CONFIG_PPC_PTDUMP has specific part for 8xx.

CONFIG_MODULES has specific handling for 8xx.

CONFIG_SMC_UCODE_PATCH is specific to 8xx for loading microcode.

CONFIG_PERF_EVENTS has specific parts for 8xx.

CONFIG_MATH_EMULATION is used by 8xx.

CONFIG_STRICT_KERNEL_RWX has specificities for 8xx.

CONFIG_VIRT_CPU_ACCOUNTING_NATIVE has specific parts for PPC32.

CONFIG_IPV6 has specificities for PPC32.

CONFIG_BPF_JIT has specificities for PPC32.

A few drivers are tightly linked to the 8xx:
- CONFIG_SPI_FSL_SPI
- CONFIG_CRYPTO_DEV_TALITOS
- CONFIG_8xxx_WDT
- CONFIG_8xx_GPIO
- CONFIG_PPC_EARLY_DEBUG_CPM

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/configs/mpc885_ads_defconfig | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 949ff9ccda5e..d21f266cea9a 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -57,3 +57,28 @@ CONFIG_CRC32_SLICEBY4=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PPC_16K_PAGES=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_FS=y
+CONFIG_PPC_PTDUMP=y
+CONFIG_MODULES=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_DEV_TALITOS=y
+CONFIG_8xx_GPIO=y
+CONFIG_WATCHDOG=y
+CONFIG_8xxx_WDT=y
+CONFIG_SMC_UCODE_PATCH=y
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_PIN_TLB=y
+CONFIG_PERF_EVENTS=y
+CONFIG_MATH_EMULATION=y
+CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_IPV6=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_VM_PGTABLE=y
+CONFIG_BDI_SWITCH=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xff002008
-- 
2.25.0

