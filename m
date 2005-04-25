Return-Path: <SWarren@nvidia.com>
Received: from HQEMGATE03.nvidia.com (hqemgate03.nvidia.com [216.228.112.143])
	by ozlabs.org (Postfix) with ESMTP id BEFFA67AC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 05:35:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 25 Apr 2005 12:35:00 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00688411F@hqemmail02.nvidia.com>
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

Eric N. Johnson (ACD) wrote:
> Freescale just realeased a new version of the eratta (hardware bugs)=20
> document for the MPC5200.  It was posted last week, and adds some
pretty=20
> significant problems to the FEC Ethernet and IDE/ATA sections.
>
> Specifically, I'm wonder if Eratta ID 485 may be the cause of some of
the=20
> IDE issues we've been attributing to Bestcomm:
>=20
>   "During the concurrent access of ATA DMA READ and PCI or LPC the
>    ATA_ISOLATION signal can be incorrectly driven when ATA is paused."
>=20
> Unfortunately, their proposed workaround isn't appropriate for many=20
> cases.  They suggest that you not use "ATA_ISOLATION" and connect the
ATA=20
> device directly to the LP bus without any buffering.  This could lead
to=20
> serious bus integrity issues, especially if the ATA device is
connected by=20
> a ribbon cable.=20

Freescale certainly confirmed that was the issue we were up against.

Freescale have been working with us on a board work-around for the
problem. This basically involves deriving a substitute ATA_ISOLATION
signal from the regular ATA control signals, in some cases.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
