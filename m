Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32112C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:52:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609412081B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d7AFzErm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609412081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g2Y070QkzDrP3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:52:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d7AFzErm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="d7AFzErm"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g2B33h6bzDqfF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 18:36:11 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id a9so4372099wrx.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uMcDYnNHJHLM6OXd2JG4ochgla6PWUUXWtSDCx4ol54=;
 b=d7AFzErmMT7NWzG6Oz7JLNIuwP7ID8xl0ilfzkZa5+WEKCiJ/CM+rtSEZIvqUcEGej
 JhgZLH61jKyBnf4Xw/0+cHgO68IogQTmYKAjl9wpHJdw2Em1K2EknJXBh3Os0FuHab+9
 Gfcu8KTIGuWyBZzHD4lYWJvq0m7Mv72S9ILUVq351/qlrkDkSno4sPa5RF13T1aM7xvY
 nSGqnUT1vI8bEhLzeH7Z/LJi15W7FJKxfzRYcXWVF2+oYxs4wFF7V2tJIfHSHM8oEu8n
 USHgE3nN+40AY4sSP3LQlULYRzCV5SxfB8YNsVoHoCmcLvZWIoLCoKWVDhKX8EE2EJjg
 vUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uMcDYnNHJHLM6OXd2JG4ochgla6PWUUXWtSDCx4ol54=;
 b=QLmBRtJ/RfJqF4bXkWEApJoCjGj3K9JE2brtZtxCbiUf03hYhEAjaqfqKWCiilD1gl
 xi4KIN8mKfx1XVhQSq7NEhxmwkz6sD56AWGOAWlpqVUna3viPmN6uHmGBt16VgrjvvxU
 s4COzZ6/UPzMcEXby8swPjBF+6MEFoDNIkta48IMvM1C9OpiEOB5c3v27ZL2erUBhSgr
 kdw0A3PTO9EU+jUkU3dgjV8bsT6Ubz2lnXDZl4uPWrrnw0nvRrMrIawWhCmuepFcjcOp
 6g3wLWra/9HQ4Y6gdp3QO9SunAE9pd2UOkxdqNjrQjJgDX/BNscWVadsVfWkDjQAo2a1
 ud5w==
X-Gm-Message-State: AGRZ1gLLEF8H7qJrbjK7QJ/S/nwqSmhyNcosHrAgfev0zhJ85IysxbG+
 uvsi1m1ebdW8ZMdJ5xGiUPpp2Q==
X-Google-Smtp-Source: AJdET5fF6ik4orW1RZUtucXHnh821t00Et3cNg69S1D/DkWyeZO68TgTfU2EEKf329nQjKVdJnhkcw==
X-Received: by 2002:adf:afdc:: with SMTP id
 y28-v6mr1684487wrd.176.1540366568602; 
 Wed, 24 Oct 2018 00:36:08 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id
 b139-v6sm6254351wmd.36.2018.10.24.00.36.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 24 Oct 2018 00:36:08 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net,
 mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Subject: [PATCH v3 6/7] drm: meson: use xxxsetbits_le32
Date: Wed, 24 Oct 2018 07:35:52 +0000
Message-Id: <1540366553-18541-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org,
 Corentin Labbe <clabbe@baylibre.com>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch convert meson DRM driver to use all xxxsetbits_le32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c      | 14 +++---
 drivers/gpu/drm/meson/meson_dw_hdmi.c   | 33 +++++++------
 drivers/gpu/drm/meson/meson_plane.c     | 13 ++---
 drivers/gpu/drm/meson/meson_registers.h |  3 --
 drivers/gpu/drm/meson/meson_venc.c      | 13 ++---
 drivers/gpu/drm/meson/meson_venc_cvbs.c |  4 +-
 drivers/gpu/drm/meson/meson_viu.c       | 65 +++++++++++++------------
 drivers/gpu/drm/meson/meson_vpp.c       | 22 ++++-----
 8 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 05520202c967..98f17ddd6b00 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/setbits.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -98,8 +99,8 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
 	writel(crtc_state->mode.hdisplay,
 	       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
 
-	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE);
 
 	priv->viu.osd1_enabled = true;
 }
@@ -114,8 +115,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
 	priv->viu.osd1_commit = false;
 
 	/* Disable VPP Postblend */
