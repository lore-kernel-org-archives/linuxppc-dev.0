Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0789C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:13:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEEC214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzC/KeKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEEC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGh06JH0zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:13:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzC/KeKL"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfD02cjzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:17 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id y197so2444108wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=yn6Id06pDDX/+u4mQsjGgX3TBS/5u8W5OOwPhGIgFdM=;
 b=YzC/KeKLwg1AvhqgZhhkiOqcltq302IQ+VApzqyw0eOEPk5APvnJA/j5KieEP8o3KI
 eTPk0c6OAs0aOZdW0oSkdHf+G0AVGVm5OPTnT3mGtX5vL84GFTej6GchpcBh3T5Bw3KT
 aOEFnjdtvDSUJAaMhBVZ/62JDXWpnAP2fUUC4fc/51fjjZhs0HMxs8+KH4YVl6cGm/N+
 Tr6BNr8nRWYa7ub9I8X/fIUnFCDftPtPIAl0SlBiaJR2r6ExpX+Y/t36rKviqlQWNaNc
 TesH5sNsjEMKj3vljaWiLDCWFju2ZEhO57X20hYZ9RnEj/jtgukPJ2YpjaPXZRsdm7Qg
 Q98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yn6Id06pDDX/+u4mQsjGgX3TBS/5u8W5OOwPhGIgFdM=;
 b=OqB3Ve8I8B2YJ3dZGgbHchwWgOq4KKTG1irZfKwYQTIbdj5LF1J+6uHC/HJ7TskQBc
 Pqc+6RRXo/CdRWUuyqZ4Xca8Mk+neROv3imQMoYICNBc5l38HcpNMv+XvrHCHdChomSe
 fla/p7CgKkgeHSSI2NMMwd88eHhk1R1Z55Ljq78keb1Bt/Aey2S0eLB7Xiek1cIPOSgN
 u0e4iksCDKDYkaYNYyf9AJ3LPwlx977CH5+R80/tUV5mzu7niTv8nAiga6cMblx10maR
 XQFDYsJedBHjJjSPEXW1apP0t8C/u8HofzUlKDZHO/cZdquVeSqnh0GWQLqQyqo3ybu8
 lMtg==
X-Gm-Message-State: APjAAAWFWUG4GlTIYKKNJ4LkS7j+5MSaUv36N3VxdKAXy0qOJiQUYqR4
 2RKtGzCuk/QL5qOH4MacYPQ=
X-Google-Smtp-Source: APXvYqw8WChf9BG5BreV5SUSIsaLZMXms31bwzlET9t+fOAgDmvooHPOEV5Pq0+Fu4l/eNjOVzO6Fg==
X-Received: by 2002:a1c:c101:: with SMTP id r1mr2526596wmf.123.1555585933878; 
 Thu, 18 Apr 2019 04:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 0/8] clk: make register endianness a run-time property
Date: Thu, 18 Apr 2019 13:12:03 +0200
Message-Id: <20190418111211.10474-1-jonas.gorski@gmail.com>
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

V2 -> V3:
 * fix passed arguments to clk_div_readl found by kbuild
 * drop unneeded else in generic read accessors
 * fix a >80 chars line issue in the powerpc patch

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

 arch/powerpc/platforms/512x/clock-commonclk.c |  9 +++--
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
 19 files changed, 181 insertions(+), 107 deletions(-)

-- 
2.13.2

