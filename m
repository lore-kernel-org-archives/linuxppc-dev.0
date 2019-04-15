Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD64C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607292075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuFcyNpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607292075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPSt14nJzDqGC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:12:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TuFcyNpZ"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQj3FT0zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:10:52 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id a184so19871665wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HOeHBVmwBdLK7v5lpV0asvyijnYp9oCdYtsI2CXEVhY=;
 b=TuFcyNpZZzp6qjWGR5KXwBzZ5uJA9tW54UpEm8rKHvQxlj1ghGBvI511SeuoaO104L
 z+sSShYKnJedS27J2rt0XNJVGm8JcVZwvuuOe43X1xRjs7AaAKuSloGGF1by7NYKpwvo
 Aump2gRxa7CYGQX+CdUHjuIq1URe1z+QLRZQQ3YfZkxsisVooPhjnLSgS8tfd64KqCcy
 prLiFCkn++e8dMZmvqtTX9BVZ9N6Z/dla8b0MKkr0veFshtsytUwMusZzt77uB5YNbuo
 LZw9/aM7Ob2jfrndVZBTm+66yge6ySbF0/QK8tYO+11WS1T/5bYFEBjq085jhHjGJPTz
 uVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HOeHBVmwBdLK7v5lpV0asvyijnYp9oCdYtsI2CXEVhY=;
 b=UQVAMfMCGfpqWil1s/6I+eoHWT/sFh70Neat8PJCL4zO+RJYoeApvF30vD5Yqe2Wxw
 SxHGbA7lUCUBgdhSy4A7fGLMXlUQumhMiMylld97zHd2UdaPoCmg172fHv2V6C7t25Pi
 lZ0Ld3WQNFDxRSyUnJhwfU9XvTNvHaI08zuxsehs5Zzp8mpQqYoWX/M57VcbVSfVf9p3
 9iIZ3NHl1ijKMKng9LWbIJzRHvgyW8CkMmJOb7uMiimPEa0tn4LanQFiOSXfbOX9xab1
 XeiTG4977XUcPbruvD8KC1hPx8JvkgQwE97wRxNhMVn5hoI6lWJiPO1dBZ8cTaoXUomG
 3GMA==
X-Gm-Message-State: APjAAAVFumGkwMBUVcoLuz29CojFiET2/retuutQfuXKZOaZ9aNS1ZJ2
 sYXjvDB2LO0us80yIUD+JuM=
X-Google-Smtp-Source: APXvYqwn7fEol0munSBw3WIb56yCpVZr/XyS1Mrs1mFAkVJWDmLh5Q8A8CU9p4yAipbxlARQQHwN3A==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr22094278wmc.76.1555323049972; 
 Mon, 15 Apr 2019 03:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.10.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:10:49 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 0/8] clk: make register endianness a run-time property
Date: Mon, 15 Apr 2019 12:10:38 +0200
Message-Id: <20190415101046.5872-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
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
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the endianness for register accesses of basic clocks if fixed
based on the architecture (BE for PowerPC, LE for everyone else). This
is inconvenient for architectures that support both.

To avoid adding more rules to the #ifdef, this patchset adds new flags
to the basic clocks to tag the registers as BE then converts the only
big endian machine PowerPC to use it.

While not used by PowerPC, also add big endian support to clk-fractional-
divider and clk-multiplier, to cover all basic clocks.
Technically clk-multiplier isn't one as it doesn't provide any
registration functions and none of its users set the basic clock flag,
but nevertheless it and its flags are defined clk-provider.h. So I think
it's close enough to a basic clock to still count.

That way we can drop the special casing for PowerPC, and allow other big
endian platforms/drivers to make use of the basic clocks.

In addition, we can now drop clk_readl and clk_writel, and replace them
with normal readl and writel accessors everywhere.

Still RFT because I don't have a PowerPC device to test, and especially
not a 512x one. I did compile test it though!

I looked really hard, and this is the only place I could find where a
PowerPC platform (indirectly) used the clk accessors.

None of the regular drivers in clk/ were selected in any of the powerpc
defconfigs, and this was the only platform code that registered basic
clocks.

Changelog:

V1 -> V2:
 * switch from global flag to per-clock flag
 * also added fractional divider and multiplier clocks, to make all
   basic or quasi basic clocks support big endian
 * reordered the basic clock patches in alphabetical order
 * drop clk_{readl,writel} instead of adding BE variants and use
   common accessors directly
 * dropped the RFC, as I got comments (yay). More always welcome of
   course :-)

Jonas Gorski (8):
  clk: divider: add explicit big endian support
  clk: fractional-divider: add explicit big endian support
  clk: gate: add explicit big endian support
  clk: multiplier: add explicit big endian support
  clk: mux: add explicit big endian support
  powerpc/512x: mark clocks as big endian
  clk: core: remove powerpc special handling
  clk: core: replace clk_{readl,writel} with {readl,writel}

 arch/powerpc/platforms/512x/clock-commonclk.c | 11 +++---
 drivers/clk/clk-divider.c                     | 26 +++++++++++---
 drivers/clk/clk-fractional-divider.c          | 22 ++++++++++--
 drivers/clk/clk-gate.c                        | 22 ++++++++++--
 drivers/clk/clk-multiplier.c                  | 22 ++++++++++--
 drivers/clk/clk-mux.c                         | 22 ++++++++++--
 drivers/clk/clk-xgene.c                       |  6 ++--
 drivers/clk/hisilicon/clk-hisi-phase.c        |  4 +--
 drivers/clk/imx/clk-divider-gate.c            | 20 +++++------
 drivers/clk/imx/clk-sccg-pll.c                | 12 +++----
 drivers/clk/nxp/clk-lpc18xx-ccu.c             |  6 ++--
 drivers/clk/nxp/clk-lpc18xx-cgu.c             | 24 ++++++-------
 drivers/clk/rockchip/clk-ddr.c                |  2 +-
 drivers/clk/rockchip/clk-half-divider.c       |  6 ++--
 drivers/clk/tegra/clk-tegra124.c              |  4 +--
 drivers/clk/tegra/clk-tegra210.c              |  6 ++--
 drivers/clk/zynq/clkc.c                       |  6 ++--
 drivers/clk/zynq/pll.c                        | 18 +++++-----
 include/linux/clk-provider.h                  | 51 +++++++++++----------------
 19 files changed, 182 insertions(+), 108 deletions(-)

-- 
2.13.2

