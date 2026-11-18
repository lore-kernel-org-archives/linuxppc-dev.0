Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E74606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZrxVi3G
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzCf1yDWz2yLF;
	Wed, 18 Nov 2026 22:00:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999630;
	cv=pass; b=bWf+Y5xZvKKay9+6br0ufKGlti+hd2AJnkOXjFuN7q2JKZBb9qbQx401FmMHVfTYFt0STrT2oIJ9lvcYeghS5x6ZHTs+r7A44Dr5GpzH5XEd4yQ53LADorNv+dMSrZiH2co00ODZ1KOg/pDFEi1+3m5Wkb1Z5+JdKkaTVrSp2pv7MomNGdEb5RSsEqj8MUUXh5f/icSyfFBHhWDNfGOulmAEjPVMYFpqaTtAY8jP3p/N2WmdC68nDbmZuWpGym8lRvIEHw3HI7h2qjwjJNLyaE8mvhyP6bL61/+ckkHkBM4Hha617fwTXmipkAQG56g7rQS97ysbJRAxwn3QJRrqAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999630; c=relaxed/relaxed;
	bh=E4zxuh669/X4MzHfFGjjwuwVEi24EA4U+7IlkNqXh+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWoseUrIrmvpYwAQ1Jtj1chH9s9YdjJHrfbtF3+I+n0nULGnc5JUTTfuIoTugYtJH0QaruOUYmvdOPm5SI3ocX8eDVudmaybe8/RCDh4q/koA4D/2QmKA3uZRrQJT5NwdB8Q00lqlberVCQzg3v+xMcMR2Joqcrn1QWm1IG9RoMoA7ib1p9jPMMcwaf3XoDthHdj89JF+zzyhq/KTqIWEX1pKG8cAqroAs/f/p8esBqZab/F3ojNlxvNHlvEThEMBvWYKsoCi5qkRurqhlLNwaaE3kJx+66GoiLcWlN0cy77CFmOyzGiFFWjHIdD3V5ToaXF1NyGvt4C9qCYnqAPgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZrxVi3G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZrxVi3G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzCV4QsRz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:00:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 314C543369;
	Wed, 18 Nov 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999620;
	b=jlQ/NrwYzgTSUc5yBjwtA+glQUxF/xPzFijJGcgy7fmxz2rfKBR12W6KnXUt1RSMQLch
	 42/0dKc3Rm48ltHnVoafKlDMqsMhet2YhgDwz2HcDCIkPkbGy0B+6+6eqYzgCfP86KE6S
	 Bdxq4jYzLQthZ7tpdabmt0567gsvKiIijGb9nNCEIvHBqOKmCpGwN4w3lgOmtyadgZn4g
	 4QY00G3ndYMYXVwGzWBVvCtVjYyJiP3x3SeFsxDQplW+aAgZlyxR7mKC4j/pFqLkEO6Iw
	 z3XD18HBcfDRxi+mhQ695CE9iDa+Hqmfu708ZVY7769SzH9uLliJEVfwbnWnRreONWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999620;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E4zxuh669/X4MzHfFGjjwuwVEi24EA4U+7IlkNqXh+c=;
	b=RiePGY+FNiDBu8ILa0l1E/p+s/eOwASEVodDtOCURUH9D/WQbi6L+gVR8OWeNB14InMl
	 2QmGYwVoT5pbgBvWpswva479mPclTuc+ozhINTgndFA6XW+5uZdk9G/BugDwxo4XXUx5J
	 fWJ37LMgt5VIjTWEhf34rCLkTamKcVDftoN5NRitCxe/ARhjLK494DdQmFDkKxeRYe47P
	 +FujK/hXkrFAIJ1S40tOri6pJ1F4tMX94OncTJeR+181Voooj0wwJDNRfCg55c2tp4mvu
	 +Qzvx8nQBQw+I7FfM+BJKVBQG42mQ+O94egiYUxHNbpDoR7MkCeG90ZaDunNJ7R6UVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64B541F000C7;
	Wed, 18 Nov 2026 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999620;
	bh=E4zxuh669/X4MzHfFGjjwuwVEi24EA4U+7IlkNqXh+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iZrxVi3GS4SfQS2lNXZjadolmKeXAOwiJccWi5/KHG/uDjtqZ4VXz7nsXMfvw9VPi
	 AV9RZwk3YvpZzC31tRKhobwGvmBhNUBNFESwELO1Mi/xk34OS7TK9aN1q6/mMCmTsS
	 O5JDeDQ0lRkAGzxHkfUa3CdWdj08EBln1Rl7usPfRYxpbHhrwbO9lhjFSd7UuZg53F
	 dslD5A+9eTwd0mX/GU/Y1pQpcr0iTuQjBVK2NJDaLdXZfxY7tLZl3wUxzWvrMgm03U
	 6UeivbArji8V2EiAitN/8G3D8KRtliBnb08if97ySM2+CvC7hEfEk8F6QoI7knSRHX
	 Popj4fcnoXAMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E0BFD4AD2E;
	Wed, 18 Nov 2026 11:00:16 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 18 Nov 2026 12:00:17 +0100
