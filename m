Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C6A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:56:45 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 22D99140B99
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:56:45 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id q129so4652672pfb.3
 for <linuxppc-dev@ozlabs.org>; Wed, 09 Mar 2016 16:56:45 -0800 (PST)
Date: Thu, 10 Mar 2016 11:56:32 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [PATCH 1/2] powerpc: Batch up loads/stores on saving and
 restoring Altivec
Message-ID: <20160310115632.14cf6a3a@camb691>
In-Reply-To: <1457564467.17010.1.camel@neuling.org>
References: <1456811735-1289-1-git-send-email-cyrilbur@gmail.com>
 <1457564467.17010.1.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Mar 2016 10:01:07 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On Tue, 2016-03-01 at 16:55 +1100, Cyril Bur wrote:
> 
> > Currently the assembly to save and restore Altivec registers boils down to
> > a load immediate of the offset of the specific Altivec register in memory
> > followed by the load/store which repeats in sequence for each Altivec
> > register.
> > 
> > This patch attempts to do better by loading up four registers with
> > immediates so that the loads and stores can be batched up and better
> > pipelined by the processor.
> > 
> > This patch results in four load/stores in sequence and one add between
> > groups of four. Also, by using a pair of base registers it means that the
> > result of the add is not needed by the following instruction.  
> 

Hi Mikey,

Thanks for the review.

> What the performance improvement?

Well the CPU instruction traces should look much nicer - this is something I'll
look at getting with this series applied. Currently the CPU isn't thrilled
about the order we're telling it to do things.

Good looking CPU execution traces are nice but we live in the real world.
Before I wrote this patch I thought I'd microbenchmark it in userspace
unfortunately I failed to get a reliably observable performance gain.

I'll run it through my battery of context switch performance scripts I used for
my other series (which have been developed since the userspace microbenchmark)
to see what happens but I have a hunch any gains here will be overshadowed by
something slower.

> 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> > These patches need to be applied on to of my rework of FPU/VMX/VSX
> > switching: https://patchwork.ozlabs.org/patch/589703/
> > 
> > I left in some of my comments indicating if functions are called from C or
> > not. Looking at them now, they might be a bit much, let me know what you
> > think.  
> 
> I think that's ok, although they are likely to get stale quickly.
> 
> > 
> > Tested 64 bit BE and LE under KVM, not sure how I can test 32bit.
> > 
> > 
> >  arch/powerpc/include/asm/ppc_asm.h | 63 ++++++++++++++++++++++++++++++--------
> >  arch/powerpc/kernel/tm.S           |  6 ++--
> >  arch/powerpc/kernel/vector.S       | 20 +++++++++---
> >  3 files changed, 70 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> > index 499d9f8..5ba69ed 100644
> > --- a/arch/powerpc/include/asm/ppc_asm.h
> > +++ b/arch/powerpc/include/asm/ppc_asm.h
> > @@ -110,18 +110,57 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
> >  #define REST_16FPRS(n, base)  	  REST_8FPRS(n, base); REST_8FPRS(n+8, base)
> >  #define REST_32FPRS(n, base)  	  REST_16FPRS(n, base); REST_16FPRS(n+16, base)
> >  
> > -#define SAVE_VR(n,b,base)  	  li b,16*(n);  stvx n,base,b
> > -#define SAVE_2VRS(n,b,base)  	  SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
> > -#define SAVE_4VRS(n,b,base)  	  SAVE_2VRS(n,b,base); SAVE_2VRS(n+2,b,base)
> > -#define SAVE_8VRS(n,b,base)  	  SAVE_4VRS(n,b,base); SAVE_4VRS(n+4,b,base)
> > -#define SAVE_16VRS(n,b,base)  	  SAVE_8VRS(n,b,base); SAVE_8VRS(n+8,b,base)
> > -#define SAVE_32VRS(n,b,base)  	  SAVE_16VRS(n,b,base); SAVE_16VRS(n+16,b,base)
> > -#define REST_VR(n,b,base)  	  li b,16*(n); lvx n,base,b
> > -#define REST_2VRS(n,b,base)  	  REST_VR(n,b,base); REST_VR(n+1,b,base)
> > -#define REST_4VRS(n,b,base)  	  REST_2VRS(n,b,base); REST_2VRS(n+2,b,base)
> > -#define REST_8VRS(n,b,base)  	  REST_4VRS(n,b,base); REST_4VRS(n+4,b,base)
> > -#define REST_16VRS(n,b,base)  	  REST_8VRS(n,b,base); REST_8VRS(n+8,b,base)
> > -#define REST_32VRS(n,b,base)  	  REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)  
> 
> Can you use consistent names between off and reg? in the below
> 