-	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_POSTBLEND_ENABLE, 0);
 
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
@@ -199,8 +200,9 @@ void meson_crtc_irq(struct meson_drm *priv)
 			   MESON_CANVAS_BLKMODE_LINEAR);
 
 		/* Enable OSD1 */
-		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
-				    priv->io_base + _REG(VPP_MISC));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+					VPP_OSD1_POSTBLEND,
+					VPP_OSD1_POSTBLEND);
 
 		priv->viu.osd1_commit = false;
 	}
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df7247cd93f9..99a136209e15 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -24,6 +24,7 @@
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/setbits.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
@@ -427,10 +428,10 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 		writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
 
 	/* Temporary Disable HDMI video stream to HDMI-TX */
-	writel_bits_relaxed(0x3, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
-	writel_bits_relaxed(0xf << 8, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING), 0x3,
+				0);
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING),
+				0xf << 8, 0);
 
 	/* Re-Enable VENC video stream */
 	if (priv->venc.hdmi_use_enci)
@@ -439,16 +440,16 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
 
 	/* Push back HDMI clock settings */
-	writel_bits_relaxed(0xf << 8, wr_clk & (0xf << 8),
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING),
+				0xf << 8, wr_clk & (0xf << 8));
 
 	/* Enable and Select HDMI video source for HDMI-TX */
 	if (priv->venc.hdmi_use_enci)
-		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCI,
-				    priv->io_base + _REG(VPU_HDMI_SETTING));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING),
+					0x3, MESON_VENC_SOURCE_ENCI);
 	else
-		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCP,
-				    priv->io_base + _REG(VPU_HDMI_SETTING));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING),
+					0x3, MESON_VENC_SOURCE_ENCP);
 
 	return 0;
 }
@@ -632,8 +633,8 @@ static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("\n");
 
-	writel_bits_relaxed(0x3, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING), 0x3,
+				0);
 
 	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
@@ -857,10 +858,10 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
 
 	/* Enable APB3 fail on error */
-	writel_bits_relaxed(BIT(15), BIT(15),
-			    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
-	writel_bits_relaxed(BIT(15), BIT(15),
-			    meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG);
+	clrsetbits_le32_relaxed(meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG,
+				BIT(15), BIT(15));
+	clrsetbits_le32_relaxed(meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG,
+				BIT(15), BIT(15));
 
 	/* Bring out of reset */
 	dw_hdmi_top_write(meson_dw_hdmi, HDMITX_TOP_SW_RESET,  0);
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 12c80dfcff59..7377aefcbb2a 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/setbits.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -115,15 +116,15 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	switch (fb->format->format) {
 	case DRM_FORMAT_XRGB8888:
 		/* For XRGB, replace the pixel's alpha by 0xFF */
-		writel_bits_relaxed(OSD_REPLACE_EN, OSD_REPLACE_EN,
-				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_CTRL_STAT2),
+					OSD_REPLACE_EN, OSD_REPLACE_EN);
 		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
 					      OSD_COLOR_MATRIX_32_ARGB;
 		break;
 	case DRM_FORMAT_ARGB8888:
 		/* For ARGB, use the pixel's alpha */
-		writel_bits_relaxed(OSD_REPLACE_EN, 0,
-				    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_CTRL_STAT2),
+					OSD_REPLACE_EN, 0);
 		priv->viu.osd1_blk0_cfg[0] |= OSD_BLK_MODE_32 |
 					      OSD_COLOR_MATRIX_32_ARGB;
 		break;
@@ -174,8 +175,8 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 	struct meson_drm *priv = meson_plane->priv;
 
 	/* Disable OSD1 */
-	writel_bits_relaxed(VPP_OSD1_POSTBLEND, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_OSD1_POSTBLEND, 0);
 
 }
 
diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index bca87143e548..03ff452655f2 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -19,9 +19,6 @@
 /* Shift all registers by 2 */
 #define _REG(reg)	((reg) << 2)
 
-#define writel_bits_relaxed(mask, val, addr) \
-	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
-
 /* vpp2 */
 #define VPP2_DUMMY_DATA 0x1900
 #define VPP2_LINE_IN_LENGTH 0x1901
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 514245e69b38..eeb59a51f316 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -19,6 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/setbits.h>
 #include <drm/drmP.h>
 #include "meson_drv.h"
 #include "meson_venc.h"