Subject: [PATCH v8 3/6] soc: fsl: guts: add the RCW override of the pad
 muxes
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
Message-Id: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-3-d01bc837593e@free.fr>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
In-Reply-To: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
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
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Frank Li <Frank.li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999615; l=7157;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=cLGyD11x+pbnSyq/6tIuQvXmgFDB1OCNk1r5nfpKXHY=;
 b=JCgUw4fh/eWMT9uWX23+qpk0HLSS4QCvE72wuqrOQNVk+qF4TfiV5Xi0u+ah2zg1mXrcT7Y3P
 SAzjzWt85R6C8+I1LuuFx2kI706MPiUbZ0D0U+YUoHaCUhe8LUk7LeD
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
the pad-mux fields of the RCW, and for them only:
 - fsl_guts_pmux_read() reads the pad-mux fields of a status register
 - fsl_guts_pmux_override() changes pad-mux fields of one under
   rcwcr_lock and waits for the status register to follow
 - fsl_guts_pmux_override_supported() tells whether the SoC has pad-mux
   fields and whether the DCSR view of DCFG, which holds the override
   registers, is mapped

Each SoC lists in its fsl_soc_data the fields that can be overridden,
per RCWSR: a register or a field outside of this list is refused, so
the SerDes protocols stay with fsl_guts_lane_set_mode(). The LX2160A
lists the pad muxes of RCWSR12 to RCWSR14 and of RCWSR27.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Frank Li <Frank.li@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/soc/fsl/guts.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fsl/guts.h |   3 ++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 28361c63e26c1..a4b767f1e297a 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -53,6 +53,12 @@ struct fsl_soc_serdes_rcw_override {
 	int val;
 };
 