Sure.

> > +#define __SAVE_4VRS(n,off0,off1,off2,off3,base) \
> > +  	  stvx n,base,off0; \
> > +  	  stvx n+1,base,off1; \
> > +  	  stvx n+2,base,off2; \
> > +  	  stvx n+3,base,off3
> > +
> > +/* Restores the base for the caller */  
> 
> Can you make this:
> /* Base: non-volatile, reg[0-4]: volatile */
> 

Ah yes

> > +#define SAVE_32VRS(reg0,reg1,reg2,reg3,reg4,base) \
> > +  	  addi reg4,base,64; \
> > +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> > +  	  __SAVE_4VRS(0,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __SAVE_4VRS(4,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __SAVE_4VRS(8,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __SAVE_4VRS(12,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __SAVE_4VRS(16,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __SAVE_4VRS(20,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __SAVE_4VRS(24,reg0,reg1,reg2,reg3,base); \
> > +  	  __SAVE_4VRS(28,reg0,reg1,reg2,reg3,reg4); \
> > +  	  subi base,base,384  
> 
> You can swap these last two lines which will make base reuse quicker
> later.  Although that might not be needed.
> 

Can't hurt! I'm not sure the base gets reused that fast in most paths but hey,
we're in the business of optimising here.

> > +#define __REST_4VRS(n,off0,off1,off2,off3,base) \
> > +  	  lvx n,base,off0; \
> > +  	  lvx n+1,base,off1; \
> > +  	  lvx n+2,base,off2; \
> > +  	  lvx n+3,base,off3
> > +
> > +/* Restores the base for the caller */
> > +#define REST_32VRS(reg0,reg1,reg2,reg3,reg4,base) \
> > +  	  addi reg4,base,64; \
> > +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> > +  	  __REST_4VRS(0,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __REST_4VRS(4,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __REST_4VRS(8,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __REST_4VRS(12,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __REST_4VRS(16,reg0,reg1,reg2,reg3,base); \
> > +  	  addi base,base,128; \
> > +  	  __REST_4VRS(20,reg0,reg1,reg2,reg3,reg4); \
> > +  	  addi reg4,reg4,128; \
> > +  	  __REST_4VRS(24,reg0,reg1,reg2,reg3,base); \
> > +  	  __REST_4VRS(28,reg0,reg1,reg2,reg3,reg4); \
> > +  	  subi base,base,384
> >  
> >  #ifdef __BIG_ENDIAN__
> >  #define STXVD2X_ROT(n,b,base)  	  	> STXVD2X(n,b,base)
> > diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> > index bf8f34a..81e1305 100644
> > --- a/arch/powerpc/kernel/tm.S
> > +++ b/arch/powerpc/kernel/tm.S
> > @@ -96,6 +96,8 @@ _GLOBAL(tm_abort)
> >   * they will abort back to the checkpointed state we save out here.
> >   *
> >   * Call with IRQs off, stacks get all out of sync for some periods in here!
> > + *
> > + * Is called from C
> >   */
> >  _GLOBAL(tm_reclaim)
> >    	  mfcr  	  r6
> > @@ -151,7 +153,7 @@ _GLOBAL(tm_reclaim)
> >    	  beq  	  dont_backup_vec
> >  
> >    	  addi  	  r7, r3, THREAD_TRANSACT_VRSTATE
> > -  	  SAVE_32VRS(0, r6, r7)  	  /* r6 scratch, r7 transact vr state */
> > +  	  SAVE_32VRS(r6,r8,r9,r10,r11,r7)  	  /* r6,r8,r9,r10,r11 scratch, r7 transact vr state */  
> 
> Line wrapping here.
> 

Thanks

> >    	  mfvscr  	  v0
> >    	  li  	  r6, VRSTATE_VSCR
> >    	  stvx  	  v0, r7, r6
> > @@ -361,7 +363,7 @@ _GLOBAL(__tm_recheckpoint)
> >    	  li  	  r5, VRSTATE_VSCR
> >    	  lvx  	  v0, r8, r5
> >    	  mtvscr  	  v0
> > -  	  REST_32VRS(0, r5, r8)  	  	  	  /* r5 scratch, r8 ptr */
> > +  	  REST_32VRS(r5,r6,r9,r10,r11,r8)  	  	  	  /* r5,r6,r9,r10,r11 scratch, r8 ptr */  
> 
> wrapping here too
> 

Thanks

> 
> >  dont_restore_vec:
> >    	  ld  	  r5, THREAD_VRSAVE(r3)
> >    	  mtspr  	  SPRN_VRSAVE, r5
> > diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> > index 1c2e7a3..8d587fb 100644
> > --- a/arch/powerpc/kernel/vector.S
> > +++ b/arch/powerpc/kernel/vector.S
> > @@ -13,6 +13,8 @@
> >   * This is similar to load_up_altivec but for the transactional version of the
> >   * vector regs.  It doesn't mess with the task MSR or valid flags.
> >   * Furthermore, VEC laziness is not supported with TM currently.
> > + *
> > + * Is called from C
> >   */
> >  _GLOBAL(do_load_up_transact_altivec)
> >    	  mfmsr  	  r6
> > @@ -27,7 +29,7 @@ _GLOBAL(do_load_up_transact_altivec)
> >    	  lvx  	  v0,r10,r3
> >    	  mtvscr  	  v0
> >    	  addi  	  r10,r3,THREAD_TRANSACT_VRSTATE
> > -  	  REST_32VRS(0,r4,r10)
> > +  	  REST_32VRS(r4,r5,r6,r7,r8,r10)
> >  
> >    	  blr
> >  #endif
> > @@ -35,20 +37,24 @@ _GLOBAL(do_load_up_transact_altivec)
> >  /*
> >   * Load state from memory into VMX registers including VSCR.
> >   * Assumes the caller has enabled VMX in the MSR.
> > + *
> > + * Is called from C
> >   */
> >  _GLOBAL(load_vr_state)
> >    	  li  	  r4,VRSTATE_VSCR
> >    	  lvx  	  v0,r4,r3
> >    	  mtvscr  	  v0
> > -  	  REST_32VRS(0,r4,r3)
> > +  	  REST_32VRS(r4,r5,r6,r7,r8,r3)
> >    	  blr
> >  
> >  /*
> >   * Store VMX state into memory, including VSCR.
> >   * Assumes the caller has enabled VMX in the MSR.
> > + *
> > + * NOT called from C
> >   */
> >  _GLOBAL(store_vr_state)
> > -  	  SAVE_32VRS(0, r4, r3)
> > +  	  SAVE_32VRS(r4,r5,r6,r7,r8,r3)
> >    	  mfvscr  	  v0
> >    	  li  	  r4, VRSTATE_VSCR
> >    	  stvx  	  v0, r4, r3
> > @@ -63,6 +69,8 @@ _GLOBAL(store_vr_state)
> >   *
> >   * Note that on 32-bit this can only use registers that will be
> >   * restored by fast_exception_return, i.e. r3 - r6, r10 and r11.
> > + *
> > + * NOT called from C
> >   */
> >  _GLOBAL(load_up_altivec)
> >    	  mfmsr  	  r5  	  	  	  /* grab the current MSR */
> > @@ -101,13 +109,15 @@ _GLOBAL(load_up_altivec)
> >    	  stw  	  r4,THREAD_USED_VR(r5)
> >    	  lvx  	  v0,r10,r6
> >    	  mtvscr  	  v0
> > -  	  REST_32VRS(0,r4,r6)
> > +  	  REST_32VRS(r3,r4,r5,r10,r11,r6)
> >    	  /* restore registers and return */
> >    	  blr
> >  
> >  /*
> >   * save_altivec(tsk)
> >   * Save the vector registers to its thread_struct
> > + *
> > + * Is called from C
> >   */
> >  _GLOBAL(save_altivec)
> >    	  addi  	  r3,r3,THREAD  	  	> /* want THREAD of task */
> > @@ -116,7 +126,7 @@ _GLOBAL(save_altivec)
> >    	  PPC_LCMPI  	  0,r7,0
> >    	  bne  	  2f
> >    	  addi  	  r7,r3,THREAD_VRSTATE
> > -2:  	  SAVE_32VRS(0,r4,r7)
> > +2:  	  SAVE_32VRS(r4,r5,r6,r8,r9,r7)
> >    	  mfvscr  	  v0
> >    	  li  	  r4,VRSTATE_VSCR
> >    	  stvx  	  v0,r4,r7  
