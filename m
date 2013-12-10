Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E86A82C0302
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:19:08 +1100 (EST)
Message-ID: <1386717537.10013.150.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Tue, 10 Dec 2013 17:18:57 -0600
In-Reply-To: <52A79E31.9070304@c-s.fr>
References: <20131210112945.E4E311A2BF3@localhost.localdomain>
 <1386714253.10013.123.camel@snotra.buserror.net> <52A79E31.9070304@c-s.fr>
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

On Wed, 2013-12-11 at 00:05 +0100, leroy christophe wrote:
> Le 10/12/2013 23:24, Scott Wood a =C3=A9crit :
> > On Tue, 2013-12-10 at 12:29 +0100, Christophe Leroy wrote:
> >> Today, the only way to load kernels whose size is greater than 8Mbyt=
es is to
> >> activate CONFIG_PIN_TLB. Otherwise, the physical memory initially ma=
pped is
> >> limited to 8Mbytes. This patch adds the capability to select the siz=
e of initial
> >> memory between 8/16/24 Mbytes and this is regardless of whether CONF=
IG_PIN_TLB
> >> is active or not. It allows to load "big" kernels (for instance when=
 activating
> >> CONFIG_LOCKDEP_SUPPORT) without having to activate CONFIG_PIN_TLB.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> diff -ur a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -980,6 +980,29 @@
> >>   config PIN_TLB
> >>   	bool "Pinned Kernel TLBs (860 ONLY)"
> >>   	depends on ADVANCED_OPTIONS && 8xx
> >> +
> >> +choice
> >> +	prompt "Initial Data Memory Mapped on 8xx"
> >> +	default 8xx_MAP_8M
> >> +	depends on ADVANCED_OPTIONS && 8xx
> >> +
> >> +config	8xx_INIT_MAP_8M
> >> +	bool "8 Mbytes"
> >> +
> >> +config	8xx_INIT_MAP_16M
> >> +	bool "16 Mbytes"
> >> +
> >> +config	8xx_INIT_MAP_24M
> >> +	bool "24 Mbytes"
> > Are you working with a loader that passes initial-mapped-area size in=
 r7
> > as per ePAPR?  If so, we could rely on that at runtime.  If you're us=
ing
> > a non-ancient U-Boot, it should qualify here even if it's not fully
> > ePAPR compliant (it passes the value of the bootm_mapsize variable in
> > r7).
> Ok, let me check that. But it means that the size of the kernel I can=20
> boot will depend on the initial memory mapped by uboot ? Isn't it=20
> limitating ?

The ePAPR IMA is supposed to be large enough to include the OS image,
device tree, etc.

> Even if uboot only maps 8Mbytes, why couldn't I be allowed to boot a=20
> kernel having 10 Mbytes data if I have 32 Mbytes mem on the board ?
> I don't like the idea of having to change the bootloader just because I=
=20
> want to activate CONFIG_LOCKDEP to debug my kernel.

Well, as noted, if you're using a non-ancient U-Boot you shouldn't have
to change anything because it already implements r7.  Now, the value of
r7 it passes might be a lie as far as ePAPR is concerned, since it's
supposed to represent what's actually mapped, but that's another matter.

Even fixing that wouldn't mean you have to change U-Boot every time the
kernel size changes; you'd just set it to something reasonable and be
done with it.  I'm not fond of adding kconfigs to hack around a problem
that has already been addressed in the standard that governs the PPC
boot process that U-Boot claims to implement.

> >> -#ifdef CONFIG_PIN_TLB
> >> +#if defined (CONFIG_8xx_INIT_MAP_16M) || defined (CONFIG_8xx_INIT_M=
AP_24M)
> >>   	/* Map two more 8M kernel data pages.
> >>   	*/
> >> +#ifdef CONFIG_PIN_TLB
> >>   	addi	r10, r10, 0x0100
> >>   	mtspr	SPRN_MD_CTR, r10
> >> +#endif
> >>  =20
> >>   	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
> >>   	addis	r8, r8, 0x0080		/* Add 8M */
> >> @@ -858,15 +860,19 @@
> >>   	addis	r11, r11, 0x0080	/* Add 8M */
> >>   	mtspr	SPRN_MD_RPN, r11
> >>  =20
> >> +#ifdef CONFIG_8xx_INIT_MAP_24M
> >> +#ifdef CONFIG_PIN_TLB
> >>   	addi	r10, r10, 0x0100
> >>   	mtspr	SPRN_MD_CTR, r10
> >> +#endif
> > Are these ifdefs for CONFIG_PIN_TLB really needed?  It shouldn't harm
> > anything to use those entries even if they're not being pinned.
>=20
> I'm not sure I understand your comment.
> ifdef for CONFIG_PIN_TLB was already there before, but was enclosing th=
e=20
> whole block, so 24 Mbytes were automatically mapped when you selected=20
> CONFIG_PIN_TLB and only 8 Mbytes were mapped when you didn't select=20
> CONFIG_PIN_TLB.
> I reduced the scope of those ifdefs so that they now apply on the=20
> pinning only.

There wasn't previously an ifdef specifically around the setting of
SPRN_MD_CTR.  That's new.  There was an ifdef around the entire block,
which has gone away because you are now trying to map more than 8M
regardless of CONFIG_PIN_TLB, but that has nothing to do with whether
there should be an ifdef around SPRN_MD_CTR.

-Scott
