Return-Path: <linuxppc-dev+bounces-24408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9732AC4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 05:23:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2sVq2Wmnz2yQL;
	Sun, 19 Jul 2026 15:23:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784438595;
	cv=none; b=Gt48xUymEYYChNwhqVskOIyksBaq16HtOU8B5M9wg9006QqAWHI3qYqHOW+X8BcXytI2GuxFwftLFGkue7JyRY6VweUWwp3VetGaEWxT0dLLeUh/hWDgOjWly8PvCAUEadfOMjkGcUJ3JWE+L8PhKkcNTgE639PlWf8hhzuESQfQrCh+11M3Aw+Y/s3cCvDB67U1E6fLit6SrJ/8e6TplY5yyPd5LqJkHh1Szor5GXvtjwxxpUUn1mLcSvpT8YKYWQAw2WRRO4xYNKUYNzZavZO/cFihSKU5vGaLVxHP/ul+TTcrdV20MnReJiEWaikgXY0z/qW2IHtdbUPEhpUR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784438595; c=relaxed/relaxed;
	bh=lQcYHP742JQAyp0Zxye8wRRdYiQ3akELTcoPNLHuwtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RBGcbfD+fjr9HAeArLdPyyyWtJE5LRV+Wy316diJt6LB5wkNdymbhW4VHGEURkiGa+Cp4S+/Wn+kSwF9YhBKPl96VKCJSOSd32nEecWBRPZTbsZngKOO9T6BtBWIiunIrb8JpDRgKBHzKzscwvoGEw3C7vpeVUqeO1hxjlkBiNJF/MIbarSnYigF0orKNoj3VFI2x4wTI4ALMNO8T7LYAJIb7FbdyC7kL8+6Z/JU3nEdX+01lbhJb1o31tdBc/ISx6mE1VhLl4mrfgLx/y9aj2Zo+3m8bZXS6wG1W8opmL8WGHbWam4kSLTpiVzyz47U9EkJbNj5hLRaS5R40zHWfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WV+83Hh5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WV+83Hh5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2sVn5tzjz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 15:23:12 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso6044710a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784438589; x=1785043389; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lQcYHP742JQAyp0Zxye8wRRdYiQ3akELTcoPNLHuwtg=;
        b=WV+83Hh5Wq3wHm3OoCXNMU4iyFPTqT0QnMQYHINX3AmN7nOCLh9QNCFMBR8nmhiatU
         eJwBQqUeuUKXZ+X+ThLHSrmNXL7JYOIVksJAjZAGwnd0sJuYm862uUg8XTtfa8xrHs4U
         R52jz74qvRwhziY++kTwfUluTL21WzRr8vX8Rp0Z0DSIA0iW+pkaK3t0B5tRZogEA08s
         cnQBOLz2mxoMJ1E+ZwP0+RbtWd6lSk2g4pLENLDPWtRG4kvOfISBbLb5toptTD3SZX3J
         cvveyIxoyw8YpLEseAjUzGwGKtVVZbSZ3lndx7YFIRAfidxDsiTu5VeyhY2dR1TSElgb
         2x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784438589; x=1785043389;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lQcYHP742JQAyp0Zxye8wRRdYiQ3akELTcoPNLHuwtg=;
        b=qiL+DBx9WYmeQSu9FSV/5B/474p7QsyEl6ENQSXi2XSSXMvA4Vdt1gPH2brfe5+f1c
         ez94ALNuEFfGy+eylkRogZJdt1ULf+4lIftc2x043w17hz4W91LnEwhHPOZ7jq3u29bB
         klj33pngvvYNrU/+YQ3+D94pXAm62rQaTWpNg6HJp0Knuo30bn2LoBOE+VXL7rOvfEVN
         xbKHynqXiyMnnFLgf9cyrCv6fEQbYNY065xYzV3dVnqQDE6HVWzFf54W3V7WaWJ1VHJg
         3m8xJrQYvYe6HU1RPJv2duyNFXLrKMYJsmYm6LH5F4wMf+F67lpzU17/5bG+y4fpr3mj
         D31g==
X-Forwarded-Encrypted: i=1; AHgh+RrDfIudY6HVALEd0kVeNn2cGLT/GcQpS05s43OnP5VIIlh4bm7Tc+h0rGQDG0p1HVTW0K3u1vveLMabyPE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwT1ZPqQ7ozqsboTmpzA5qgFF4jMyuw0fQEBHJEl/+ox7l2KkHn
	m9xx3PCJv2sis/32WzpfeHYDbIqtFVohNOg2F3ZmKpkJM1gr0NL64Yx4
