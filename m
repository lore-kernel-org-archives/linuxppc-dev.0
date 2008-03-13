Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F9CCDDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 18:03:59 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2D73p4I020406 for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 00:03:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2D73ojh006955
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 02:03:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Subject: RE: fsldma seems to be buggy, noticed in loop mode
Date: Thu, 13 Mar 2008 15:03:54 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AED32DD2@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080312180421.GC7255@Chamillionaire.breakpoint.cc>
References: <20080312180421.GC7255@Chamillionaire.breakpoint.cc>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Sebastian Siewior" <linuxppc-embedded@ml.breakpoint.cc>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Sebastian

Could you please apply these two patches and test again?

http://lkml.org/lkml/2008/3/10/64
http://lkml.org/lkml/2008/3/13/36

Thanks!
Wei.

> -----Original Message-----
> From: Sebastian Siewior [mailto:linuxppc-embedded@ml.breakpoint.cc]=20
> Sent: Thursday, March 13, 2008 2:04 AM
> To: linuxppc-embedded@ozlabs.org
> Cc: Zhang Wei
> Subject: fsldma seems to be buggy, noticed in loop mode
>=20
> Hello,
>=20
> I have a little kmod where I dma data from one place to another (can
> post it if someone wants to see it). It works in general according to
> memcmp :)
>=20
> If I set the DAHE flag (DAHTS =3D 0, for one byte transfers) =
everything
> seems to work as well (I see only the last byte which has the correct
> value).
> Now if I change the destination address to my FIFO I get the requested
> transfer size plus some extra bytes. The extra bytes are looking like
> exactly the same DMA transfer once again. Then my FIFO overruns.
> Enabling some printks in the kernel gave me the following log:
>=20
> |of-fsl-dma-channel e0021100.dma-channe: new link desc alloc df32a000
> |of-fsl-dma-channel e0021100.dma-channe: --memcpy issue--
> |of-fsl-dma-channel e0021100.dma-channe: Ch 0, LD 1f32a000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 0: 00050000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 1: 1f0be000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 2: 00050000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 3: 1f36c000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 4: 00000000
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 5: 00000001
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 6: 00000100
> |of-fsl-dma-channel e0021100.dma-channe: LD offset 7: 00000000
> |of-fsl-dma-channel e0021100.dma-channe: ----------------
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: xfer LDs staring=20
> from 0x000000001f32a000
> |of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie =3D 1
> |of-fsl-dma-channel e0021100.dma-channe: link descriptor=20
> df32a000 will be recycle.
> |of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie =3D 1
> |of-fsl-dma-channel e0021100.dma-channe: chan completed_cookie =3D 1
>=20
> done.=20
> I have one list entry which is df32a000. According to the output that
> single request gets started a couple of times what would=20
> explain why the
> FIFO overruns.
> Is it possible that the driver does not properly recognize that the
> transfer is finished _and_ that is the last one in line? Enabling the
> dma self test Kconfig option shows no error message but the number of
> interrupts that have been generated differ from channel to channel,
> from boot to boot.
>=20
> btw: It is a MPC8544 DS with -rc5.
>=20
> thanks,
>  Sebastian
>=20
