Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E373ADDF03
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 05:44:49 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] Xlinx ML403 AC97 Controller
	Reference	device driver
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hsl6sws0s.wl%tiwai@suse.de>
References: <1186655810.7420.26.camel@localhost> <s5hsl6sws0s.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 21:44:46 +0200
Message-Id: <1186688686.28843.61.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Takashi,

before posting a corrected version, I would like to ask some unclear
things (I think I understood the rest):

On Thu, 2007-08-09 at 19:13 +0200, Takashi Iwai wrote:
> (snip)
> > +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
> > +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
> > +static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
> 
> Can the driver really support multiple instances?
> If not, better to avoid these arrays.

Well, while I wrote the driver I considered that there might be more
than one instance - though I didn't test it and I won't be able to test
it (no such hardware available - with more than one LM4550 chip).
So, shall I remove it?

> > +struct lm4550_reg lm4550_regfile[64] = {
> > +	{.reg = 0x00,
> > +	 .flag = LM4550_REG_NOSAVE | LM4550_REG_FAKEREAD,
> > +	 .def = 0x0D50},
> 
> Better to use C99 style initialization here, e.g.
> 
> 	[0x00] = { .... },
> 	[0x02] = { .... },
> 	[0x7e] = { .... },
> 
> so you can avoid writing empty items.
> The index value could be also AC97_XXX, such as [AC97_MASTER] =
> {...}.
> 
> What is the purpose of reg field at all, BTW?  I guess it's
> superfluous.

No, it's there to provide a shadow copy of the codec's (LM4550)
registers. It contains default values and (while driver is running)
current values, which were written to the hardware. I had to introduce
this, because Xilinx's AC97 Controller Reference has a very ugly bug: It
provides a "register access finish" bit, so the driver is able to tell
when a register read or write access is finished. Unfortunately this
particular bit only works in the range of 0 to 100 times since board
reset. After that many register access it just remains saying: I'm _not_
ready. But in fact, in most cases (98%) the correct value already is the
read register (assume we have just said to the control that we want to
read a register).
I thought, ok we have such RegAccessFinished bit, so use it, if we have
to, until it doesn't work anymore.
So, through a shadow copy of most registers (some cannot be shadow or it
makes no sence) I can provide the values without having to actually read
from the controller/codec. The regfile also contains info which register
might be shadowed, if values get saved at all (if written) ...
Furthermore ALSA's AC97 layer does heavy initialization access series on
the codec, which I tried to "mask out" completely
(LM4550_REG_FAKEPROBE).

> > +#define LM4550_RF_FLAG(reg)  lm4550_regfile[reg / 2].flag
<snip>
> > +static void lm4550_regfile_init(void)
> > +{
> > +	int i;
> > +	for (i = 0; i < 128; i = i + 2)
> > +		if (LM4550_RF_FLAG(i) & LM4550_REG_FAKEPROBE)
> > +			LM4550_RF_VAL(i) = LM4550_RF_DEF(i);
> 
> "MACRO(x) = XXX" looks a bit strange to me.

Hmmm, ok. I thought about that, too. I think, I'll spell them out?

> RATE_CONTINUOUS and RATE_KNOW are usually exclusive.

Ok, so what I want is RATE_CONTINUOUS, right? (because the LM4550
supports 4000 to 48000kHz in 1Hz steps)
BTW: What is RATE_KNOT good for?

 Joachim
