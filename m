Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9B36DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 12:43:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4P2hK0K028452
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 19:43:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4P2hJma029762
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 21:43:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] qe_lib: export symbols to fix compile error when QE
	drivers compile as modules
Date: Fri, 25 May 2007 10:45:07 +0800
Message-ID: <989B956029373F45A0B8AF0297081890B768A2@zch01exm26.fsl.freescale.net>
In-Reply-To: <5E953418-3B5B-4051-9ABB-4C3B1CE1567F@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
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
> Sent: Thursday, May 24, 2007 7:44 PM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_lib: export symbols to fix compile error when
QE drivers
> compile as modules
>=20
>=20
> On May 24, 2007, at 4:14 AM, Li Yang wrote:
>=20
> > Export symbols of qe_lib to be used by QE drivers.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/sysdev/qe_lib/ucc.c      |    7 +++++++
> > arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
> > arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 ++++++++++--
> > 3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> A number of the EXPORT_SYMBOL() are not used by any in kernel drivers
> and thus should not be added.  See comments below.  Also, should
> these be EXPORT_SYMBOL_GPL().

Some of them are not used by in kernel driver, but they are used by some
off kernel drivers and driver in development.  Shouldn't we export them?

I know Linux is again non-GPL modules, but Freescale won't be forcing
customers to use GPL as long as Linux doesn't ban non-GPL module
completely.

> > static void get_cmxucr_reg(int ucc_num, volatile u32 ** p_cmxucr,
> > u8 * reg_num,
> > 			   u8 * shift)
> > @@ -122,6 +126,7 @@ static void get_cmxucr_reg(int ucc_num,
> > volatile u32 ** p_cmxucr, u8 * reg_num,
> > 		break;
> > 	}
> > }
> > +EXPORT_SYMBOL(get_cmxucr_reg);
>=20
> remove, you shouldn't be exporting something marked static.

Good catch.

Thanks,
Leo
