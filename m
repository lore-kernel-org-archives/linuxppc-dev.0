Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id AE20BDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 21:50:46 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] Xlinx ML403 AC97 Controller Reference
	device driver
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hsl6sws0s.wl%tiwai@suse.de>
References: <1186655810.7420.26.camel@localhost> <s5hsl6sws0s.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Fri, 10 Aug 2007 13:50:40 +0200
Message-Id: <1186746640.8965.21.camel@localhost>
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

again some question came up (while correcting all the other issues):

On Thu, 2007-08-09 at 19:13 +0200, Takashi Iwai wrote:
> > +static int __init
> > +snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
> > +			struct snd_ml403_ac97cr **rml403_ac97cr)
> 
> It's no longer __init as long as you use platform_device.
> It should be __devinit instead.

Ok, I changed that (for create(), pcm(), mixer(), etc.). Do I have to
change it for the module_init and module_exit functions, too? I guess,
they are not in the "scope" of platform device, right? So, they will
keep __init / __exit ?

> > --- /dev/null
> > +++ b/sound/ppc/pcm-indirect2.h
> (snip)
> > +#ifdef SND_PCM_INDIRECT2_STAT
> > +static inline void snd_pcm_indirect2_stat(struct snd_pcm_substream *substream,
> > +					  struct snd_pcm_indirect2 *rec)
> 
> Remove inline from the functions in this file.  They are too lengthy.
> 
> sound/pcm-indirect.h contain inline functions becuase they are
> relatively small, and I didn't want to add them in the core module
> unconditionally.

I looked at my functions again. And I think we could still go with
inline for the *_interrupt() and *_pointer() functions since they have
just a few lines.
With both *_transfer() functions - I don't know. In fact they shouldn't
be much longer than yours in pcm-indirect.h . They seem long, because
there are lot of comments and the #ifdef SND_PCM_INDIRECT2_STAT stuff,
which is/was a debugging feature, which _won't_ be compiled in without
CONFIG_SND_DEBUG.

[I removed inline from the _stat() and _min_periods() function - that's
true, they are too long.]

The other thing I thought about, is: Is it ok to have non-inline
functions in a header file? Don't we need a .c file + .h ? (Are there
any CodingStyle rules about that?)

 Joachim
