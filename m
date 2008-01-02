Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9683DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:29:56 +1100 (EST)
Message-ID: <477BADF5.9060003@freescale.com>
Date: Wed, 02 Jan 2008 09:29:57 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
In-Reply-To: <9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>>  sound/soc/fsl/fsl_ssi.c                      |  614 +++++++++++++++++++
>>  sound/soc/fsl/fsl_ssi.h                      |  224 +++++++
> 
> I'm confused about this part. You built a driver for the mpc8610 ssi
> port.  This port has a device tree entry.
> 
> +		ssi@16000 {
> +			compatible = "fsl,ssi";
> +			cell-index = <0>;
> +			reg = <16000 100>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <3e 2>;
> +			fsl,mode = "i2s-slave";
> +			codec {
> +				compatible = "cirrus,cs4270";
> +				/* MCLK source is a stand-alone oscillator */
> +				bus-frequency = <bb8000>;
> +			};
> +		};
> 
> But then you don't create an of_platform_driver for this device.
> Instead you create one for the fabric driver, struct
> of_platform_driver mpc8610_hpcd_of_driver, and directly link the SSI
> driver into it.

That's the best plan I came up with.  This is apparently fixed in ASoC 
V2.  From ASoC V1's perspective, the fabric driver must be the master. 
However, it doesn't make sense to have a node in the device tree for the 
fabric driver, because there is no such "device".  The fabric driver is 
an abstraction.  So I need to chose some other node to probe the fabric 
driver with.  I chose the SSI, since each SSI can have only one codec.

> 
> +static struct of_device_id mpc8610_hpcd_match[] = {
> +	{
> +		.compatible = "fsl,ssi",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
> +
> +static struct of_platform_driver mpc8610_hpcd_of_driver = {
> +	.owner  	= THIS_MODULE,
> +	.name   	= "mpc8610_hpcd",
> +	.match_table    = mpc8610_hpcd_match,
> +	.probe  	= mpc8610_hpcd_probe,
> +	.remove 	= mpc8610_hpcd_remove,
> +};
> 
> static int mpc8610_hpcd_probe(struct of_device *ofdev,
> 	const struct of_device_id *match)
> {
> .....
> 	machine_data->dai.cpu_dai = fsl_ssi_create_dai(&ssi_info);
> 
> Isn't this two separate drivers that have been combined into one
> driver? Or does the fsl_ssi channel only work on the mpc8610_hpcd?

Sorry, I don't understand your question.

> This is the problem of knowing how to load the fabric driver that I
> was talking about in the other threads.

Yes, and the decision I made on this topic is to have the fabric driver 
probed on the SSI node.

For ASoC V1, I believe the problem is undefined and each driver should 
be implemented in whatever way works best.

 > A device that can occur on
> more than one chip ".compatible = "fsl,ssi"," is being used to pull in
> a platform specific fabric driver, "mpc8610_hpcd". You can use the
> kernel config system to select the right driver for ".compatible =
> "fsl,ssi"," that matches you hardware and compile it in.

Ok, I think I understand that.

> But that doesn't work in my environment. My generic channel is
> "fsl,i2s". I have four different systems booting off from a shared
> network drive. Each of these systems needs the common "fsl,i2s" driver
> but they all four need different fabric drivers.

That, I don't understand.  fsl,ssi is pretty much the same thing as 
fsl,i2s, since the SSI *is* an I2S device.  It's also an AC97 device, 
which is why I added the fsl,mode property.

The fabric driver is specific to the board.  So you should be using 
Kconfig to select the fabric driver.  There is no node in the device 
tree for fabric drivers.  I thought that was the consensus.

Are you saying that you want to use the same kernel on four different 
systems?  If so, then you need to find a way to compile all fabric 
drivers together, and at boot time each fabric driver will decide 
whether it will do anything.
