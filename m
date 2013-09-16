Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7685A2C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 07:02:49 +1000 (EST)
Message-ID: <1379365336.2536.166.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Mon, 16 Sep 2013 16:02:16 -0500
In-Reply-To: <52329CDF.9020103@c-s.fr>
References: <201309121825.r8CIPrkI005690@localhost.localdomain>
 <1379011469.2536.45.camel@snotra.buserror.net> <52329CDF.9020103@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-13 at 07:04 +0200, leroy christophe wrote:
> Le 12/09/2013 20:44, Scott Wood a =C3=A9crit :
> > On Thu, 2013-09-12 at 20:25 +0200, Christophe Leroy wrote:
> >> This is a reorganisation of the setup of the TLB at kernel startup, =
in order
> >> to handle the CONFIG_PIN_TLB case in accordance with chapter 8.10.3 =
of MPC866
> >> and MPC885 reference manuals.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/ar=
ch/powerpc/kernel/head_8xx.S
> >> --- linux-3.11.org/arch/powerpc/kernel/head_8xx.S	2013-09-02 22:46:1=
0.000000000 +0200
> >> +++ linux-3.11/arch/powerpc/kernel/head_8xx.S	2013-09-09 11:28:54.00=
0000000 +0200
> >> @@ -785,27 +785,24 @@
> >>    * these mappings is mapped by page tables.
> >>    */
> >>   initial_mmu:
> >> -	tlbia			/* Invalidate all TLB entries */
> >> -/* Always pin the first 8 MB ITLB to prevent ITLB
> >> -   misses while mucking around with SRR0/SRR1 in asm
> >> -*/
> >> -	lis	r8, MI_RSV4I@h
> >> -	ori	r8, r8, 0x1c00
> >> -
> >> +	lis	r8, MI_RESETVAL@h
> >>   	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> >>  =20
> >> -#ifdef CONFIG_PIN_TLB
> >> -	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
> >> -	ori	r10, r10, 0x1c00
> >> -	mr	r8, r10
> >> -#else
> >>   	lis	r10, MD_RESETVAL@h
> >> -#endif
> >>   #ifndef CONFIG_8xx_COPYBACK
> >>   	oris	r10, r10, MD_WTDEF@h
> >>   #endif
> >>   	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
> >>  =20
> >> +	tlbia			/* Invalidate all TLB entries */
> > Is this change to make sure we invalidate everything even if the
> > bootloader set RSV4I?
> Most probably. It is step 2 of the process defined in MPC866 and MPC885=
=20
> Reference Manuals:
>=20
> =C2=A78.10.3 Loading Locked TLB Entries:
> The process of loading a single reserved entry in the TLB is as follows=
:

To minimize code churn we should just fix actual problems, rather than
shuffle things around to conform to a suggested sequence.  After all,
we're not just trying to load a single entry.

> >> +	ori	r8, r8, 0x1c00
> >> +	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> >> +#ifdef CONFIG_PIN_TLB
> >> +	ori	r10, r10, 0x1c00
> >> +	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
> >> +#endif
> > Still 0x1c00?
> Yes, I kept the same entries in order to limit modifications:
> * 28 =3D First 8Mbytes page
> * 29 =3D IMMR
> * 30 =3D Second 8Mbytes page
> * 31 =3D Third 8Mbytes page

If you actually want to program them in increasing order then it looks
like you're still missing a write to CTR between the last two 8M entries
-- thus you'll overwrite the IMMR with the last 8M entry.  That was the
same problem that v1 fixed -- did that change get lost accidentally?

The hardware wants to decrement; why fight it?

> >>   	/* Now map the lower 8 Meg into the TLBs.  For this quick hack,
> >>   	 * we can load the instruction and data TLB registers with the
> >>   	 * same values.
> >> @@ -825,6 +822,12 @@
> >>   	mtspr	SPRN_MI_AP, r8
> >>   	mtspr	SPRN_MD_AP, r8
> >>  =20
> >> +	/* Always pin the first 8 MB ITLB to prevent ITLB
> >> +	 * misses while mucking around with SRR0/SRR1 in asm
> >> +	 */
> >> +	lis	r8, (MI_RSV4I | MI_RESETVAL)@h
> >> +	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> > Entry 0 is not pinnable.
> Here we are not trying to pin entry 0.

Sorry, misread the patch.

> We are at step 8, we are setting=20
> MI_RSV4I. At the same time, we set MD_CTR to 0 which is off the pinned=20
> range, to be sure that we won't overwrite one of the pinned entries.
>
> The main difference compared to the previous implementation is that=20
> before, we were setting the RSV4I bit before loading the TLB entries.=20
> Now, as defined in the Reference Manuals, we are doing it at the end.

Have you seen any evidence that it matters?

-Scott
