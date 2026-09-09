Return-Path: <linuxppc-dev+bounces-26923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E66C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:22:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1gk1Bbcz2yqd;
	Wed, 09 Sep 2026 23:22:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960146;
	cv=none; b=aIwS2DfCKeDxK/F/0DjruTIJCaJL2ipRqAaOVe0OvL77JLGfnX+oMv548jF6Xq7Z2mRN2SUtyGLIOJs6iGUm9c2Jwgor5R7fIXYkSOtySKg4hugdN2mx+ztrdNqA4zVf5VCSd7UuuoFi3yEeFFlFUF2PzDYV+HYxVrF7huWsqzc1HjHgzOtqCK9MJEAF/Agkk6Af6X91wCaTv0qEscW+MDjn09aWxUF2OqT0WeLidHBdT8AKSGAUDSzt+/hW2vtXMlZQ40w5eF8VntlepgKpWGCEH+GkXXvEAbhN/eDNSW2lJIytMk8WJA2KNHmRmwJjB0ob1EhTLDAqc3fYamLNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960146; c=relaxed/relaxed;
	bh=qCe2RO6qTVcChylmS63aNkzITaRtgFf2KHRZcB9dyNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThaINMAV/UoJKI2dXGxET2o59ftD1tOVX2NGGByza0LQciQjfXljzszSVwWTmzreU7nxv/5PnDKYL1cNRqxtd/8Z8A0r/JZ4BP+LvlWyOA/0K7+ix6HV1s/rBJWQjAEwueqSfH29pSuJ/iuVQwi9FOOKI+ZOolbbC0/NUJFebBUnzEmRW0UO7wLRfx7KU4Da3wcVXSltIzVyMlK6AMH3511IpsMvPnZX5wCw5mWWO1BGeacZkE9fiFU/RkWKuyxjbJ1C4J09i8EeHvdvx2/gsx/FPK4VSxkbXdDRAOx5QU6Koz0JdEIumccK9DQYe+IHKvllkIZIkR7sMDasgiG2dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBnFHO96; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBnFHO96;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1gh5ht8z2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:22:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B0A660214;
	Wed,  9 Sep 2026 13:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D871F00A3D;
	Wed,  9 Sep 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960141;
	bh=qCe2RO6qTVcChylmS63aNkzITaRtgFf2KHRZcB9dyNM=;
	h=From:To:Cc:Subject:Date;
	b=EBnFHO96jEjY9r9nl+2huXxzbReGZqLOuT4SSQ+W2f4sPLefJKCcPU3aqswpBVkDZ
	 6r1oEvVHRbhW66AdrTxJfQxrpQ84qQPUMDrstxN6iWFqpiIyeUyw3boALLiLYaBs5B
	 O9olTOgI8Wv8Z7xSOpKyCqLdRehwEwDhUCU+NqbwxklnhGhTuAQyNlGgWfEqGA7+m/
	 DkDwJkt078AvqT1+LHpICaaBnQpMjriEhYhcvkxsSFlYzsuSHfoT6xiR0jN/tDZAdT
	 0UhP9n10qjnJbot9xoUEfv+t6bWIW0OAiL+gCtJaXR2+LtOSqH4dsEyKRpDfPZ1Hyl
	 9jMcZB2yjavtA==
From: Arnd Bergmann <arnd@kernel.org>
To: Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH 00/14] mfd: unused driver purge
Date: Wed,  9 Sep 2026 15:21:37 +0200
Message-ID: <20260909132153.1596191-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

As part of my cleanup of old platforms, I had a look at all drivers that
may have become unused because the last platform_data or DT definition
was removed, or because of unmet Kconfig dependencies.

These are all the mfd drivers I found. The first ten in the list
actually turned out to have been unusable long before my series, and
I have added explanations on how I determined this in each patch. The
last four patches are still in use in linux-7.3 but become unused after
my series [1] that I hope to get merged for 7.4.

Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
to simplify the interdependencies: removing just the mfd driver would
leave unselectable or broken drivers in other subsystems.  I also have
additional patches for each of the other subsystems, currently a total
of 300 patches, many of which still need better testing or proper
changelog texts.

Please let me know if you all think this approach is ok, or if I should
explode this further and turn these 14 patches into 70 individual ones
by splitting them per subsystem.

