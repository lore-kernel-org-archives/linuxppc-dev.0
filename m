Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2E0EBDDEEC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 16:15:27 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l195FOwI002519
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 22:15:24 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l195FMrA000053
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 23:15:23 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 9 Feb 2007 13:15:21 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7F80@zch01exm20.fsl.freescale.net>
In-Reply-To: <3E83A767-0E8C-41E3-A9C7-A231CD841EAF@kernel.crashing.org>
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
> >>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/=20
> >>> kernel/head_fsl_booke.S index 66877bd..0d05db0 100644
> >>> --- a/arch/powerpc/kernel/head_fsl_booke.S
> >>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> >>> @@ -705,7 +705,7 @@ #else
> >>>  #endif /* CONFIG_SPE */
> >>>
> >>>  	/* SPE Floating Point Round */
> >>> -	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception,
> >>> EXC_XFER_EE)
> >>> +	EXCEPTION(0x2050, SPEFloatingPointRound,
> >>> SPEFloatingPointException_Round, EXC_XFER_EE)
> >>>
> >>>  	/* Performance Monitor */
> >>>  	EXCEPTION(0x2060, PerformanceMonitor,=20
> >>> performance_monitor_exception, EXC_XFER_STD) @@ -840,6 +840,8 @@=20
> >>> load_up_spe:
> >>>  	oris	r5,r5,MSR_SPE@h
> >>>  	mtmsr	r5			/* enable use of SPE now */
> >>>  	isync
> >>> +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE |
> >>> SPEFSCR_FOVFE)
> >>> +	mtspr   SPRN_SPEFSCR,r5
> >>
> >> We should do this via INIT_THREAD, is there a reason that=20
> you want to=20
> >> set these always?
> >
> > I just thought it's the first time that an SPE instruction is=20
> > encountered, so I enable the exceptions here.
>=20
> Lets do this via INIT_THREAD instead, its cleaner. (just=20
> remember to add the proper ifdef protection for SPE_IEEE

Talking about INIT_THREAD, I'm wondering where is the best place to
enble the exceptions? Please advice!

And also, I will put all of your other suggestions into next patches.
Thank you!

B.R.
Ebony
