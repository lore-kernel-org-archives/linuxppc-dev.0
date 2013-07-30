Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/4 v6] powerpc: export debug registers save function for
 KVM
In-reply-to: <8F1AA8FF-5428-4978-B847-B89A581E1B28@suse.de>
References: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1372921067-19678-2-git-send-email-Bharat.Bhushan@freescale.com>
 <8F1AA8FF-5428-4978-B847-B89A581E1B28@suse.de>
Date: Tue, 30 Jul 2013 12:42:46 +1000
Message-ID: <28333.1375152166@ale.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 =?windows-1252?Q?=22=93tiejun=2Echen=94_Chen=22?= <tiejun.chen@windriver.com>,
 Bharat Bhushan <r65777@freescale.com>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> wrote:

> 
> On 04.07.2013, at 08:57, Bharat Bhushan wrote:
> 
> > KVM need this function when switching from vcpu to user-space
> > thread. My subsequent patch will use this function.
> > 
> > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> 
> Ben / Michael, please ack.

It's not really my area of expertise, but it applies and compiles for me
and it's relatively simple, so FWIW...

Acked-by: Michael Neuling <mikey@neuling.org>

> 
> 
> Alex
> 
> > ---
> > v5->v6
> > - switch_booke_debug_regs() not guarded by the compiler switch
> > 
> > arch/powerpc/include/asm/switch_to.h |    1 +
> > arch/powerpc/kernel/process.c        |    3 ++-
> > 2 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> > index 200d763..db68f1d 100644
> > --- a/arch/powerpc/include/asm/switch_to.h
> > +++ b/arch/powerpc/include/asm/switch_to.h
> > @@ -29,6 +29,7 @@ extern void giveup_vsx(struct task_struct *);
> > extern void enable_kernel_spe(void);
> > extern void giveup_spe(struct task_struct *);
> > extern void load_up_spe(struct task_struct *);
> > +extern void switch_booke_debug_regs(struct thread_struct *new_thread);
> > 
> > #ifndef CONFIG_SMP
> > extern void discard_lazy_cpu_state(void);
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 01ff496..da586aa 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -362,12 +362,13 @@ static void prime_debug_regs(struct thread_struct *thread)
> >  * debug registers, set the debug registers from the values
> >  * stored in the new thread.
> >  */
> > -static void switch_booke_debug_regs(struct thread_struct *new_thread)
> > +void switch_booke_debug_regs(struct thread_struct *new_thread)
> > {
> > 	if ((current->thread.debug.dbcr0 & DBCR0_IDM)
> > 		|| (new_thread->debug.dbcr0 & DBCR0_IDM))
> > 			prime_debug_regs(new_thread);
> > }
> > +EXPORT_SYMBOL_GPL(switch_booke_debug_regs);
> > #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
> > #ifndef CONFIG_HAVE_HW_BREAKPOINT
> > static void set_debug_reg_defaults(struct thread_struct *thread)
> > -- 
> > 1.7.0.4
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
