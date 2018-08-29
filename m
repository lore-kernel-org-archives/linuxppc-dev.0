Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 420mKc6q3NzF31f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 23:13:56 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 robh+dt@kernel.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v2 4/6] net/wan/fsl_ucc_hdlc: hmask
Date: Wed, 29 Aug 2018 15:13:26 +0200
Message-Id: <20180829131328.27901-5-david.gounaris@infinera.com>
In-Reply-To: <20180829131328.27901-1-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ability to set hmask in the device-tree,
which can be used to change address
filtering of packets.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt | 6 ++++++
 drivers/net/wan/fsl_ucc_hdlc.c                               | 5 ++++-
 drivers/net/wan/fsl_ucc_hdlc.h                               | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
index 03c741602c6d..6d2dd8a31482 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
@@ -98,6 +98,12 @@ The property below is dependent on fsl,tdm-interface:
 	usage: optional for tdm interface
 	value type: <empty>
 	Definition : Internal loopback connecting on TDM layer.
+- fsl,hmask
+	usage: optional
+	Value type: <u16>
+	Definition: HDLC address recognition. Set to zero to disable
+		    address filtering of packets:
+		    fsl,hmask = /bits/ 16 <0x0000>;
 
 Example for tdm interface:
 
diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 0f703d7be5e0..be5b0096af3b 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -263,7 +263,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
 	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
 	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
-	iowrite16be(DEFAULT_ADDR_MASK, &priv->ucc_pram->hmask);
+	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
 	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
 	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
 	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
@@ -1097,6 +1097,9 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		if (ret)
 			goto free_utdm;
 	}
+	
+	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
+		uhdlc_priv->hmask = DEFAULT_ADDR_MASK;
 
 	ret = uhdlc_init(uhdlc_priv);
 	if (ret) {
diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
index c21134c1f180..b99fa2f1cd99 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -106,6 +106,7 @@ struct ucc_hdlc_private {
 
 	unsigned short encoding;
 	unsigned short parity;
+	unsigned short hmask;
 	u32 clocking;
 	spinlock_t lock;	/* lock for Tx BD and Tx buffer */
 #ifdef CONFIG_PM
-- 
2.13.6
