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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E99C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:03:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C1206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhk+UoUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKtq710bzDq5j
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:03:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fhk+UoUS"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKCY6jNNzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:33:13 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id b65so5729229plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/SViyYrS1FftN56nFj/LUBMdZmL6citnsb/V8UFB/zw=;
 b=fhk+UoUSzOrDtXSxqqb3QYerakbuvYA/XLrrnRu2go7f0rY0KK4Eq1j0EjG7l9mctI
 MPxxWV45JWRPcRASmeIznO0nXcm03KnfzZIlpzxUQXbf7l16Hd6RPPb8fFP9ikw+FlYm
 zuVVSEVUzzyy52gVcfrI7d9qL5FBr/mp2ww+ig67ad/9j4RzixtxIoB20uGkiMK1pgRd
 p5O/1phRXB9Gmr64ZC26q8zE7rMt9QcfbIVZL5oZ+LbdGKR4b7y+9le3b6mdTmYKLEns
 6bpNwg2lE1x01CDTK9Ok/tirWTdKP02Et/Ym+o8xHkCN5xWXYmITdCHZmtUSyZqXVfwS
 D6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/SViyYrS1FftN56nFj/LUBMdZmL6citnsb/V8UFB/zw=;
 b=lue5TPyMs7IK0pozImS57lN8170RZy0UeU0rjKhG9BpiQWBoQE80P3Yq+ElR9GlzRe
 /pp9Zush4LXo/Gga+4caxuBkLh9wWZ94ffyCq8SADlp0oe0eKSfiWjuUxOKvxUMjH/Uw
 FBMQKgldaHW64ipmpb9j3FLB54m5QsUt/sH70kPrxLax04J8/MX+GWSF3jI7AacD+Wjy
 awXksKsMoHfL2Yuc+JPkEfidE+qevtabKChyy4zQLvB/EJ3LgvKDcEpMssvE4lvk1MNQ
 tubr850icb+qwGK5jFyEGQ3reevdWO+vmzkw1Z4KlF1YzyMyvJt8tbJ96YAGJdRK87Tk
 YObQ==
X-Gm-Message-State: APjAAAXUumNc6I0XOa3TdBLy+zxUYCV8dE1NM9Er8x+9O0vSCSmnyqIM
 CjGVZTqi82a2Oy0jKestPTk=
X-Google-Smtp-Source: APXvYqx+LDaXvVGOMIPeO233vrs3m+tOzvhaXEMY4h32Y28CavB8ya4LXqA/dRJssrqtXHZkbEdfaw==
X-Received: by 2002:a17:902:2a29:: with SMTP id
 i38mr70041345plb.22.1554186790652; 
 Mon, 01 Apr 2019 23:33:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:33:10 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 18/18] LS1021A: dtsi: add ftm quad decoder entries
Date: Tue,  2 Apr 2019 15:30:53 +0900
Message-Id: <58aec84fb201e7ba2e24ff51f8fd1b4261d6b895.1554184734.git.vilhelm.gray@gmail.com>
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

Add the 4 Quadrature counters for this board.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
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
2.21.0

