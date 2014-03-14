Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8303F2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 10:02:03 +1100 (EST)
Message-ID: <1394838105.12479.144.camel@snotra.buserror.net>
Subject: Re: [PATCH 8/9] powerpc/85xx: add save/restore functions for core
 registers
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Fri, 14 Mar 2014 18:01:45 -0500
In-Reply-To: <20140312094237.GG4706@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-8-git-send-email-chenhui.zhao@freescale.com>
 <1394585114.13761.112.camel@snotra.buserror.net>
 <20140312094237.GG4706@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com, Wang Dongsheng-B40534 <B40534@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 17:42 +0800, Chenhui Zhao wrote:
> On Tue, Mar 11, 2014 at 07:45:14PM -0500, Scott Wood wrote:
> > On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > 
> > > Add booke_cpu_state_save() and booke_cpu_state_restore() functions which can be
> > > used to save/restore CPU's registers in the case of deep sleep and hibernation.
> > > 
> > > Supported processors: E6500, E5500, E500MC, E500v2 and E500v1.
> > > 
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > > ---
> > >  arch/powerpc/include/asm/booke_save_regs.h |   96 ++++++++
> > >  arch/powerpc/kernel/Makefile               |    1 +
> > >  arch/powerpc/kernel/booke_save_regs.S      |  361 ++++++++++++++++++++++++++++
> > >  3 files changed, 458 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/powerpc/include/asm/booke_save_regs.h
> > >  create mode 100644 arch/powerpc/kernel/booke_save_regs.S
> > > 
> > > diff --git a/arch/powerpc/include/asm/booke_save_regs.h b/arch/powerpc/include/asm/booke_save_regs.h
> > > new file mode 100644
> > > index 0000000..87c357a
> > > --- /dev/null
> > > +++ b/arch/powerpc/include/asm/booke_save_regs.h
> > > @@ -0,0 +1,96 @@
> > > +/*
> > > + *  Save/restore e500 series core registers
> > 
> > Filename says booke, comment says e500.
> > 
> > Filename and comment also fail to point out that this is specifically
> > for standby/suspend, not for hibernate which is implemented in
> > swsusp_booke.S/swsusp_asm64.S.
> 
> Sorry for inconsistency. Will changes e500 to booke.
> Hibernation and suspend can share the code.

Maybe they could, but AFAICT this patchset doesn't make that happen --
and I'm not convinced that the churn would be worthwhile.  Note that
swsusp_asm64.S is not just for booke, so most of that file would not be
going away if you did make such a change.

I also don't like the way it looks like booke_save_regs.S is a booke
version of ppc_save_regs.S, even though they serve different purposes
and ppc_save_regs.S is still relevant to booke.

> > > + * Software-Use Registers
> > > + *	SPRG1			0x260		(dw * 76), 64-bit need to save.
> > > + *	SPRG3			0x268		(dw * 77), 32-bit need to save.
> > 
> > What about "CPU and NUMA node for VDSO getcpu" on 64-bit?  Currently
> > SPRG3, but it will need to change for critical interrupt support.
> > 
> > > + * MMU Registers
> > > + *	PID0 - PID2		0x270 ~ 0x280	(dw * 78 ~ dw * 80)
> > 
> > PID1/PID2 are e500v1/v2 only -- and Linux doesn't use them outside of
> > KVM (and you're not in KVM when you're running this code).
> > 
> > Are we ever going to have a non-zero PID at this point?
> 
> I incline to the view that saving all registers regardless of used or
> unused. The good point is that it can be compliant to the future
> changes of the usage of registers.
> 
> What do you think?

I agree to a certain extent, but balance it with the complexity of
dealing with registers that don't exist on all booke chips.  If they
don't really need to be saved, why go through the hassle of conditional
code?

> > > + * Debug Registers
> > > + *	DBCR0 - DBCR2		0x288 ~ 0x298	(dw * 81 ~ dw * 83)
> > > + *	IAC1 - IAC4		0x2a0 ~ 0x2b8	(dw * 84 ~ dw * 87)
> > > + *	DAC1 - DAC2		0x2c0 ~ 0x2c8	(dw * 88 ~ dw * 89)
> > > + *
> > > + */
> > 
> > IAC3-4 are not implemented on e500.
> > 
> > Do we really need to save the debug registers?  We're not going to be in
> > a debugged process when we do suspend.  If the concern is kgdb, it
> > probably needs to be told to get out of the way during suspend for other
> > reasons.
> 
> I think in the ideal case the suspend would not break any context. We
> should try to save/restore all cpu state. Of cause, trade-off is
> unavoidable in practice.
> 
> > 
> > > +#define SR_GPR1			0x000
> > > +#define SR_GPR2			0x008
> > > +#define SR_GPR13		0x010
> > > +#define SR_FPR14		0x0a8
> > > +#define SR_CR			0x138
> > > +#define SR_LR			0x140
> > > +#define SR_MSR			0x148
> > 
> > These are very vague names to be putting in a header file.
> 
> How about BOOKE_xx_OFFSET?

Better, but does it need to be in a public header file at all?
 
> > > +/*
> > > + * hibernation and deepsleep save/restore different number of registers,
> > > + * use these flags to indicate.
> > > + */
> > > +#define HIBERNATION_FLAG	1
> > > +#define DEEPSLEEP_FLAG		2
> > 
> > Again, namespacing -- but why is hibernation using this at all?  What's
> > wrong with the existing hibernation support?
> 
> How about BOOKE_HIBERNATION_FLAG?
> 
> Just wish to share code between hibernation and suspend.

No need until and unless you actually implement the change for
hibernation to use this.  As is, this is dead and untestable code.
 
> > > +booke_cpu_append_save:
> > > +	mfspr	r0, SPRN_PVR
> > > +	rlwinm	r11, r0, 16, 16, 31
> > > +
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E6500@l
> > > +	cmpw	r11, r12
> > > +	beq	e6500_append_save
> > > +
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E5500@l
> > > +	cmpw	r11, r12
> > > +	beq	e5500_append_save
> > > +
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E500MC@l
> > > +	cmpw	r11, r12
> > > +	beq	e500mc_append_save
> > > +
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E500V2@l
> > > +	cmpw	r11, r12
> > > +	beq	e500v2_append_save
> > > +
> > > +	lis	r12, 0
> > > +	ori	r12, r12, PVR_VER_E500V1@l
> > > +	cmpw	r11, r12
> > > +	beq	e500v1_append_save
> > > +	b	1f
> > > +
> > > +e6500_append_save:
> > > +	do_e6500_sr_interrupt_regs(save)
> > > +	do_e6500_sr_debug_regs(save)
> > > +	b	1f
> > > +
> > > +e5500_append_save:
> > > +	do_e5500_sr_interrupt_regs(save)
> > > +	b	1f
> > > +
> > > +e500mc_append_save:
> > > +	do_e500mc_sr_interrupt_regs(save)
> > > +	b	1f
> > > +
> > > +e500v2_append_save:
> > > +e500v1_append_save:
> > > +	do_e500_sr_interrupt_regs(save)
> > > +1:
> > > +	do_sr_interrupt_regs(save)
> > > +	do_sr_debug_regs(save)
> > > +
> > > +	blr
> > 
> > What is meant by "append" here?
> 
> Means extra registers for specific e500 derivative core.

How is that related to skipping it in the hibernation case?
 
-Scott
