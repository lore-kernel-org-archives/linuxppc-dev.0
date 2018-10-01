Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84170C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:30:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA8420645
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA8420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P5nX1Z83zDr6Q
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 01:30:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P5hL19DSzF31R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 01:25:37 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so13452231otl.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 08:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K0qpChji6w0LLSn0lM1GrJpAlsS+LmEXIOEhGGyEO8s=;
 b=eswSE6nHFJZQkZCqd5RCnfPIt1VIp/gpzUHec1nY5Wc19X/2NsQG/QSqBdc04cNLZg
 6i0tD3dhq7Uy0passDiDBtq3UOECYVXg00EleYz2AKnCmgX4mVemkbqoy9iyTlTBPCFy
 LJPkUJjzPDb4bn1Fhcfjl/pSW+EbFOOCsa7EeOutbcrCvtw2BxqrKs9yC0ca9tDf71OB
 BaNE7UdTqR61Rfxo4ImmAHueND43kxIdh5wwtmrNhgAb1KCVgkiEU+C0FBVG/Sw134mv
 kq2t+bxJgrV/dg5ZEFTdEunkzBrYPrB4A3oCt1A+NeVRI2fV/GyCsjaf5FTMQzuL5xvf
 xn8g==
X-Gm-Message-State: ABuFfojbFHMGrttvJowQ8ZTVwmq+m894GpUTq1X3CsbH7Pl2dxhki+3o
 7WixiZCxUXiWnijNT5mGcPZ+YxSQiA==
X-Google-Smtp-Source: ACcGV62NTIp2QT846//fWnNIjd4g3t93cOansO0u/0JN3eiIHDiUe3TPZ6mHpmgcuTn8g6O7RGxy6Q==
X-Received: by 2002:a9d:1566:: with SMTP id z35mr1502496otz.325.1538407535391; 
 Mon, 01 Oct 2018 08:25:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 s203-v6sm2047035oif.33.2018.10.01.08.25.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 08:25:34 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 1/9] powerpc: build .dtb files in dts directory
Date: Mon,  1 Oct 2018 10:25:23 -0500
Message-Id: <20181001152531.3385-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Align powerpc with other architectures which build the dtb files in the
same directory as the dts files. This is also in line with most other
build targets which are located in the same directory as the source.
This move will help enable the 'dtbs' target which builds all the dtbs
regardless of kernel config.

This transition could break some scripts if they expect dtb files in the
old location.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---

PPC maintainers, really need you review/ack on this.

 arch/powerpc/Makefile          |  2 +-
 arch/powerpc/boot/Makefile     | 55 ++++++++++++++++------------------
 arch/powerpc/boot/dts/Makefile |  1 +
 3 files changed, 28 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acba164a..53ea887eb34e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -294,7 +294,7 @@ bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)

 %.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)

 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..bca5c23767df 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -304,9 +304,9 @@ image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
 					   dtbImage.adder875-redboot

 # Board ports in arch/powerpc/platform/52xx/Kconfig
-image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 lite5200.dtb
-image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200b lite5200b.dtb
-image-$(CONFIG_PPC_MEDIA5200)		+= cuImage.media5200 media5200.dtb
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200b
+image-$(CONFIG_PPC_MEDIA5200)		+= cuImage.media5200

 # Board ports in arch/powerpc/platform/82xx/Kconfig
 image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
@@ -381,11 +381,11 @@ $(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperb
 	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))

 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
-$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
-	$(call if_changed,wrap,$*,,$(obj)/$*.dtb)
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
+	$(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb)

 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
 # prefix
@@ -395,36 +395,33 @@ $(obj)/vmlinux.strip: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits) FORCE
 	$(call if_changed,wrap,uboot)

-$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/uImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
+$(obj)/uImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/cuImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
+$(obj)/cuImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/simpleImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb)
+$(obj)/simpleImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb)

-$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+$(obj)/treeImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)

-$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
-	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
+$(obj)/treeImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
+	$(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb)

-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
-	$(call if_changed_dep,dtc)
+# Needed for the above targets to work with dts/fsl/ files
+$(obj)/dts/%.dtb: $(obj)/dts/fsl/%.dtb
+	@cp $< $@

 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/powerpc/boot/dts/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
--
2.17.1
