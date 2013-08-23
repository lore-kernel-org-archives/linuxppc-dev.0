Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA0962C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 05:25:45 +1000 (EST)
Date: Fri, 23 Aug 2013 14:25:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
Message-ID: <20130823192532.GA29205@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Shaohui.Xie@freescale.com, "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bcc: 
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
Reply-To: 
In-Reply-To: <g7gj9smnc.fsf@dworkin.scrye.com>

On Wed, May 08, 2013 at 06:04:39AM -0600, Anthony Foiani wrote:
> Anthony Foiani <tkil@scrye.com> writes:
> > Maybe I need to call ata_set_sata_spd as well.  Can I do that before
> > discovery, or should it be a part of the port_start callback?  And
> > if the latter, shouldn't it be handled within the ata core, instead
> > of expecting each host driver to do that call?
> 
> My final version calls sata_set_spd from within the hard reset
> callback for the fsl sata driver.
> 
> If there's a better place to put it, please let me know.
> 
> With this patch (and an appropriate entry in the device tree), the
> machine comes up and reports:
> 
>   # cd /sys/devices/e0000000.immr/e0019000.sata
> 
>   # find * -name '*_spd*' -print | xargs grep .
>   ata2/link2/ata_link/link2/sata_spd:1.5 Gbps
>   ata2/link2/ata_link/link2/hw_sata_spd_limit:1.5 Gbps
>   ata2/link2/ata_link/link2/sata_spd_limit:1.5 Gbps
> 
> Which is what I needed to see.
> 
> Thanks for the hints!
> 
> Best regards,
> Anthony Foiani
> 
> ---
> >From 357c96b4f31b457eca0b96147c749c21d0f4f086 Mon Sep 17 00:00:00 2001
> From: Anthony Foiani <anthony.foiani@gmail.com>
> Date: Wed, 8 May 2013 05:24:20 -0600
> Subject: [PATCH] sata: fsl: allow device tree to limit sata speed.
> 
> There used to be an "orphan" config symbol (CONFIG_MPC8315_DS) that
> would artificially limit SATA speed to generation 1 (1.5Gbps).
> 
> Since that config symbol got lost whenever any sort of configuration
> was done, we instead extract the limitation from the device tree,
> using a new name "sata-spd-limit".
> 
> Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/board.txt      | 23 ++++++++++++++++++
>  drivers/ata/sata_fsl.c                             | 28 +++++++++++-----------
>  2 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> index 380914e..9c9fed4 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> @@ -67,3 +67,26 @@ Example:
>  			gpio-controller;
>  		};
>  	};
> +
> +* Maximum SATA Generation workaround
> +
> +Some boards advertise SATA speeds that they cannot actually achieve.
> +Previously, this was dealt with via the orphaned config symbol
> +CONFIG_MPC8315_DS.  We now have a device tree property
> +"sata-spd-limit" to control this.  It should live within the "sata"
> +block.
> +
> +Example:
> +
> +		sata@18000 {
> +			compatible = "fsl,mpc8315-sata", "fsl,pq-sata";
> +			reg = <0x18000 0x1000>;
> +			cell-index = <1>;
> +			interrupts = <44 0x8>;
> +			interrupt-parent = <&ipic>;
> +			sata-spd-limit = <1>;
> +		};
>
> +By default, there is no limitation; if a value is given, it indicates
> +the maximum "generation" that should be negotiated.  Gen 1 is 1.5Gbps,
> +Gen 2 is 3.0Gbps.

This should go in Documentation/devicetree/bindings/ata/fsl-sata.txt.

As for the property name, I'd prefer "fsl,sata-speed-limit" or
"fsl,sata-max-generation".  Shaohui, do the driver bits look OK?

This patch should go via the linux-scsi list (note that Tejun Heo is now
the SATA maintainer).

-Scott

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d6577b9..9e3f3ec 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -726,20 +726,6 @@ static int sata_fsl_port_start(struct ata_port *ap)
>  	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
>  	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
>  
> -#ifdef CONFIG_MPC8315_DS
> -	/*
> -	 * Workaround for 8315DS board 3gbps link-up issue,
> -	 * currently limit SATA port to GEN1 speed
> -	 */
> -	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
> -	temp &= ~(0xF << 4);
> -	temp |= (0x1 << 4);
> -	sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
> -
> -	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
> -	dev_warn(dev, "scr_control, speed limited to %x\n", temp);
> -#endif
> -
>  	return 0;
>  }
>  
> @@ -836,6 +822,11 @@ try_offline_again:
>  	 */
>  	ata_msleep(ap, 1);
>  
> +	/* if the device tree forces a speed limit, set it here. */
> +	ata_link_info(link, "setting speed (in hard reset)\n");
> +	DPRINTK("setting spd_limit\n");
> +	sata_set_spd(link);
> +
>  	/*
>  	 * Now, bring the host controller online again, this can take time
>  	 * as PHY reset and communication establishment, 1st D2H FIS and
> @@ -1444,6 +1435,15 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  		goto error_exit_with_cleanup;
>  	}
>  
> +	/* record speed limit if requested by device tree */
> +	if (!of_property_read_u32(ofdev->dev.of_node, "sata-spd-limit",
> +				  &temp)) {
> +		int i;
> +		for (i = 0; i < SATA_FSL_MAX_PORTS; ++i)
> +			host->ports[i]->link.hw_sata_spd_limit = temp;
> +		dev_warn(&ofdev->dev, "speed limit set to gen %u\n", temp);
> +	}
> +
>  	/* host->iomap is not used currently */
>  	host->private_data = host_priv;
>  
