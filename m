Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D9C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 03:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8474820731
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 03:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474820731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cw3h40mnnzDqMn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 14:31:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cw3dg0BCtzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2020 14:29:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YXr9wTd8; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4Cw3df5kH4z9sSC; Tue, 15 Dec 2020 14:29:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Cw3df4vv1z9sTL; Tue, 15 Dec 2020 14:29:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1608002950;
 bh=51HQqD+LFXc1awO15HMTfrlKXfR/56aQ965FGFAbY44=;
 h=From:To:Cc:Subject:Date:From;
 b=YXr9wTd8GA/hgTGEGrZTq9JTJPPL+O9rs8QDlTEMbkU3SysborVGWP75mMI7aj2T4
 zYXwHZoxDHFPflpq/3iOhiSvLc+eGG7WrYpKdB9MxJrLD932MXZJd3wIrrKFJFQbPy
 dYwB2+j+4i8LuWeXwwWVcmpcAoE3+ozF0h7P6ZwN9GgqSfFRO+4BMVkqekUjTKTD6f
 I3LSc0Xb4DR1v/ETGphbeiJlfpvhSCnHCILgl206cfiPQniJpDeOaNp3sh3CbWOTON
 HealgboC8TJyf7660tRfy3VruacOOQwv2V4Vnv2ud/Hj/cjleFbEKEYTn3CayIUS5r
 vkjFl9v3opHSg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: masahiroy@kernel.org
Subject: [PATCH] powerpc/boot: Fix build of dts/fsl
Date: Tue, 15 Dec 2020 14:29:06 +1100
Message-Id: <20201215032906.473460-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The lkp robot reported that some configs fail to build, for example
mpc85xx_smp_defconfig, with:

  cc1: fatal error: opening output file arch/powerpc/boot/dts/fsl/.mpc8540ads.dtb.dts.tmp: No such file or directory

This bisects to:
  cc8a51ca6f05 ("kbuild: always create directories of targets")

Although that commit claims to be about in-tree builds, it somehow
breaks out-of-tree builds. But presumably it's just exposing a latent
bug in our Makefiles.

We can fix it by adding to targets for dts/fsl in the same way that we
do for dts.

Fixes: cc8a51ca6f05 ("kbuild: always create directories of targets")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 68a7534454cd..c3e084cceaed 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -372,6 +372,8 @@ initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
 targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
 		$(patsubst $(x).%, dts/%.dtb, $(filter $(x).%, $(image-y))))
+targets += $(foreach x, dtbImage uImage cuImage simpleImage treeImage, \
+		$(patsubst $(x).%, dts/fsl/%.dtb, $(filter $(x).%, $(image-y))))
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
-- 
2.25.1

