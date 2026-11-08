Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A7606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlJriO2I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMpVX2bbCz2yVT;
	Sun, 08 Nov 2026 21:07:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794132420;
	cv=pass; b=KLX926KIEAU4xIs0MWvvoAU2AbPnRpKHLSYHHU7afmuAwPdzAmOIiJwj0hXE/mKQXwMBGC20khsBZAkTZYONpsTm/lHrNFcdoec4dUU9+La4Onu3Tsr2losP2/JT4LVvLWsG3iFxjxyVX4jgFPPZo65ziJ4JcZnpKjijzb2+uhJwtNCFjF/Y3voWqhpKe9jZSHFXZjV2qrDVyC0uuuQ5SH5oUWfw+uGxeAVt3vneK59hWMswQrudUVsJBlzXotSFgygObVVCuNusffKO0QCoFuFYxKW5ibZeZr9/0Zok0/f8liyC4SxT/HetspkL3ymAi5lVQJPE8USgyrIttvMDzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794132420; c=relaxed/relaxed;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uo6g4Qtw5Ah7XbdO5JcZ+XAoPdevT1IMRkU4nei2Fy7fMpjW7VR4/z5C8O3+JjS/qKsNDtmFYkk1Xg6GrkraWscf+oTqfCS+2CFJujW5ngnJehZH+1CVavXMXYyC0cwngHSgvvvHkebmY8w02GtxOFdhb1G9bdL623Tz3SAR/+bS1MTgEBpl0XttRpjpJtsiWO7CPg8/FKdZYuVfKe0Ho8dLlUMqHKdfhq78OtIBLj8rroBXNyzU//XvdaxrdiK2dlXCYcSljh53f85vsjyaVaSVwni7JTVcLra4pWfjvWei9dv5n/xtAoD9WIlCor+ybWqRh65Yo1Uxzn6nxTgrGQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlJriO2I; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlJriO2I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMpVT13F9z2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 21:06:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B63B43CCC;
	Sun,  8 Nov 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794132415;
	b=0jAmR3JjNP9khpbqfFnxA/YgXeOq6F95Jh8Yr8+y79tjeXyI7CleyeLY9dWNF6L3vRhj
	 03bxK5bRoVDrQLJoaq3SLrjsG5bX7K3MWmTcd8ttgW2buBmsvM542FkxExIDIFPqhHI9Q
	 5jN357Is2UJ53L0Il/POusq8wz/dMzwgKNJGfD9gQlEwNHhQ12rSA+CHz+hRAydXbgwac
	 DoANeR9aBOQddVxNMWnycDp2B82CzG+s8DRnPRPQIAK9dgnfhk+bapEzepN/u2A1orE5F
	 HkUjW/Dn5A9FhrzSr1wPcmDAilESNaSGLV/oYsBzOywVPyk1voEBL4gMh77lERnxC7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794132415;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	b=edwKSPvp8jT80ukuLuH9tQeK9I4DFgl5zZqcAhTPYzmV5TfgtoiOy/mCDFS0SWEaNhML
	 xQk6XCRLMkwViW70w62L9VXPthIZmWHVzie3VjxIRyApi3iV+Ind1dprPfdh6RXHxxOKk
	 E1eVHqGyz9faZyj83DOSOZ3P9Viwi0W9hlB9E5BYXyJAj4XUoBt+hEldh8quidFRKYJ7F
	 ItyrDVxoAcggyOiGmdTs9X2gZ+aZBPhbis4U9BvGhdbduXCNiGUYl3PakTEjUtLshfY1q
	 eTkK8y1rA4jxPprlt3NOmemihSqe0u5kxRqx+1uFNwLelnvel4AB1DfvREatLa/vbuQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D3A91F008A3;
	Sun,  8 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794132414;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nlJriO2IGP7RVBOgkcNeJQc46C9tTI9rg4S7arrI6Fx6sjNOY5llkDWh5eKcuxEzq
	 dY3t66ASRwWhkU84qeJZFYBxW3eyIpVFGgwEpgxHNV9CiStjpytijb74bC1l+GvJyh
	 qwWSLOmGqO9aUo023JsrS5XVW/+GFdVZpMmf5+PVVHD56xGAXHt7VxMviZ5Z/tCLAk
	 CGuxkh+oZV+WSKFAC+WDBcVeSoYgHokeoyeTsGZAqAbHzrx+tO5rbbXR5SO1Y0hcPD
	 ED8eJthdkwSeuBqf9/EK8dzfIkrQAW57h+8GcLGknjWspXoxAnbZltbEdbAVzM0MOG
	 CoUkphjG12ynQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C46A47ED3;
	Sun,  8 Nov 2026 10:06:53 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Sun, 08 Nov 2026 11:06:51 +0100
