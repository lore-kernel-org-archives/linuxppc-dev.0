Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DF64EDDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 16:48:14 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l195mAhQ029513
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 22:48:11 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l195m8QH029635
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 23:48:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 9 Feb 2007 13:48:07 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7F8A@zch01exm20.fsl.freescale.net>
In-Reply-To: <8EEEA9ED-284B-4201-A8AD-18C3F2F10388@kernel.crashing.org>
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
> Sent: Friday, February 09, 2007 1:29 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc V2: Add the general support=20
> for Embedded Floating-Point instructions
>=20
>=20
> On Feb 8, 2007, at 11:15 PM, Zhu Ebony-r57400 wrote:
>=20
> >
> >>>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S=20
> b/arch/powerpc/=20
> >>>>> kernel/head_fsl_booke.S index 66877bd..0d05db0 100644
> >>>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
> >>>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> >>>>> @@ -705,7 +705,7 @@ #else
> >>>>>  #endif /* CONFIG_SPE */
> >>>>>
> >>>>>  	/* SPE Floating Point Round */
> >>>>> -	EXCEPTION(0x2050, SPEFloatingPointRound,=20
> unknown_exception,
> >>>>> EXC_XFER_EE)
> >>>>> +	EXCEPTION(0x2050, SPEFloatingPointRound,
> >>>>> SPEFloatingPointException_Round, EXC_XFER_EE)
> >>>>>
> >>>>>  	/* Performance Monitor */
> >>>>>  	EXCEPTION(0x2060, PerformanceMonitor,=20
> >>>>> performance_monitor_exception, EXC_XFER_STD) @@ -840,6 +840,8 @@
> >>>>> load_up_spe:
> >>>>>  	oris	r5,r5,MSR_SPE@h
> >>>>>  	mtmsr	r5			/* enable use=20
> of SPE now */
> >>>>>  	isync
> >>>>> +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE |=20
> SPEFSCR_FUNFE |
> >>>>> SPEFSCR_FOVFE)
> >>>>> +	mtspr   SPRN_SPEFSCR,r5
> >>>>
> >>>> We should do this via INIT_THREAD, is there a reason that
> >> you want to
> >>>> set these always?
> >>>
> >>> I just thought it's the first time that an SPE instruction is=20
> >>> encountered, so I enable the exceptions here.
> >>
> >> Lets do this via INIT_THREAD instead, its cleaner. (just=20
> remember to=20
> >> add the proper ifdef protection for SPE_IEEE
> >
> > Talking about INIT_THREAD, I'm wondering where is the best place to=20
> > enble the exceptions? Please advice!
>=20
> What's the issue with enabling via INIT_THREAD?  am I missing=20
> something?

Do you mean that add=20
".spefscr =3D SPEFSCR_FINV| SPEFSCR_FDBZE|SPEFSCR_FUNFE|SPEFSCR_FOVFE"
In the defination of INIT_THREAD?

I think it should work.
