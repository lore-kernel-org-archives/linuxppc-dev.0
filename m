Return-Path: <kumar.gala@freescale.com>
Received: from motgate2.mot.com (motgate2.mot.com [144.189.100.101])
	by ozlabs.org (Postfix) with ESMTP id D8B972BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Nov 2004 04:27:34 +1100 (EST)
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate2.mot.com (8.12.11/Motgate2) with ESMTP id iA1HUexv000128
	for <linuxppc-embedded@ozlabs.org>; Mon, 1 Nov 2004 10:30:40 -0700 (MST)
In-Reply-To: <ED6D9FBD-2C27-11D9-801F-000393C30512@freescale.com>
References: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
	<0329659A-2BC9-11D9-A949-000393DBC2E8@freescale.com>
	<ED6D9FBD-2C27-11D9-801F-000393C30512@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4B79D05E-2C2B-11D9-8819-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 1 Nov 2004 11:27:24 -0600
To: "Fleming Andy-afleming" <afleming@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RFC: performance monitor/oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 1, 2004, at 11:03 AM, Fleming Andy-afleming wrote:

> Well, it looks like I messed up the patch, and included some stuff I'm
> working on for generalizing the PHY interface.=A0 Strange, because I
> thought I had hand-inspected that patch...=A0 Ah, I see: I copied the
> wrong patch, which was done against linux-2.6, rather than my internal
> tree.=A0 Please ignore the patch, since much of that code is obsolete.
>
> Anyway, I will respond to Kumar's comments, and have attached the
> CORRECT patch:
>
> On Oct 31, 2004, at 23:43, Kumar Gala wrote:
>
> > Andy,
>  >
>  > Some feedback:
>  >
>  > * Any reason to get ride of the 604 code now,w/o replacing it with
> > something?
>
> Well, it doesn't really do much, and I was told that no one was using
> it.=A0 If people want, I can add it back.
>
> > * Why have you introduce two CPU features (CPU_FTR_CAN_USE_PMON_INTR=20=

> &
> > CPU_FTR_FSL_BOOKE_PMON) you dont use ?
>
> Ah, this is for the near future, when I implement support for 74xx
> processors.=A0 The non-Freescale-Book-E parts use a different perfmon
> scheme, and I wanted a way to distinguish.=A0 It may not be useful,
> though, I agree, since I am using CONFIG_FSL_BOOKE to do this.=A0
> CAN_USE_PMON_INTR is important, though, to detect the errata which
> could send the processor into never-neverland.=A0 Eventually, some =
74xx
> processors will have this bit set, while some will not.

Ok, add this when you add the code, not before then.

> > * In the PerformanceMonitor can't you use regs->nip for the same
> > purpose of regs->sia?
>
> Hmmm.... somehow I missed this when I was looking for a way to get the
> sampled address.=A0 I will change this if no one thinks of a good =
reason
> to do otherwise.
>
> > * Does arch/ppc/kernel/perfmon.c really need all the headers you are
> > including?
>
> Probably not.=A0 Does anyone know an easy way to determine which =
headers
>  are needed?
>
> > * Does perfmon.c make more sense as perfmon_fsl_booke.c
>
> Well, I thought about that, but I figured that it was ok to put all of
> the code into one file, and use #ifdef to distinguish.=A0 I'm willing =
to
> divide it into two (one for FSL booke, and one for classic), though.

Unless there is a fair amount of shared code, I would recommend=20
separating the files. We are not going to have a single kernel image=20
that supports both book-e and classic PPC so we can make this a=20
compile/makefile decision instead of #ifdef'd.

> > * op_ppc32_setup, I'd prefer the saving & restoring of the perf_irq
> > like arch/ppc64/oprofile/common.c does
>
> Well, does this really make sense?=A0 If one driver grabs the =
interrupt,
> and a subsequent driver tries to grab it, do we want the second driver
> to win, but nicely restore the handler later, or do we want the second
> driver to fail, and give the user the chance to disable the other
> driver?=A0 I definitely won't use the method in ppc64, since that =
isn't
> thread-safe if more than one driver wants the perfmon interrupt.

Hmm, ok.  I'm not sure what we should do here.  Maybe others have some=20=

comments.

> > * a number of issues related to SMP
>
> I admit, I haven't carefully worked this out, as there aren't any SMP
> e500 systems out there.

True, but if you are going share infrastructure with PPC classic, there=20=

are a number of SMP systems there.

[snip]

- kumar=
