Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9437CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4D42146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="oGtwGp0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4D42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JTY0KZvzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="oGtwGp0c"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FS4MjBzDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:56 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id p27so6365763edc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
 b=oGtwGp0cHyc/ThOhI0NGYWLVDSrVX2SWB9ZJ86TRWH4C14DlC7FmlBqmeHKpbD4ucE
 vy/cFD//qkNVp/7JweqiNyeeg6fDH7HUF9mA0hk3Qp+XvmGXydwbBtQScNcqt99PQqJj
 fXJiLwhkrLzTHy8oWETYAmZeDKsH/sLeZhett9YfcfNF3hxuBS6vcRFn1IuHqEM0GQrJ
 scnLF3d9dBAcbYPSfUy/wulNDGyhsraiJpy/A78BMb5aGPAuPBzsm9QQa9gq2UtvAHin
 5jYZqBKuzSOiKZeBUYrIuuIng+KsDiIFRHsTEbrGCCOO34hD2CMy1H1kiXUMQDAfUcYo
 cHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
 b=dkbZshvgrh+0aTy23zuG3Eycq3GGC8Il72qs6vln9KN1H45IGuts/82y9KcJgpYsEw
 dKlnZ5otowH2ua32g5riE3U7dG4yDklZyaJOJxOQLU7XfxGFSL/J1G0rTVGpCeRO5tB9
 gYX27iYwRl+Dn69B9YiaL8kpAAHu53ja2xnTjlFjS8d2CdWFaeWmlpmZ+V0qDkzEngEZ
 mwlNUSa0tKm/xXyjZSuLkqLOsd4t90O/6PnjQJlB6zmrBYM4YMBR40TeYw1YyTkKvrhK
 3Kws8XiTDtoA4EyjdLYVM+AQdb1o3K38QvYBW61CN+DVvvlM9r23rV6SUkRnGF6aW+uh
 DB9A==
X-Gm-Message-State: AHQUAub/rK4ebotOpWh9AMBAEb558Mqpwba3dKk2z+7Ld/l5ojluiWrY
 pmKjiL8UFCF40y91PfrJpjozVA==
X-Google-Smtp-Source: AHgI3IaGiJP5XG+ub4Q/7liQMN3rjPdmMOiO1kL3JJ7SmjuWWM5ZIcTeHoTOJT8m3tJlRpqM6BKEYA==
X-Received: by 2002:a17:906:1552:: with SMTP id
 c18mr8653338ejd.64.1550498633824; 
 Mon, 18 Feb 2019 06:03:53 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:53 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/8] LS1021A: dtsi: add ftm quad decoder entries
Date: Mon, 18 Feb 2019 15:03:19 +0100
Message-Id: <20190218140321.19166-6-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-Mailman-Approved-At: Tue, 19 Feb 2019 09:22:41 +1100
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.17.1

