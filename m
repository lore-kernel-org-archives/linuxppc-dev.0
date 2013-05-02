Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EBD62C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 16:38:12 +1000 (EST)
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
In-Reply-To: <5180392D.1000103@pobox.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <gd35lbf55.fsf@dworkin.scrye.com> <517F67AD.2010101@scrye.com>
 <5180392D.1000103@pobox.com>
From: Anthony Foiani <tkil@scrye.com>
Date: Thu, 02 May 2013 00:37:57 -0600
Message-ID: <87a9odrinu.fsf@hum.int.foiani.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Anthony Foiani <tkil@scrye.com>,
 Scott Wood <scottwood@freescale.com>, "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Jeff --

Thanks for the quick reply -- sorry that it took me a few days to get
back to you.

[Also, apologies if anyone gets a dupe -- I'm working on a new mail
configuration, and while I did test it, something went sideways the
first time I tried to send this.]

Jeff Garzik writes:
> Regarding this patch:  Search for "sata_spd_limit" and xxx_spd* functions

Ok, I see them, but it's not entirely clear how I'm supposed to use
them.

I think that maybe I want to set hw_sata_spd_limit in each port's link
in the ata_host structure, after ata_host_alloc_pinfo, but before
ata_host_activate.

Something like the patch at the end of this message?  It seems to have
correctly set the spd_ values, but the negotiated link speed is still
too high:

  # cd /sys/devices/e0000000.immr/e0019000.sata

  # find * -name '*_spd*' -print | xargs grep .
  ata2/link2/ata_link/link2/sata_spd:3.0 Gbps
  ata2/link2/ata_link/link2/hw_sata_spd_limit:1.5 Gbps
  ata2/link2/ata_link/link2/sata_spd_limit:1.5 Gbps

Or am I misinterpreting those values?

Maybe I need to call ata_set_sata_spd as well.  Can I do that before
discovery, or should it be a part of the port_start callback?  And if
the latter, shouldn't it be handled within the ata core, instead of
expecting each host driver to do that call?

With my original patch, I see the correct (throttled-down) value for
"sata_spd":

  # cd /sys/devices/e0000000.immr/e0019000.sata

  # find . -name '*_spd*' -print | xargs grep .
  ./ata2/link2/ata_link/link2/sata_spd:1.5 Gbps
  ./ata2/link2/ata_link/link2/hw_sata_spd_limit:1.5 Gbps
  ./ata2/link2/ata_link/link2/sata_spd_limit:1.5 Gbps

Thanks for any pointers.  Patch below.

Thanks again,
Anthony Foiani

(Pardon the extra context, but it seemed the easiest way to show how
this call slotted in between the alloc and the init.)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d6577b9..bd24445 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -714,44 +714,30 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	/*
 	 * Now, we can bring the controller on-line & also initiate
 	 * the COMINIT sequence, we simply return here and the boot-probing
 	 * & device discovery process is re-initiated by libATA using a
 	 * Softreset EH (dummy) session. Hence, boot probing and device
 	 * discovey will be part of sata_fsl_softreset() callback.
 	 */
 
 	temp = ioread32(hcr_base + HCONTROL);
 	iowrite32((temp | HCONTROL_ONLINE_PHY_RST), hcr_base + HCONTROL);
 
 	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
-#ifdef CONFIG_MPC8315_DS
-	/*
-	 * Workaround for 8315DS board 3gbps link-up issue,
-	 * currently limit SATA port to GEN1 speed
-	 */
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	temp &= ~(0xF << 4);
-	temp |= (0x1 << 4);
-	sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
-
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	dev_warn(dev, "scr_control, speed limited to %x\n", temp);
-#endif
-
 	return 0;
 }
 
 static void sata_fsl_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
 	struct sata_fsl_port_priv *pp = ap->private_data;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
 	u32 temp;
 
 	/*
 	 * Force host controller to go off-line, aborting current operations
 	 */
 	temp = ioread32(hcr_base + HCONTROL);
@@ -1432,30 +1418,39 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	}
 	host_priv->irq = irq;
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,pq-sata-v2"))
 		host_priv->data_snoop = DATA_SNOOP_ENABLE_V2;
 	else
 		host_priv->data_snoop = DATA_SNOOP_ENABLE_V1;
 
 	/* allocate host structure */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
 	if (!host) {
 		retval = -ENOMEM;
 		goto error_exit_with_cleanup;
 	}
 
+	/* set speed limit if requested by device tree */
+	if (!of_property_read_u32(ofdev->dev.of_node, "sata-spd-limit",
+				  &temp)) {
+		int i;
+		for (i = 0; i < SATA_FSL_MAX_PORTS; ++i)
+			host->ports[i]->link.hw_sata_spd_limit = temp;
+		dev_warn(&ofdev->dev, "speed limit set to gen %u\n", temp);
+	}
+
 	/* host->iomap is not used currently */
 	host->private_data = host_priv;
 
 	/* initialize host controller */
 	sata_fsl_init_controller(host);
 
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
 	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
 			  &sata_fsl_sht);
