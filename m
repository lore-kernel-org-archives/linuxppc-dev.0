Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85C24679E9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 10:00:09 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
In-Reply-To: <1148137032.3407.12.camel@localhost>
References: <1147860564.14395.6.camel@johannes>
	<200605180002.01669.borge@arivene.net>
	<20060518004141.GC1552@kunpuu.plessy.org>
	<1148137032.3407.12.camel@localhost>
Content-Type: text/plain; charset=utf-8
Date: Sun, 21 May 2006 09:59:46 +1000
Message-Id: <1148169587.13249.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	charles-debian-nospam@plessy.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-05-20 at 16:57 +0200, Benjamin Berg wrote:
> On Thu, 2006-18-05 at 09:41 +0900, Charles Plessy wrote: 
> > Hi all,
> > 
> > just a "me too" mail:
> > 
> > Le Thu, May 18, 2006 at 12:02:01AM +0200, Børge Holen a écrit :
> > > I can also remember half way throught a ogg/mp3 playlist when it also 
> > > scrambled the output, this has only happened ONCE.
> > 
> > I experience the same on my 8,1 powermac, but more systematically. It
> > takes usually more than one hour of continuous listening before it
> > happens, and then it happens sort of stochastically. I am not using
> > anything else than xmms, so I did not figure out if it is a xmms or a
> > driver problem. Stop/Starting the listening stops the scrambling.
> 
> This is exactly the problem that I have experienced since a while now.
> The problem is that some interrupts get lost. This results in a broken
> address calculation and the new data is written to the wrong place.

See my other mail about that. Worth tracking down. As far as the DBDMA
handling is concerned, I think walking the descriptors and harvesting
status bits is a better approach as it also allows you to get error
status if you ever get any. Now, if you can have some reliable frame
counter, that's definitely something to look into passing userland too.

> The attached patch fixes this by checking the 'frame_count'.
> What I don't really understand is, that the first time the interrupt
> gets executed, the frame_count is 8 _less_ of what I would have expected
> My guess is that the dma controller reads the last 32 bytes, and then
> the interrupt gets fired.

The DBDMA definitely has a fifo. By the time you get the IRQ, it may
have started pumping the "next" packet. 32 bytes sounds about right for
the DBDMA fifo... old DBDMAs had 16 bits iirc but I could imagine Apple
improving that.

> diff --git a/soundbus/i2sbus/i2sbus-pcm.c b/soundbus/i2sbus/i2sbus-pcm.c
> index 9eadf83..8511234 100644
> --- a/soundbus/i2sbus/i2sbus-pcm.c
> +++ b/soundbus/i2sbus/i2sbus-pcm.c
> @@ -440,6 +440,11 @@ static int i2sbus_pcm_trigger(struct i2s
>  			return -ENXIO;
>  		}
>  
> +		/* get the current frame_count - 32 bytes. This is just guessed,
> +		   but it seems that the interrupt triggers as soon as the last 32 bytes
> +		   are cached or something. */
> +		pi->frame_count = in_le32(&i2sdev->intfregs->frame_count) - 0x20 / (pi->substream->runtime->sample_bits / 8);
> +
>  		/* wake up the chip with the next descriptor */
>  		out_le32(&pi->dbdma->control, (RUN|WAKE) | ((RUN|WAKE)<<16));
>  		/* off you go! */
> @@ -488,13 +493,29 @@ static snd_pcm_uframes_t i2sbus_pcm_poin
>  static inline void handle_interrupt(struct i2sbus_dev *i2sdev, int in)
>  {
>  	struct pcm_info *pi;
> +	u32 fc;
> +	u32 delta;
>  
>  	get_pcm_info(i2sdev, in, &pi, NULL);
>  	if (!pi->substream) {
>  		printk(KERN_INFO "i2sbus: got %s irq while not active!\n", in?"rx":"tx");
>  		return;
>  	}
> -	pi->current_period = (pi->current_period+1) % (pi->periods);
> +	
> +	fc = in_le32(&i2sdev->intfregs->frame_count);
> +	/* a counter overflow does not change the calculation. */
> +	delta = fc - pi->frame_count;
> +	
> +	if (delta <= pi->substream->runtime->period_size) {
> +		pi->current_period = pi->current_period + 1;
> +		delta = 0;
> +	} else while (delta >= pi->substream->runtime->period_size) {
> +		pi->current_period = pi->current_period + 1;
> +		delta = delta - pi->substream->runtime->period_size;
> +	}
> +	
> +	pi->frame_count = fc - delta;
> +	pi->current_period = pi->current_period % pi->periods;
>  	snd_pcm_period_elapsed(pi->substream);
>  }
>  
> diff --git a/soundbus/i2sbus/i2sbus.h b/soundbus/i2sbus/i2sbus.h
> index b054e02..f5d16aa 100644
> --- a/soundbus/i2sbus/i2sbus.h
> +++ b/soundbus/i2sbus/i2sbus.h
> @@ -41,6 +41,7 @@ struct pcm_info {
>  	struct snd_pcm_substream *substream;
>  	int current_period;
>  	int periods;
> +	u32 frame_count;
>  	struct dbdma_command_mem dbdma_ring;
>  	volatile struct dbdma_regs __iomem *dbdma;
>  };
> 
> 
