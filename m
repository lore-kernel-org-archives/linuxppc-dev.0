Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FC606A8A4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHR9iPT4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRT142z6Mz2yVT;
	Sat, 14 Nov 2026 20:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794647560;
	cv=pass; b=DQcxNQcOvWYxuUtSRtuNwAUMe0JeHTzDc8kSEiQ9oU9olzCkAOJfj6HP3s9n5Z4giU9eY7A778osOSYBnDtxt5EPxAKpyzbtTYEODkqo5apYBJspAhpxwxzJgX5B5FjyibxJfhdLURkNOqGbUVU2dqfPhVJ0QyZ/MTfYhxM3t3P9jF4HWf0Vvdb7W24FtuE/iMuvDymCN9kVWv6Eg7hJKpxMsvA4BH+HKhXv4+eASYLQYea2ojkmpVeIu/3WeXZ9FFiXq5dmgOGSd9DjwyxhGdvAvIoYUFv5Zu9o4vFFC7aWym+F8wwzI6frnGPUkasaDqG5urFQsvDIq9XDp71Hew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794647560; c=relaxed/relaxed;
	bh=K2e2n2f0dPZQunPWOM/IqDNSeCUqCz06+hLqPXwzTUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHCRLucNMCVDefGo8z2/gY3XgZPaKlM7KD3cjunPrSCWiWJfOaeGxzXxkYQYTMO7dl82hGk+NF2HoLxkOkf+vpJC2r9+DEtyNd4+UMAWhJXbeTzsingUrMcvhjCB7meVp9Qto1Z8vAxwde/R+YAPSn2R//I9H1K0OvdkUH+ke0OOtmXn0JLh4QDrlI9brsvja1Z+9oeer8cAlHxZJQvAcsuF0mtsta/n+WPFFwneuDP3lqO5RpFTyPUZ2NAy64BnoIABxhzljV7eR2Y51UjZk2LwmGzsjZkP/xw3pn5wefWdhWNyv5OjGfh7dLVhwoCCZVLOkNCeIUNDwNBVt/IFwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHR9iPT4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHR9iPT4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRT114z9Qz2xL3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 20:12:37 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E639A461DC;
	Sat, 14 Nov 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794647555;
	b=zc/LBpqN1G+3d7xrHIjT8Z7b2j1GjBtDyi/t56VlY4aq9RRvyhvPZNLKXFdAl2YMsvBQ
	 qT9k/LaR1sW2k3OdzB8e4Useqpik63k/soQAjb7vZQzke9J5nQr8EcT+GRnYUQPzy9wvy
	 Pcam5grGbZMbq7TNbWO49rq94+5/YQyCFiYzllJPZkGB05TPsNiiCBYeXqpW2XeRn82RO
	 SnTj74h2KkjBS5qfZEt8m97ZDdQ4UPT68vb/w0a0SBe4WuDowHKEfXHb9rQWnUjptdZml
	 Air8y4DBKCY66R48KrsuVTyd++FK92z7GuHkj7jXfOnDqu3A05qG9wBg2ygvfMzPTow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=K2e2n2f0dPZQunPWOM/IqDNSeCUqCz06+hLqPXwzTUE=;
	b=qvhonCWSEHXD/6Tr6w35GxsqnsO9Tq7Yr7WCcrkVIEnwPmTvLoyCX1AE/lMKgdzN6wBD
	 uMNfrx/OLYDhm+qEL6JobW4HqMNcbe2l5lkhkeUl03HPitJfRtotze8qIP+mBuNtyENCZ
	 HDMXEgQA3URZ5cKsrGVQbNk9pXJdEVY4NFhECSaRvpp2mtj4rl3MIVn1lYQMSjMrCRepF
	 m0YRFmEW4+GKzvkJwEWF1Tn8LOLfeyEpiS3ZQpty9s37qOajohX5Bkt3cMcr1EnMyMFIx
	 oa/pT/WG0PivIj+jF62P14HsoRgF8dcZ+d6AiwE708PRHeO+rZhzlK5c48BzzQsHoSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 77F011F000D0;
	Sat, 14 Nov 2026 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794647555;
	bh=K2e2n2f0dPZQunPWOM/IqDNSeCUqCz06+hLqPXwzTUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KHR9iPT4curqjuwFLE8HR6YK68+p/ECg3twcfWygoBpfx8BnXcn+WL33KEVz6i0AI
	 HG4HKIbGUCcmRq9eJ1hTWSJi+8aHkRJSmZzq2eIrTz/p/lSbXPI94lRXoZW5dcUqCz
	 HXXKUOa70RYvumC84x4nzYM1x4OUjgH94vooDrn6YoleqxZOb9tG0VOjnuZ/izryDo
	 epWOMdRFueyB52QsV0b67H4+X/xAr71/GAi/ExINMJiKK1EdRInXl8+VZ7oqHHsE4c
	 jWXRGmxVk8Pby6rfrQ7XYacT+hDK0yXZRSmeVBqIoCAulkEbRwRih1cxdvtoT7Fhu4
	 VdXkKygm6+Bbg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EFE0649D1A;
	Sat, 14 Nov 2026 09:12:33 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Sat, 14 Nov 2026 10:12:30 +0100
Subject: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
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
Message-Id: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
In-Reply-To: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794647552; l=4092;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=qmpWO2UIwwok1/NH6X0xAVlyzqob0UppXneZjaDgtC0=;
 b=hxOYUB9ZLhLimfk2NjjY3amSsGbohxb3JnlDLN6cgdBXOOqU/2Vxn6ns1NRtLIxeFK+IiG+WF
 SD4h15yViRwAtH3/i2rim3wFvIys80FU54bSBqOfZMs4m6DwHLJPlT8
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Frank Li <Frank.li@nxp.com>
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



