Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 26CEBDDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 17:27:25 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l196RLpE006058
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 23:27:22 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l196RK6b002438
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 00:27:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 9 Feb 2007 14:27:18 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7F9F@zch01exm20.fsl.freescale.net>
In-Reply-To: <2F133E13-3703-40BE-8A40-142C300B93DF@kernel.crashing.org>
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
> Sent: Friday, February 09, 2007 2:04 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc V2: Add the general support=20
> for Embedded Floating-Point instructions
>=20
>=20
> On Feb 8, 2007, at 11:48 PM, Zhu Ebony-r57400 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, February 09, 2007 1:29 PM
> >> To: Zhu Ebony-r57400
> >> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [patch][5/5] powerpc V2: Add the general support for=20
> >> Embedded Floating-Point instructions
> >>
> >>
> >> On Feb 8, 2007, at 11:15 PM, Zhu Ebony-r57400 wrote:
> >>
> >>>
> >>>>>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S
> >> b/arch/powerpc/
> >>>>>>> kernel/head_fsl_booke.S index 66877bd..0d05db0 100644
> >>>>>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
> >>>>>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> >>>>>>> @@ -705,7 +705,7 @@ #else
> >>>>>>>  #endif /* CONFIG_SPE */
> >>>>>>>
> >>>>>>>  	/* SPE Floating Point Round */
> >>>>>>> -	EXCEPTION(0x2050, SPEFloatingPointRound,
> >> unknown_exception,
> >>>>>>> EXC_XFER_EE)
> >>>>>>> +	EXCEPTION(0x2050, SPEFloatingPointRound,
> >>>>>>> SPEFloatingPointException_Round, EXC_XFER_EE)
> >>>>>>>
> >>>>>>>  	/* Performance Monitor */
> >>>>>>>  	EXCEPTION(0x2060, PerformanceMonitor,=20
> >>>>>>> performance_monitor_exception, EXC_XFER_STD) @@=20
> -840,6 +840,8 @@
> >>>>>>> load_up_spe:
> >>>>>>>  	oris	r5,r5,MSR_SPE@h
> >>>>>>>  	mtmsr	r5			/* enable use
> >> of SPE now */
> >>>>>>>  	isync
> >>>>>>> +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE |
> >> SPEFSCR_FUNFE |
> >>>>>>> SPEFSCR_FOVFE)
> >>>>>>> +	mtspr   SPRN_SPEFSCR,r5
> >>>>>>
> >>>>>> We should do this via INIT_THREAD, is there a reason that
> >>>> you want to
> >>>>>> set these always?
> >>>>>
> >>>>> I just thought it's the first time that an SPE instruction is=20
> >>>>> encountered, so I enable the exceptions here.
> >>>>
> >>>> Lets do this via INIT_THREAD instead, its cleaner. (just
> >> remember to
> >>>> add the proper ifdef protection for SPE_IEEE
> >>>
> >>> Talking about INIT_THREAD, I'm wondering where is the=20
> best place to=20
> >>> enble the exceptions? Please advice!
> >>
> >> What's the issue with enabling via INIT_THREAD?  am I missing=20
> >> something?
> >
> > Do you mean that add
> > ".spefscr =3D SPEFSCR_FINV| =
SPEFSCR_FDBZE|SPEFSCR_FUNFE|SPEFSCR_FOVFE"
> > In the defination of INIT_THREAD?
>=20
> You may want to have something like #define=20
> SPE_EXCEPTION_ENABLE (SPEFSCR_FINV|=20
> SPEFSCR_FDBZE|SPEFSCR_FUNFE|SPEFSCR_FOVFE)
>=20
> Yep, with the proper #ifdef CONFIG_ protection.

OK, I got your point.

B.R.
Ebony
