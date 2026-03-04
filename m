Return-Path: <linuxppc-dev+bounces-17740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859C0EFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3LC0Swmz3c8f;
	Thu, 05 Mar 2026 06:55:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633270;
	cv=none; b=EB0otCyf8A6+FXgfYkqr2c96deODaLbksb/3icqBSaj7preLWnrjgNPFsedxSEXJaHW9ioFeydl1+waPdsPCsNAimnZswpJyU0pOPQPq55DEXDSm1IMqWCEDtVXiYjQQgsYNvl3IKctw6caNzi4w2MrxHTug5Ki+NppmXsjSZHyb/Ckw6S25oq8KcGfE6Lpzlt6DE8OaIpPfns2lqVLRSw1UXqom8sJzN1WMOqDi+xQwjCDBir8uNnb0eXhDRgG5Ubtu+3QkSqRcmwWs7OP1sHPqk4vL2EwY9JlAjJPQLXmbIB+h8wSiIC9wO+sVCnCV15Q4GoBETHVf4eu/6Yi+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633270; c=relaxed/relaxed;
	bh=kpsptxMLAqoswZFWlYkpwOHcyofMbV/CwC4Yy5VaDOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESIo8CSf6nXbzKraFvLU4jOYPkIeLh4YtvT/vM2praS9hJnBfcS2IC+ywrFdIDtZi7isA9fw/Q7uH/xqWa38eVwGLzr4pus58NiIMH0uzTfZZMwTRXa6V//09g5dVz63N3DrIh7IuImuzKgXxLkogeMgXG2mXXGd1vbUd01ttwJTmpYzGpZb7FUgnQ86nPIiX+3PVrGtahnDRcEDuC7upYTf8DpoDURCLHFb13bbfIUDx8d4RbJUXiLbc5OUvazeKQ2i+vvm+jkziMy8PZLzyg+EF1RmDIdaU/oVmbJBix5l/sOT7QwjqShwRwgHgM7MYIl7FPHoYv/zWkQO85XEMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQSiLw4r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQSiLw4r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvdK5bZHz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:07:49 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3599019ae92so1774204a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633268; x=1773238068; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpsptxMLAqoswZFWlYkpwOHcyofMbV/CwC4Yy5VaDOU=;
        b=TQSiLw4r9IdmnUFFYi7PZBUAIZ9/L9ugZam+a2jDkG8Nwf3FOQXJ0usslDn5whWAyP
         iJSYYjfOeTYm2vPElLhk6AqAX/A3ygUBgnp4P2D9aED/XC/sr2He+i1NmmIcohNJa+/G
         ZwOydoH21cq71W9Cjr/bBrVL+5TxyfReUm4QCdgZNT1gZxym+w4E+NnJAbnQPSojiwND
         ef974UIQgAm+4+KrgIIb0bV+azMwJhStD57LhFE+w+IsyVHoMTVafviovKoT6UeguYks
         6XBEDNc8ZC4kVl1x5FnX965iOqxN8MbSaS44Ua9v5e+FOoNMmFJEdVhC7UXknbDue1H6
         rXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633268; x=1773238068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpsptxMLAqoswZFWlYkpwOHcyofMbV/CwC4Yy5VaDOU=;
        b=YJ32+OCGbkeh7pGuogcuHKtGWkounyLDEOEqSnjXhDqJd3foAh+dbgmWegTd1O4koa
         e2BxD/Es7pkUi+ZJ43XiTsCOG03PrGtnnORQmZphZEuKFW08dNFnba7c3JuvHZYCLDpd
         7KGJCAnluRl0+PH0yi4hg2KmrCEyKzlvFfCadqhWLKt7dRdqstEtyiz5bWcCGDlcooUR
         Qqk3OuyRq+/1ePUzQ6o8aD7oo9SKGaqcphtXOgv0S0d7O7ObbLz066QyEurNyAobJDSc
         m2i2joGji6bmwl+15AYsKIrJg66ME8owlcpg6/8mzuLTddVTWkJM29Yk97lhhKWJgZuJ
         jMdA==
X-Forwarded-Encrypted: i=1; AJvYcCVavMH8Png4i2HDX3AR6P0+chOQT48wJ4T0mPW6rUz6pnQ2E/nxUaqB82zqqIn/xc+tKdWJDgGR806YL5o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjrwdZxPY16lk0QRauzs8GihKMTYFaa6sOnuyJQ88aH3vj6/Xn
	cXWx/YCS7e4I0EHErGQz+yf2u4H+SWdXWlCpOegzmIoHydX18igLkDIs
X-Gm-Gg: ATEYQzww7v75IDgyET9btZDh2jnu34vtJN2REonlUK+iLN/6QisN38Te+DsbF/Qtv2K
	91sWC2YEcLuMLgk/zF3UGktxz+kl9YZooetZPFwXVrQgYPp48b9NTVPqIdXuNtF59djjmtJuidD
	pJlYVnwMyK0p9gq6JByJXNv49YwnUOgQknEODzQu6XmhcWLIA3AtAzQXeJOlM+zIYvBhOfcJGi6
	ji1dpJP0lR6ourObA6eCIBn2IdEJsmbjDOcOFLknyySbNTufrejgQWNoSoH5IZy5nhHp9jM+z/L
	ml/NaFSvydwLZBOAvUSwoyZMuW3u9Xwip3iPkjt9gcrhVQW2G8+FPBKPan9jFCpBzD6JPXEY52a
	gIYQFFMvit+CQ05h9vchrV5T11XffXORDH6o51n9CI7SUTX78q2sP/0kPtZ+qJ+prvAOssN6pOy
	eGvQDq6mkJx0ELyZjFkqUq
X-Received: by 2002:a17:90b:3f83:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-359a6a4a2fbmr1903833a91.21.1772633267856;
        Wed, 04 Mar 2026 06:07:47 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:07:47 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Hans Zhang <18255117159@163.com>,
	Koichiro Den <den@valinux.co.jp>,
	Thomas Gleixner <tglx@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 05/18] PCI: bt1: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:48 +0530
Message-ID: <20260304140329.7089-6-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-bt1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 1340edc18d12..ef6a3c7fa279 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -636,6 +636,7 @@ static struct platform_driver bt1_pcie_driver = {
 	.driver = {
 		.name	= "bt1-pcie",
 		.of_match_table = bt1_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(bt1_pcie_driver);
-- 
2.50.1


