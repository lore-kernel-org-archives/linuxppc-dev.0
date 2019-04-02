Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA54C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B20020856
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtEgzesw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B20020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKmW4TTKzDqCT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtEgzesw"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKBz2LlTzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:32:43 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id u9so6013167pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NHS2OJqKj6xRANV1sj2z+WTKmkExPEvasKWv9BLPxUI=;
 b=OtEgzesw2B0IUv5mVHvaxNwujAktKsr5w00A91ZxGIV7gsSSslrvvQxf8VWtStCEDx
 7082XQx6h/pRgh6LjRwyESCB3Gv30/T5Ir2zuFlTjt6qawwCZBgxeaVsThf/GY/aLEVl
 CGwcgudKMRvXmGv5Y+S9vKkzW5f8CZVEeTLHWxgcLc/2MlOEOpDp3zd8RA6wvYDHxCpV
 LgJI1oDSPvSxazZrqSe3lLHlIvG1JUNwvKhHeBl1Kvr4yeae9TH4B4D8LuR8OEylh0qV
 XP25kZvfRSgiEAN/nla8HGltQFI6dLx+Ji69nS25sPQQhbozx3hTyasVMWzBOhUrUcnO
 NBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NHS2OJqKj6xRANV1sj2z+WTKmkExPEvasKWv9BLPxUI=;
 b=G4H8SJkSw2LOuZSV0V2hYMKW0gwX7wBTlLWd3vZtqEs5HE2ALmGjawCWQtqQi6uFpj
 92T/fkMr3+W68CzL+1XP9KmsPK8a37FnGIeO4HYGxM8HhYqs5D9lxoqm8bK6i8MgTvQk
 LbJMSFgC3b4mr+/m8J2pmac1/ZuDAsNRY4gvldklTlpHcdwAYkLB8yR99Lt/VCOIG2cw
 b14bCQ6inWkb8RBoLULV0gCOqiGwbRhSGF8p0zvbk1oKEsOze+QbVaz6YV6JCKu0I8SL
 E7eI6FoE3/AWtcah/+6MjJC7DMHw39YvNZWyu7cjwBIVOVE2W92mqMny5I7Q2u2LQzlg
 UfVA==
X-Gm-Message-State: APjAAAUJNj8PEwim+9+Y/bf0YqVWxh+SaN+DwVEwDamCkgHuRMe7qdmb
 WzbV6nKw7WXUeyJYVsAGL6U=
X-Google-Smtp-Source: APXvYqwp7lbXFM74wVWgWuUn8e2AojrE5yckHl/rYqUc14StMv0sEf9qHtA/NNgvqW3iXpZdFch9yQ==
X-Received: by 2002:a63:6c87:: with SMTP id
 h129mr65618774pgc.190.1554186761385; 
 Mon, 01 Apr 2019 23:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:32:40 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 15/18] dt-bindings: counter: ftm-quaddec
Date: Tue,  2 Apr 2019 15:30:50 +0900
Message-Id: <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 William Breathitt Gray <vilhelm.gray@gmail.com>, robh+dt@kernel.org,
 tglx@linutronix.de, fabrice.gasnier@st.com, esben@haabendal.dk,
 shawnguo@kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 knaack.h@gmx.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Patrick Havelange <patrick.havelange@essensium.com>

FlexTimer quadrature decoder driver.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
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
2.21.0

