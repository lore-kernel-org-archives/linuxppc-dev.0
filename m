Message-ID: <E69FF45ADA3BD511A25900047623CC4F12AA76@JUPITER>
From: Neil Wilson <NWILSON@Airspan.com>
To: "'Mark A. Greer'" <mgreer@mvista.com>,
	Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Sandpoint 3 + MPC7450 + HHL2
Date: Thu, 28 Jun 2001 07:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Got it working now....

Not sure if these fixes are just Sandpoint3 or MPC7450 or the combination,
but...

1) The openpic_init call in sandpoint_init_IRQ needs the offset argument to
get the SIO int setup.

2) I also needed to add a enable of the TBEN in HID0 (bit 0x04000000) just
to get the kernel to think about booting at all - I put this in the
decompress_kernel function.

Do these sort of changes need pushing into the source tree ?, and if so
would anyone care to explain how a newcommer does this, thanks.

Neil

> -----Original Message-----
> From:	Mark A. Greer [SMTP:mgreer@mvista.com]
> Sent:	Wednesday, June 27, 2001 5:48 PM
> To:	Neil Wilson
> Cc:	'linuxppc-embedded@lists.linuxppc.org'
> Subject:	Re: Sandpoint 3 + MPC7450 + HHL2
>
> Neil Wilson wrote:
>
> > Hi,
> >
> > I managed to get the JourneyMan 2 82XX booting up on my Sandpoint3
> MPC7450 -
> > after adding a enable for the TimeBase - however when a ramdisk is
> mounted
> > up I get very slow serial response, like several seconds to print a
> string,
> > does anyone have some ideas of what I could look at to resolve this, I
> have
> > an Abatron bdi etc but a lot of this is new to me so any help would be
> very
> > welcome. Thanks.
>
> I'll virtually guarantee you that its an interrupt-related problem.
> Either the
> routing is wrong or the IRQ isn't enabled or...
>
> Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
