Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73366606A33E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7FkLUHQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxWb37nlz2xwL;
	Wed, 04 Nov 2026 05:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729579;
	cv=pass; b=B/JwIYPS8GwCjCwqyfKnD1Kprf/NUJB3n88iSbV08iCntW9ODUB/MfgOEWt5igSiaWgrz957kkE3qzLF82sAWrarUsbDX23KIZP2vyL+W646oe3I9OhDi+KpBWpqmvKOtFMEhn4+VgmfEcghKoME6a92Q1Lw4GxpnFrk98+NP7znCyNQJnRwZIok94bRv1eb57gyhfQRT7cYcDoaDh8ov6TglfvAtp1ZQfr/afEEA0oaNEDTJTdxuqRBWSPup+1/PHDSNqfUQxS5XAp1mOa55N0fZnBDFWFC0Utt3UcHgCe2d+ySuC38MDL2T4EKjGwaJyVHZkWdf8nBLiXwtCqWQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729579; c=relaxed/relaxed;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQEWmlpPg+pBWmIeSY4o+yjKPOiy41rSGvQ1ajbWoJwuCc2o8VhGfHxcuWAudYH8sDPLvqb3j/MLd3x0xjKlOAtuVFz6Rp3prah8XvX70+ecy7PHUPSbtePjGqMHngI+32cX8P6X9oTLg7UhO1TPofixUWsbglQl3ujMtMp2GjEWfozU2Y6zFgdR/kKGrFwZyt0jUHYyekGZ3xXsGpX2G8+sSEE13YGxPtkUJwAvVT9NdH8yyA1DLxmqYSXuOthoLZgKHyST6SpwBzEbj3XbqpZ98FMf9v2YxhRmgSCIA2Ss/jQUztp8s/OJhUfF9y7Uv9X/tQRx4G707NSrE4+LLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7FkLUHQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7FkLUHQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxWY5w63z2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:12:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E574A435AF;
	Tue,  3 Nov 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793729575;
	b=KzS87br2cjp6oFUGnSjRAMwgEy7539ZTBomT0cw2Qni/sSe8oKGZVr2P7RGixNzFFgwZ
	 LbpKx6V3ZdWrwofGGN08pol54sER3xi4SRrsfSuZ1Si7FQL6Wxh0p6ZY6gqapr/ViPdu0
	 Haq+ucPiwf9VEyY9ES2wrt4yKecETC13EPsJjoOTMiCUeCPQKO3S+N7HA7K0cGSuZHf+8
	 jmHwUS2T1t5N3da98ZRF1YA3IULXh8aiZ5JQa3b9hYF47Lj7EiKbrZ32j0ONRlYM9+QZv
	 SgxOG/bfhPzrA/8dfwoZDWRfIbCVg3H9uUmLV+e0bbVhIwqr4zsq4Iv1a0dDLj8ifnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729575;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	b=06WLQpIQv5uDjfYgtqQgafaT6fk1TPl+6oR+TwWZpgnO7Y7OkycQ7Y0PlI9MFv9CnBi5
	 UdUNCpKeg6SZuSPmBfFV/GRAXg9qM7Jd3zBmlZ4J6H2KbwsUOQWaM/X4bXlfc6wDbnlCX
	 CSlPlxYM1jCAses6CCq7twTYkY0MuaoSE7x7bgomDhmjh0QfcwxoQALs8b32r1ljX0vih
	 UtQ/Q1yyxrehiCxUpGN8tfRS2HFrBrt5hqYxwg6McOmxDnDgH5aZHmGnwymP6dLrxK0nO
	 kui5iCf3f7fwbWC/OElj/oXn3USPfgI70fBfYumAZD5CjSDHXuCimOVRdWNeV6aP6eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9A6961F00A1B;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729575;
	bh=g1GO0N9RZa7XxF5IhvFVAct0JfNThmJRb5rQhjdL3DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g7FkLUHQ9X6944DLOPOvZ618phj/qg2lFdtJSEaWoOPF1O0vS00DjUn5EPfwB8ZB5
	 WOj2n3/jXvNF43Od1yxflOHDebZERtausJ30UKXKL7zNngjF8wXCq0avGI3kg1NgQD
	 3KqFdAAonF+HN+7w02vpGAPnHNNBxwbKopbquOuTrO1YljBpUG3GYsV6N/3qbPUWhb
	 umc19e5RC9+7kTsrT22vA/YYen27f0JdXqQ7Bf++x+LqDwParxJANoJqQ0bTM2S9Ff
	 3kEcs4wKvP/c9C8Yao4y7rqjgeWqk9ehXeWZC6lhisHHbJoxu+5ltEymtDoWJTDXF2
	 ZxNE0bIdgznHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2B21746A79;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 03 Nov 2026 19:12:11 +0100
Subject: [PATCH v2 3/5] soc: fsl: guts: add the RCW override of any RCWSR
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
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-3-3aad0860b984@free.fr>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793729572; l=4011;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=zMby9g9Gw8IHCSfvPJh/Ob7NvLFrXegdSthe00uEpLg=;
 b=3zKcpMNbwXD0ISVjbADl5wy7QKJn3/g1eTQwLbcHdryMN/kYlLl7hEV4ccFx1Ntotq7J62tdr
 VS7KdOx4y0TCnL4xBkGi2IuRdxbBtMaZLr4Ev4Nbg8/gpiUJztQVnpj
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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



