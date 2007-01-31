Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2696FDDF96
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 20:45:57 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0V9jtFO006682
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 02:45:55 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0V9jrYX003670
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 03:45:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Wed, 31 Jan 2007 17:45:52 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85DCAD@zch01exm20.fsl.freescale.net>
In-Reply-To: <FC3C8B30-CD7C-4BE0-82AE-16E708B36374@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
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

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Monday, January 29, 2007 10:31 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 29, 2007, at 4:00 AM, Zhu Ebony-r57400 wrote:
>=20
> > Hi Kumar,
> >
> > I think enabling SPEFSCR[FINXE] or SPEFSCR[FRMC]=3D0b10/0b11=20
> to enable=20
> > FP round interrupt will cause the exception occurring very often,=20
> > which will dramatically decrease the performance of SPE=20
> instructions.=20
> > Do you think putting an option in menuconfig to let user choose=20
> > whether to enable FP round simulation is a reasonable idea?
>=20
> I don't see any issue with it, but I have to believe if you=20
> want full IEEE results, you want full IEEE results for everything.
>=20
> - k
>=20

Agreed, we need to fully comply with IEEE754. So let's talk something
about the handler.

The round exceptions can be put into 2 categories:

1. SPEFSCR[FRMC] =3D 0b10 or 0b11 (rounding toward +Inf and -Inf)
We need to handle this exception to comply with IEEE

2. SPEFSCR[FINXE] =3D 1
If we enable this, round exception will occurs when inaccurate results
are
generated. However, I think we don't need to do so. With FINXE=3D0, if =
SPE
data
exception occurs, we can handle the exception by existing handler, which
is fully IEEE complied, including rounding. If no data exception occurs,
HW
can implement "round to nearest" and "round toward zero" with IEEE
complied,
and "round toward +Inf/-Inf" can be handled by the handler of point 1.
So all
the situations are covered, we do have to enable FINXE.

Could you make some comments on this? Thanks!

B.R.
Ebony
