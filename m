Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: "andrew may" <acmay@acmay.homeip.net>,
	"Matt Porter" <porter@cox.net>,
	"Linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: very minor 405GP and 405GPr PCI difference
Date: Wed, 9 Oct 2002 08:21:56 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEBBDNAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1034159717.1600.89.camel@spawn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I think it's a good idea to isolate the kernel as much as possible from
> the bootloader. This way you cut down on strange bugs that could depend
> not on the kernel but on the firmware.
>
> What do we really gain by trusting the firmware for anything but the
> most basic stuff like some timing values and dram setup.

Now that we have argued ourselves into putting everything back into the
kernel because all firmware is evil, let me make a suggestion and provide a
couple examples.

Recommendation:
Setup that is related to the "hardware" configuration of the processor
should be done in firmware or at least not assumed to be wrong by the
kernel. Note: PCI memory translation windows do not fall into this criteria.

Examples (8260 related):
- clock routing, what clock source is connected to what peripheral
- clock/baud rate configuration, there is probably a reason why a clock
source was configured with a specific frequency
- I/O port configuration, this needs more thought, there are reasons why
pins are configured as in/out/open drain... (chip selects, reset controls,
etc)

I am sure that I could come up with other examples but hopefully you get my
point.  :)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
