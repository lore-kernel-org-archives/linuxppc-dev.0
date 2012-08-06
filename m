Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AD992C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 02:24:39 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/4] powerpc/booke: Merge the 32 bit e5500/e500mc cpu
 setup code.
Date: Mon, 6 Aug 2012 16:24:31 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D15BA25@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341838701-17089-1-git-send-email-Varun.Sethi@freescale.com>
 <27CB83E1-41F1-40E3-80A3-95D5B96D88B6@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D15ADB3@039-SN2MPN1-013.039d.mgd.msft.net>
 <D762F063-8210-41EF-B583-F277967EA279@kernel.crashing.org>
In-Reply-To: <D762F063-8210-41EF-B583-F277967EA279@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, August 06, 2012 9:28 PM
> To: Sethi Varun-B16395
> Cc: agraf@suse.de; benh@kernel.crashing.org; linuxppc-
> dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org
> Subject: Re: [PATCH 2/4] powerpc/booke: Merge the 32 bit e5500/e500mc cpu
> setup code.
>=20
>=20
> On Aug 4, 2012, at 1:31 PM, Sethi Varun-B16395 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, August 03, 2012 10:04 PM
> >> To: Sethi Varun-B16395
> >> Cc: agraf@suse.de; benh@kernel.crashing.org; linuxppc-
> >> dev@lists.ozlabs.org; kvm-ppc@vger.kernel.org
> >> Subject: Re: [PATCH 2/4] powerpc/booke: Merge the 32 bit e5500/e500mc
> >> cpu setup code.
> >>
> >>
> >> On Jul 9, 2012, at 7:58 AM, Varun Sethi wrote:
> >>
> >>> Merge the 32 bit cpu setup code for e500mc/e5500 and define the
> >> "cpu_restore"
> >>> routine (for e5500/e6500) only for the 64 bit case. The cpu_restore
> >>> routine is used in the 64 bit case for setting up the secondary
> cores.
> >>>
> >>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> >>> ---
> >>> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    1 +
> >>> arch/powerpc/kernel/cputable.c            |    4 ++++
> >>> 2 files changed, 5 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> >>> b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> >>> index a55d028..5e87737 100644
> >>> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> >>> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> >>> @@ -75,6 +75,7 @@ _GLOBAL(__setup_cpu_e500v2)
> >>> 	mtlr	r4
> >>> 	blr
> >>> _GLOBAL(__setup_cpu_e500mc)
> >>> +_GLOBAL(__setup_cpu_e5500)
> >>
> >> This is a bit confusing, as we now have duplicated
> >> __setup_cpu_e5500() between the ppc32 and ppc64 cases.
> >>
> >> If you build this patch for corenet32_smp_defconfig it fails.
> > [Sethi Varun-B16395] I am able to build without any issue with the same
> config.
> >
> > -Varun
>=20
> If you build corenet32_smp_defconfig at commit:
>=20
> commit c5537ef2d672d2cf48d4e4ac754781c8db112843
> Author: Varun Sethi <Varun.Sethi@freescale.com>
> Date:   Mon Jul 9 18:28:21 2012 +0530
>=20
>     powerpc/booke: Merge the 32 bit e5500/e500mc cpu setup code.
>=20
> You get the following build error:
>=20
> arch/powerpc/kernel/cpu_setup_fsl_booke.S: Assembler messages:
> arch/powerpc/kernel/cpu_setup_fsl_booke.S:110: Error: symbol
> `__setup_cpu_e5500' is already defined
>=20
Oh.., didn't realize that. Thanks for fixing this.

-Varun
