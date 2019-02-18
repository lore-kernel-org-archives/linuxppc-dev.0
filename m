Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E13C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEB72146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 22:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="KJPSI94h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443JWb6N4lzDqBL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="KJPSI94h"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435FV269qzDq67
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:03:58 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id b20so13876301edw.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
 b=KJPSI94h/3tr09gSDgWJ5ok7TSJC7JE/SFp+CPCPi5fV/xhzlIP8m+1T5aj3kNAVCS
 xawDKsAC8POcScc1qfEU3Mx7JR/0TIz2paMShO/Y2zlRdoxPpLXQcVNXOi1BkhNbvT5t
 k0Dsnts9zdDl5ya7+AE5PYVl1eet6ZUddv22gxrkx+FfPCHE1QFt1rqHB425oMLtX2dH
 DLj9oeRh/NaIiuETNkVr+lgZUDEJeC/mlCLreb/nV4Sgwr66LdO2XTOmd/gnnQ92GugB
 s6PgCWxnsmxMFnaVMIB24Cm2z6lH0e8xo+pB9gUvDoZQ5IXH9k28jMdD5ZInypUxMlVn
 vJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
 b=OeYcnxdJb4kXyLOvi+vL0l6UZpbCT4/Xqe6EHSbohlRN/EpqYRIBMFT4BXnAiBK5M+
 rrzZ9XNTPKvFKphTtV6E5LlZgwBKFvZ0kGfvnoGH/ztQdz5jKW7KFWpqkKA3JuEwKSaL
 4W9WS5L0HrfVEdBo36B97ZGqlyg8g/E3UyvztylT2j3vYfyDhOk+NQj6Yo/z4pbYJQcs
 d/2NRsS9NqZkG4ZUgXHTRcDRw/9bkTX0IMCTz1T7hqv6JCpwAh1qBnT0L9FSEprvhrU4
 IzM/W1q2AGVK0xzx4L6Wjt/dD751e4jALdOx/F6bmFmIIDLqovxoVid12eTvu/QWahQX
 lDJw==
X-Gm-Message-State: AHQUAubdIbn+1HWpKo7JRnbGYpAGaBn6c59Ry5RXgNhy5/iiZ5wA5VYy
 XdPCOEXqbzAqS+nSVLuME2wjXw==
X-Google-Smtp-Source: AHgI3IZWqJlESiACGZSBuFtcSlgUTXzB5UwYLjy0fJjTMr4Yq/bz8Bc0PoTINj2B3ihTtaQ8an9+iQ==
X-Received: by 2002:a50:fc12:: with SMTP id i18mr19300418edr.149.1550498635286; 
 Mon, 18 Feb 2019 06:03:55 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:54 -0800 (PST)
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
Subject: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add poll-interval
 parameter
Date: Mon, 18 Feb 2019 15:03:20 +0100
Message-Id: <20190218140321.19166-7-patrick.havelange@essensium.com>
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

New optional parameter supported by updated driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
index 4d18cd722074..60554e6c4367 100644
--- a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -6,8 +6,14 @@ Required properties:
 - compatible:		Must be "fsl,ftm-quaddec".
 - reg:			Must be set to the memory region of the flextimer.
 
-Optional property:
+Optional properties:
 - big-endian:		Access the device registers in big-endian mode.
+- poll-interval		Poll interval time in milliseconds for detecting
+			the under/overflow of the counter. Default value
+			is 100.
+			A value of 0 disables polling. This value can also
+			be set at runtime, but not to less than this initial
+			value (except 0 for disabling).
 
 Example:
 		counter0: counter@29d0000 {
-- 
2.17.1

