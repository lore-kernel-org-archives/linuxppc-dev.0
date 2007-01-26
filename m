Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8B406DE03C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:17:01 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0Q6H0TA004333
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 23:17:00 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0Q6Gv8r007820
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 00:16:58 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 26 Jan 2007 14:16:55 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85D7DF@zch01exm20.fsl.freescale.net>
In-Reply-To: <F8DCDEDE-C060-458D-8E04-EA4C1EE2B2EE@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
	<A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
	<F8DCDEDE-C060-458D-8E04-EA4C1EE2B2EE@kernel.crashing.org>
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
> Sent: 2007=C4=EA1=D4=C225=C8=D5 23:11
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 25, 2007, at 2:53 AM, Zhu Ebony-r57400 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: 2007=C4=EA1=D4=C225=C8=D5 16:29
> >> To: Zhu Ebony-r57400
> >> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with=20
> >> IEEE-754 standard
> >>
> >>
> >> On Jan 25, 2007, at 2:25 AM, Zhu Ebony-r57400 wrote:
> >>
> >>>
> >>>> No, I think the round handler should try to do the
> >> rounding by hand.
> >>>> Since you have the non rounded information provided by HW,
> >> its much
> >>>> simpler to just do the rounding step.
> >>>
> >>> Hi Kumar,
> >>>
> >>> I have some new thoughts about rounding handler.
> >>> Suppose we set SPEFSCR[FRMC]=3D0b10 (rounding towards +Inf)
> >> and a normal
> >>> "efsmul" may generate rounding interrupt. At this time,
> >> according to
> >>> manual, unrounded (truncated) result is placed in the
> >> target register.
> >>> Please note the target register contains a hexadecimal
> >> representation
> >>> of a floating point number. Since it represents a floating point=20
> >>> number exactly so we can not round it anymore.
> >>
> >> I don't follow what you mean by not being able to round it anymore.
> >
> > I try to make myself clear:
> >> From my understanding, rounding is from a floating point number to=20
> >> another
> > which can be represented by IEEE-754 complied hexadecimal, but not=20
> > from a hexadecimal to another. For example:
> >
> > Assume the result we got from efsmul is 3.29305125103e-44=20
> It will be=20
> > stored in target register as 0x00000017. However,
> > 0x00000017
> > Represents 3.2229864679470793e-44 accurately. Can we round  =20
> > 3.2229864679470793e-44?
> > I'm afraid not. I mean, we must round the result before it being=20
> > stored in target register as hexadecimal, not after.
>=20
> I still don't follow what you are getting at.  The HW stores=20
> the non- rounded result.  You seem to imply there is some=20
> format change or something that is going on between the=20
> computed result and what's stored in the register.  If the=20
> result is such that it doesn't need rounding than you don't=20
> round (I forget if you can an exception or not if G|X are not set).

I'm now confused on this point. If I get round interrupt and the target
register is 0x00000017, what the round result should be for 0x00000017?
What is it if round to zero? If round to nearest? If round to +Inf? If =
round to -Inf?
>From the only info that 0x00000017 is a non-rounded result, we still =
don't know
how to round it. 0x00000017 is an inexact value itself.

Actually, in existing code of math-emu, rounding takes place when =
packing the bits
back into native fp result.

> >>> Maybe we still need to emulate the whole "efsmul" instruction by=20
> >>> software.
> >>
> >> You can't always do that.  Think about the following instruction:
> >>
> >> 	efsmul	r3, r3, r3
> >>
> >> You'll have lost the original value of r3 when the=20
> exception occurs.
> >
> > If this operation causes FP data interrupt, just let data interrupt=20
> > handler to do the simulation. I think there's no chance that we get=20
> > data and round interrupts simultaneously.
>=20
> Agreed, and I think FP data will take precedence, however the=20
> example I use can still cause a round exception and no data=20
> exception given the right input values.
OK, and I think I need to do some more tests to prove this.


Thanks for your feedback!

B.R.
Ebony
