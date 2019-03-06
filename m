Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC69C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:26:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D9B20661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="y9p1pYFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D9B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ds0M33tgzDqB5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 22:26:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=patrick.havelange@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=essensium-com.20150623.gappssmtp.com
 header.i=@essensium-com.20150623.gappssmtp.com header.b="y9p1pYFh"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DrhP1FFMzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 22:12:37 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id f2so9980033edy.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 03:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OLBy4rUf+vwVDyhcvFboGzgSFexgJ/70lYXQZKoXH4k=;
 b=y9p1pYFhwEaq3LqfnJdglnV1zJAJ4xGkgGq5wzbEgT1+UkuRR6t4d5J3WPn8HqGMSY
 LKi0iJ3wlMM8qvq6tbSqQjkM8liBb9EraZim9KPvz6z1MyOTksQdZl6LRNY3XWlDB0Nu
 ss3KYheIT+W7gPiW4ARMo8a+V75DTmziu24wb9EquUd/XPUwZYo0MN8tlGObQsmqzK/S
 qhDhJAuR+zIZuJJ8VnJjBuN99Uyl3UYfmfuNIVYAq8uj+VSA90b55HN3m7l8EEzb8R3Q
 YDAScUlPWi8ZsYWtJBubDhE9YaeOTRspZT66yRyN/enuoFsaI2xkrhyTDtE1sODjDAOy
 RWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OLBy4rUf+vwVDyhcvFboGzgSFexgJ/70lYXQZKoXH4k=;
 b=giHB7/874lhRg9RhSB4UYgx+nrEdv3MDCWB9raiBhjZDgBKbGtb4KXqwtx0ljT/DB5
 Vzou/vmmBdUdvxZMFxyCUfmb7Y8P22RCwlo3jka6cJy/eg65I7eDmn+biaIlCv+FZnKX
 3/HHfDWMVW5D/EuWKXlnleqazVnmx4UbZc101o4pVs//+Wb37YtxRjrcH7W0rdcPMOiX
 n3MSqGnf8C+vvkhngE9zCZbbfPZaVPgokLa61D4aGQuymZj5+INXugxI2V8Riq4pCaQ1
 0kZY1Jtwcz6d3FgTCdsqJ3C/ujd2F6XeKX5dT9ze24Xe1YmmO9E9oJRVw04uAsyCsNxx
 YBUg==
X-Gm-Message-State: APjAAAV/rvfOgmvYRbC1cSmjNYS0p3D+oQmzRZEqmtWo979K5PY2bSKT
 Uue2VrT2zzKoPhoDT79iUv8Avg==
X-Google-Smtp-Source: APXvYqwxJtV24srsDX56efa9N1UEgqc1JG9cFSnmXyVxIL2iePPXuuVUOXdmtG/8E3Ku/SVZz0q+8A==
X-Received: by 2002:a50:a2a6:: with SMTP id 35mr22337546edm.227.1551870754602; 
 Wed, 06 Mar 2019 03:12:34 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com
 (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 03:12:34 -0800 (PST)
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
Subject: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific
 counter sysfs documentation
Date: Wed,  6 Mar 2019 12:12:07 +0100
Message-Id: <20190306111208.7454-7-patrick.havelange@essensium.com>
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

This adds documentation for the specific prescaler entry.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v2
 - Add doc for prescaler entry
---
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
new file mode 100644
index 000000000000..2da629d6d485
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
@@ -0,0 +1,16 @@
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler that is a 7-bit counter. This acts like a clock
+		divider.
-- 
2.19.1

