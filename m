Return-Path: <linuxppc-dev+bounces-24935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A958C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 11:16:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8Xw249WWz2xyk;
	Tue, 28 Jul 2026 21:16:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785236354;
	cv=none; b=o2uaM1FE3C6sJhaJC38gi+cwVNW/j8mWWyQWGJv/KC7lJum/9olZhdK5fuat3iiYBonAoe24gqdg0VYPy8NbcyZjYC/GJYI83lU5kdpTc6g6nPUThdVP1BeLSq4rnXKzveknsmSf7wD3GV2Eii1FSvMtWQyIhXm4FC7IDoKz5bzIF/vUyyyCmlkUNCNdFa8wmzQr+gmr5OeEGIVkAoSpcUcwbPZTLY3K1Adbdd4zFZSBiY2Ucg2/WMv4INr6lzjtyqPmRYY3teoy2gCsRNLRWeFdz0WGgwTMkU3ILUKFexRC50nMFloTUxMJFrimQgCSvmdkgHo7FGreamg/LMdT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785236354; c=relaxed/relaxed;
	bh=PkzrPROsbva/YpLFO9tFoN00fEkvGr3SpS1eH/m/1Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jbd/lW4OIhoEWDySxfemfznP8yQbVHdRR7TzCdejbRYb0nHL1YBmskE+Tgr7PcLdEUBiuKQ42WaoSmze0Pmz0hXyUzf3cIcFghdBn57J1/nYwfbj3C8fseC3fEm2jdtjACt11GqcJypjVQiW4e8fYbM/cjcwnZZLcwZPiVY83/9JEgTz2MPxgCHAJHxi1yZPwYCHvsY1GnkQf/ijgpJJ58w0Zv7u/GDBNXcgMxjMM8AnGiwWeN6UgHRTmCjrY4M06Gq/ot0MAyy0Pq7Sv4L/ZwSZhiW7Q9H6fyW4FIYgpUwoTLcPcQHOlPGDmHVFu+gc6UJNvtos/1CrqZ5V1zwhZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=crNO1rlJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=crNO1rlJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8XXJ4hn1z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:59:11 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4954aff6088so32508245e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785236347; x=1785841147; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkzrPROsbva/YpLFO9tFoN00fEkvGr3SpS1eH/m/1Ik=;
        b=crNO1rlJguImFTpcRqQv7BqZhNu70KGjcNOOJliwf2EQZbvbIgpW1VoGB3QbGrWsxz
         Wtu7lkEn8tijD8rBR6YBShZKT3szaQ8ojTZmqRVaBdlbEDF459GXX7EN4xPgGdCnwKMO
         K+kygU8qjHyaFFwl12a9Y8ND8bR2XqGcbOPiAPOTvFZt5LXHV9v9VSk9cFRU6Hy5qlA7
         e0U6WJS793zwQ4AIL6NKNoXkqtAwHoYBwKCf/VXX2DwHCYX1a8DsDoJlYAxnL4KChXl6
         SkCSCUK370tyHJ85zGOnE952JuwjzsS6MdopURqRzQfp69yCvJhM3F/pgwEfWONsOD8R
         FpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785236347; x=1785841147;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PkzrPROsbva/YpLFO9tFoN00fEkvGr3SpS1eH/m/1Ik=;
        b=WoIqjfgI/7yanhBdx4U3umqQKai7uEULXnqoVY4viyv8n3EYaahotWGXsVZLiPyd8J
         Qwn4Chc5Ul0yx/uphn3vPIH7mYuFgsU75WQFMBOrVzQ4MxIAAGRTb1hXoLUCSpY9JPZh
         ky9VK8hG84uddF3XwtaaX25kpCqtb/knQuNrVvk5iE3ROXbe3KtoVdNYQl8vQvlp83xF
         L+NY2cqtDIKeXL9KqjugmG1RCOUH+1oV5/QJHnKRmd4OXyNx5Pi/glGDKfDrxyh/U7uf
         8ab1Tn/gekwbpvHxLCzuEMGwYn5JE2JPGvcgUNcN1GWxtcjg5lyB9Qr/dBV9yOvIQ/9i
         8nYw==
X-Gm-Message-State: AOJu0Yy+p7v7YhrpnhJ2L64R7axNsm2XNNCZPupx2J4E+vaJX+OnpBLR
	rgTDFe15VP6bq1SbJzf2E2nJSq2jf94OMaqdq7tGTpvXu1SiKFHJ++W/N/hW1iT7QL8=
X-Gm-Gg: AR+sD12CAWfXNHTcH5exoYEheMB0NJm/Buu544Rq/Jp+G8UEyPcN2wx/e+1x1N4mP3R
	RjlaYVEcXD+a/q/e6tr1rjAOLwVm8SwO/Ddh1pEFheO9I5zp4X+XZjFJ/3U9Drh8jI0pP8UQaGU
	S3gxy3a20P+zREqRtCMZ+60cD4aSkXXv44xccs/9XoHPTSI5ebSntjgR/ylsngmopYr4S7E/dpV
	T4JPCc6QGbt/W4rdD3Z+J8lWXbtqJZKlk7JwoofuReztKfvpEOTifnCa93RxyrCOI2VLVszrlny
	KYb6pizP2D+VXQjf/iFXXbRrQc9lvvRdZ+AWSzy4TT+ze+D0QI7ZAghcWO9+syA+LOxTQ4+Rd6C
	+XUBokAHeE9Ct43Sjh+qsSe/qhB/PDC8BB9/hShwnjBofakh/Q9YBxIPpOHa7stKkri8m5XSO4J
	nvEb2774BLI8/eljG32Gk=
X-Received: by 2002:a05:600c:a51:b0:495:5b4a:53c9 with SMTP id 5b1f17b1804b1-496c65a2d71mr22488525e9.39.1785236346952;
        Tue, 28 Jul 2026 03:59:06 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:364d:4a01:2121:cbde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45bb2e7sm73484875e9.7.2026.07.28.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:59:06 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 28 Jul 2026 11:58:56 +0100
Subject: [PATCH] bus: fsl-mc: drop unused assignment of
 acpi_device_id::driver_data
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-acpi-bus-v1-1-12ff25fdea9b@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAG+LaGoC/yXMQQ5AMBCF4avIrDXRLkpcRSyqMxgLpINImt5ds
 fyS/70IQoFJoC0iBLpYeFszdFmAn906kWLMBlMZW9WmUc7vrIZTlEPbeNSjRY2Q8z3QyPd31fW
 /5RwW8se7h5Qey68Hm2wAAAA=
X-Change-ID: 20260728-acpi-bus-ad68cd1f6d1d
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785236346; l=1168;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=mucCZf1NS0fqiFUADE3n7xyqr9AOroSST9K2LCuKKWo=;
 b=BH384Q69MA/2LGMLx5Ou4eT5qIbk//2B3ufcJ9Grc+zwP8Q594exHGE+TYej2jgVU9zAMWkzx
 hTiwbCeF45aCyP5RJCgvY50uJhnWcqfUuDVwuQ74q8mWpOuNAxCO6/j
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module sets the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - use a named initializer for the
acpi_device_id::id field as well to make the code more
readable.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 64d75eed0d34..ce024a0fb7e4 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1202,7 +1202,7 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
 MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
 
 static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
-	{"NXP0008", 0 },
+	{ .id = "NXP0008" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);

---
base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
change-id: 20260728-acpi-bus-ad68cd1f6d1d

Best regards,
--  
Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>


