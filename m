Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3355E679E2
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 19:34:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9NAte5K025484
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 04:55:40 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9N9Yp58004977
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 04:34:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Mon, 23 Oct 2006 17:35:37 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2070D6@zch01exm20.fsl.freescale.net>
In-Reply-To: <17724.15919.790114.628418@cargo.ozlabs.ibm.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>,
	"Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Paul
> Mackerras
> Sent: Monday, October 23, 2006 12:00 PM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
>=20
> Scott Wood writes:
>=20
> > This patch causes a sync do be done after masking a QE interrupt, to
> > ensure that the masking has completed before interrupts are enabled.
> > This allows the masking of the cascade IRQ to be removed without
causing
> > spurious interrupts.
>=20
> Hmmm.  In general a sync having completed doesn't mean that previous
> MMIO stores have actually got to the device.  Reading from a device
> register generally does ensure that previous writes have actually got
> to the device though - could you do that instead?  I'm concerned that
> adding the sync is not a robust fix and is possibly only working due
> to fortuitous timing.

But an i/o read will be considerably slower than a sync, and it is in
the critical path of interrupt.  I have tested the patch under
relatively heavy Ethernet load, and there is no spurious interrupt.
Maybe it is because the device is an SOC device and MMIO store completes
faster.  I'm wondering if there is a standard test method to show if the
faster approach is sufficient or not.

- Leo=20
