Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 10:00:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF4D21871
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 10:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kN/2bOyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF4D21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WKyl51rLzDqKN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:59:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="kN/2bOyy"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WKx15fxwzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 20:58:25 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id b14so31279265edt.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=h+Rf+jAwqRnDHxDwfVstrC8MiBhsGyo9qIPQ48nJo/A=;
 b=kN/2bOyyitvBG50l4dxdoLPLeJY+bnGWVNBPhozL2pP2E7+2PA60xSohrja3Ias29n
 YZTuQH2cckAu717LEgmGF5kMI1V4+IAdpVaQWtbCR6zFY47AAh9gKLergEF04vHsgicS
 Tvr4Tm6YbfEDqtQ+9nRcnWv4jfDY6u/yIIGZ62zRzpjS37+5H02kB+lisKKbgm02C6/b
 9VPojaYhaHjJ2aeNsSrdz3oA+RhiuKRDZnOtZ5CvWSJLrJl2MRCdKy4c4F3ihRsHkosf
 WGselI1x8j+NycMNSldDcFsZKHf34h/VoNQnRwrlomsw/vshrXHpYndEffJapVIVgpwv
 nLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=h+Rf+jAwqRnDHxDwfVstrC8MiBhsGyo9qIPQ48nJo/A=;
 b=ZU0Q/HIXrC29iwPLnsei3y1vO3YaKmpYbUcVoExycVKh4vV8UbIBtFWXcppHIhnX3l
 qMDsTKwiVeUAGoe3jq6i1qp0w7PBi/eCwAI7WzNZ4b3Wo7QjhlqjYsnwoh7S12/l7kEt
 Tz89ZR5BuSoP7zsuhi+6NdsNlYLKeGRtZd98pJcRETxsK7z7zMGFGmyvDdE7yAnHwxRM
 p3R6JnbDuktkvvE3QwokfyMUePYCwGIvLI3/8XLglWVvjDHshyu70gyZNmzz1UxkCP/k
 FEVIL7SzPYXvbTKpGKXdcpXWQuoDIHiN+khZA9jQM5KNTxF7UdutoRmpc6uDo8i2Z0De
 Al0Q==
X-Gm-Message-State: AA+aEWaqjkFQmFlmRvNxd3SPUHcuAzhCIQKPtpRS+aoaA3zVoUHGtIw/
 IMSRiiR43oLET79b+hERiT8lfA==
X-Google-Smtp-Source: AFSGD/U+tvfODn5sU/FW74Zikyssyqk7OlLdENLg8vcSWA2wchRBS9n2WQreMVm5lcoGkRk59OBTmw==
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr46484192edx.208.1546595902550; 
 Fri, 04 Jan 2019 01:58:22 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id j23sm22386663edr.89.2019.01.04.01.58.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 01:58:21 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 paulus@samba.org, robh+dt@kernel.org
Subject: [PATCH] powerpc: build dtb even without COMPILE_TEST
Date: Fri,  4 Jan 2019 09:58:17 +0000
Message-Id: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I wanted to test the virtex440-ml507 qemu machine and found that the dtb
for it was not builded.
All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
COMPILE_TEST.
But building DTB is not related to a "compile build test".

So this patch made building of DTB independent of COMPILE_TEST (by
depending only on the PPC arch)
A better selection of which DTB to build could be done in the future
like that do the ARM arch.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/boot/dts/Makefile     | 2 +-
 arch/powerpc/boot/dts/fsl/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..3a73cf41585b 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -3,4 +3,4 @@
 subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_PPC) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index 3bae982641e9..27c5ca3a35be 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_PPC) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.19.2

