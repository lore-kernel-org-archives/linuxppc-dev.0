Return-Path: <linuxppc-dev+bounces-25543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D1C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 05:36:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGXv34yVqz3bps;
	Fri, 07 Aug 2026 15:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786080975;
	cv=none; b=hnDB44yvOcR81lTrjDPJvKrAmW1wh8A8/pj9NAHB3rWERu2pNXLyYbrf1RldYvkm7sASjO6RkrYg+NwLhqyl+59VBznNFGPXI3jQMI2P3ixsyPT8l/Hvl5OcAu6FhI8FWa4n4U3skJ8nOB0idUsLbIA7FgXwdlQMsqJT+/L3kQBkLy5AED2cEzChQQAsP/pwblgg9mJFcptYc7cq0z9KWIlQa4+5sy3PMQLoTGV8WDMoKHxxYvTiM8RFUBNq9Z/Q5yr4mIRNW41G9MZrSRAcw+uvV/ooEhd03cFpaRTihAsXz7ayXyRJvdntEtqyjLcoCuWZN0JJgcn289adtGge1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786080975; c=relaxed/relaxed;
	bh=kNkdOQcC2ETToC90VfwFI80Jg9M/yh183B14tDW5Vmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDVqCiaHtQg9f69aoLuypihmrhvWXogVzqXRx0XK1tenn0HTQEEWWbEpi2JGhh5GkFnI32WnBCgatrtEqqpMPN6u6I45Np6uXfdVHUPrjSQPhDU40VWOdg7/P/O4qdea6RyYgPt944pOqyhPEB+/qHiu1BTdF8fPW8zCWtYaR00vCN73bnqFM9orbJr+WblCAlCnGmWMWL25cJ39F8gTN7eSckAuKGbFUcvCWTKST95ypBH14M9Wj7ohASXLebN2HpTazQqfjdxbivdajQgOeFnAH5QsXTZAVeROfl4Ydg6KBr6bJ54p64gkfh80xDlxVjrihHSrmzk0CUsc5P4JdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JulXg+KG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JulXg+KG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGXv242zCz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 15:36:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 83DA7600B1;
	Fri,  7 Aug 2026 05:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDAA1F000E9;
	Fri,  7 Aug 2026 05:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786080971;
	bh=kNkdOQcC2ETToC90VfwFI80Jg9M/yh183B14tDW5Vmo=;
	h=From:To:Cc:Subject:Date;
	b=JulXg+KG1FRQKQrSmKoNSJIVYeGcDT4ofxR3TE1zp5uJhq56kCSz2Q4PgWpKwnOsk
	 /fpRwRBOlBl5AYNUltHWiAOP/HE7TZGoA39d9s0OTUd6FhoN2iVEz2Ei0a6qdv2oU0
	 /ec5i0k2TGlxOvvefy/5lMMpqy6hrdhdgOYW7E9JVsY7pYV4IlW6FQqYug2cOYitsb
	 g+yA8Ucvlu4lHIWhxx5SVOeWB24xcOPH6vTdse80e8jFUCkPEeCq6zK7fOYBi0Ukot
	 wKHxlcdLh4H+fVXHoqYETlY73apRDs00z9cu1oicMRSx+ZHmrW4PZLd04Vizopev/h
	 VB3T3xOraMOTA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: fsl: qe: Fix sparse warnings in GPIO
Date: Fri,  7 Aug 2026 07:35:52 +0200
Message-ID: <6a84b38e766729676b375c93bf54c67ea455288d.1786080840.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=chleroy@kernel.org; h=from:subject:message-id; bh=1woWX/X91UmwPsG4AqjMQzLoWo4AhbpQz9HxDwH39vY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSV5u1SfhATN3ultMOUTYX/96r+crp2+PbEGca1/k3Sd 1amlReJdZSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJbLNkZNhmsGmaostPwYxt J1Ysf+naG+zPde0Rq8jetUYfzasmnBFm+MO13Ly/JVfq5F3PG4/7LJ0c7xh+SxIVltuYpnbxsNE KIyYA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

A C=2 build on mpc83xx_defconfig provides following warnings:

  drivers/soc/fsl/qe/gpio.c:44:34: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:44:34:    expected restricted __be32 [usertype] cpdata
  drivers/soc/fsl/qe/gpio.c:44:34:    got unsigned int [usertype] cpdata
  drivers/soc/fsl/qe/gpio.c:45:34: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:45:34:    expected restricted __be32 [usertype] cpdir1
  drivers/soc/fsl/qe/gpio.c:45:34:    got unsigned int
  drivers/soc/fsl/qe/gpio.c:46:34: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:46:34:    expected restricted __be32 [usertype] cpdir2
  drivers/soc/fsl/qe/gpio.c:46:34:    got unsigned int
  drivers/soc/fsl/qe/gpio.c:47:34: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:47:34:    expected restricted __be32 [usertype] cppar1
  drivers/soc/fsl/qe/gpio.c:47:34:    got unsigned int
  drivers/soc/fsl/qe/gpio.c:48:34: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:48:34:    expected restricted __be32 [usertype] cppar2
  drivers/soc/fsl/qe/gpio.c:48:34:    got unsigned int
  drivers/soc/fsl/qe/gpio.c:49:33: warning: incorrect type in assignment (different base types)
  drivers/soc/fsl/qe/gpio.c:49:33:    expected restricted __be32 [usertype] cpodr
  drivers/soc/fsl/qe/gpio.c:49:33:    got unsigned int
  drivers/soc/fsl/qe/gpio.c:297:17: warning: restricted __be32 degrades to integer
  drivers/soc/fsl/qe/gpio.c:299:17: warning: restricted __be32 degrades to integer
  drivers/soc/fsl/qe/gpio.c:302:17: warning: restricted __be32 degrades to integer
  drivers/soc/fsl/qe/gpio.c:304:17: warning: restricted __be32 degrades to integer
  drivers/soc/fsl/qe/gpio.c:308:18: warning: restricted __be32 degrades to integer
  drivers/soc/fsl/qe/gpio.c:314:9: warning: restricted __be32 degrades to integer