@@ -913,8 +914,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		hsync_pixels_venc *= 2;
 
 	/* Disable VDACs */
-	writel_bits_relaxed(0xff, 0xff,
-			priv->io_base + _REG(VENC_VDAC_SETTING));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VENC_VDAC_SETTING), 0xff,
+				0xff);
 
 	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
@@ -1250,8 +1251,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
 
 		/* Set DE signal’s polarity is active high */
-		writel_bits_relaxed(BIT(14), BIT(14),
-				    priv->io_base + _REG(ENCP_VIDEO_MODE));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(ENCP_VIDEO_MODE),
+					BIT(14), BIT(14));
 
 		/* Program DE timing */
 		de_h_begin = modulo(readl_relaxed(priv->io_base +
@@ -1549,8 +1550,8 @@ void meson_venc_init(struct meson_drm *priv)
 	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
 
 	/* Disable HDMI */
-	writel_bits_relaxed(0x3, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING), 0x3,
+				0);
 
 	/* Disable all encoders */
 	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index f7945bae3b4a..6fff94d69e85 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/setbits.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
@@ -177,7 +178,8 @@ static void meson_venc_cvbs_encoder_enable(struct drm_encoder *encoder)
 	struct meson_drm *priv = meson_venc_cvbs->priv;
 
 	/* VDAC0 source is not from ATV */
-	writel_bits_relaxed(BIT(5), 0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VENC_VDAC_DACSEL0),
+				BIT(5), 0);
 
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
 		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 1);
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 6bcfa527c180..952b74e874af 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/setbits.h>
 #include <drm/drmP.h>
 #include "meson_drv.h"
 #include "meson_viu.h"
@@ -131,16 +132,16 @@ void meson_viu_set_osd_matrix(struct meson_drm *priv,
 		writel(m[20] & 0xfff,
 			priv->io_base + _REG(VIU_OSD1_MATRIX_OFFSET2));
 
-		writel_bits_relaxed(3 << 30, m[21] << 30,
-			priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42));
-		writel_bits_relaxed(7 << 16, m[22] << 16,
-			priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42),
+					3 << 30, m[21] << 30);
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_MATRIX_COLMOD_COEF42),
+					7 << 16, m[22] << 16);
 
 		/* 23 reserved for clipping control */
-		writel_bits_relaxed(BIT(0), csc_on ? BIT(0) : 0,
-			priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL));
-		writel_bits_relaxed(BIT(1), 0,
-			priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL),
+					BIT(0), csc_on ? BIT(0) : 0);
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_MATRIX_CTRL),
+					BIT(1), 0);
 	} else if (m_select == VIU_MATRIX_OSD_EOTF) {
 		int i;
 
@@ -150,10 +151,10 @@ void meson_viu_set_osd_matrix(struct meson_drm *priv,
 				(m[i * 2 + 1] & 0x1fff), priv->io_base +
 				_REG(VIU_OSD1_EOTF_CTL + i + 1));
 
-		writel_bits_relaxed(BIT(30), csc_on ? BIT(30) : 0,
-			priv->io_base + _REG(VIU_OSD1_EOTF_CTL));
-		writel_bits_relaxed(BIT(31), csc_on ? BIT(31) : 0,
-			priv->io_base + _REG(VIU_OSD1_EOTF_CTL));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_EOTF_CTL),
+					BIT(30), csc_on ? BIT(30) : 0);
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_EOTF_CTL),
+					BIT(31), csc_on ? BIT(31) : 0);
 	}
 }
 
@@ -203,11 +204,11 @@ void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
 			priv->io_base + _REG(data_port));
 
 		if (csc_on)
-			writel_bits_relaxed(0x7 << 29, 7 << 29,
-					    priv->io_base + _REG(ctrl_port));
+			clrsetbits_le32_relaxed(priv->io_base + _REG(ctrl_port),
+						0x7 << 29, 7 << 29);
 		else
-			writel_bits_relaxed(0x7 << 29, 0,
-					    priv->io_base + _REG(ctrl_port));
+			clrsetbits_le32_relaxed(priv->io_base + _REG(ctrl_port),
+						0x7 << 29, 0);
 	} else if (lut_sel == VIU_LUT_OSD_EOTF) {
 		writel(0, priv->io_base + _REG(addr_port));
 
@@ -230,14 +231,14 @@ void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
 			priv->io_base + _REG(data_port));
 
 		if (csc_on)
