Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0FE2084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3KMmyUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0FE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKCb3mN2zDqLg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3KMmyUR"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK880TL5zDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:30:15 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z9so6009853pgu.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9BsIkZBYglgWK6GSpo0aZ/aTtxs6mxHN7TKHXjgH19w=;
 b=J3KMmyURzg8DeGMM5fCBb5O7IQPLqTE8ub/+e9g46rgM4dWjPbrr622Ll/K7l2kx3L
 hiRECEl2fztLifmV5Aw3FsFGshcfrLdlgHoQXqEGgO0uVlFLdz4w3S2GnMUKT0HPhPP2
 3Vji6Bxk5MwrUYUPbwRs6/0Cn+Y5ac3pUDVg5bWmJrEKzX2cub3jXqU0VT6DyTrElb0r
 S3GgLiBF2fXjwnRLnZLm4SGlBlqRcOpIVQ26fXVnfjp00hWE6PYjSM/h5szHhNAlNGxs
 cU65ms9pRRf5wE2wAbsScI4pgkERCUks4kPtGB+dzxxucfWH+yRtQ50WFZXaqKRR3290
 EGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9BsIkZBYglgWK6GSpo0aZ/aTtxs6mxHN7TKHXjgH19w=;
 b=Wu/XImPBtMnp2jlRhk1OW7HDIUsJ4hwLoDehYcZnX5e97ZhnQBdw0bLVeJgW63VkHY
 /SMkhd9KprMZAtR6qQHOUQNDxx4ugwcE5LT7B6sDNRyGmgdIjqOOzz3YB09K8bISg46u
 nFDM+zJKfI/2LJOSSM0uoW8pOfOo6ysQV2jh0AYq1702KnTOUST3kBTxahiz46sCB0AK
 CDTnjM2pLO3R308fpMxALfz3fgK0lyPeO76m81gNWuz4m8AWgoM8GpAOefneb6n854sV
 kqBllksbI2bum16KhiWrSOFhvBXpQ09zZ47KABvU6wGko43D0gV6p89I2R80n/x00voW
 A7nQ==
X-Gm-Message-State: APjAAAVAKF5No6xeI+s9JxPzPQRN6uVLUfJBiez0sxf5Vr9ixdB9GX0K
 /RQfdazrWYhMjeKKvX5iAyM=
X-Google-Smtp-Source: APXvYqx0obJ8Ofk/95VNnfqwJ+f0hgu5fXiFV5AoyB+rJy+OxFNtuGvsiF99EFeuOhGjc5ANiU5clA==
X-Received: by 2002:a63:ff18:: with SMTP id k24mr66050078pgi.140.1554186610293; 
 Mon, 01 Apr 2019 23:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:30:09 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 00/18] Introduce the Counter subsystem
Date: Tue,  2 Apr 2019 15:30:35 +0900
Message-Id: <cover.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
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

Changes in v10:
  - Fix minor typographical errors in documentation
  - Merge the FlexTimer Module Quadrature decoder counter driver patches

This revision is functionally identical to the last; changes in this
version were made to fix minor typos in the documentation files and also
to pull in the new FTM quadrature decoder counter driver.

The Generic Counter API has been and is still in a feature freeze until
it is merged into the mainline. The following features will be
investigated after the merge: interrupt support for counter devices, and
a character device interface for low-latency applications.

Benjamin Gaignard (2):
  counter: Add STM32 Timer quadrature encoder
  dt-bindings: counter: Document stm32 quadrature encoder

Fabrice Gasnier (2):
  counter: stm32-lptimer: add counter device
  dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move

Patrick Havelange (7):
  include/fsl: add common FlexTimer #defines in a separate header.
  drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
  drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
    #defines
  dt-bindings: counter: ftm-quaddec
  counter: add FlexTimer Module Quadrature decoder counter driver
  counter: ftm-quaddec: Documentation: Add specific counter sysfs
    documentation
  LS1021A: dtsi: add ftm quad decoder entries

William Breathitt Gray (7):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  iio: 104-quad-8: Update license boilerplate
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation
  iio: counter: Add deprecation markings for IIO Counter attributes

 Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec |   16 +
 Documentation/ABI/testing/sysfs-bus-iio       |    8 +
 .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
 .../bindings/counter/ftm-quaddec.txt          |   18 +
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
 .../bindings/counter/stm32-timer-cnt.txt      |   31 +
 .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
 .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
 Documentation/driver-api/generic-counter.rst  |  342 ++++
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |   15 +-
 arch/arm/boot/dts/ls1021a.dtsi                |   28 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/clocksource/timer-fsl-ftm.c           |   15 +-
 drivers/{iio => }/counter/104-quad-8.c        |  782 +++++++-
 drivers/counter/Kconfig                       |   60 +
 drivers/counter/Makefile                      |   10 +
 drivers/counter/counter.c                     | 1567 +++++++++++++++++
 drivers/counter/ftm-quaddec.c                 |  356 ++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 ++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 drivers/iio/counter/Makefile                  |    8 -
 drivers/pwm/pwm-fsl-ftm.c                     |   44 +-
 include/linux/counter.h                       |  510 ++++++
 include/linux/counter_enum.h                  |   45 +
 include/linux/fsl/ftm.h                       |   88 +
 32 files changed, 4877 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 rename drivers/{iio => }/counter/104-quad-8.c (44%)
 create mode 100644 drivers/counter/Kconfig
 create mode 100644 drivers/counter/Makefile
 create mode 100644 drivers/counter/counter.c
 create mode 100644 drivers/counter/ftm-quaddec.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (51%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/Kconfig
 delete mode 100644 drivers/iio/counter/Makefile
 create mode 100644 include/linux/counter.h
 create mode 100644 include/linux/counter_enum.h
 create mode 100644 include/linux/fsl/ftm.h

-- 
2.21.0

