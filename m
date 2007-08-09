Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id F389CDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 06:07:13 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so412486rvf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 13:07:12 -0700 (PDT)
Message-ID: <fa686aa40708091307r1b00ed8duc71f10c8fa524442@mail.gmail.com>
Date: Thu, 9 Aug 2007 14:07:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Joachim_F=F6rster?=" <mls.JOFT@gmx.de>
Subject: Re: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
In-Reply-To: <1186689700.28843.76.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1186655810.7420.26.camel@localhost>
	<fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
	<1186689700.28843.76.camel@localhost>
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

On 8/9/07, Joachim F=F6rster <mls.JOFT@gmx.de> wrote:
> Hi Grant,
>
> On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > > diff --git a/sound/ppc/Makefile b/sound/ppc/Makefile
> > > index eacee2d..827f2f5 100644
> > > --- a/sound/ppc/Makefile
> > > +++ b/sound/ppc/Makefile
> >
> > Couldn't this end up on MicroBlaze too?  If so, sound/ppc is the wrong =
place.
>
> Well, I don't know. The only arch depended calls I use (am aware of) are
> in/out_be32(), so this _might_ work for mb, too. (I won't be able to
> test that in the next few months ...)
>
> On Thu, 2007-08-09 at 11:17 -0700, Stephen Neuendorffer wrote:
> >  I second grant here... this should eventually work on microblaze, too,
> > so putting it drivers/ and using XILINX_DRIVERS instead of XILINX_VIRTE=
X
> > (based on the patch Wolfgang recently posted) would probably be prefera=
ble.
> >
> > > +
> > > +config SND_ML403_AC97CR
> > > +       tristate "Xilinx ML403 AC97 Controller Reference"
> > > +       depends on SND && XILINX_VIRTEX
> >
> > Steve
>
> So, like Stephen Neuendorffer said, I should move it to sound/drivers,
> right? Takashi?
>
>
> On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > > +snd-ml403_ac97cr-objs :=3D ml403_ac97cr.o
> >
> > This line is only needed if you're compiling multiple .c files into one=
 .ko
>
> Ah, well, then I have to rename the main .c file. But all the other ALSA
> drivers seem to _not_ include the "snd-" in front of it (ok, except the
> new PS3 driver and maybe other new ones?)
>
> > I'll try adding your patches to my tree this afternoon.
>
> I made patch against your tree, too (like a said before). Tell me, then
> I post it ...

No, don't base against my tree.  You worry about mainline; I'll worry
about my tree.  :-)

My tree gets rebased periodically anyway, so it's a much harder target.

>
>  Joachim
>
>
>


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
