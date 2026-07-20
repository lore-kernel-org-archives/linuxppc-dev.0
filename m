Return-Path: <linuxppc-dev+bounces-24441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D1C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 05:37:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Tmm0tmTz2yY0;
	Mon, 20 Jul 2026 15:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784525847;
	cv=none; b=K62nwGsxVu1UCdW6aWeHE0JIHUm1cOEJV4AiOPVzlTG3rdixlesZkngHdEsWBZe1xviyPPRMLYVCQ3KzSuacBURb1IdB9Xjnt9JPb8clskwtWx3m7sOCRMisE7RhTBMIXqSi2AgCXcUUSoBRiHLoAxZ1nL+3Gu4eQ9d6/yiFCqjwmY0E8TDYQJEF3HurrLm7Op6TGCHGFRYLslSNlFh+5/Jl9VVE0Y446TYuj/OAa6IErMgwOgyALbDROtYSwjZRdOG19QGvkk1bIqASgfOtZw7q7xM0S8nECFDnatB8xH2S0IRDuvuT5VmgqVbeK//hQuD2ac4gBFlc5ltZhvlFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784525847; c=relaxed/relaxed;
	bh=R8dZOeWZ4QzXx1G8tKCpK6OKK6m4eWHKLk5KGtNIMNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZP0A0OimuBvgpheAasQD2myzrMqlBpCWpRwBLynOLzzzjJgrMbE7Vyvan8CLgghtt3gZ/yjCKlH0lCCt6Rn+DYcq3ktqF5zu5J2jnRrbR4Run9mHVCafrYAeJlSARU6IfIJPdZfXITJ/rrZE8wn4qk+eNARrGRKKRbVYrhzmH5sou1oSoKlGHhKe3wBGsIWFSpEi5OXKAREcQa0iQFPm/Ft5KY6oX2FJ1OYhGbkKDey+3iaf6qYdchLL7NEA6+dYCTHjeyTniggxWfi0PYjFCtX19udQjPz/h4kDwXnhbbI1rfiLUN7nnv/ktEAu2zeZU2YE4+YpEghjD0ebnZrSIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FDprfs1H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FDprfs1H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Tmk3XYZz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 15:37:25 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso3774370a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784525841; x=1785130641; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R8dZOeWZ4QzXx1G8tKCpK6OKK6m4eWHKLk5KGtNIMNU=;
        b=FDprfs1HEVDJGCIEMHIUoVkrXLRGQxs06vuQSCZLk4LqgoApDwWijUqEJjNR3Ipv0O
         9I7uDIzI79Uvrae1OUBMNNOPWmqxinJMKuSdv5lMVg+j78ZeU9DbWXDXrPq4XHKsSEEz
         L+RPq8smX9f3glkH+TTem3hVm1FMjcKEwfFffKP+Ua5ioEo4j8f2JH7rRFrASECbrh6Y
         rmOmKejhXlrQ6Yr4GQMQlNHUA72UPtKaKPV7C4XDnWXR7f2rOyfegv6Xe1LD4NYjCrCc
         /vd1/tjPAvhvKYvMWARq+K5nM1HtP9mS1P3HdaLknQP5zGMy400a5R8KlG4Q/rNJGXcA
         ddjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784525841; x=1785130641;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R8dZOeWZ4QzXx1G8tKCpK6OKK6m4eWHKLk5KGtNIMNU=;
        b=EqAIC71e9rk+bsbWVPZnTJt9BgsoqTvFa8Oogxd9jEM1kToMxkefn8qa+ZPoI6qWZd
         NyvTIgXdWyaV8ObQ5Ig8N/rZugecjmC3hZloU4ZHFgdwMRNFMfZioWFxOwSBhJO810Kz
         01ck88mp5NF6zNlM3eFuGmbsibIQYV7DcXI60UxmjyZclBxVrqbo9z/fqylnxMEmYPod
         bFgX2SejPV6dlXIsnmmFxAWXKIxJ2EGqEo4Tvwi/WT3JzcYcZnCKbhn892nvs6wT292W
         tsc3Rs8hjWxtcJte6Lv3NMLA/qHffLfzPIcwJpenHNrUoUO1cNGy8AUqwIKWYUJUicWl
         GgJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXIctZHJRYiLqoWiTk2tLf/JbnTxstzpTB+7NjPhVGfFkffVO9jPTBWQzN6NE0W0Xu64bd9v/CKJ9EhSI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLrYW+3J1ypgGsnyDndLSKn2K3jnlwXKV/u2/sTVe0Fu6jx771
	nMKk/I3zxDKWCW6j3/+LPDhr3OuNldDmQsRYHvJZbnbliVzhBdJrOLSU
X-Gm-Gg: AfdE7cmHK6OgIkImqR7STnkbIjQ2D3PgX7VbRfD9L3NjKZ0og/6LUNDt47pnsJ/gx+d
	Dlhz9khHM76/5Yj0zZtSAHu+M+BVlIWIm0rLGAxsF8vJuDyo8mv9uutLHGtjaNb4jWXjwDQpSWv
	hErhT2G7h/qg6HNqIL7q4AjA/WDQg67aFZynOwMcaD5IPB1D3O7m+B0sYIzV5yQDgj2vTt5yUL8
	Q//mMzcO6Cy5r0SdTNpYfRDeAkZfKgZsCZjJj3IupHcZ73DltMPGgkKBQHPMDRqdVI9c3jmS8Gj
	oXtVh88APqKRla3HlkOGtgamDq8YEnU3kPjJKLI0ZmBhAHdUUYvvX6HY011fE7i5EAG8TR5m89u
	lMy0yge2sB7VW4pF5l2EUQBAe2E7C9Iso9XzN/bPEo3Y5JoNYPFKaJPJ9MbI2Dh0RQNVYdF0+Iu
	3Q4kULCzK5iMIeWoGiRwdLpg8upf6mNgYFYvoxPYt3pifm4PzKWS+XwPGSP3QKL9EP0A==
X-Received: by 2002:a05:6a21:7a46:b0:3bf:6237:4d49 with SMTP id adf61e73a8af0-3c3ad7aa051mr14685620637.23.1784525841254;
        Sun, 19 Jul 2026 22:37:21 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm34224663eec.30.2026.07.19.22.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:37:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/3] powerpc: 512x: Convert ADS7845 touchscreen on
 PDM360NG to device tree
Date: Sun, 19 Jul 2026 22:37:15 -0700
Message-Id: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAu0XWoC/2WNwQ6CMBAFf4Xs2Zq2CK2c/A/DobZbWCOFtEg0h
 H8XMJ48TjJv3gwJI2GCKpsh4kSJ+rCCPGRgWxMaZORWBsllyZVQzLik9Klkg+vykoeGoVXozl5
 JryWssyGip9eevNZfTs/bHe24dTajpTT28b1/TmLzfnn9n58E48znQntdWGcKdWk6Q4+j7Tuol
 2X5AAvNLP3CAAAA
X-Change-ID: 20260717-ads7846-pdm360ng-ec7ed9f72f82
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

The reason for this series is to remove support for platform data in the
ads7846 touchscreen driver, as pdm360ng is the last user of legacy
platform data in the kernel for this driver.

This series converts the ADS7845 touchscreen on the PDM360NG board to use
Device Tree bindings instead of legacy platform data callbacks:

- Move GPIO controller capabilities into mpc5121.dtsi so all MPC5121
  boards inherit proper controller definitions, and remove redundant
  local declarations from ac14xx.dts

- Update pdm360ng.dts to use "ti,ads7845" with pendown-gpio and
  interrupt-parent referencing gpio_pic

- Add "ifm,pdm360ng" to mpc512x_generic.c and delete obsolete
  pdm360ng.c.

This change has been discussed in '24 but I just got around to
implementing this:

https://lore.kernel.org/r/ZoNHLjmSvCN12vU5@google.com/

Note that this should compile but I have not tried this on real
hardware.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- Set pendown-gpio to GPIO_ACTIVE_LOW in pdm360ng.dts to match the
  active-low hardware pen-down signal
- Expanded commit description of patch 2 explaining why early boot setup
  in pdm360ng_penirq_init() is harmless prior to patch 3
- Removed Anatolij Gustschin since I got a bounce telling he's no longer
  with DENX
- Link to v1: https://lore.kernel.org/r/20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com

---
Dmitry Torokhov (3):
      powerpc/dts: mpc5121: Move GPIO controller properties to SoC dtsi
      powerpc/dts: pdm360ng: Convert ADS7845 touchscreen to DT bindings
      powerpc/512x: Remove pdm360ng platform setup in favor of mpc512x_generic

 arch/powerpc/boot/dts/ac14xx.dts              |  13 ---
 arch/powerpc/boot/dts/mpc5121.dtsi            |   6 +-
 arch/powerpc/boot/dts/pdm360ng.dts            |   8 +-
 arch/powerpc/platforms/512x/Kconfig           |   3 +-
 arch/powerpc/platforms/512x/Makefile          |   1 -
 arch/powerpc/platforms/512x/mpc512x_generic.c |   1 +
 arch/powerpc/platforms/512x/pdm360ng.c        | 126 --------------------------
 7 files changed, 13 insertions(+), 145 deletions(-)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260717-ads7846-pdm360ng-ec7ed9f72f82

Thanks.

-- 
Dmitry


