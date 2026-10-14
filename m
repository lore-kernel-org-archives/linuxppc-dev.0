Return-Path: <linuxppc-dev+bounces-29510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F23FCC6B2C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:48:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4hb01Djgz2yqs;
	Thu, 15 Oct 2026 06:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792007308;
	cv=none; b=GGhH6WLt0lMSaHkmyZHXkvMMSoGXZLDTs9I6+JbqEKAtRagz3cd7gBinSPSwmR2DTTqEi+6YJWTPGie30C5y4Ord19YwAQM1XGEOVmALQmzLNjGiE2Iz1aQuH5Rpba0ESEf7oh6+un9NT9DwqsEFWqMKmgUs1yyr4RedNDldSgpoFUhpf5RebH9rX4aIOQdNoUARxkgaQ5HGVbI3cNrEbGYqeNYoM61icLqir/wEtYjRYze+x06tk7tbbaqv34R2a3T2lz2iH0jkzGn17BE2PIJMbos1D64kby/X3OBKxhTUCQondIU69zTiZ6Z6Q2uM7OCCnJGKzloIY8CnsfiXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792007308; c=relaxed/relaxed;
	bh=lwAGilf8XPAN8IgKAoTZWrMVSJPekmcQlKbM/o+0xfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YReQN/aCAYsB4OdGZ9PI1Ds5B9B8KV/hCFeut6d/RoFOvqkoB61DHzvb826WCNk6gX9fTOLQV12LyOk3HmsXTF6uAlhE7bG2qxWaowGkpKPkO4gT9kMaQTGbeDaKtAvvTnZlTSdT9MtiAen0OeoxvpNN6BLaXY2y2lF6qyCQde0usin78mKouNrikr6ejmfVFUPYhSy2OYpAvRGvz4mhOCh7jdiHQRjQKrHdXCUdpwu5/HxZKzUn94VqWellj05e3wimk3sahSpgAfZFP2EBYAa1EOt9iTIWsyc7Zl07oncFpkcSp99t6SeJ6ilvVAsITKlOZQjhSHI1MgV61hDrfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sUkjYe9A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sUkjYe9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4hZy22t6z2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 06:48:26 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8899a204034so2156981b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792007304; x=1792612104; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwAGilf8XPAN8IgKAoTZWrMVSJPekmcQlKbM/o+0xfU=;
        b=sUkjYe9AjeUvcthsrziSHQl+EwOk4jKBeQ7ngc1rV48/PFgLEqxs9RYMNr4O/5RX1p
         1c335CENOCFxDGKZsvLko1uxS6LAGoJIvhLzQ3n7l3FRejvQlOUS+ep5dFrEigV+ZHZ0
         2sGDpoJg3+1EiHmTSkAhs0oYPfla9q6OoZiAs8guX5xx+YpnUrOQiXhnc+Lr09Te1GCt
         BcWvjqMJXGpriR2o4okNhC6yamRRZYxdDdlPUkYrprAHizantMBBBUI7wWxzvo+cCU+r
         XAAIQZ29sui/AUDliLjbNJtx8l9dGrETUwOVTnF3uCPeK3rUMPyjS816hec60uVPk4Nu
         PtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007304; x=1792612104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwAGilf8XPAN8IgKAoTZWrMVSJPekmcQlKbM/o+0xfU=;
        b=uTOeRRlzATejjSfKKuATOqUCMzU3q83GUex5cd1186k4a8wgz+6WQqc0S0IVu85lgj
         7IvKO4Jhifk3+kJztwSOo91Zg4XA/q2jzQBU+RFQ9wHZ3xINu2zvZqnfj8cBbAwDEQbl
         8JUY1WkNCYpk/aWXRgkuDtAnoZcg+B+bLaBPuRlL3122jUyQpvdWC3wJ4kfyYTtplpeP
         5JuCNeMTBKJiu1Oi0eZw9Fn6SO9ESZ6Z98x4l3spWvwuMFRdLYFxulBRMQ35urAFz/8u
         lvMZKENdwyx7M/U4Gz9xhPgnQ1UvHN3urPVMVHVn2vuDdoEFGlpdRw43PLxgMyWG00ih
         BuUw==
X-Gm-Message-State: AFq9FYLSitoMCjTOMlS6cvgYdeW6uDTHLHh1EwysW4bcFKrQ0aZmd5vX
	nResTRshrWV+iWR7/31eB6IF9qaNvuPFotF1jHN8Rjhn7N7/6G7zD5GLQpK/qLOS
