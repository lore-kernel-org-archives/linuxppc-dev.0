MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Successful master window access
Date: Wed, 2 Jun 2004 09:38:26 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D007E84007@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: "Oliver Korpilla" <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry I didn't respond to your earlier post. This was a holiday weekend
in the US, and I've been trying to catch up.

To answer your earlier question:
> Did VMIC run into similar problems when trying to run the driver
> module on the VMIVME7050 (750FX/GX IBM  PowerPC board)?
> Because it is not yet in the list of supported boards?

We have not done that port yet, but I'm sure the same problem exists.

> While vme_dma_read() and vme_dma_write() worked already, even
> on the PowerPC,
> vme_peek() and vme_poke() (both based on PCI master windows)
> did not work.
>
> Today I successfully made accesses using that functions with
> my modified module,
> giving me the desired results:
>
> 1st test: MVME2100 (PPC) master - MVME162 (68k) slave
> vme_dma_read -A <VME address @ slave board> -d VME_D32
> vme_peek -A <VME address @ slave board> -d VME_D32
> Produced the same result for both accesses.
>
> 2nd test: MVME2100 (PPC) master - MVME162 (68k) slave
> vme_dma_write -A <VME address @ slave board> -d VME_D32 0xDEADFACE
> vme_peek -A <VME address @ slave board> -d VME_D32
> Produced the written value on reading.
>
> It seems, though I have to verify 1st, doing two things did the trick:
>
> 1.) Acquiring the PCI Window address range from the PCI bus
> address range of the
> bridge's PCI bus.
> 2.) Writing a help function that converts the physical
> address to a PCI bus
> address (doing nothing for x86, and on PPC doing a
> conversion). Only this
> address may be used when writing to the Universe window registers.
>
> It seems this may be a solution that should work for both platforms.
>
> Somehow I'm very excited and happy! :)

Very cool.

> I will go clean up that code, test it more thoroughly (with
> tracers enabled),
> focus on slave windows afterwards, and maybe even get to test
> it on a VMIVME7698
> - to verify it is still correct on Intel.
>
> When I got something more substantial than the current hack,
> I'll submit it to
> you, of course.

Fantastic, you're a good guy!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