X-Gm-Gg: AfdE7cm1XBxXalZhYFwUwB+WylwnQCI6KOMFyg2qAfaPFUYyibfkT+w1EK9EL9hISjX
	6MvcRtBKxZup+9fHn8zyLIyxsYxwoNW3OS4269H/JB5ecGqAnWd/k/qbCcW9p4UiiDb5eCIYB5D
	yXwAAix137RAv6ZopH5Z8uZ/wn009gEsZGOzm6hO1EqF7vURaunRbNt2OVvEvUxpInRnQqngX53
	ITXlfpIQeyia3Kce9UtVvBeHcbvPayvlHKJYVUXXwc6Ec48nOD/0p/bU56VKVVk4aZJdHg8zfsw
	QKU++z2PS0RlBV+GkNHmRiPJUHJ3KTKwW+qfprCZM3iSGuMzxjeoJzwHyD25qb2QUZ8z7Gb3CB/
	9eSAeF2CyUsmUGU2Ge/phwEuqPIuSd5G0tLgL3If3QI8u+Clr4EiKCp/asRCn40vjaKlaRCnAlD
	q888bprNBU/VqEV7EpMakay0UXYNobHtNMmWJqMNP6DigS46Yzx/U3YmSESpGPVmAsPdPWl0ZhU
	KvS
X-Received: by 2002:a05:6a20:9f8d:b0:3c3:ad17:edf7 with SMTP id adf61e73a8af0-3c3ada267d8mr9727040637.63.1784438588669;
        Sat, 18 Jul 2026 22:23:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:431d:c6bc:133f:2959])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm25950461eec.15.2026.07.18.22.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 22:23:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] powerpc: 512x: Convert ADS7845 touchscreen on PDM360NG
 to device tree
Date: Sat, 18 Jul 2026 22:22:52 -0700
Message-Id: <20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACxfXGoC/yXMQQqDMBBA0avIrBuIsWTUq5QuNJnoCEbJtEUQ7
 26qy7f4fwehxCTQFjsk+rHwEjPKRwFu7OJAin02GG2sxhJV5wXrp1Wrnyur46DIIfkmoAm1gZy
 tiQJv1/L1vi3ffiL3+X/gOE7wwndQdAAAAA==
X-Change-ID: 20260717-ads7846-pdm360ng-ec7ed9f72f82
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Anatolij Gustschin <agust@denx.de>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

The reason for this series is to remove support for platform data in the
ads7846 touchscreen driver, as pdm360ng is the last user of legacy
platform data in the kernel for this driver.

This series converts the ADS7845 touchscreen on the PDM360NG board to
use Device Tree bindings instead of legacy platform data callbacks:

- Move GPIO controller capabilities into mpc5121.dtsi so all MPC5121
  boards inherit proper controller definitions, and remove redundant
  local declarations from ac14xx.dts
- Update pdm360ng.dts to use "ti,ads7845" with pendown-gpio and
  interrupt-parent referencing gpio_pic
- Add "ifm,pdm360ng" to mpc512x_generic.c and delete obsolete
  pdm360ng.c.

This change has been discussed in '24i but I just got around to
implementing this:

https://lore.kernel.org/r/ZoNHLjmSvCN12vU5@google.com/

Note that this should compile but I have not tried this on real
hardware.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (3):
      powerpc/dts: mpc5121: Move GPIO controller properties to SoC dtsi
      powerpc/dts: pdm360ng: Convert ADS7845 touchscreen to DT bindings
      powerpc/512x: Remove pdm360ng platform setup in favor of mpc512x_generic

 arch/powerpc/boot/dts/ac14xx.dts              |  13 ---
 arch/powerpc/boot/dts/mpc5121.dtsi            |   6 +-
 arch/powerpc/boot/dts/pdm360ng.dts            |   7 +-
 arch/powerpc/platforms/512x/Kconfig           |   3 +-
 arch/powerpc/platforms/512x/Makefile          |   1 -
 arch/powerpc/platforms/512x/mpc512x_generic.c |   1 +
 arch/powerpc/platforms/512x/pdm360ng.c        | 126 --------------------------
 7 files changed, 12 insertions(+), 145 deletions(-)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260717-ads7846-pdm360ng-ec7ed9f72f82

Thanks.

-- 
Dmitry


