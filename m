Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 60DE2DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 16:38:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2F5cCqt011679
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 22:38:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2F5cB9I004859
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 00:38:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Date: Thu, 15 Mar 2007 13:39:25 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DB10B@zch01exm26.fsl.freescale.net>
In-Reply-To: <88E3290D-D9C8-48F0-9D47-D2235D5F092E@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, March 15, 2007 11:49 AM
> To: Li Yang-r58472
> Cc: Tabi Timur-B04825; Phillips Kim-R1AAHA; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
configurableoption
>=20
>=20
> On Mar 14, 2007, at 10:02 PM, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> >> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On
> >> Behalf
> > Of Timur
> >> Tabi
> >> Sent: Thursday, March 15, 2007 3:36 AM
> >> To: Phillips Kim-R1AAHA
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
> > configurableoption
> >>
> >> Kim Phillips wrote:
> >>> On Wed, 14 Mar 2007 13:15:05 -0500 (CDT)
> >>> Kumar Gala <galak@kernel.crashing.org> wrote:
> >>>
> >>>>  arch/powerpc/Kconfig                |    8 --------
> >>>>  arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
> >>>>  2 files changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> What about 85xx QE support?
> >>
> >> Kumar and I talked about it.  85xx support will be added when QE
> >> works
> > on 85xx.
> >> However,
> >> the patch still needs changes.  To allow each CPU family to have
its
> > own QE option,
> >> we'll
> >> need to define something like QUICC_ENGINE_83xx and
> >> QUICC_ENGINE_85xx,
> > and then
> >> have
> >> something like this:
> >>
> >> config QUICC_ENGINE
> >> 	bool
> >> 	default y if QUICC_ENGINE_83xx || QUICC_ENGINE_85xx
> >
> > I don't think we need these new options.  If there are differences
> > between the two SOC versions, presumably not too many, we can
address
> > them in device tree.  It's better to leave the QUICC_ENGINE option
at
> > arch/powerpc/Kconfig level, IMHO.
>=20
>=20
> The issue isn't dealing with differences between 83xx/85xx.  Its
> allowing the choice for only those two subarchs.

If you want to make it configurable, I suggest we put it under the
"Processor Support" menu in arch/powerpc/Kconfig like Altivec and SPE.
It is a chip feature rather than board.  And we won't need the two
redundant options then.

- Leo
