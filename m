Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE01.nvidia.com (hqemgate01.nvidia.com [216.228.112.170])
	by ozlabs.org (Postfix) with ESMTP id 780F867A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 08:14:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 25 Apr 2005 15:13:54 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B006884160@hqemmail02.nvidia.com>
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: New MPC5200 Eratta/ATA Bugs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Eric N. Johnson (ACD) [mailto:ejohnson@acdstar.com]=20
> At 02:35 PM 4/25/2005, Stephen Warren wrote:
> >Freescale have been working with us on a board work-around for the
> >problem. This basically involves deriving a substitute ATA_ISOLATION
> >signal from the regular ATA control signals, in some cases.
>=20
> Are you able to share the circuit they've recommended?  Is it as
simple as:
>    ISOLATION =3D ((ATA_CS1 or ATA_IOR) and (ATA_CS0 or ATA_IOR))
>=20
> This seems like it would be in violation of the setup and hold time=20
> requirements for the data bus.

This was suggested:

>>> 2. ... beleives that to fix the ATA_ISOLATION with logic would be
>>>  something like this:
>>>  ATA_ISOLATION_TO_BUFFERS =3D MPC's_ATA_ISOLATION or (GPIO_UDMA and
ATA_DMA_ACK#)=20

The idea is that the errata only causes a problem for UDMA (not MDMA or
PIO). So, the kernel is modified to set a GPIO whenever UDMA is in
progress. This triggers the external logic to use ATA_DMA_ACK# to
trigger the bus drivers. ATA_DMA_ACK# is the signal that means an actual
DMA data transfer is in progress.

That said, various people are in the process of trying the above logic,
and the more explicit:

ATA_ISOLATION_TO_BUFFERS =3D \
    (~GPIO_UDMA and MPC's_ATA_ISOLATION) | \
    (GPIO_UDMA and ATA_DMA_ACK#)

(possibly with the extra ~'s in there to fix high v.s. low true...)

And neither of these approaches actually works for us.

If I recall correctly, one of the other errata means MDMA can't work
either...

> I've been told there's a new silicon revision of the MPC5200 due
sometime=20
> later in the year, but the date keeps getting pushed back.

We were told this too. Sounds like maybe sometime in the middle of the
year at the earliest.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
