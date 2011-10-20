Return-Path: <R65777@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 61A47B6F98
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2011 16:15:13 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
Date: Thu, 20 Oct 2011 05:14:44 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE6245098@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
 <B8D6CA50DACE9E4AAADE9A4D56FBAAE6244FDF@039-SN1MPN1-005.039d.mgd.msft.net>
 <C79C8827-F6FE-42E0-8FAF-E62A8FFD6A1F@kernel.crashing.org>
In-Reply-To: <C79C8827-F6FE-42E0-8FAF-E62A8FFD6A1F@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, October 20, 2011 9:32 AM
> To: Bhushan Bharat-R65777
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard
> SMP id
>=20
>=20
> On Oct 19, 2011, at 10:53 PM, Bhushan Bharat-R65777 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From:
> >> linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org
> >> [mailto:linuxppc-dev-
> >> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> >> bounces+Kumar
> >> Gala
> >> Sent: Friday, October 14, 2011 1:23 PM
> >> To: linuxppc-dev@ozlabs.org
> >> Subject: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard
> >> SMP id
> >>
> >> Normally logical and hard cpu ID are the same, however in same cases
> >> like on the P3060 they may differ.  Where the logical is 0..5, the
> >> hard id goes 0,1,4..7.  This can causes issues for places we utilize
> >> PIR to index into array like in debug exception handlers for finding
> >> the exception stack.
> >
> > Kumar, What should be the CONFIG_NR_CPUS for this? 8 or 6 ?
>=20
> 8.

Kumar, I am just trying to understand the impact of setting NR_CPUS =3D 8 w=
hile actual cpus are 6 only.

If I understood correctly, cpu_present, cpu_online are logical cpuid bit ma=
p. Also the PACA is allocated for nr_cpu_ids (NR_CPUS) and also indexed by =
logical cpuid. While they have knowledge of physical_cpuid.

So in this case last two entries of PACA will not be used or wasted?
I am not sure I am missing something here?

Thanks
-Bharat
