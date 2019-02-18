Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0F7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:33:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DB12146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="kdHcXhxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JYM0sYdzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="kdHcXhxC"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FT1B1CzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:53 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id p27so6365645edc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
 b=kdHcXhxCjuyfL/RsbUdI7m1L2Yqy6Ch6aOf/JLBNnD5HRcGRSlgFnLV7GDHT0+O/ZH
 WwhadtXZC4vVGNOZDuBn55xN7S4uRWX++KyhraFKHbfOfDIpV2BF2i1X1ZZmPSUG4VoF
 AkRhIRakB9igwGHCOjQRaHFAWn158WcLofcO9Bvujyxj6a9Q5/FR2tK/sXcaVtMFDepB
 mzDtU5X9T6XAokc0oVHVyJYLk6aWrjK7mlq7vIRYN+67ZQfflVjoZTlS3hBnJ8v3vCvY
 cUmqgkNmUgZCJM9+9LD/mdkYFxEuSclcXauFOzLsjW1gmke/0ca5/PZRLVfeL0qwR77Y
 7kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
 b=kXM4k+XXJlNqX0yfHJHSGGbcVc64LBMYj3hdVppCqORi6yAO3bxSVvoLdOoqLA980l
 evbkZ9nq8ecWc2Tk++MKLwRTTXYoNQcGsbwmWdvmjRi5zXx5iRORXJpykldQrfkR882g
 XQxINqYYXi64s6TO+y0ytLW1gevGrtUCr0ldI61brgp11Je7yQF6zoysK5xoPYBclHhi
 5dduAHlok15lGuMRYNm7UBFnjHA7Z8xUmCnQFVB9yKXn5c1N0mMASFFC5EeB+aLN0Fir
 3l4jzlNfIQBTr33XVZviQ0C8gR6yMqmTJIsKrBzmUlh/YCEuiSsOrMhYAbAAwzXppg+m
 SAxg==
X-Gm-Message-State: AHQUAuYARMkEETvdbHWiipH1+oWECntdZGlvbMAsN7vQHHjUHD0EtE+J
 qHUur8oA/23Pu0WXyiizXzIycw==
X-Google-Smtp-Source: AHgI3IZi9n1v6BYfISfADbqQLufHezmPHIqiJiJUI3/6IPWV+cI2byGpqq/pa18Sn/cvn8B5knGS2w==
X-Received: by 2002:a17:906:ee2:: with SMTP id
 x2mr16832980eji.202.1550498631380; 
 Mon, 18 Feb 2019 06:03:51 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:50 -0800 (PST)
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
Subject: [PATCH 4/8] dt-bindings: iio/counter: ftm-quaddec
Date: Mon, 18 Feb 2019 15:03:17 +0100
Message-Id: <20190218140321.19166-4-patrick.havelange@essensium.com>
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

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../bindings/iio/counter/ftm-quaddec.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.17.1

