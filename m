Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 67FBFB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Nov 2009 03:39:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
Date: Mon, 16 Nov 2009 08:23:15 -0800
In-Reply-To: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com>
References: <8B957E110B62714A84290A01A597805F05CA0AA1@Exchange.discretix.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Alon Ziv" <alonz@discretix.com>,
	"linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <56a3f016-525a-4eb2-9a0f-1477ea2eee91@VA3EHSMHS019.ehs.local>
Cc: John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Alon,

There are at least two other ways that you might be able to reset a
board:
1) Internally through the ICAP device.
2) Through a GPIO connected externally to the reset logic.

Part of this is board specific, part of is it design specific.
Probably it would be best to have a mechanism in the device tree which
references the
reset mechanism?  In any event, you probably don't want a driver to
eplicitly reference the plaform code.  If you want to do it explicitly
like this, it would better to have the plaform code reference the driver
mechanism.  This would, to some extent, generalize to the device tree
case.

Steve
 =

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Alon
Ziv
> Sent: Sunday, November 15, 2009 1:34 AM
> To: linuxppc-dev
> Subject: [PATCH/RFC] Booting Xilinx ML510 board using SystemACE
> =

> I am using locally the attached (hackish) patch; could someone propose
a
> way to make it acceptable to mainline (or should I just keep this
> quiet)?
> =

> diff --git a/arch/powerpc/platforms/44x/virtex.c
> b/arch/powerpc/platforms/44x/virtex.c
> index cf96cca..749a330 100644
> --- a/arch/powerpc/platforms/44x/virtex.c
> +++ b/arch/powerpc/platforms/44x/virtex.c
> @@ -51,6 +51,16 @@ static int __init virtex_probe(void)
>  	return 1;
>  }
> =

> +void (*board_reset_system)(char *);
> +EXPORT_SYMBOL(board_reset_system);
> +
> +static void virtex_reset_system(char *cmd)
> +{
> +	if (board_reset_system)
> +		board_reset_system(cmd);
> +	ppc4xx_reset_system(cmd);
> +}
> +
>  define_machine(virtex) {
>  	.name			=3D "Xilinx Virtex440",
>  	.probe			=3D virtex_probe,
> @@ -58,5 +68,5 @@ define_machine(virtex) {
>  	.init_IRQ		=3D xilinx_intc_init_tree,
>  	.get_irq		=3D xilinx_intc_get_irq,
>  	.calibrate_decr		=3D generic_calibrate_decr,
> -	.restart		=3D ppc4xx_reset_system,
> +	.restart		=3D virtex_reset_system,
>  };
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index b20abe1..f3b4ab9 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -950,6 +950,19 @@ static struct block_device_operations ace_fops =3D
{
>  	.getgeo =3D ace_getgeo,
>  };
> =

> +extern void (*board_reset_system)(char *);
> +static struct ace_device *the_ace_device;
> +
> +/*
--------------------------------------------------------------------
> + * Board reset using ACE (forced FPGA reconfigure)
> + */
> +static void ace_reset_system(char *cmd)
> +{
> +	printk(KERN_EMERG "ace_reset_system: attempting suicide\n");
> +	ace_out(the_ace_device, ACE_CTRL, ACE_CTRL_FORCECFGMODE |
> +		ACE_CTRL_CFGMODE | ACE_CTRL_CFGSTART | ACE_CTRL_CFGSEL);
> +}
> +
>  /*
--------------------------------------------------------------------
>   * SystemACE device setup/teardown code
>   */
> @@ -1040,6 +1053,9 @@ static int __devinit ace_setup(struct ace_device
> *ace)
>  	val |=3D ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
>  	ace_out(ace, ACE_CTRL, val);
> =

> +	board_reset_system =3D ace_reset_system;
> +	the_ace_device =3D ace;
> +
>  	/* Print the identification */
>  	dev_info(ace->dev, "Xilinx SystemACE revision %i.%i.%i\n",
>  		 (version >> 12) & 0xf, (version >> 8) & 0x0f, version &
> 0xff);
>
************************************************************************
**********************
> IMPORTANT: The contents of this email and any attachments are
confidential. They are intended for the
> named recipient(s) only.
> If you have received this email in error, please notify the system
manager or the sender immediately
> and do
> not disclose the contents to anyone or make copies thereof.
> =

> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
