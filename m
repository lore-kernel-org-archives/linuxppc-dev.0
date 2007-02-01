Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C80D2DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 20:35:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l119Z90f029902
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 02:35:09 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l119Z6h9024324
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 03:35:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 1 Feb 2007 17:35:05 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85DE2C@zch01exm20.fsl.freescale.net>
In-Reply-To: <1B425F03-C72C-44C5-8AD0-177DFA184305@kernel.crashing.org>
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
> Sent: Wednesday, January 31, 2007 10:49 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
> >> On Jan 29, 2007, at 4:00 AM, Zhu Ebony-r57400 wrote:
> >>
> >>> Hi Kumar,
> >>>
> >>> I think enabling SPEFSCR[FINXE] or SPEFSCR[FRMC]=3D0b10/0b11
> >> to enable
> >>> FP round interrupt will cause the exception occurring very often,=20
> >>> which will dramatically decrease the performance of SPE
> >> instructions.
> >>> Do you think putting an option in menuconfig to let user choose=20
> >>> whether to enable FP round simulation is a reasonable idea?
> >>
> >> I don't see any issue with it, but I have to believe if=20
> you want full=20
> >> IEEE results, you want full IEEE results for everything.
> >>
> >> - k
> >>
> >
> > Agreed, we need to fully comply with IEEE754. So let's talk=20
> something=20
> > about the handler.
> >
> > The round exceptions can be put into 2 categories:
> >
> > 1. SPEFSCR[FRMC] =3D 0b10 or 0b11 (rounding toward +Inf and -Inf) We =

> > need to handle this exception to comply with IEEE
> >
> > 2. SPEFSCR[FINXE] =3D 1
> > If we enable this, round exception will occurs when=20
> inaccurate results=20
> > are generated. However, I think we don't need to do so.=20
> With FINXE=3D0,=20
> > if SPE data exception occurs, we can handle the exception=20
> by existing=20
> > handler, which is fully IEEE complied, including rounding.=20
> If no data=20
> > exception occurs, HW can implement "round to nearest" and "round=20
> > toward zero" with IEEE complied, and "round toward=20
> +Inf/-Inf" can be=20
> > handled by the handler of point 1.
> > So all
> > the situations are covered, we do have to enable FINXE.
> >
> > Could you make some comments on this? Thanks!
>=20
> While I agree with most of what you're saying there is one=20
> issue.  If the user want's an exception reported on inexact=20
> results when the =20
> rounding mode is set to "round to nearest" or "round towards zero".  =20
> Of course we know when the user requests this and can=20
> enable/disable this exception at that point if we want to.
>=20
> On a side node, wondering if you've come across this test suite:
> http://www.jhauser.us/arithmetic/TestFloat.html
>=20
> - k

Thank  you for your comments and useful link. It seems quite good for
testing the handler.

B.R.
Ebony






>=20