See [2] for the current state of the overall series.

     Arnd

[1] https://lore.kernel.org/lkml/20260908152808.3928630-1-arnd@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3

Arnd Bergmann (14):
  mfd: remove unused 88pm80x driver
  mfd: remove unused rdc321x southbridge support
  mfd: remove unused si476x driver
  mfd: remove unused wm8400 driver
  mfd: remove unused adp5520 driver
  mfd: remove unused da903x driver
  mfd: remove unused lp8788 driver
  mfd: remove unused aat2870 driver
  mfd: remove unused lm3533 driver
  mfd: remove unused rc5t583 driver
  mfd: remove unused wm8350 driver
  mfd: remove unused mcp-sa11x0/ucb1x00 driver
  mfd: remove unused menelaus driver
  mfd: remove unused iPaq micro driver

 .../ABI/testing/sysfs-class-backlight         |   11 -
 Documentation/admin-guide/devices.txt         |    1 -
 .../admin-guide/media/radio-cardlist.rst      |    1 -
 Documentation/admin-guide/media/si476x.rst    |  160 --
 .../admin-guide/media/v4l-drivers.rst         |    1 -
 .../devicetree/bindings/regulator/88pm800.txt |   38 -
 Documentation/hwmon/index.rst                 |    1 -
 Documentation/hwmon/wm8350.rst                |   30 -
 .../watchdog/watchdog-parameters.rst          |    7 -
 MAINTAINERS                                   |   14 -
 drivers/gpio/Kconfig                          |   22 -
 drivers/gpio/Makefile                         |    3 -
 drivers/gpio/gpio-adp5520.c                   |  169 --
 drivers/gpio/gpio-rdc321x.c                   |  199 --
 drivers/gpio/gpio-wm8350.c                    |  144 --
 drivers/hwmon/Kconfig                         |   10 -
 drivers/hwmon/Makefile                        |    1 -
 drivers/hwmon/wm8350-hwmon.c                  |   92 -
 drivers/iio/adc/Kconfig                       |    9 -
 drivers/iio/adc/Makefile                      |    1 -
 drivers/iio/adc/lp8788_adc.c                  |  219 ---
 drivers/iio/light/Kconfig                     |   17 -
 drivers/iio/light/Makefile                    |    1 -
 drivers/iio/light/lm3533-als.c                |  922 ----------
 drivers/input/keyboard/Kconfig                |   10 -
 drivers/input/keyboard/Makefile               |    1 -
 drivers/input/keyboard/adp5520-keys.c         |  191 --
 drivers/input/misc/88pm80x_onkey.c            |  152 --
 drivers/input/misc/Kconfig                    |   10 -
 drivers/input/misc/Makefile                   |    1 -
 drivers/input/touchscreen/Kconfig             |   13 -
 drivers/input/touchscreen/Makefile            |    1 -
 drivers/input/touchscreen/da9034-ts.c         |  365 ----
 drivers/leds/Kconfig                          |   47 -
 drivers/leds/Makefile                         |    5 -
 drivers/leds/leds-adp5520.c                   |  195 --
 drivers/leds/leds-da903x.c                    |  145 --
 drivers/leds/leds-lm3533.c                    |  755 --------
 drivers/leds/leds-lp8788.c                    |  171 --
 drivers/leds/leds-wm8350.c                    |  267 ---
 drivers/media/radio/Kconfig                   |   17 -
 drivers/media/radio/Makefile                  |    1 -
 drivers/media/radio/radio-si476x.c            | 1523 ---------------
 drivers/mfd/88pm800.c                         |  619 -------
 drivers/mfd/88pm805.c                         |  275 ---
 drivers/mfd/88pm80x.c                         |  159 --
 drivers/mfd/Kconfig                           |  186 --
 drivers/mfd/Makefile                          |   28 -
 drivers/mfd/aat2870-core.c                    |  458 -----
 drivers/mfd/adp5520.c                         |  346 ----
 drivers/mfd/da903x.c                          |  565 ------
 drivers/mfd/ipaq-micro.c                      |  442 -----
 drivers/mfd/lm3533-core.c                     |  635 -------
 drivers/mfd/lm3533-ctrlbank.c                 |  162 --
 drivers/mfd/lp8788-irq.c                      |  194 --
 drivers/mfd/lp8788.c                          |  246 ---
 drivers/mfd/mcp-core.c                        |  235 ---
 drivers/mfd/mcp-sa11x0.c                      |  304 ---
 drivers/mfd/menelaus.c                        | 1251 -------------
 drivers/mfd/rc5t583-irq.c                     |  383 ----
 drivers/mfd/rc5t583.c                         |  299 ---
 drivers/mfd/rdc321x-southbridge.c             |   96 -
 drivers/mfd/si476x-cmd.c                      | 1543 ----------------
 drivers/mfd/si476x-i2c.c                      |  861 ---------
 drivers/mfd/si476x-prop.c                     |  233 ---
 drivers/mfd/ucb1x00-assabet.c                 |  175 --
 drivers/mfd/ucb1x00-core.c                    |  795 --------
 drivers/mfd/ucb1x00-ts.c                      |  445 -----
 drivers/mfd/wm8350-core.c                     |  444 -----
 drivers/mfd/wm8350-gpio.c                     |  217 ---
 drivers/mfd/wm8350-i2c.c                      |   64 -
 drivers/mfd/wm8350-irq.c                      |  542 ------
 drivers/mfd/wm8350-regmap.c                   |  335 ----
 drivers/mfd/wm8400-core.c                     |  163 --
 drivers/power/supply/Kconfig                  |   22 -
 drivers/power/supply/Makefile                 |    3 -
 drivers/power/supply/da9030_battery.c         |  581 ------
 drivers/power/supply/lp8788-charger.c         |  730 --------
 drivers/power/supply/wm8350_power.c           |  590 ------
 drivers/regulator/88pm800-regulator.c         |  287 ---
 drivers/regulator/Kconfig                     |   55 -
 drivers/regulator/Makefile                    |    8 -
 drivers/regulator/aat2870-regulator.c         |  201 --
 drivers/regulator/da903x-regulator.c          |  495 -----
 drivers/regulator/lp8788-buck.c               |  541 ------
 drivers/regulator/lp8788-ldo.c                |  640 -------
 drivers/regulator/rc5t583-regulator.c         |  171 --
 drivers/regulator/wm8350-regulator.c          | 1330 -------------
 drivers/regulator/wm8400-regulator.c          |  276 ---
 drivers/rtc/Kconfig                           |   45 -
 drivers/rtc/Makefile                          |    3 -
 drivers/rtc/rtc-88pm80x.c                     |  340 ----
 drivers/rtc/rtc-lp8788.c                      |  322 ----
 drivers/rtc/rtc-rc5t583.c                     |  312 ----
 drivers/rtc/rtc-wm8350.c                      |  474 -----
 drivers/video/backlight/Kconfig               |   41 -
 drivers/video/backlight/Makefile              |    5 -
 drivers/video/backlight/aat2870_bl.c          |  206 ---
 drivers/video/backlight/adp5520_bl.c          |  385 ----
 drivers/video/backlight/da903x_bl.c           |  160 --
 drivers/video/backlight/lm3533_bl.c           |  398 ----
 drivers/video/backlight/lp8788_bl.c           |  190 --
 drivers/watchdog/Kconfig                      |   19 -
 drivers/watchdog/Makefile                     |    2 -
 drivers/watchdog/rdc321x_wdt.c                |  281 ---
 drivers/watchdog/wm8350_wdt.c                 |  171 --
 include/linux/mfd/88pm80x.h                   |  370 ----
 include/linux/mfd/aat2870.h                   |  164 --
 include/linux/mfd/adp5520.h                   |  298 ---
 include/linux/mfd/lm3533.h                    |   99 -
 include/linux/mfd/lp8788-isink.h              |   48 -
 include/linux/mfd/lp8788.h                    |  289 ---
 include/linux/mfd/mcp.h                       |   63 -
 include/linux/mfd/menelaus.h                  |   41 -
 include/linux/mfd/rc5t583.h                   |  369 ----
 include/linux/mfd/rdc321x.h                   |   27 -
 include/linux/mfd/si476x-core.h               |  532 ------
 include/linux/mfd/si476x-platform.h           |  256 ---
 include/linux/mfd/si476x-reports.h            |  154 --
 include/linux/mfd/ucb1x00.h                   |  261 ---
 include/linux/mfd/wm8350/audio.h              |  620 -------
 include/linux/mfd/wm8350/comparator.h         |  171 --
 include/linux/mfd/wm8350/core.h               |  692 -------
 include/linux/mfd/wm8350/gpio.h               |  356 ----
 include/linux/mfd/wm8350/pmic.h               |  775 --------
 include/linux/mfd/wm8350/rtc.h                |  265 ---
 include/linux/mfd/wm8350/supply.h             |  129 --
 include/linux/mfd/wm8350/wdt.h                |   24 -
 include/linux/mfd/wm8400-audio.h              | 1174 ------------
 include/linux/mfd/wm8400-private.h            |  913 ---------
 include/linux/mfd/wm8400.h                    |   27 -
 include/linux/platform_data/mfd-mcp-sa11x0.h  |   17 -
 include/media/drv-intf/si476x.h               |   28 -
 include/uapi/linux/v4l2-controls.h            |    4 +-
 sound/soc/codecs/Kconfig                      |   16 -
 sound/soc/codecs/Makefile                     |    6 -
 sound/soc/codecs/si476x.c                     |  263 ---
 sound/soc/codecs/wm8350.c                     | 1638 -----------------
 sound/soc/codecs/wm8350.h                     |   25 -
 sound/soc/codecs/wm8400.c                     | 1348 --------------
 sound/soc/codecs/wm8400.h                     |   54 -
 sound/soc/fsl/fsl-asoc-card.c                 |    8 -
 142 files changed, 2 insertions(+), 39449 deletions(-)
 delete mode 100644 Documentation/admin-guide/media/si476x.rst
 delete mode 100644 Documentation/devicetree/bindings/regulator/88pm800.txt
 delete mode 100644 Documentation/hwmon/wm8350.rst
 delete mode 100644 drivers/gpio/gpio-adp5520.c
 delete mode 100644 drivers/gpio/gpio-rdc321x.c
 delete mode 100644 drivers/gpio/gpio-wm8350.c
 delete mode 100644 drivers/hwmon/wm8350-hwmon.c
 delete mode 100644 drivers/iio/adc/lp8788_adc.c
 delete mode 100644 drivers/iio/light/lm3533-als.c
 delete mode 100644 drivers/input/keyboard/adp5520-keys.c
 delete mode 100644 drivers/input/misc/88pm80x_onkey.c
 delete mode 100644 drivers/input/touchscreen/da9034-ts.c
 delete mode 100644 drivers/leds/leds-adp5520.c
 delete mode 100644 drivers/leds/leds-da903x.c
 delete mode 100644 drivers/leds/leds-lm3533.c
 delete mode 100644 drivers/leds/leds-lp8788.c
 delete mode 100644 drivers/leds/leds-wm8350.c
 delete mode 100644 drivers/media/radio/radio-si476x.c
 delete mode 100644 drivers/mfd/88pm800.c
 delete mode 100644 drivers/mfd/88pm805.c
 delete mode 100644 drivers/mfd/88pm80x.c
 delete mode 100644 drivers/mfd/aat2870-core.c
 delete mode 100644 drivers/mfd/adp5520.c
 delete mode 100644 drivers/mfd/da903x.c
 delete mode 100644 drivers/mfd/ipaq-micro.c
 delete mode 100644 drivers/mfd/lm3533-core.c
 delete mode 100644 drivers/mfd/lm3533-ctrlbank.c
 delete mode 100644 drivers/mfd/lp8788-irq.c
 delete mode 100644 drivers/mfd/lp8788.c
 delete mode 100644 drivers/mfd/mcp-core.c
 delete mode 100644 drivers/mfd/mcp-sa11x0.c
 delete mode 100644 drivers/mfd/menelaus.c
 delete mode 100644 drivers/mfd/rc5t583-irq.c
 delete mode 100644 drivers/mfd/rc5t583.c
 delete mode 100644 drivers/mfd/rdc321x-southbridge.c
 delete mode 100644 drivers/mfd/si476x-cmd.c
 delete mode 100644 drivers/mfd/si476x-i2c.c
 delete mode 100644 drivers/mfd/si476x-prop.c
 delete mode 100644 drivers/mfd/ucb1x00-assabet.c
 delete mode 100644 drivers/mfd/ucb1x00-core.c
 delete mode 100644 drivers/mfd/ucb1x00-ts.c
 delete mode 100644 drivers/mfd/wm8350-core.c
 delete mode 100644 drivers/mfd/wm8350-gpio.c
 delete mode 100644 drivers/mfd/wm8350-i2c.c
 delete mode 100644 drivers/mfd/wm8350-irq.c
 delete mode 100644 drivers/mfd/wm8350-regmap.c
 delete mode 100644 drivers/mfd/wm8400-core.c
 delete mode 100644 drivers/power/supply/da9030_battery.c
 delete mode 100644 drivers/power/supply/lp8788-charger.c
 delete mode 100644 drivers/power/supply/wm8350_power.c
 delete mode 100644 drivers/regulator/88pm800-regulator.c
 delete mode 100644 drivers/regulator/aat2870-regulator.c
 delete mode 100644 drivers/regulator/da903x-regulator.c
 delete mode 100644 drivers/regulator/lp8788-buck.c
 delete mode 100644 drivers/regulator/lp8788-ldo.c
 delete mode 100644 drivers/regulator/rc5t583-regulator.c
 delete mode 100644 drivers/regulator/wm8350-regulator.c
 delete mode 100644 drivers/regulator/wm8400-regulator.c
 delete mode 100644 drivers/rtc/rtc-88pm80x.c
 delete mode 100644 drivers/rtc/rtc-lp8788.c
 delete mode 100644 drivers/rtc/rtc-rc5t583.c
 delete mode 100644 drivers/rtc/rtc-wm8350.c
 delete mode 100644 drivers/video/backlight/aat2870_bl.c
 delete mode 100644 drivers/video/backlight/adp5520_bl.c
 delete mode 100644 drivers/video/backlight/da903x_bl.c
 delete mode 100644 drivers/video/backlight/lm3533_bl.c
 delete mode 100644 drivers/video/backlight/lp8788_bl.c
 delete mode 100644 drivers/watchdog/rdc321x_wdt.c
 delete mode 100644 drivers/watchdog/wm8350_wdt.c
 delete mode 100644 include/linux/mfd/88pm80x.h
 delete mode 100644 include/linux/mfd/aat2870.h
 delete mode 100644 include/linux/mfd/adp5520.h
 delete mode 100644 include/linux/mfd/lm3533.h
 delete mode 100644 include/linux/mfd/lp8788-isink.h
 delete mode 100644 include/linux/mfd/lp8788.h
 delete mode 100644 include/linux/mfd/mcp.h
 delete mode 100644 include/linux/mfd/menelaus.h
 delete mode 100644 include/linux/mfd/rc5t583.h
 delete mode 100644 include/linux/mfd/rdc321x.h
 delete mode 100644 include/linux/mfd/si476x-core.h
 delete mode 100644 include/linux/mfd/si476x-platform.h
 delete mode 100644 include/linux/mfd/si476x-reports.h
 delete mode 100644 include/linux/mfd/ucb1x00.h
 delete mode 100644 include/linux/mfd/wm8350/audio.h
 delete mode 100644 include/linux/mfd/wm8350/comparator.h
 delete mode 100644 include/linux/mfd/wm8350/core.h
 delete mode 100644 include/linux/mfd/wm8350/gpio.h
 delete mode 100644 include/linux/mfd/wm8350/pmic.h
 delete mode 100644 include/linux/mfd/wm8350/rtc.h
 delete mode 100644 include/linux/mfd/wm8350/supply.h
 delete mode 100644 include/linux/mfd/wm8350/wdt.h
 delete mode 100644 include/linux/mfd/wm8400-audio.h
 delete mode 100644 include/linux/mfd/wm8400-private.h
 delete mode 100644 include/linux/mfd/wm8400.h
 delete mode 100644 include/linux/platform_data/mfd-mcp-sa11x0.h
 delete mode 100644 include/media/drv-intf/si476x.h
 delete mode 100644 sound/soc/codecs/si476x.c
 delete mode 100644 sound/soc/codecs/wm8350.c
 delete mode 100644 sound/soc/codecs/wm8350.h
 delete mode 100644 sound/soc/codecs/wm8400.c
 delete mode 100644 sound/soc/codecs/wm8400.h

-- 
2.53.0

Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: patches@opensource.cirrus.com
Cc: linux-watchdog@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: mfd@lists.linux.dev
Cc: linux-pm@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev

