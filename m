Return-Path: <linuxppc-dev+bounces-24343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28532C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 14:51:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1tCV6ntxz2yQJ;
	Sat, 18 Jul 2026 00:51:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784299894;
	cv=none; b=Xo9kDzU0Qq/WrOtBg75N+g+bpJIDv/Og0gGkaR+QQR3zKC7e1JUx0WVDfOmBFAk0iybnL7PG6mvjRG5fI+cbksR2hBhDMczNm33QARNzaY0RsMdCX9Egw+Fuo7PU5UlTb4gHsnxomay+9BZZgdJ5s0F1Z9LjqF6yAwJSOIljT5vXlfxI9FkEst7mVVQplz8/P92NscHPkGgEywT1g9UGfUDF4lR/sj31BA+jGNoLi2yvwosKP/yb0cUWH7SBwsGW2MjenWklxssgTwSO1WxJqtEQ1obFueQMi/2JnevDU39BPHlHmEepa6/C/jE67iLbV0wPOH0TVdgLeslCt4+2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784299894; c=relaxed/relaxed;
	bh=8AdUtRfzJF8aQtS4v5fF5lPXueRGdYBtCeyt7x5EaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtuRcNS+Vs12MBXvZk/Ud1471G4z5PTnnjwxefUCuojthaoldlndqfMkM75y0stGAfa51sfLB85x5sOpDE4jHZS95OX18AWpFD8QoGAOzqmKp8npVJDxgxzWRGigYvfE6SfO4Ochpv5AQPhwBsLTXTbAIaexxARfvZfSDxDv1k6uwk+AC14vdan3xfexjrRkHJTFcHwy7+POHngO71S4qUDImj8c1F7nu6iuprmqpf7Eeg9k0PQyG0gAnnWPlv7fS+VbPnJ9poIdPbMmp7pBL/PcvqiiKa+N8u69f8T76jmxoNvkKTRgf1MgzPqK6mKHIPlBAzC5KJSEdUUXuZv2hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BEHRaGyo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BEHRaGyo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1tCR1tPvz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 00:51:28 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c15ba5b151dso613379366b.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784299884; x=1784904684; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8AdUtRfzJF8aQtS4v5fF5lPXueRGdYBtCeyt7x5EaDI=;
        b=BEHRaGyoUq4N1NnPBnTHfsBSoOKm7U6MXaPre8qqCgx+Nlu9/Vgu3HThTJHTJ4O7sT
         vCPnSL4sHTbj/6NnT6LJq5pY44vR7XH85Rwps9ouo12RkGbO7bGcwp/p9qk0M5jQF+Ga
         +PifUxvP6Qz6+us+n2MS7cmPW4ltLvI0F8ahFA95VjKiiANhHwjztMDQf8Pem6MvW6WY
         LEWch514cMFqBYSv+17TScwdyc1hhndOREanI0J5DY62p/j1QmfmUkLzNbIKaK2Yw1up
         TrWd96amsvnulmwMHYh1yS62apohgA3qZ1fqzXmd4+dob14Fv1pov4JAM6rhkg8l7iFw
         gPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299884; x=1784904684;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8AdUtRfzJF8aQtS4v5fF5lPXueRGdYBtCeyt7x5EaDI=;
        b=tPfiJxdDwEvNVbX077eML1QY/i+sW55H7CVSbcmBzY9NI/aOqG8Ev6SlZe7Lsx21K0
         GK8Jb+Y932+QEswHg3Onc99saJCL3v+h2WJBxxdh5vRDlmd6YQ3vLZz9ME46LIlaUfcA
         x8q7B9pkWY9QR4xy25bAKBdnze/kinylyJF5rTBKL3+/vZrXG1/gpKgtz+vlRN820sJ3
         kPDamXTQMDENlIveWQTFsh5mvbb9fD2xbsf5gjc3MTkBrSbnVK0A0Tcj6hL7ZthpHbpx
         lnLsuKT2v4sxO6bUJCzkFQ99IZoIeTHnQ/KmVXtfUCwdhYqx17xgyyNIdg49DQNYYesB
         LH7w==
