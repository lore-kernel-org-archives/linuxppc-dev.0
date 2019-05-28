Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95238C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 08:17:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA422075C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 08:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA422075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CmtH0SH2zDqLf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 18:17:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Cmrj354MzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 18:16:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45Cmrj1pw0z9s5c; Tue, 28 May 2019 18:16:21 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45Cmrj0wRKz9s7h; Tue, 28 May 2019 18:16:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/configs: Rename foo_basic_defconfig to foo_base.config
Date: Tue, 28 May 2019 18:16:14 +1000
Message-Id: <20190528081614.26096-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We have several "defconfigs" that are not actually full defconfigs
they are just a base set of options which are then merged with other
fragments to produce a working defconfig.

The most obvious example is corenet_basic_defconfig which only
contains one symbol CONFIG_CORENET_GENERIC=y. But there is also
mpc85xx_base_defconfig which doesn't actually enable CONFIG_PPC_85xx.

To avoid confusion, rename these config fragments to "foo_base.config"
to make it clearer that they are not full defconfigs.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile                                | 12 ++++++------
 .../{corenet_basic_defconfig => corenet_base.config} |  0
 .../{mpc85xx_basic_defconfig => mpc85xx_base.config} |  0
 .../{mpc86xx_basic_defconfig => mpc86xx_base.config} |  0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/configs/{corenet_basic_defconfig => corenet_base.config} (100%)
 rename arch/powerpc/configs/{mpc85xx_basic_defconfig => mpc85xx_base.config} (100%)
 rename arch/powerpc/configs/{mpc86xx_basic_defconfig => mpc86xx_base.config} (100%)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c345b79414a9..94f735db2229 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -333,32 +333,32 @@ PHONY += powernv_be_defconfig
 
 PHONY += mpc85xx_defconfig
 mpc85xx_defconfig:
-	$(call merge_into_defconfig,mpc85xx_basic_defconfig,\
+	$(call merge_into_defconfig,mpc85xx_base.config,\
 		85xx-32bit 85xx-hw fsl-emb-nonhw)
 
 PHONY += mpc85xx_smp_defconfig
 mpc85xx_smp_defconfig:
-	$(call merge_into_defconfig,mpc85xx_basic_defconfig,\
+	$(call merge_into_defconfig,mpc85xx_base.config,\
 		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw)
 
 PHONY += corenet32_smp_defconfig
 corenet32_smp_defconfig:
-	$(call merge_into_defconfig,corenet_basic_defconfig,\
+	$(call merge_into_defconfig,corenet_base.config,\
 		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw dpaa)
 
 PHONY += corenet64_smp_defconfig
 corenet64_smp_defconfig:
-	$(call merge_into_defconfig,corenet_basic_defconfig,\
+	$(call merge_into_defconfig,corenet_base.config,\
 		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw dpaa)
 
 PHONY += mpc86xx_defconfig
 mpc86xx_defconfig:
-	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
+	$(call merge_into_defconfig,mpc86xx_base.config,\
 		86xx-hw fsl-emb-nonhw)
 
 PHONY += mpc86xx_smp_defconfig
 mpc86xx_smp_defconfig:
-	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
+	$(call merge_into_defconfig,mpc86xx_base.config,\
 		86xx-smp 86xx-hw fsl-emb-nonhw)
 
 PHONY += ppc32_allmodconfig
diff --git a/arch/powerpc/configs/corenet_basic_defconfig b/arch/powerpc/configs/corenet_base.config
similarity index 100%
rename from arch/powerpc/configs/corenet_basic_defconfig
rename to arch/powerpc/configs/corenet_base.config
diff --git a/arch/powerpc/configs/mpc85xx_basic_defconfig b/arch/powerpc/configs/mpc85xx_base.config
similarity index 100%
rename from arch/powerpc/configs/mpc85xx_basic_defconfig
rename to arch/powerpc/configs/mpc85xx_base.config
diff --git a/arch/powerpc/configs/mpc86xx_basic_defconfig b/arch/powerpc/configs/mpc86xx_base.config
similarity index 100%
rename from arch/powerpc/configs/mpc86xx_basic_defconfig
rename to arch/powerpc/configs/mpc86xx_base.config
-- 
2.20.1

