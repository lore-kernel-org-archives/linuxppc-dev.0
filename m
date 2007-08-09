Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B25ACDDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 06:01:43 +1000 (EST)
Subject: Re: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
References: <1186655810.7420.26.camel@localhost>
	<fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 22:01:40 +0200
Message-Id: <1186689700.28843.76.camel@localhost>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
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

Hi Grant,

On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > diff --git a/sound/ppc/Makefile b/sound/ppc/Makefile
> > index eacee2d..827f2f5 100644
> > --- a/sound/ppc/Makefile
> > +++ b/sound/ppc/Makefile
> 
> Couldn't this end up on MicroBlaze too?  If so, sound/ppc is the wrong place.

Well, I don't know. The only arch depended calls I use (am aware of) are
in/out_be32(), so this _might_ work for mb, too. (I won't be able to
test that in the next few months ...)

On Thu, 2007-08-09 at 11:17 -0700, Stephen Neuendorffer wrote: 
>  I second grant here... this should eventually work on microblaze, too,
> so putting it drivers/ and using XILINX_DRIVERS instead of XILINX_VIRTEX
> (based on the patch Wolfgang recently posted) would probably be preferable.
> 
> > +
> > +config SND_ML403_AC97CR
> > +       tristate "Xilinx ML403 AC97 Controller Reference"
> > +       depends on SND && XILINX_VIRTEX
> 
> Steve

So, like Stephen Neuendorffer said, I should move it to sound/drivers,
right? Takashi?


On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > +snd-ml403_ac97cr-objs := ml403_ac97cr.o
> 
> This line is only needed if you're compiling multiple .c files into one .ko

Ah, well, then I have to rename the main .c file. But all the other ALSA
drivers seem to _not_ include the "snd-" in front of it (ok, except the
new PS3 driver and maybe other new ones?)

> I'll try adding your patches to my tree this afternoon.

I made patch against your tree, too (like a said before). Tell me, then
I post it ...

 Joachim