Subject: [PATCH v3 3/5] soc: fsl: guts: add the RCW override of any RCWSR
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
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-3-5a0063f1da9e@free.fr>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794132412; l=4011;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=zMby9g9Gw8IHCSfvPJh/Ob7NvLFrXegdSthe00uEpLg=;
 b=2b1nOVqOafOScXjWJwLBfaZRxAk5LXAMFetO1Zi2NRhoOC9E019pnsyEBWgl0ObkpuXfGHhY1
 SemDGmin9KTAOpDCHsTO6HO7nr4HADSit4kn5z43VV4xJEDzzCT/X3J
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
other fields of the RCW:
 - fsl_guts_rcw_read() reads a status register
 - fsl_guts_rcw_override() changes fields of one under rcwcr_lock and
   waits for the status register to follow
 - fsl_guts_rcw_override_supported() tells whether the DCSR view of DCFG,
   which holds the override registers, is mapped

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/soc/fsl/guts.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsl/guts.h |  3 ++
 2 files changed, 76 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 28361c63e26c..d2e3f66d0da4 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -369,6 +369,79 @@ int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mo
 }
 EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
 
+/**
+ * fsl_guts_rcw_read() - read a RCW status register
+ * @index: one-based index, RCWSR1 to RCWSR32
+ * @val: the value read
+ *
+ * Return: 0 on success, -ENODEV before the DCFG block is mapped,
+ * -EINVAL when @index is not 1 to 32
+ */
+int fsl_guts_rcw_read(unsigned int index, u32 *val)
+{
+	if (!soc.dcfg_ccsr)
+		return -ENODEV;
+	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
+		return -EINVAL;
+
+	*val = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[index - 1]);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_read, "FSL_GUTS");
+
+/**
+ * fsl_guts_rcw_override() - override fields of a RCW
+ * @index: one-based index of the RCWSR and RCWCR pair
+ * @val: the new value of the fields, in place
+ * @mask: the fields to change
+ *
+ * The fields outside @mask keep the value the status register shows. The
+ * override register is written and the status register polled until it
+ * shows the result, as fsl_guts_lane_set_mode() does for a SerDes lane.
+ *
+ * Context: takes rcwcr_lock, shared with fsl_guts_lane_set_mode(), and
+ * busy-polls the status register for up to RCW_TIMEOUT_US. Does not
+ * sleep; must not be called from interrupt context.
+ *
+ * Return: 0 on success, -EOPNOTSUPP without a DCSR mapping of DCFG,
+ * negative error otherwise
+ */
+int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask)
+{
+	int err;
+
+	if (!soc.dcfg_ccsr)
+		return -ENODEV;
+	if (!soc.dcfg_dcsr)
+		return -EOPNOTSUPP;
+	if (index < 1 || index > ARRAY_SIZE(soc.dcfg_ccsr->rcwsr))
+		return -EINVAL;
+
+	spin_lock(&soc.rcwcr_lock);
+	err = fsl_guts_rcw_rmw(index - 1, val & mask, mask);
+	spin_unlock(&soc.rcwcr_lock);
+	if (err)
+		pr_err("RCW override of RCWSR%u failed: %pe\n", index,
+		       ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override, "FSL_GUTS");
+
+/**
+ * fsl_guts_rcw_override_supported() - can a Reset Configuration Word be
+ *				       overridden?
+ *
+ * Return: true when the DCFG block is mapped with its DCSR view, the
+ * second reg of the dcfg node, which holds the override registers
+ */
+bool fsl_guts_rcw_override_supported(void)
+{
+	return soc.dcfg_ccsr && soc.dcfg_dcsr;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_rcw_override_supported, "FSL_GUTS");
+
 static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 {
 	struct device_node *np;
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 8d5ffb985fee..7127de897c23 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -142,6 +142,9 @@ int fsl_guts_lane_validate(int serdes_idx, int lane,
 			   enum lynx_lane_mode lane_mode);
 int fsl_guts_lane_set_mode(int serdes_idx, int lane,
 			   enum lynx_lane_mode lane_mode);
+int fsl_guts_rcw_read(unsigned int index, u32 *val);
+int fsl_guts_rcw_override(unsigned int index, u32 val, u32 mask);
+bool fsl_guts_rcw_override_supported(void);
 
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))

-- 
2.43.0



