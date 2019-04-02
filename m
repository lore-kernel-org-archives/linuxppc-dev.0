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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B17C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:02:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C21206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX6JIZqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C21206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKrp2XtgzDq9p
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:02:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FX6JIZqz"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKCN3JynzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:33:04 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id 8so5838835pfr.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dHZ0ys7QT6DS6LbvlqKk410H9kGaWEJZlcsSa1/ZJoE=;
 b=FX6JIZqz0xEX86ficCeBVsIIY/NYiOZpzl/XHvjJ6TU8RYpOvRwUlwPkKEFUL9uOR/
 moSQzqJ5yuOrjJAYZeym+ZuP9M3TPlLGgtRtvEwF1lngzxMM/4SF6R68O8+LweVtSCK6
 hq0Dv6XVHuw2EXQ2Iduf1MctTp41niv4mFVEGRR5V2mSNK2s6o4dbCzkRG4wdDmV0RgO
 Okbavz9RaJc/Vn7fTxoLfkMdVPcAuJp+zVs8N1pqSx+nMoHVAOiecRJQ23BMlsCnN71d
 xcwhGHgckkSshU9sUBZqhd86yQk+TLDvcK6Gpc/O2MdIth2kFA2ymvxtS8JZH0+zqaNM
 reDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dHZ0ys7QT6DS6LbvlqKk410H9kGaWEJZlcsSa1/ZJoE=;
 b=VojGPDQCfMuw6AO0xsUrYlH7n9rK/imBU8izRgHO/AxbNrUV5Sn8eY6GegsfDmSS7v
 naX2SmEAjXwBHCKqAExk9IUIMRc49eCc8zCAt2PFpz9ZglP8h8322bJsVKHxwCwNZuLw
 WeKj4Kj6cxmb98gQZut+4z3c0ZPWKil9Q5TLq0uEMPOXZ8gIvvuxfkUpw6FO4mcd/TkE
 5oanTn+6E55eFC8jmy6CDvLnThCO9ppwdz1KYPmdDtFepBVum1YtLgyiWVTBlMDmbtqB
 Sa+oIXcQ39nkWr4whxAvB1Xqi40BDhlZtAdd9HoSqLRaKGOmdDXamg5sn23+wUbRfK2y
 M9xw==
X-Gm-Message-State: APjAAAUfjfDDmWTzsF7y95Pnuv9c5AXXcrTvlBMt5osddMFwZnqvecr6
 /jee0zAdTCtM6fbsy2szJQY=
X-Google-Smtp-Source: APXvYqzxU/1cn6HqqwqwGRcNz4T2n8y3agd6WUAA5BYTS+jULwsi9YHs0mVX43LpBeAFRJ3Mo+hlOA==
X-Received: by 2002:a63:7444:: with SMTP id e4mr46906923pgn.261.1554186782569; 
 Mon, 01 Apr 2019 23:33:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:33:02 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 17/18] counter: ftm-quaddec: Documentation: Add specific
 counter sysfs documentation
Date: Tue,  2 Apr 2019 15:30:52 +0900
Message-Id: <3273619b1e22d8dbcd0beccd9a887f14a8aa38e0.1554184734.git.vilhelm.gray@gmail.com>
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

This adds documentation for the specific prescaler entry.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
new file mode 100644
index 000000000000..7d2e7b363467
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
@@ -0,0 +1,16 @@
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler (i.e. a counter). This acts like a clock
+		divider.
-- 
2.21.0

