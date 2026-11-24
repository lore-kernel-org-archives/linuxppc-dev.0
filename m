Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0595606A686
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fdNnu9rg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYVyZ37Yfz2y97;
	Tue, 24 Nov 2026 16:01:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795496486;
	cv=none; b=L4LjuvcdEd7dB5Vn616+ZZnoEa9wFQCNt3P2+X6FYvPsXcEgu1sAvioLqhl4tZe0HRsTp6N4JqyddDeI68EGAcftI6i+M3fdZ0UyolumBOIVxEjoOEMAwz98jLzQSJfpHkRboVh4+ZVmpokY0kpBXXhWr+IB/mE9oaRwwzJSjQZI63McigQq2L0822+N+H3Z+OinH46uhDWasA4iFvev9Eqs/p1phladjM0OYlU9JPqsIqCNqcwoK2mLX37uWPQ/wgP1V8MxPI+FQTT6Tyyqkv/XWg9Te7kRqgNd8tsp5ApN6JVsLuji/jkuyxEGkHkDoK7k6zWhYOnHKULBXX2h0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795496486; c=relaxed/relaxed;
	bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2tqtxky10zzLGYuqXNi2dcTtYVjtVwKIrjq4/OUcl0wD3JPFeDZpZJ81PEogVEfQWGW3amVEo+Tfrbkp/zv2t/uCdpPkOqgCnlF3A4rU0lhP+SzeHWllRkkxopYUhv3AiKvir7bu51rkvZlUb30ZyfHRaC0qrJDUQYsvGIVxqYVEdU+bxUzcCMUzjW+6pFXz7p0b2nJQWnSWnJZkC+3HsGJKyo9nZYXSCPjmh9La2MfTJcqiMb1o80W/3cxEr1hoeC5aEMtUQKKLS4izJD7HX7Sp8zO/40EaywlshERE+sIkUx06A4w4ZIoI2zlhJ0ivCS9hjGU8Gk5rM0wgvP4Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fdNnu9rg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fdNnu9rg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYVyX5bZ6z2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 16:01:24 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so25963605e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496481; x=1796101281; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
        b=fdNnu9rgZLUEtpKSYJyJdYQiAbtdjLxO4nSyzryxqcPL0GxutdvORcQyNLQlUQRfyn
         nAAGpcgfNyi2VYD2gPyTRO9V6UPT16hqf7vQZi7jraylH4l3AicLtWbcwYnfWokenpen
         NgeXwBx3LRvzueAkue2EYI8NEsgBxdGm4kH5dbaNot/vUV9+ZstI4FVvwouFFf7ngJvK
         5hTCdwGOtZ292vxlOkNnP6aox/wRgE9EGpcOCK3hlZxtpSuDgCNRfBl2HjGir81dApqh
         49d82D9a4smPZMNyB+Lhup4aWf1ZiRtFtixstxhiR90Zc8nwnhN1U+xscCT9cksDpgCj
         sRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496481; x=1796101281;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
        b=edzzrhh+tpXF4spWkQdddBRhA5Y3nODxQW0WuwvVFEtGmOcc8GY3ddL2Q6OZU6ksvU
         pr2KiNUF+TTX+iaB91poS4ELMKQDkcd5MY0NV8f8knkJbTu/+yOxua963WXkF1u61khz
         ywAWiViik3FfVZgNr61EfBOGXRmtm4vw+Lp5GbrBYhZD1T5XSo38kfcsOQUlQaDCIC0A
         7xbGwfHYocB3eo8NzbyCedMRBrdgyc9+1pgn5djMfJXpzmcsHWG0iEYjSmywusRo3t5q
         qDB5gBFI7YHS7hKek999sc45oBN8A6lln8iMrIizonrJn6H7qubt7E6n1c4n5YoKAO2s
         uliA==
X-Forwarded-Encrypted: i=1; AL+hErH/U/AisoBHnlwU0OvNZyLRfHG5qNhztv8iBgfd7ApxSltVt8V4dl+FP1+nUw60p9yC/b29KNHMOF3DVYU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+FfDscxEXWDKDUd+hNxvH6+y/6bSaf2hGCt4NjOeP4VXMIzTc8
	IrIZXhd4Otin1RpIhZvptCi4Ri+y8E9Uy9mKto7p24U9RX6Wnwj+B10e
