Subject: Re: New TiPB - PCMCIA settings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: George Staikos <staikos@kde.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1037695549.3241.479.camel@thor>
References: <1037695549.3241.479.camel@thor>
Content-Type: text/plain; charset=ISO-8859-1
Date: 19 Nov 2002 10:18:13 +0100
Message-Id: <1037697493.1624.140.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-11-19 at 09:45, Michel Dänzer wrote:
>
> On Die, 2002-11-19 at 00:29, George Staikos wrote:
> >
> > What doesn't work right now:
> > - dmasound is aweful (lots of clicking and sounds bad)
>
> With a current benh kernel? Do the latest TiBooks have different sound
> hardware again?

According to the device-tree, it seems to be a snapper (tas3004),
maybe we don't set some i2s registers properly, I don't know.
The device-tree also imply that it supports 2 sample rates,
it's possible that the sample rate or format on i2s side doesn't
match what is configured in the texas chip.

> > - video issues in XFree86 and fbdev, along with sleeping
> >     - closing the screen causes lots of garbling on the screen.
>
> Sleep doesn't even work with the 7500 Mobility yet, let alone the 9000
> Mobility. Otherwise, people have reported moderate success with radeonfb
> from the current benh tree and my DRI snapshot Debian packages.

The remaining problem seem to be the same as desktop r9000's with ADC
connector, that is a palette issue. According to Ani, the DACs are
physical (that is, regardless of CRTC1 or 2 usage, the DACs for each
output is fixed, and we may not be configuring the palette in the
proper one).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