-			writel_bits_relaxed(7 << 27, 7 << 27,
-					    priv->io_base + _REG(ctrl_port));
+			clrsetbits_le32_relaxed(priv->io_base + _REG(ctrl_port),
+						7 << 27, 7 << 27);
 		else
-			writel_bits_relaxed(7 << 27, 0,
-					    priv->io_base + _REG(ctrl_port));
+			clrsetbits_le32_relaxed(priv->io_base + _REG(ctrl_port),
+						7 << 27, 0);
 
-		writel_bits_relaxed(BIT(31), BIT(31),
-				    priv->io_base + _REG(ctrl_port));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(ctrl_port),
+					BIT(31), BIT(31));
 	}
 }
 
@@ -301,10 +302,10 @@ void meson_viu_init(struct meson_drm *priv)
 	uint32_t reg;
 
 	/* Disable OSDs */
-	writel_bits_relaxed(BIT(0) | BIT(21), 0,
-			priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
-	writel_bits_relaxed(BIT(0) | BIT(21), 0,
-			priv->io_base + _REG(VIU_OSD2_CTRL_STAT));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_CTRL_STAT),
+				BIT(0) | BIT(21), 0);
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD2_CTRL_STAT),
+				BIT(0) | BIT(21), 0);
 
 	/* On GXL/GXM, Use the 10bit HDR conversion matrix */
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
@@ -322,12 +323,12 @@ void meson_viu_init(struct meson_drm *priv)
 	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
 
 	/* Set OSD alpha replace value */
-	writel_bits_relaxed(0xff << OSD_REPLACE_SHIFT,
-			    0xff << OSD_REPLACE_SHIFT,
-			    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
-	writel_bits_relaxed(0xff << OSD_REPLACE_SHIFT,
-			    0xff << OSD_REPLACE_SHIFT,
-			    priv->io_base + _REG(VIU_OSD2_CTRL_STAT2));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD1_CTRL_STAT2),
+				0xff << OSD_REPLACE_SHIFT,
+				0xff << OSD_REPLACE_SHIFT);
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_OSD2_CTRL_STAT2),
+				0xff << OSD_REPLACE_SHIFT,
+				0xff << OSD_REPLACE_SHIFT);
 
 	priv->viu.osd1_enabled = false;
 	priv->viu.osd1_commit = false;
diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index 27356f81a0ab..f36254485486 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/setbits.h>
 #include <drm/drmP.h>
 #include "meson_drv.h"
 #include "meson_vpp.h"
@@ -128,30 +129,29 @@ void meson_vpp_init(struct meson_drm *priv)
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
 		writel_relaxed(0x108080, priv->io_base + _REG(VPP_DUMMY_DATA1));
 	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu")) {
-		writel_bits_relaxed(0xff << 16, 0xff << 16,
-				    priv->io_base + _REG(VIU_MISC_CTRL1));
+		clrsetbits_le32_relaxed(priv->io_base + _REG(VIU_MISC_CTRL1),
+					0xff << 16, 0xff << 16);
 		writel_relaxed(0x20000, priv->io_base + _REG(VPP_DOLBY_CTRL));
 		writel_relaxed(0x1020080,
 				priv->io_base + _REG(VPP_DUMMY_DATA1));
 	}
 
 	/* Initialize vpu fifo control registers */
-	writel_relaxed(readl_relaxed(priv->io_base + _REG(VPP_OFIFO_SIZE)) |
-			0x77f, priv->io_base + _REG(VPP_OFIFO_SIZE));
+	setbits_le32_relaxed(priv->io_base + _REG(VPP_OFIFO_SIZE), 0x77f);
 	writel_relaxed(0x08080808, priv->io_base + _REG(VPP_HOLD_LINES));
 
 	/* Turn off preblend */
-	writel_bits_relaxed(VPP_PREBLEND_ENABLE, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_PREBLEND_ENABLE, 0);
 
 	/* Turn off POSTBLEND */
-	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_POSTBLEND_ENABLE, 0);
 
 	/* Force all planes off */
-	writel_bits_relaxed(VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND |
-			    VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	clrsetbits_le32_relaxed(priv->io_base + _REG(VPP_MISC),
+				VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND | VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND,
+				0);
 
 	/* Disable Scalers */
 	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_SC_CTRL0));
-- 
2.18.1

