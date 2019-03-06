Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE8CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:28:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B42220675
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="B2QkguN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B42220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ds2843d4zDqD3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:28:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="B2QkguN+"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhQ1P7ZzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:38 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id a16so10014546edn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fBsJhgoGrFCnj+gqRWXLatgkoJvBbncuK8fMCwiAQ1o=;
 b=B2QkguN+LbzrcAwzI7m0frGmtI8TB6PVamnZR6METHHol5sq0ydKlyInzcbgJv/MrG
 fg2lt2msy/ap/hiVbl/VNkID3cTlvpPPoaLf6jWe0Dd+Sk2gynMYZTrU6bZr11A+pT+j
 OUtC0FcvP9iiqbwOS22aN5fn8PxXuJEBJrj0JMamWLZM3O2w0gfkb5Rz4QLgyMq8B6/S
 CKTCO/xiihyvUTE4ppXewgh+525H/1il+IeFz/+P1dE84S0vwXbgY2tp4VKZTmyyB9eE
 7CyQ/W2x9+ecIJ8J9MJ7nI7dB7CL/OWLHvx+F8ymntH7WxN0nEJztamnumjRGLcGnlyn
 ldlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fBsJhgoGrFCnj+gqRWXLatgkoJvBbncuK8fMCwiAQ1o=;
 b=HNcc0/vWrPbUArnTTy4dBRDpVBVoZkkSD5DMY+z4pvTVfijozFmQm20DBvgWNT/L5r
 hQOoIkPBRkeR3/NSg6IkqfqsZ8hoYFhSFqx0Qk+g/1JcH1lsVS5yCGP6AHa/TeegCqcj
 gIsAZKkWJTvG9niReyr9QqxxJlKr/twu594R3rN1zLzt7KWWo+SoE5pcJ0e7MhzSA3Mu
 bLr+TV0nQASO9tblXK364TAKpHdK5EShrfH0ZPaBhw0oOr3x5HCfv5lALxFDkVPz4zQl
 MJvFH6ahM0KddedPpuqZoCJO5KX65A6QpEB8jjjY5B13023ZRtO+08EfWBL8/CdQsADz
 ShYg==
X-Gm-Message-State: APjAAAU3nc5crPh/SY3MGUMFiJ7NgHUz2P4l4k69O7rHtXF8dYWKJbx4
 pbCfMozQpPOdqe4/OpMiQRM5dw==
X-Google-Smtp-Source: APXvYqyFXAXiCVWXtNAgaIj9RlYtrBEiJ3my+vfuQMRu/79RRgCn9B5KvgVZYlKL83oTfcThvrzD7g==
X-Received: by 2002:a50:ed8c:: with SMTP id h12mr22261726edr.128.1551870755623; 
 Wed, 06 Mar 2019 03:12:35 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:35 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 7/7] LS1021A: dtsi: add ftm quad decoder entries
Date: Wed,  6 Mar 2019 12:12:08 +0100
Message-Id: <20190306111208.7454-8-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
 - None
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
2.19.1

