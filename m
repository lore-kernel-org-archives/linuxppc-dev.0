Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CDB07DE170
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:53:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0P8rbhh007505
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 01:53:37 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0P8rYnS009254
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 02:53:35 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 25 Jan 2007 16:53:33 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
In-Reply-To: <A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
	<A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
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
> Sent: 2007=C4=EA1=D4=C225=C8=D5 16:29
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 25, 2007, at 2:25 AM, Zhu Ebony-r57400 wrote:
>=20
> >
> >> No, I think the round handler should try to do the=20
> rounding by hand.
> >> Since you have the non rounded information provided by HW,=20
> its much=20
> >> simpler to just do the rounding step.
> >
> > Hi Kumar,
> >
> > I have some new thoughts about rounding handler.
> > Suppose we set SPEFSCR[FRMC]=3D0b10 (rounding towards +Inf)=20
> and a normal=20
> > "efsmul" may generate rounding interrupt. At this time,=20
> according to=20
> > manual, unrounded (truncated) result is placed in the=20
> target register.=20
> > Please note the target register contains a hexadecimal=20
> representation=20
> > of a floating point number. Since it represents a floating point=20
> > number exactly so we can not round it anymore.
>=20
> I don't follow what you mean by not being able to round it anymore.

I try to make myself clear:
>From my understanding, rounding is from a floating point number to =
another
which can be represented by IEEE-754 complied hexadecimal, but not
from a hexadecimal to another. For example:

Assume the result we got from efsmul is 3.29305125103e-44
It will be stored in target register as 0x00000017. However, 0x00000017
Represents 3.2229864679470793e-44 accurately. Can we round  =
3.2229864679470793e-44?
I'm afraid not. I mean, we must round the result before it being stored =
in
target register as hexadecimal, not after.



> > Maybe we still need to emulate the whole "efsmul" instruction by=20
> > software.
>=20
> You can't always do that.  Think about the following instruction:
>=20
> 	efsmul	r3, r3, r3
>=20
> You'll have lost the original value of r3 when the exception occurs.

If this operation causes FP data interrupt, just let data interrupt =
handler to
do the simulation. I think there's no chance that we get data and round =
interrupts
simultaneously.


>=20
> - k
>=20
>=20