X-Gm-Gg: AYBFou2yGlHVirgwOM/YHFO4mmX9vZmfN+u6qTTPdvtPeAhnsCZLPkRiXp4lW3iaenO
	bn8v3Xi+a+mILQbmpuolJ8DykpwyNWIeW5o8AfReSxBpEdDo2mQYCH7e3YipQHj8OP07BS4L/ag
	Al/90X4MKL+S+MQUXVVvLkFzzVoqIdn5XibojRV5kTviZ1pWtbGGmllrSYF2IqbSnrgzBJK49Y9
	FVloI3rVDqIDwkpelKa3OxDzjLl5XKqFD9heDadDeDp5RKhkH3TvwtCh0sjYepFL9XI3VK2FRyG
	zbBJryScGGX3T49E71OI5UjKWY6KxCfYEfBR4tfn9g8PB3hJ/HCPUC4/cjo9moZ02zUfaG3uEDJ
	BRBcx/xXC3D+gmVYQ8+s11W2jR4e4SH0fteobMmqbEcWuUosUxwwOqTB19nwgI4Na9/MHG3mlvv
	SJWqdpHN2/CQ4nvmiSm8AcFhfajZ8ZZdVOsjErfKq15ZhoUlEBsKqOfA0t3oEgRHrnRExxkIyp6
	7j9PyY474ZCgGSJxguFRuuSBEGbbgxry1lfXlGmh1NFddjLmUwzaaldDain9X3b6hHu9/F9mwkh
	zrB/gyQ/RkaLwLBSbKgXAmNeHn9Ws04Tfs6Yh8z+Dg1Pz3Qz
X-Received: by 2002:a05:6a20:d80f:b0:3e1:558d:e37a with SMTP id adf61e73a8af0-3e16bdf0e71mr13923393637.26.1792007303717;
        Wed, 14 Oct 2026 12:48:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d8050d76csm1468779b3a.52.2026.10.14.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:48:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY)
Subject: [PATCH net v5] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
Date: Wed, 14 Oct 2026 12:48:18 -0700
Message-ID: <20261014194818.11640-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014194818.11640-1-rosenp@gmail.com>
References: <20261014194818.11640-1-rosenp@gmail.com>
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

marvell_config_intr() rewrites the whole interrupt enable register, so
the config_intr call from phy_init_hw() on resume silently cleared
WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
the board did not wake.

Bit 7 of that register is WOL_EIE only on these two PHYs; on others,
such as the 88E1111, it enables a FIFO error interrupt. So give the
88E1318S and 88E1510 their own config_intr and handle_interrupt, and
leave the shared callbacks unchanged.

m88e1318_set_wol() now records whether WoL is enabled, and both it and
the new config_intr derive WOL_EIE from that state under the MDIO bus
lock. WOL_EIE stays set across config_intr while WoL is enabled, except
when the PHY has an interrupt line and interrupts are being disabled,
as in phy_free_interrupt(): INTn is then the PHY IRQ, and nothing would
read IEVENT after free_irq() to release it. The bit is set again once
interrupts are re-enabled. phy_probe() still clears a WOL_EIE left by a
previous boot, since WoL starts out disabled. The new handler also
claims WoL events, so they do not go unacknowledged when the PHY IRQ is
in use.

Helios4 (Armada 388, 88E1512), 7.2.9. With this patch WOL_EIE stays set
over 3 link down/up cycles, "wol d" clears it, and a magic packet on a
running board is a handled interrupt. Without it, WOL_EIE is lost on the
first down/up, survives "wol d", and the magic packet is an unhandled
interrupt.

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Tested-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/marvell.c | 97 ++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..94e8dbe9a859 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -55,6 +55,8 @@
 #define MII_M1011_IMASK			0x12
 #define MII_M1011_IMASK_INIT		0x6400
 #define MII_M1011_IMASK_CLEAR		0x0000
+/* WOL Event Interrupt Enable, 88E1318S and 88E1510 only */
+#define MII_M1011_IMASK_WOL		BIT(7)
 
 #define MII_M1011_PHY_SCR			0x10
 #define MII_M1011_PHY_SCR_DOWNSHIFT_EN		BIT(11)
@@ -139,11 +141,6 @@
 #define MII_88E1318S_PHY_MSCR1_REG	16
 #define MII_88E1318S_PHY_MSCR1_PAD_ODD	BIT(6)
 
-/* Copper Specific Interrupt Enable Register */
-#define MII_88E1318S_PHY_CSIER				0x12
-/* WOL Event Interrupt Enable */
-#define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
-
 #define MII_88E1318S_PHY_LED_FUNC		0x10
 #define MII_88E1318S_PHY_LED_FUNC_OFF		(0x8)
 #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
