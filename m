Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99E7C2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 16:52:23 +1000 (EST)
Message-ID: <517F67AD.2010101@scrye.com>
Date: Tue, 30 Apr 2013 00:41:49 -0600
From: Anthony Foiani <tkil@scrye.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <gd35lbf55.fsf@dworkin.scrye.com>
In-Reply-To: <gd35lbf55.fsf@dworkin.scrye.com>
Content-Type: multipart/mixed; boundary="------------010004060202040500090600"
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Scott Wood <scottwood@freescale.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010004060202040500090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Apologies for resurrecting a very old thread, but...

On 05/30/2012 02:14 PM, Anthony Foiani wrote:
>
> Maybe someone who knows devtree really well could crank that out in a
> few minutes... but I'm not that person.  :)
Well, I wasn't last year, but this year I decided that I didn't care.  
Took me about an hour, not a minute, but...

Having been bitten by this config symbol disappearing one more time, 
please find attached my attempt at using information out of the device 
tree to enable this hack.

Patch is against 3.4.36 or so; hopefully upstream hasn't diverged very much.

Tested by me, so feel free to add that tag if required.

Thanks,
Anthony Foiani

--------------010004060202040500090600
Content-Type: text/x-patch;
 name="0001-sata-fsl-allow-device-tree-to-limit-sata-speed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-sata-fsl-allow-device-tree-to-limit-sata-speed.patch"

>From c0a85758a669b430c0a6af825e71d18a54ef88d0 Mon Sep 17 00:00:00 2001
From: Anthony Foiani <anthony.foiani@gmail.com>
Date: Mon, 29 Apr 2013 23:44:14 -0600
Subject: [PATCH] sata: fsl: allow device tree to limit sata speed.

There used to be an "orphan" config symbol (CONFIG_MPC8315_DS) that
would artificially limit SATA speed to generation 1 (1.5Gbps).

Since that config symbol got lost whenever any sort of configuration
was done, we instead extract the limitation from the device tree.

Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
---
 .../devicetree/bindings/powerpc/fsl/board.txt      | 23 +++++++++++
 drivers/ata/sata_fsl.c                             | 44 ++++++++++++++++++----
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
index 380914e..6a30398 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
@@ -67,3 +67,26 @@ Example:
 			gpio-controller;
 		};
 	};
+
+* Maximum SATA Generation workaround
+
+Some boards advertise SATA speeds that they cannot actually achieve.
+Previously, this was dealt with via the orphaned config symbol
+CONFIG_MPC8315_DS.  We now have a device tree property
+"fsl,sata-max-gen" to control this.  It should live within the "sata"
+block.
+
+Example:
+
+		sata@18000 {
+			compatible = "fsl,mpc8315-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			cell-index = <1>;
+			interrupts = <44 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,sata-max-gen = <1>;
+		};
+
+By default, there is no limitation; if a value is given, it indicates
+the maximum "generation" that should be negotiated.  Gen 1 is 1.5Gbps,
+Gen 2 is 3.0Gbps.
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d6577b9..6d3ec47 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -274,6 +274,17 @@ struct sata_fsl_port_priv {
 };
 
 /*
+ * speed negotiation.
+ */
+
+enum {
+	SCR_SPEED_NEG_MASK	= 0xf0,
+	SCR_SPEED_NEG_UNLIMITED	= 0x00,
+	SCR_SPEED_NEG_GEN_1	= 0x10, /* 1.5Gbps max */
+	SCR_SPEED_NEG_GEN_2	= 0x20  /* 3.0Gbps max */
+};
+
+/*
  * ata_port->host_set private data
  */
 struct sata_fsl_host_priv {
@@ -282,6 +293,7 @@ struct sata_fsl_host_priv {
 	void __iomem *csr_base;
 	int irq;
 	int data_snoop;
+	u32 speed_neg;
 	struct device_attribute intr_coalescing;
 };
 
@@ -726,19 +738,23 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
-#ifdef CONFIG_MPC8315_DS
 	/*
 	 * Workaround for 8315DS board 3gbps link-up issue,
 	 * currently limit SATA port to GEN1 speed
 	 */
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	temp &= ~(0xF << 4);
-	temp |= (0x1 << 4);
-	sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
+	if ( host_priv->speed_neg != SCR_SPEED_NEG_UNLIMITED )
+	{
 
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	dev_warn(dev, "scr_control, speed limited to %x\n", temp);
-#endif
+		u32 orig;
+		sata_fsl_scr_read(&ap->link, SCR_CONTROL, &orig);
+		temp = ( ( orig                 & ~SCR_SPEED_NEG_MASK ) |
+			 ( host_priv->speed_neg &  SCR_SPEED_NEG_MASK ) );
+		sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
+
+		sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
+		dev_warn(dev, "speed limited, scr_control 0x%x -> 0x%x\n",
+			 orig, temp);
+	}
 
 	return 0;
 }
@@ -1437,6 +1453,18 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	else
 		host_priv->data_snoop = DATA_SNOOP_ENABLE_V1;
 
+	if (!of_property_read_u32(ofdev->dev.of_node, "fsl,sata-max-gen",
+				  &temp))
+	{
+		switch (temp)
+		{
+		case 1: host_priv->speed_neg = SCR_SPEED_NEG_GEN_1; break;
+		case 2: host_priv->speed_neg = SCR_SPEED_NEG_GEN_2; break;
+		}
+		dev_warn(&ofdev->dev, "speed limit set to gen %u (0x%x)\n",
+			 temp, host_priv->speed_neg);
+	}
+
 	/* allocate host structure */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
 	if (!host) {
-- 
1.8.1.4


--------------010004060202040500090600--
