Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1BD52C0196
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 07:22:39 +1000 (EST)
Message-ID: <1379712141.16231.36.camel@aoeu.buserror.net>
Subject: Re: [PATCH v2] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Fri, 20 Sep 2013 16:22:21 -0500
In-Reply-To: <5238860F.4030405@c-s.fr>
References: <201309121825.r8CIPrkI005690@localhost.localdomain>
 <1379011469.2536.45.camel@snotra.buserror.net> <52329CDF.9020103@c-s.fr>
 <1379365336.2536.166.camel@snotra.buserror.net> <5238860F.4030405@c-s.fr>
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

On Tue, 2013-09-17 at 18:40 +0200, leroy christophe wrote:
> Le 16/09/2013 23:02, Scott Wood a =C3=A9crit :
> > On Fri, 2013-09-13 at 07:04 +0200, leroy christophe wrote:
> >> Le 12/09/2013 20:44, Scott Wood a =C3=A9crit :
> >>> On Thu, 2013-09-12 at 20:25 +0200, Christophe Leroy wrote:
> >>>> This is a reorganisation of the setup of the TLB at kernel startup=
, in order
> >>>> to handle the CONFIG_PIN_TLB case in accordance with chapter 8.10.=
3 of MPC866
> >>>> and MPC885 reference manuals.
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>>
> >>>> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/=
arch/powerpc/kernel/head_8xx.S
> >>>> --- linux-3.11.org/arch/powerpc/kernel/head_8xx.S	2013-09-02 22:46=
:10.000000000 +0200
> >>>> +++ linux-3.11/arch/powerpc/kernel/head_8xx.S	2013-09-09 11:28:54.=
000000000 +0200
> >>>> @@ -785,27 +785,24 @@
> >>>>     * these mappings is mapped by page tables.
> >>>>     */
> >>>>    initial_mmu:
> >>>> -	tlbia			/* Invalidate all TLB entries */
> >>>> -/* Always pin the first 8 MB ITLB to prevent ITLB
> >>>> -   misses while mucking around with SRR0/SRR1 in asm
> >>>> -*/
> >>>> -	lis	r8, MI_RSV4I@h
> >>>> -	ori	r8, r8, 0x1c00
> >>>> -
> >>>> +	lis	r8, MI_RESETVAL@h
> >>>>    	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> >>>>   =20
> >>>> -#ifdef CONFIG_PIN_TLB
> >>>> -	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
> >>>> -	ori	r10, r10, 0x1c00
> >>>> -	mr	r8, r10
> >>>> -#else
> >>>>    	lis	r10, MD_RESETVAL@h
> >>>> -#endif
> >>>>    #ifndef CONFIG_8xx_COPYBACK
> >>>>    	oris	r10, r10, MD_WTDEF@h
> >>>>    #endif
> >>>>    	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
> >>>>   =20
> >>>> +	tlbia			/* Invalidate all TLB entries */
> >>> Is this change to make sure we invalidate everything even if the
> >>> bootloader set RSV4I?
> >> Most probably. It is step 2 of the process defined in MPC866 and MPC=
885
> >> Reference Manuals:
> >>
> >> =C2=A78.10.3 Loading Locked TLB Entries:
> >> The process of loading a single reserved entry in the TLB is as foll=
ows:
> > To minimize code churn we should just fix actual problems, rather tha=
n
> > shuffle things around to conform to a suggested sequence.  After all,
> > we're not just trying to load a single entry.
> Ok, I'll try again.
> >
> >>>> +	ori	r8, r8, 0x1c00
> >>>> +	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> >>>> +#ifdef CONFIG_PIN_TLB
> >>>> +	ori	r10, r10, 0x1c00
> >>>> +	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
> >>>> +#endif
> >>> Still 0x1c00?
> >> Yes, I kept the same entries in order to limit modifications:
> >> * 28 =3D First 8Mbytes page
> >> * 29 =3D IMMR
> >> * 30 =3D Second 8Mbytes page
> >> * 31 =3D Third 8Mbytes page
> > If you actually want to program them in increasing order then it look=
s
> > like you're still missing a write to CTR between the last two 8M entr=
ies
> > -- thus you'll overwrite the IMMR with the last 8M entry.  That was t=
he
> > same problem that v1 fixed -- did that change get lost accidentally?
> Oops, no, in fact I diffed from the version which was including it=20
> already. My mistake.
> >
> > The hardware wants to decrement; why fight it?
> I see your point.
> However it is not clear in the documentation if the decrement is done=20
> really after the update, or at xTLB interrupt. So I propose to still se=
t=20
> the CTR ourself as described in the reference Manual and not assume tha=
t=20
> the HW decrements it.

It says "every update" -- do you have any reason to believe that's
wrong?  It could be tested...

-Scott