@@ -354,6 +351,7 @@ struct marvell_priv {
 	u32 step;
 	s8 pair;
 	u8 vct_phase;
+	bool wol_enabled;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -407,7 +405,8 @@ static int marvell_config_intr(struct phy_device *phydev)
 	return err;
 }
 
-static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
+static irqreturn_t __marvell_handle_interrupt(struct phy_device *phydev,
+					      u16 mask)
 {
 	int irq_status;
 
@@ -417,7 +416,7 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (!(irq_status & MII_M1011_IMASK_INIT))
+	if (!(irq_status & mask))
 		return IRQ_NONE;
 
 	phy_trigger_machine(phydev);
@@ -425,6 +424,57 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
+{
+	return __marvell_handle_interrupt(phydev, MII_M1011_IMASK_INIT);
+}
+
+/* WOL_EIE also routes WoL events to INTn. Keep it set while WoL is enabled,
+ * unless INTn is the PHY interrupt and that interrupt is being disabled:
+ * nothing would read IEVENT after free_irq() to release the line.
+ */
+static u16 m88e1318_wol_imask(struct phy_device *phydev)
+{
+	struct marvell_priv *priv = phydev->priv;
+
+	if (priv->wol_enabled &&
+	    (phydev->interrupts == PHY_INTERRUPT_ENABLED ||
+	     !phy_interrupt_is_valid(phydev)))
+		return MII_M1011_IMASK_WOL;
+
+	return 0;
+}
+
+static int m88e1318_config_intr(struct phy_device *phydev)
+{
+	bool enable = phydev->interrupts == PHY_INTERRUPT_ENABLED;
+	u16 imask;
+	int err;
+
+	if (enable) {
+		err = marvell_ack_interrupt(phydev);
+		if (err)
+			return err;
+	}
+
+	/* Serialise against m88e1318_set_wol() updating wol_enabled */
+	phy_lock_mdio_bus(phydev);
+	imask = enable ? MII_M1011_IMASK_INIT : MII_M1011_IMASK_CLEAR;
+	imask |= m88e1318_wol_imask(phydev);
+	err = __phy_write(phydev, MII_M1011_IMASK, imask);
+	phy_unlock_mdio_bus(phydev);
+	if (err || enable)
+		return err;
+
+	return marvell_ack_interrupt(phydev);
+}
+
+static irqreturn_t m88e1318_handle_interrupt(struct phy_device *phydev)
+{
+	return __marvell_handle_interrupt(phydev, MII_M1011_IMASK_INIT |
+					  MII_M1011_IMASK_WOL);
+}
+
 static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 {
 	u16 val;
@@ -1969,18 +2019,27 @@ static void m88e1318_get_wol(struct phy_device *phydev,
 static int m88e1318_set_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct marvell_priv *priv = phydev->priv;
 	int err = 0, oldpage;
 
 	oldpage = phy_save_page(phydev);
 	if (oldpage < 0)
 		goto error;
 
-	if (wol->wolopts & (WAKE_MAGIC | WAKE_PHY)) {
-		/* Explicitly switch to page 0x00, just to be sure */
-		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
-		if (err < 0)
-			goto error;
+	priv->wol_enabled = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
 
+	/* Explicitly switch to page 0x00, just to be sure */
+	err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+	if (err < 0)
+		goto error;
+
+	/* Update the WOL interrupt enable */
+	err = __phy_modify(phydev, MII_M1011_IMASK, MII_M1011_IMASK_WOL,
+			   m88e1318_wol_imask(phydev));
+	if (err < 0)
+		goto error;
+
+	if (priv->wol_enabled) {
 		/* If WOL event happened once, the LED[2] interrupt pin
 		 * will not be cleared unless we reading the interrupt status
 		 * register. If interrupts are in use, the normal interrupt
@@ -1990,12 +2049,6 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 		if (!phy_interrupt_is_valid(phydev))
 			__phy_read(phydev, MII_M1011_IEVENT);
 
-		/* Enable the WOL interrupt */
-		err = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
-				     MII_88E1318S_PHY_CSIER_WOL_EIE);
-		if (err < 0)
-			goto error;
-
 		err = marvell_write_page(phydev, MII_MARVELL_LED_PAGE);
 		if (err < 0)
 			goto error;
@@ -3817,8 +3870,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1318_config_init,
 		.config_aneg = m88e1318_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = genphy_resume,
@@ -3925,8 +3978,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = m88e1510_resume,
-- 
2.56.0