X-Forwarded-Encrypted: i=1; AHgh+RrfonAE+Db1AJ7Zz06VrWKpW8k1KCqtL+n8HU6FcwXqR5N60S341Ahs/j2r3Kujju1ojT2xTj3RM8kPG3Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd428ic4koyGeyteoEs1ZaJ9ufv1gnlrJipBI9H2oku//9UtVQ
	4jjkbZmzyB6zf1g+KtPGXThVeS21jAO4qhpMfNBjFJ/LmvEsgnLtErbkOq6R7JN6QrY=
X-Gm-Gg: AfdE7cmZCNVt9Rxx33C8uPafKdhfM0Xvpv3ov9QX1mnCH+DbdHSPWvWgFCRU4YixPxC
	IaJOWzuTCYwj9Or/bxfOVVZiwuZGR19TAExyKWslLHlymGjL2T8XTt8BAPCWgIYPP/l6PT0nDA1
	Y/Z+rNagUPcMQCLwS/zifuMY/CkUVYKicx1IePKe0SaCydqJY7JLgcKwjCQypa8E3S9ILNTL8TF
	63OooGPWVvxpnzMOWMwqDciOiT/HQ0QpK4bVJJhA80I7Lzw7JUwkDnFw6xSP3mzGmehY1mZwgUD
	xc6eQOfk7hDQww+wGOneps0YpmjgduG1mtqghmfaDkzF8CGQJW0rAydVy7XF+JX3OQMMCS0SvdE
	E1X1FW+ZHUiBO1prwLdtkxN6zk7gUN/cSRhh5RWeVCS7Vwx2/Lm5hZ4GLL0oBq3t7sTEEXX39aA
	L0trpVxmIKTzvzHKb0N1rUn5x6+E48LXhSlL8LaogAlz+DHYsdQqBH17t0B+JPlIClyg==
X-Received: by 2002:a17:907:1b1f:b0:c15:c1fb:e8ca with SMTP id a640c23a62f3a-c16b4699441mr149267966b.12.1784299884353;
        Fri, 17 Jul 2026 07:51:24 -0700 (PDT)
Received: from localhost (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c1712a5f986sm89319766b.40.2026.07.17.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:51:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Frank Haverkamp <haver@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Akshay Gupta <Akshay.Gupta@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	John Stultz <jstultz@google.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Keng-Yu Lin <keng-yu.lin@hpe.com>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Alexander Graf <graf@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	linux-gpio@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 00/12] misc: Improvements around *_device_id defintions
Date: Fri, 17 Jul 2026 16:50:46 +0200
Message-ID: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4565; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=v6KGcwddb0l8IcWTqCRDb4zO+LUewoltHwDvvn+vphg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWkFG1z8C4NRHLFUNeuqopgHw00qW+nI9nFAsy Lfpc0JrQqqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalpBRgAKCRCPgPtYfRL+ TgjPB/9mDiKAMUXV0wTB+CyNHbQLJZIEXYEmWQVuhH9QRBDgKl1H4iFu+J0C1cRYAMVVBXeWFKm bptw/U5yGNddrGZvPJIizrYRpjxAnbfRAeB11r9vDLxDKnILPO0Gvw8AZGCVsF0Y8eD40XySF0I 4wW5eRLSjMmzGU85S2ppLQevXoWQJKNEG7yr3Iqo2otnw5M0yZi7bzrfo0svgyXHp0KRM4CSb0V 17EyD29NvMnGBXwhZFUY2b6eghbBe8aTG7/1aR4zbNON8LPAmHRIFWIEMu0jgHftV26VB3u4Of1 3S89MPmxjLcxL6oF/2/xjjiCEz0G0TxVyXHqaWkJMimv5c5w
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the main motivation for this series are the patches that introduce named
initializers to these arrays. The reason I want these is that I plan to
make .driver_data a union, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for more details about this quest.

This series superseds a patch that only handled i2c_device_id, which is
available at
https://lore.kernel.org/all/20260515162734.469327-2-u.kleine-koenig@baylibre.com/.