X-Gm-Gg: AZFdTZf96XbsTyoFLLzTly+167dUM8ZVzOX7vikG/EjyNEyAqiyJkkGXqdJAi8EISM0
	pw2mJ4d+gRHnSLsMuI1cyWLh7/Fz2ePjhlWOi/hvVty5N6J40lmAQof4FQHDsH6SeI8MGmtWTzI
	KTvSoeQZd9/wCjose/gn/wi/XMm6ifkB7AC5AYhknPPwrJgNFBAuG/BXQ6kbrIA2tPSTWcJiKAG
	/N65eUhOSr8iGzXBYndZ0B9nMTJi/FYYHR+dOkXOFOEPmPtm9ReQcUGXDWOAGf2V4qzoHTs3QXP
	VVwNEP0D8nRdOavT/jQIbtBxbgmmHvTp0OuxVDC219jw9y1daEXDzur5mWQ97/er+Pf+MabE1y8
	aeTDXDgUB1S4cUMAVXp9kJh/Kyd7CnNuXZMMIrL/Nv2vSwOOYcDUitTaLmueLyc8Z2xmnz1SakW
	Te0j4Th3rQpKV9zpEOKVj9DOpRv+KMJdsVw7jVqOpvV6o/3cX7Iz+D+FxzyiN1bCO6l41BZgN9a
	XMxVAKrOeUbOedebQBeqtML74SL9phpsIRLAHhwVULcXnkovgTBQ3/6cgcrmj8a/r7fxqG12Yaz
	IR5CpAbIQqxbkgXEmWbgfCDTG+r38PJmDk9ZKlJvJbl8PZgWGEbgQIcqbd8azFtMaBet50w9HMo
	PEVW0URBM1jagjDhArSZlI0HdTt8wD7iTpScXFJwoBrukNUdh7TY/yFS2AyIUuNJUWfgkI2KyfQ
	uoUpxGI1788sTKJIgXT89i8bq4h0A/AT2ype4LSqpsUyce32e1dklGHEtlbCy2ubHOOB0yKm4u+
	w==
X-Received: by 2002:a05:600c:3113:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb88816b2bmr291844445e9.27.1795496480513;
        Mon, 23 Nov 2026 21:01:20 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:20 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] watchdog: max63xx_wdt: Support a WDI pin connected to a GPIO
Date: Tue, 24 Nov 2026 06:01:15 +0100
Message-ID: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series picks up Pali's patches [1], which stopped at v3 in July
2022. Pali is on Cc.

The MAX6370 on CZ.NIC Turris 1.x routers has its SET pins connected
through a CPLD, but its WDI pin is connected to a SoC GPIO. The driver
currently cannot use this GPIO, despite turris1x.dts already describing
it.

This series adds GPIO support to the driver and binding, and updates
turris1x.dts to use the new wdi-gpios property.

Changes in v4:

- Address review feedback from Rob, Tzung-Bi and Guenter.
- Fix GPIO direction handling and remove unnecessary locking.
- Rename the property in turris1x.dts.

Tested on a Turris 1.1 running the Turris OS build of Linux 6.6.142
with patches 2 and 3 backported. The watchdog works with periodic GPIO
pings and resets the board after the pings stop. On v7.4-rc3, also
tested the binding with dt_binding_check and dtbs_check, and built the
driver for powerpc, and for arm64 with and without GPIOLIB. GPIO
behaviour was additionally tested under QEMU.

Patch 3 can go through the powerpc tree once the binding is in.

[1] https://lore.kernel.org/r/20220705001023.14660-1-pali@kernel.org/

Josef Schlehofer (1):
  powerpc: dts: turris1x.dts: Use wdi-gpios for the watchdog

Pali Rohár (2):
  dt-bindings: watchdog: maxim,max63xx: Add wdi-gpios
  watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO

 .../bindings/watchdog/maxim,max63xx.yaml      |  6 +++++
 arch/powerpc/boot/dts/turris1x.dts            |  2 +-
 drivers/watchdog/max63xx_wdt.c                | 24 +++++++++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.54.0 (Apple Git-157)


