Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C63CDDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 14:09:18 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9I49Blj015756
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:09:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9I49AvL003558
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:09:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3 2/9] ipic: add new interrupts introduced by new chip
Date: Thu, 18 Oct 2007 12:09:09 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5B44@zch01exm26.fsl.freescale.net>
In-Reply-To: <BB3ACE22-7584-49D9-BEB0-DC355FA25BA1@kernel.crashing.org>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<BB3ACE22-7584-49D9-BEB0-DC355FA25BA1@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, October 17, 2007 9:46 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v3 2/9] ipic: add new interrupts=20
> introduced by new chip
>=20
>=20
> On Oct 12, 2007, at 8:28 AM, Li Yang wrote:
>=20
> > These interrupts are introduced by the latest Freescale SoC such as=20
> > MPC837x.  The patch also adds comment to interrupts.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/sysdev/ipic.c |  224 +++++++++++++++++++++++++++++++++
> > +----------
> >  arch/powerpc/sysdev/ipic.h |    7 +-
> >  include/asm-powerpc/ipic.h |   12 ++-
> >  3 files changed, 186 insertions(+), 57 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/ipic.c=20
> b/arch/powerpc/sysdev/ipic.c=20
> > index 05a56e5..cd8590d 100644
> > --- a/arch/powerpc/sysdev/ipic.c
> > +++ b/arch/powerpc/sysdev/ipic.c
> > @@ -33,7 +33,31 @@ static struct ipic * primary_ipic;  static=20
> > DEFINE_SPINLOCK(ipic_lock);
> >
> >  static struct ipic_info ipic_info[] =3D {
> > -	[9] =3D {
> > +	[1] =3D {	/* PEX1 CNT */
>=20
> Remove the comments, they are not correct for all IPIC users=20
> and thus misleading.

We had discussed about this.  The reason why I add these comments is
that IPIC register definition in our user manual only reference
interrupts by name rather than numbers.  It will greatly enhance the
readability of the code, so that we can check easily if the current code
fits IPIC definition of a specific chip.  Without comments the check
will be a disaster. :)
The comments are correct for all the in tree CPUs.  It should be kept
up-to-date easily when adding new CPUs.

- Leo
