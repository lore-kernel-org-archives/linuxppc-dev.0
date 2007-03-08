Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 634E3DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 12:57:00 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l281uqKi018972
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 18:56:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l281uo7A007823
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 19:56:51 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 09:56:49 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
In-Reply-To: <CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
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

Hi, Kumar and Scott,
=20
Thanks for your review. :-)

The MPC8641HPCN's RTC is a module of ULI1575, which is a legacy RTC
device with operate by I/O ports 0x70 and 0x71. So I use functions
defined in asm-generic/rtc.h to set and get rtc time.

Best Regards,
Zhang Wei

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, March 08, 2007 3:49 AM
> To: Wood Scott-B07421
> Cc: Loeliger Jon-LOELIGER; Zhang Wei-r63237; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
>=20
>=20
> On Mar 7, 2007, at 1:34 PM, Scott Wood wrote:
>=20
> > On Wed, Mar 07, 2007 at 01:19:29PM -0600, Kumar Gala wrote:
> >> On Mar 7, 2007, at 12:49 PM, Jon Loeliger wrote:
> >>> From: Zhang Wei <wei.zhang@freescale.com>
> >>>
> >>> Give more IRQ numbers for MPIC IPIs and TIMERs use.
> >>> Added generic RTC support for MPC8641HPCN.
> >>>
> >>> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> >>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >>
> >> Nack.
> >>
> >> You can't call the generic set_rtc_time from the
> >> ppc_md.set_rtc_time.  Take a look at:
> >>
> >> http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030440.html
> >
> > set_rtc_time !=3D rtc_set_time.  The latter is the one that=20
> goes through
> > the drivers/rtc stuff and needs a workqueue; the former=20
> (which this =20
> > patch
> > uses) is in asm-generic/rtc.h, and appears to be interrupt-safe.
>=20
> I ah, didn't notice.. Well I don't think=20
> set_rtc_time/get_rtc_time do =20
> anything useful for most ppc's, since it seems they use CMOS_READ/=20
> CMOS_WRITE which is only defined in asm/mc146818rtc.h
>=20
> - k
>=20
