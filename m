Return-Path: <timur@freescale.com>
Message-ID: <4720C0DE.8050707@freescale.com>
Date: Thu, 25 Oct 2007 11:14:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <471F52ED.10007@freescale.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>	
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>	
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>	
	<20071025000425.GD23694@localhost.localdomain>	
	<9e4733910710241717i3c436e76l48f6c273d7114b94@mail.gmail.com>	
	<20071025003849.GB24382@localhost.localdomain>
	<9e4733910710242011y771d5cbbuaa1eb274672ccb48@mail.gmail.com>
In-Reply-To: <9e4733910710242011y771d5cbbuaa1eb274672ccb48@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> This could work. The generic codec is a alsa soc_device_driver, not a
> of_device_driver. The codec node could instantiate the fabric as a
> of_device_driver which could then instantiate the soc_device_driver
> for the generic codec.
> 
> The generic codecs are supposed to work cross platform so they can't
> include code that munges the of device tree.

My understanding of ASoC is that the fabric driver is supposed to be OF-aware, 
and the codec and other drivers are not.  The other drivers have ASoC entry 
points that the fabric driver calls to provide information.

Example:

Fabric driver:

static int mpc8610hpcd_startup(struct snd_pcm_substream *substream)
{
	...
	if (codec_dai->dai_ops.set_fmt) {
		ret = codec_dai->dai_ops.set_fmt(codec_dai, machine_data->dai_format);
		if (ret < 0) {
			printk(KERN_ERR "mpc8610-hpcd: could not set codec "
				"driver audio format (ret=%i)\n", ret);
			return ret;
		}
	}

codec driver:

static int cs4270_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
			      unsigned int format)
{
	...

	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
	case SND_SOC_DAIFMT_I2S:
	case SND_SOC_DAIFMT_LEFT_J:
		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
		break;


In my device tree, the I2S node specifies the interface (this node layout is 
what I came up with 6 months ago when I started working on this.)

		ssi@16000 {
			compatible = "fsl,ssi";
			reg = <16000 100>;
			interrupt-parent = <&mpic>;
			interrupts = <3e 2>;
			/* This is probably not the right way to tell the
			   SSI driver how to configure the interface */
			fsl,mode = "i2s-slave";
			codec {
				compatible = "cs4270";
			};
		};


The fabric driver reads "i2s-slave" and converts that to SND_SOC_DAIFMT_I2S.
