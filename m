Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C63D3B6FFF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 21:16:24 +1000 (EST)
Subject: Re: [PATCH 03/13] kvm/powerpc: Fix the build for 32-bit Book 3S
	(classic) processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <C5B8A119-56B6-467C-B3BD-01D5D7FA0773@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511103950.GD2837@brick.ozlabs.ibm.com>
	<C5B8A119-56B6-467C-B3BD-01D5D7FA0773@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 21:16:19 +1000
Message-ID: <1305198979.29820.102.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-12 at 11:33 +0200, Alexander Graf wrote:
> Am 11.05.2011 um 12:39 schrieb Paul Mackerras <paulus@samba.org>:
> 
> > Commits a5d4f3ad3a ("powerpc: Base support for exceptions using
> > HSRR0/1") and 673b189a2e ("powerpc: Always use SPRN_SPRG_HSCRATCH0
> > when running in HV mode") cause compile and link errors for 32-bit
> > classic Book 3S processors when KVM is enabled.  This fixes these
> > errors.
> > 
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > ---
> > arch/powerpc/include/asm/reg.h       |    5 +++++
> > arch/powerpc/kvm/book3s_rmhandlers.S |    2 ++
> > 2 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 47e3416..05658b7 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -823,6 +823,11 @@
> >    FTR_SECTION_ELSE_NESTED(66);            \
> >    mtspr    SPRN_SPRG_HSCRATCH0,rX;            \
> >    ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
> > +
> > +#else /* CONFIG_PPC_BOOK3S_64 */
> > +#define GET_SCRATCH0(rX)    mfspr    rX,SPRN_SPRG_SCRATCH0
> > +#define SET_SCRATCH0(rX)    mtspr    SPRN_SPRG_SCRATCH0,rX
> > +
> > #endif
> > 
> > #ifdef CONFIG_PPC_BOOK3E_64
> > diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
> > index ae99af6..1a1b344 100644
> > --- a/arch/powerpc/kvm/book3s_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
> > @@ -112,7 +112,9 @@ INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_MACHINE_CHECK
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_DATA_STORAGE
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_INST_STORAGE
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL_HV
> 
> Hrm - I don't remember putting this one here. When did it get into the tree and why wasn't I CC'ed?

Because I did and I forgot :-)

The patch in question only marginally touched kvm, it's one in a series
that rework of the ppc64 exception vectors to better operate on modern
CPUs running in HV mode (deal with HSRR's vs SRR's etc...) and it needed
a small fixup to the KVM code due to 0x500 becoming "H" interrupts
(using HSRR's) on these.

Unfortunately, it looks like I didn't have KVM enabled in any of my
32-bit test configs and missed that little breakage.

I should have CCed you I suppose, I simply forgot as it wasn't primarily
a KVM related patch.

Cheers,
Ben.