+/* Pad-mux fields of the one-based RCWSRn, the ones that may be overridden */
+struct fsl_soc_pmux_mask {
+	unsigned int rcwsr;
+	u32 mask;
+};
+
 struct fsl_soc_data {
 	const char *sfp_compat;
 	u32 uid_offset;
@@ -62,6 +68,7 @@ struct fsl_soc_data {
 	int (*serdes_get_rcw_override)(int index, int lane,
 				       enum lynx_lane_mode lane_mode,
 				       struct fsl_soc_serdes_rcw_override *override);
+	const struct fsl_soc_pmux_mask *pmux;
 };
 
 enum qoriq_die {
@@ -369,6 +376,110 @@ int fsl_guts_lane_set_mode(int serdes_idx, int lane, enum lynx_lane_mode lane_mo
 }
 EXPORT_SYMBOL_NS_GPL(fsl_guts_lane_set_mode, "FSL_GUTS");
 
+static const struct fsl_soc_pmux_mask *
+fsl_guts_get_pmux_mask(unsigned int rcwsr)
+{
+	const struct fsl_soc_pmux_mask *pmux;
+
+	if (!soc.data || !soc.data->pmux)
+		return NULL;
+
+	for (pmux = soc.data->pmux; pmux->rcwsr; pmux++) {
+		if (pmux->rcwsr == rcwsr)
+			return pmux;
+	}
+
+	return NULL;
+}
+
+/**
+ * fsl_guts_pmux_read() - read the pad-mux fields of a RCW status register
+ * @rcwsr: one-based index of the status register, as in RCWSR12
+ * @val: the pad-mux fields read, the other fields of the register are 0
+ *
+ * Return: 0 on success, -ENODEV before the DCFG block is mapped, -EINVAL
+ * when the register holds no pad-mux field on this SoC
+ */
+int fsl_guts_pmux_read(unsigned int rcwsr, u32 *val)
+{
+	const struct fsl_soc_pmux_mask *pmux;
+
+	if (!soc.dcfg_ccsr)
+		return -ENODEV;
+
+	pmux = fsl_guts_get_pmux_mask(rcwsr);
+	if (!pmux)
+		return -EINVAL;
+
+	*val = fsl_guts_read(&soc.dcfg_ccsr->rcwsr[rcwsr - 1]) & pmux->mask;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_read, "FSL_GUTS");
+
+/**
+ * fsl_guts_pmux_override() - override pad-mux fields of the RCW
+ * @rcwsr: one-based index of the RCWSR and RCWCR pair, as in RCWSR12
+ * @val: the new value of the fields, in place
+ * @mask: the fields to change
+ *
+ * Only the pad-mux fields that the SoC lists can be changed: a SerDes
+ * protocol is changed with fsl_guts_lane_set_mode(), and the other fields
+ * of the RCW are refused.
+ *
+ * The fields outside @mask keep the value the status register shows. The
+ * override register is written and the status register polled until it
+ * shows the result, as fsl_guts_lane_set_mode() does for a SerDes lane.
+ *
+ * Context: takes rcwcr_lock, shared with fsl_guts_lane_set_mode(), and
+ * busy-polls the status register a bounded number of times. Does not
+ * sleep, shall not be called from interrupt context.
+ *
+ * Return:
+ * * 0 on success
+ * * -ENODEV before the DCFG block is mapped
+ * * -EOPNOTSUPP without a DCSR mapping of DCFG
+ * * -EINVAL when @mask is not made of pad-mux fields of the register
+ * * negative error otherwise
+ */
+int fsl_guts_pmux_override(unsigned int rcwsr, u32 val, u32 mask)
+{
+	const struct fsl_soc_pmux_mask *pmux;
+	int err;
+
+	if (!soc.dcfg_ccsr)
+		return -ENODEV;
+	if (!soc.dcfg_dcsr)
+		return -EOPNOTSUPP;
+
+	pmux = fsl_guts_get_pmux_mask(rcwsr);
+	if (!pmux || !mask || (mask & ~pmux->mask))
+		return -EINVAL;
+
+	spin_lock(&soc.rcwcr_lock);
+	err = fsl_guts_rcw_rmw(rcwsr - 1, val & mask, mask);
+	spin_unlock(&soc.rcwcr_lock);
+	if (err)
+		pr_err("RCW override of RCWSR%u failed: %pe\n", rcwsr,
+		       ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_override, "FSL_GUTS");
+
+/**
+ * fsl_guts_pmux_override_supported() - can the pad muxes be overridden?
+ *
+ * Return: true when the SoC lists pad-mux fields and the DCFG block is
+ * mapped with its DCSR view, the second reg of the dcfg node, which holds
+ * the override registers
+ */
+bool fsl_guts_pmux_override_supported(void)
+{
+	return soc.dcfg_ccsr && soc.dcfg_dcsr && soc.data && soc.data->pmux;
+}
+EXPORT_SYMBOL_NS_GPL(fsl_guts_pmux_override_supported, "FSL_GUTS");
+
 static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 {
 	struct device_node *np;
@@ -579,6 +690,18 @@ static const struct fsl_soc_data ls1028a_data = {
 	.num_serdes_lanes = 4,
 };
 
+static const struct fsl_soc_pmux_mask lx2160a_pmux[] = {
+	{ 12, GENMASK(29, 0) },	/* IIC2..SDHC1_DIR */
+	{ 13, GENMASK(29, 0) },	/* SDHC2_DAT74..EVT43 */
+	{ 14, GENMASK(10, 0) },	/* EVT20..IIC1 */
+	{ 27, GENMASK(7, 0) },	/* EC1, EC2, USB_EXT, GTX_CLK, SDHC1_DS */
+	{}
+};
+
+static const struct fsl_soc_data lx2160a_data = {
+	.pmux = lx2160a_pmux,
+};
+
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for Freescale QorIQ SOCs.
@@ -606,7 +729,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", .data = &ls1088a_data},
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", .data = &ls1046a_data},
-	{ .compatible = "fsl,lx2160a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", .data = &lx2160a_data},
 	{ .compatible = "fsl,ls1028a-dcfg", .data = &ls1028a_data},
 	{}
 };
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 8d5ffb985feed..ae245afeb7b9d 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -142,6 +142,9 @@ int fsl_guts_lane_validate(int serdes_idx, int lane,
 			   enum lynx_lane_mode lane_mode);
 int fsl_guts_lane_set_mode(int serdes_idx, int lane,
 			   enum lynx_lane_mode lane_mode);
+int fsl_guts_pmux_read(unsigned int rcwsr, u32 *val);
+int fsl_guts_pmux_override(unsigned int rcwsr, u32 val, u32 mask);
+bool fsl_guts_pmux_override_supported(void);
 
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))

-- 
2.43.0