Changes since then:

 - Also handle all the other *_device_id to ideally only have to bother
   about drivers/misc once for all the similar quests
 - split drivers/misc/eeprom in separate patches
 - rebased to yeserday's next

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (12):
  misc: Drop unused assignment of spi_device_id driver data
  misc/pvpanic: Drop unused assignment of acpi_device_id driver data
  misc: genwqe: Drop unused assignment of pci_device_id driver data
  misc: eeprom: Use named initializers for arrays of i2c_device_data
  misc: Use named initializers for arrays of i2c_device_data
  misc: Use named initializers for arrays of spi_device_data
  misc: mei: Use named initializers for acpi_device_id array
  misc: mei: Use named initializer for platform_device_id array
  misc: ibmvmc: Use named initializers for vio_device_id array
  misc: eeprom: idt_89hpesx: Unify style of of_device_id array
  misc: Unify style of of_device_id arrays
  misc: Unify code style for various *_device_id arrays

 drivers/misc/ad525x_dpot-i2c.c                |  52 ++---
 drivers/misc/ad525x_dpot-spi.c                |  58 ++---
 drivers/misc/amd-sbi/rmi-i2c.c                |   6 +-
 drivers/misc/apds9802als.c                    |   2 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   2 +-
 drivers/misc/bh1770glc.c                      |   6 +-
 drivers/misc/cardreader/alcor_pci.c           |   2 +-
 drivers/misc/cb710/core.c                     |   5 +-
 drivers/misc/ds1682.c                         |   6 +-
 drivers/misc/eeprom/idt_89hpesx.c             | 202 +++++++++---------
 drivers/misc/eeprom/max6875.c                 |   2 +-
 drivers/misc/fastrpc.c                        |   6 +-
 drivers/misc/gehc-achc.c                      |   4 +-
 drivers/misc/genwqe/card_base.c               |  88 +++-----
 drivers/misc/hi6421v600-irq.c                 |   2 +-
 drivers/misc/hisi_hikey_usb.c                 |   2 +-
 drivers/misc/hmc6352.c                        |   2 +-
 drivers/misc/hpilo.c                          |   6 +-
 drivers/misc/ibmasm/module.c                  |   2 +-
 drivers/misc/ibmvmc.c                         |   4 +-
 drivers/misc/ics932s401.c                     |   2 +-
 drivers/misc/isl29003.c                       |   4 +-
 drivers/misc/isl29020.c                       |   2 +-
 drivers/misc/keba/lan9252.c                   |   4 +-
 drivers/misc/lattice-ecp3-config.c            |   4 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c        |   8 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c        |   2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   |   4 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c |   4 +-
 drivers/misc/mei/pci-csc.c                    |   2 +-
 drivers/misc/mei/pci-me.c                     | 166 +++++++-------
 drivers/misc/mei/pci-txe.c                    |   6 +-
 drivers/misc/mei/platform-vsc.c               |   2 +-
 drivers/misc/mei/vsc-tp.c                     |  10 +-
 drivers/misc/mrvl_cn10k_dpi.c                 |   2 +-
 drivers/misc/nsm.c                            |   2 +-
 drivers/misc/ocxl/pci.c                       |   2 +-
 drivers/misc/open-dice.c                      |   2 +-
 drivers/misc/pci_endpoint_test.c              |  16 +-
 drivers/misc/phantom.c                        |   6 +-
 drivers/misc/pvpanic/pvpanic-mmio.c           |   8 +-
 drivers/misc/pvpanic/pvpanic-pci.c            |   4 +-
 drivers/misc/qcom-coincell.c                  |   4 +-
 drivers/misc/rp1/rp1_pci.c                    |   2 +-
 drivers/misc/sram.c                           |   2 +-
 drivers/misc/ti_fpc202.c                      |   2 +-
 drivers/misc/tsl2550.c                        |   2 +-
 drivers/misc/vcpu_stall_detector.c            |   4 +-
 drivers/misc/vmw_vmci/vmci_guest.c            |   4 +-
 50 files changed, 362 insertions(+), 381 deletions(-)


base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
-- 
2.55.0.11.g153666a7d9bb