The problem is the 'struct qe_pio_reg' embedded in 'struct qe_gpio_chip'
to save register values. As the values are read with ioread32be(), they
are now in CPU byte order and can't be stored as-is in a __be32 object.

Replace 'struct qe_pio_reg saved_regs' by individual u32 fields.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608051952.ADkLIB86-lkp@intel.com/
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/qe/gpio.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 5cd59cfbf22f..8e210f8a3b6c 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -32,8 +32,13 @@ struct qe_gpio_chip {
 	/* shadowed data register to clear/set bits safely */
 	u32 cpdata;
 
-	/* saved_regs used to restore dedicated functions */
-	struct qe_pio_regs saved_regs;
+	/* saved regs used to restore dedicated functions */
+	u32 saved_cpodr;
+	u32 saved_cpdata;
+	u32 saved_cpdir1;
+	u32 saved_cpdir2;
+	u32 saved_cppar1;
+	u32 saved_cppar2;
 };
 
 static void qe_gpio_save_regs(struct qe_gpio_chip *qe_gc)
@@ -41,12 +46,12 @@ static void qe_gpio_save_regs(struct qe_gpio_chip *qe_gc)
 	struct qe_pio_regs __iomem *regs = qe_gc->regs;
 
 	qe_gc->cpdata = ioread32be(&regs->cpdata);
-	qe_gc->saved_regs.cpdata = qe_gc->cpdata;
-	qe_gc->saved_regs.cpdir1 = ioread32be(&regs->cpdir1);
-	qe_gc->saved_regs.cpdir2 = ioread32be(&regs->cpdir2);
-	qe_gc->saved_regs.cppar1 = ioread32be(&regs->cppar1);
-	qe_gc->saved_regs.cppar2 = ioread32be(&regs->cppar2);
-	qe_gc->saved_regs.cpodr = ioread32be(&regs->cpodr);
+	qe_gc->saved_cpdata = qe_gc->cpdata;
+	qe_gc->saved_cpdir1 = ioread32be(&regs->cpdir1);
+	qe_gc->saved_cpdir2 = ioread32be(&regs->cpdir2);
+	qe_gc->saved_cppar1 = ioread32be(&regs->cppar1);
+	qe_gc->saved_cppar2 = ioread32be(&regs->cppar2);
+	qe_gc->saved_cpodr = ioread32be(&regs->cpodr);
 }
 
 static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
@@ -284,7 +289,6 @@ void qe_pin_set_dedicated(struct qe_pin *qe_pin)
 {
 	struct qe_gpio_chip *qe_gc = qe_pin->controller;
 	struct qe_pio_regs __iomem *regs = qe_gc->regs;
-	struct qe_pio_regs *sregs = &qe_gc->saved_regs;
 	int pin = qe_pin->num;
 	u32 mask1 = 1 << (QE_PIO_PINS - (pin + 1));
 	u32 mask2 = 0x3 << (QE_PIO_PINS - (pin % (QE_PIO_PINS / 2) + 1) * 2);
@@ -294,24 +298,20 @@ void qe_pin_set_dedicated(struct qe_pin *qe_pin)
 	spin_lock_irqsave(&qe_gc->lock, flags);
 
 	if (second_reg) {
-		qe_clrsetbits_be32(&regs->cpdir2, mask2,
-				   sregs->cpdir2 & mask2);
-		qe_clrsetbits_be32(&regs->cppar2, mask2,
-				   sregs->cppar2 & mask2);
+		qe_clrsetbits_be32(&regs->cpdir2, mask2, qe_gc->saved_cpdir2 & mask2);
+		qe_clrsetbits_be32(&regs->cppar2, mask2, qe_gc->saved_cppar2 & mask2);
 	} else {
-		qe_clrsetbits_be32(&regs->cpdir1, mask2,
-				   sregs->cpdir1 & mask2);
-		qe_clrsetbits_be32(&regs->cppar1, mask2,
-				   sregs->cppar1 & mask2);
+		qe_clrsetbits_be32(&regs->cpdir1, mask2, qe_gc->saved_cpdir1 & mask2);
+		qe_clrsetbits_be32(&regs->cppar1, mask2, qe_gc->saved_cppar1 & mask2);
 	}
 
-	if (sregs->cpdata & mask1)
+	if (qe_gc->saved_cpdata & mask1)
 		qe_gc->cpdata |= mask1;
 	else
 		qe_gc->cpdata &= ~mask1;
 
 	iowrite32be(qe_gc->cpdata, &regs->cpdata);
-	qe_clrsetbits_be32(&regs->cpodr, mask1, sregs->cpodr & mask1);
+	qe_clrsetbits_be32(&regs->cpodr, mask1, qe_gc->saved_cpodr & mask1);
 	spin_unlock_irqrestore(&qe_gc->lock, flags);
 }
 EXPORT_SYMBOL(qe_pin_set_dedicated);
-- 
2.54.0


