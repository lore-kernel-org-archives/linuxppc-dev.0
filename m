Return-Path: <linuxppc-dev+bounces-17750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8021CEFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Mk3ClVz3cD1;
	Thu, 05 Mar 2026 06:56:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633755;
	cv=none; b=AYmVSckcy5KeCZkgj4X9x15jeJxSlCqcsySNFfOgahQxuQNPHDu23bsyJK0/p3vV85NfFhO1sGatmpSDX0qWhAB5Mq7qd7fcbPJQrKzzF1OMvodpegYva6zgrDN3WmGWFCp5Jj5GWCr+h0RnYAI56KykVyohN+w+eRnmT2WrgxF3DW++9rNmnBsXcAGvAmDpuEy7FCZjns4I63mZFVV1qLP+Fx21y/dCn0uwJG6rt2v1U5OBy5/695BxxBHgx6hRaUpYNGkBjohA7JiCE6mld6A6+E5BHKtcpbOrHSMl0QjVQiin3RouWTnycBibLpqGGvTGKtQQo4gMH0wbS//riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633755; c=relaxed/relaxed;
	bh=/CrWSKJRkZKN008VlCo4uVGQadvKlijsjSi8/hdflIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkUiFIbTGEMiEB/fIpgMNgMecm0o1Wlx8DGpQS332ZQTPS1uS/dBFyyKieLHV/4u8a6Gvu84ZrFK+q4fBJVIev8FsxhIufSLp3XFPutqSBs4iL4L6G62t4AmimD6zINZwLFyqG30p6eBoiq5hZqWEBSwhC+FLTCFVn3gGomqmAuQFGV9bamiHOA5YCo5qraN+BnLaCinr/FkVFWnG4rZGl7kruFqhEeCPZ7bqUsH9pNAuUHej0P+fpQRuUrrdkBwaVjUrY3X7qaYGEUk00O1hif7IgmdtEOdZv6IH51jTMWf7nO6vHjaYddD+6Py5tU0wLUGGjOpYoPkS0LGQwIVwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MLYyfrsq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MLYyfrsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvpg0wX6z3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:15:54 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3059787a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633753; x=1773238553; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CrWSKJRkZKN008VlCo4uVGQadvKlijsjSi8/hdflIY=;
        b=MLYyfrsqRikwBZSLsQNyOH+wdf8tMRa8QY492nfaWGTzxCARf81QEBt1armZHixLxX
         SSK2G/FkAqbQLiuf85acOhCp1J8z2FZqVMTCnk0fi1moMBv4AK+Qs5la4upAxQCRI6Tz
         LWZmzkUZTh4vwrCoPmQ91jgZuAyP80eiGLZ1eFgWqwmr4gUg6J6hWuuvC0R8ZG/HLXHC
         U0J9Y1Y5Ot5Huc7XWURCm6VZ1Nw3xtJWENJQI4y8j2Dn5mBbJNWeHLi1954NOj2ySQyr
         kMX6uo8WRnDuwF55FFplttwsP6VeUtYAGEQWMb62JNO3B2EZ2YULq4ftU9Gqh8G3u1dY
         8D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633753; x=1773238553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/CrWSKJRkZKN008VlCo4uVGQadvKlijsjSi8/hdflIY=;
        b=v6R6YGy055UNkZiSFDZI8dm72T9PEVxvllY1cwCYwka2Bgs1uQkX2fQmntLHTLWBWx
         eH8UcmKb/grNfqInbt+JYVbBPjgCtG1HhvNUFg8+L5dG1KbGwAxLN5H/9BnKOS1gEv1D
         tDHELiHFHIq4jzcVeUmWVHBBf6dX8/n7FTdKjEllNCol1jRufKzBtlq5iuLfGbIN2+xT
         V7Ji948l77pHNp7LDf8jS7xPuVtzXQpPclu9tpX87cWa0Vu5JnNgUPkB1linsY2oeze6
         8q3U1ga/yXMzi17m/nAhkrxMUSCqkobI2RFTPWWi/ohe07SAQBWA78aXlm5QCzsxCz8Q
         k9bA==
X-Forwarded-Encrypted: i=1; AJvYcCX+hZq0LgBY+kyipGT2jwrlCt0XvZTIyRHSH2dv0Gnh3xB+XkxDA03aq4L0xRTculKciuIxVshX2XiRU1A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFXrd9CvgENtECFkW0puO2ZYvDnz0o0/kD0f9dfCaMP4QEY1dA
	wHLOc6Q6rExI8s+VUdTWyRtClvlGFcfPrivGXVZBO7zdmwmXCwAORldw
X-Gm-Gg: ATEYQzximRL+SA9JtFPIzprrgoPQFbhJoSeAHNt8cQ8Wlrrfx5aRoNdyBD2O0U4a7iK
	soq6PyjMUlzx/jwMeHYg6qJh7MUUTdRusdm3/nBh75cB03kbU1c7bb3bbgsj45PJTllFqUEohyb
	gB2oFroD1/tIoUctQIzw7T+xMuAlNPyl5kZzPuHu1bZNFwlGs/iwD9JHeAYcHkxMRd1r5lWuJq9
	uMbVAqVW9+Ha/KS9EMof+lR0oRlgcNyA05S12VKXrgvHRUpIbTihsGLwGQ94WKPdw61JvZeSkbn
	Nv0pelSTV19YvT3hKF4KslHWN6WA8tkAh+tnnY9FgBg7vp0a62bqRbU5hfCqHDhbiY0mUxRkCeB
	EAwUx8fsdIXcETPC9nP0I+++zhrY1FfK3iJkrFOPeyNK4zI1vHzcuDn8Qt8JwfV22uGbD5k5lpg
	jw6r4rKvtARFJkpqFV8Ncn
X-Received: by 2002:a17:90b:3506:b0:354:a57c:65dd with SMTP id 98e67ed59e1d1-359a6a66b87mr2001714a91.24.1772633753114;
        Wed, 04 Mar 2026 06:15:53 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:52 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Niklas Cassel <cassel@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Vidya Sagar <vidyas@nvidia.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list),
	linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG EXYNOS),
	linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	imx@lists.linux.dev (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	linux-amlogic@lists.infradead.org (open list:PCIE DRIVER FOR AMLOGIC MESON),
	linux-arm-kernel@axis.com (open list:PCIE DRIVER FOR AXIS ARTPEC),
	sophgo@lists.linux.dev (open list:SOPHGO DEVICETREES and DRIVERS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS:Keyword:fu[57]40)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 15/18] PCI: sophgo: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:58 +0530
Message-ID: <20260304140329.7089-16-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304140329.7089-1-linux.amoon@gmail.com>
References: <20260304140329.7089-1-linux.amoon@gmail.com>
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

Establishing a PCIe link can take a while, allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..0393f4b613de 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -269,6 +269,7 @@ static struct platform_driver sophgo_pcie_driver = {
 		.name = "sophgo-pcie",
 		.of_match_table = sophgo_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sophgo_pcie_probe,
 };
-- 
2.50.1


