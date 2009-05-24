Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC483DE058
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 21:46:51 +1000 (EST)
Date: Sun, 24 May 2009 12:46:35 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524114635.GF4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231307.17919.5277.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090523231307.17919.5277.stgit@terra>
Subject: Re: [alsa-devel] [PATCH V2 6/9] Codec for STAC9766 used on the Efika
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 07:13:07PM -0400, Jon Smirl wrote:
> AC97 codec for STAC9766 used on the Efika.
> Datasheet: http://www.idt.com/products/getDoc.cfm?docID=13134007
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

This looks mostly good, a couple of issues below.  I'll apply the patch
but please submit a followup patch for resume as discussed below.

> +static int ac97_digital_trigger(struct snd_pcm_substream *substream,
> +								int cmd, struct snd_soc_dai *dai)

Very strange indentation here...

> +static int stac9766_codec_resume(struct platform_device *pdev)
> +{

> +	/* give the codec an AC97 warm reset to start the link */
> +reset:
> +	if (reset > 5) {
> +		printk(KERN_ERR "stac9766 failed to resume");
> +		return -EIO;
> +	}
> +	codec->ac97->bus->ops->warm_reset(codec->ac97);
> +	id = soc_ac97_ops.read(codec->ac97, AC97_VENDOR_ID2);
> +	if (id != 0x4c13) {
> +		stac9766_reset(codec, 0);
> +		reset++;
> +		goto reset;
> +	}

As I said last time I'd this looks like it should be using the reset
function that you've provided?  

The loop is new since last time and seems very suspicious - are you sure
that this is a CODEC problem that's being worked around and not an issue
with the AC97 controller or with the specific system starting up the
master clock for the CODEC after resume?  If it's an issue with the
controler then it'd be better to fix it there so that all CODEC drivers
get the benefit.  If it's a CODEC issue a comment explaining the problem
would be helpful since it's not the sort of issue I'd expect to see in a
CODEC.  The fact that it's not needed on initial boot suggests something
controller or external clock related.

Either way, it'd be much clearer to rewrite it using a for or while loop
rather than a goto.  Please submit a followup patch fixing at least this
issue.

> +static int __init stac9766_modinit(void)
> +{
> +	return snd_soc_register_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));
> +}
> +module_init(stac9766_modinit);
> +
> +static void __exit stac9766_exit(void)
> +{
> +	snd_soc_unregister_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));
> +}
> +module_exit(stac9766_exit);

These are not needed for AC97 CODECs, ASoC doesn't wait for them to
probe.  I'll apply a patch removing these.
