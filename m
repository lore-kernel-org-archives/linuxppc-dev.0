Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C3C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:55:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E2720827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 12:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e0vvQH5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E2720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ysgc4CbVzDqSW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 23:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="e0vvQH5r"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YscX1kMgzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 23:52:59 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id n190so4050634wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=0F4k4YtVOnMFo5jh8Gnlg0kYbmRjxVoumr7jiM5rHqI=;
 b=e0vvQH5rBGL9wdtGa6CX6FX0PiHKYqSFsB2gPVDMdafpp3kNWqnMmIrzImOF8kvQvb
 3lRaoMIxgcGd4Bhob0XP1P3lYOshXbea/F9o3nPPTqxBKZNv9Am5yOO873kv8cdgMUPl
 g9LWeoNpFqYrwxQ4+XKOumbIS9mqV8IzlAXXFZEIvJhkQ1eBEEDHqHf/jjeRFjoYmQTk
 625ky33Lb4X5A87OOGTUZK1ra1xdEeyYrw1EjdjeJ3/V1tQDrfvlRguuZGbTzkoojTYk
 MD3nVtFamo5LU/b63dDE7U98Gl4KqJEJRDVJsYYOBFenryAoxjrNdrn5vxwoxjHNawuT
 i7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0F4k4YtVOnMFo5jh8Gnlg0kYbmRjxVoumr7jiM5rHqI=;
 b=pD76hOaiqzGoEj0GDSfIgsjUo9X2AVpj8N2EovFzZvN4z7B/KIVWz1kocfiVQbV68y
 vl3q6tQUmywJyK59m3VkubjbL9+LILD2G/VxjZ49ugSqQrAR6VTB7YAyzmfSzIrxt2hP
 a5G0y9IVOKcwaH5Ht1cQ7wttqZZoQ6jGv3kddb4o9ox836FlTbmar8RbdGE8/lNPVXyF
 eEVQAA/xeZiz9wJD5pC31+lMaOYjEdU69bpIp71aJwt0pbllVHJlEMBjY8gWZXoEfh5Z
 0p7aktSFKaEk2VL3EZxp9bD3JBzwkpiAwpgm1pUBBZyN5FI10rS+nr1qMwYZVVFMol0H
 JBgA==
X-Gm-Message-State: AJcUukdGiTB1wTJNj/jbi7tTGS3ZeXt+VB2F091PkEKyiu3mGcNlzyBq
 s+vEo3a4Mkan+IY0C5s3SIAw2Q==
X-Google-Smtp-Source: ALg8bN5yVh6pLVRUMaEv2IIrJnAVglcZ6pj1YNfX8iW6u0vavGa46yMZerCKWD8CFs4JPbv/ALzQJg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1772220wmf.117.1546951976580; 
 Tue, 08 Jan 2019 04:52:56 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id 67sm81044121wra.37.2019.01.08.04.52.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 08 Jan 2019 04:52:55 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
 paulus@samba.org, robh+dt@kernel.org
Subject: [PATCH] powerpc: build virtex dtb
Date: Tue,  8 Jan 2019 12:52:50 +0000
Message-Id: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
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

This patchs adds build of virtex dtbs depending on
CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..cae14fca682e 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -4,3 +4,5 @@ subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb
+dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml510.dtb
-- 
2.19.2

