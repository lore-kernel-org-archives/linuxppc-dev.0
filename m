Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F177C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:00:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695B920684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoPBSnxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695B920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q53Q3NTNzF38J
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:00:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KoPBSnxd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KoPBSnxd"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q50X4YwCzF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:58:04 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id k19-v6so1143331pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fHF+vMwGodN1t6Ft4fmHoQtshBWGkDJvDuNOhaAaQE=;
 b=KoPBSnxdf8umPFV/fE2cuwTk3wkMPZmFUZvba/wy6sHWh8BbHtfTOamZ1EiGIzz2LE
 9pifUQ4DlvAi7qNPOX7a9TqOLx9OBJFsuTKEflALgS91oo5E/Q3F/bhCtkNxVry3OctX
 Fp0Lq+rAHXBcOn0mN4/dLOV+eV+DbIa18fzFt2LsLO4kR7wORg/KEQGCBD+vgF9M05sO
 NcQrhm381JAKtjjKM9mCm4ijMaI4ZG/+7eMJwdmeIr8aeR3f6zyG3qlKAum9jSmEzftj
 LOGWsPm9bm5uGK+nw1xc8cR7SYBig2W+exO2hjuSis3IXhpZnnbOljN1Iu4dVTDLAkh3
 YfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fHF+vMwGodN1t6Ft4fmHoQtshBWGkDJvDuNOhaAaQE=;
 b=VvEmOQ7+qsSi+0sGGJEejlp4chufzsfBnqj/lCxIFldzmBpRdvxAxV0jNUZQnBLmO/
 IhxIWFgEMkSxcaKm3RjBNO+ItNCbj7/x+MvGvyJZj7Gwl7UhUHQG9eZ1Q5kckBob5oeY
 chkIpTaK/gADAlXA27Hn3YBoZfCSAkEoXkQCFlhuG6839rZW3lJ2kNKTQo4Ba9xOng7r
 5Dj37X6NDmDzfHMKC0l387COsu78EV4T8E2hHxlkENEc/QPikujQqgn54Z3fZ5YUJfNi
 VAQBVUKvEOCI3f3Ax8KuFwR7HDnE3Pe0vNavRD/an01m0bcc6SCuMSF0gIe79afLakag
 Kjog==
X-Gm-Message-State: ABuFfohsDJPHNEPLWYoFEpTaJP6WmgVbw358fbyF3g4v0Ec+CjKTOEEg
 GYVlw61V7qrPb8X6Adtu7/g=
X-Google-Smtp-Source: ACcGV63Xg3Yo19h6evb/Y6lDbMNpb2sRsGe4k+DwwcRwH3e6hpjbJsl5nS7vy6Z2HjjXPna1x76hYg==
X-Received: by 2002:a63:6ce:: with SMTP id
 197-v6mr16937206pgg.338.1538546282499; 
 Tue, 02 Oct 2018 22:58:02 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id f83-v6sm679980pfa.109.2018.10.02.22.57.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 22:58:01 -0700 (PDT)
Date: Wed, 3 Oct 2018 15:57:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 2/7] powerpc: Prepare for moving thread_info into
 task_struct
Message-ID: <20181003155756.0d387496@roar.ozlabs.ibm.com>
In-Reply-To: <8c53e2fd-c97e-7968-130f-8b5728e20cab@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <8dd2cade6299099a244b5eb223d7b84b460d7cd9.1538396658.git.christophe.leroy@c-s.fr>
 <20181003150253.5124e989@roar.ozlabs.ibm.com>
 <8c53e2fd-c97e-7968-130f-8b5728e20cab@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Oct 2018 07:49:44 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:02, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:21 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> This patch cleans the powerpc kernel before activating
> >> CONFIG_THREAD_INFO_IN_TASK:
> >> - The purpose of the pointer given to call_do_softirq() and
> >> call_do_irq() is to point the new stack =3D=3D> change it to void*
> >> - Don't use CURRENT_THREAD_INFO() to locate the stack.
> >> - Fixed a few comments.
> >> - TI_CPU is only used when CONFIG_SMP is set.
> >> - Replace current_thread_info()->task by current
> >> - Remove unnecessary casts to thread_info, as they'll become invalid
> >> once thread_info is not in stack anymore.
> >> - Ensure task_struct 'cpu' fields is not used directly out of SMP code
> >> - Rename THREAD_INFO to TASK_STASK: As it is in fact the offset of the
> >> pointer to the stack in task_struct, this pointer will not be impacted
> >> by the move of THREAD_INFO.
> >> - Makes TASK_STACK available to PPC64 which will need it to the get
> >> stack pointer from current once the thread_info have been moved.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   arch/powerpc/include/asm/irq.h       |  4 ++--
> >>   arch/powerpc/include/asm/livepatch.h |  2 +-
> >>   arch/powerpc/include/asm/processor.h |  4 ++--
> >>   arch/powerpc/include/asm/reg.h       |  2 +-
> >>   arch/powerpc/kernel/asm-offsets.c    |  2 +-
> >>   arch/powerpc/kernel/entry_32.S       |  2 +-
> >>   arch/powerpc/kernel/entry_64.S       |  2 +-
> >>   arch/powerpc/kernel/head_32.S        |  4 ++--
> >>   arch/powerpc/kernel/head_40x.S       |  4 ++--
> >>   arch/powerpc/kernel/head_44x.S       |  2 +-
> >>   arch/powerpc/kernel/head_8xx.S       |  2 +-
> >>   arch/powerpc/kernel/head_booke.h     |  4 ++--
> >>   arch/powerpc/kernel/head_fsl_booke.S |  6 ++++--
> >>   arch/powerpc/kernel/irq.c            |  2 +-
> >>   arch/powerpc/kernel/misc_32.S        |  8 ++++++--
> >>   arch/powerpc/kernel/process.c        |  6 +++---
> >>   arch/powerpc/kernel/setup_32.c       | 15 +++++----------
> >>   arch/powerpc/kernel/smp.c            |  4 +++-
> >>   arch/powerpc/xmon/xmon.c             |  2 +-
> >>   19 files changed, 40 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm=
/irq.h
> >> index ee39ce56b2a2..8108d1fe33ca 100644
> >> --- a/arch/powerpc/include/asm/irq.h
> >> +++ b/arch/powerpc/include/asm/irq.h
> >> @@ -63,8 +63,8 @@ extern struct thread_info *hardirq_ctx[NR_CPUS];
> >>   extern struct thread_info *softirq_ctx[NR_CPUS];
> >>  =20
> >>   extern void irq_ctx_init(void);
> >> -extern void call_do_softirq(struct thread_info *tp);
> >> -extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
> >> +extern void call_do_softirq(void *tp);
> >> +extern void call_do_irq(struct pt_regs *regs, void *tp); =20
> >=20
> > void *sp for these ? =20
>=20
> Yes, why not but it means changing the code. I wanted to minimise the=20
> changes and avoid cosmetic.

Fair enough.

> Or maybe should add a cosmetic patch at the=20
> end ?

Yeah that would be nice, I don't mind too much if it goes as part of
the patches or as a cleanup afterward. There's a few other places that
could use similar minor.

> > This all seems okay to me except the 32-bit code which I don't know.
> > Would it be any trouble for you to put the TI_CPU bits into their own
> > patch? =20
>=20
> No problem, I can put the TI_CPU bits in a separate patch.

Great thanks.

Thanks,
Nick

>=20
> >=20
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >  =20
>=20
> Thanks
> Christophe
>=20
> >  =20
> >>   extern void do_IRQ(struct pt_regs *regs);
> >>   extern void __init init_IRQ(void);
> >>   extern void __do_irq(struct pt_regs *regs);
> >> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/inclu=
de/asm/livepatch.h
> >> index 47a03b9b528b..818451bf629c 100644
> >> --- a/arch/powerpc/include/asm/livepatch.h
> >> +++ b/arch/powerpc/include/asm/livepatch.h
> >> @@ -49,7 +49,7 @@ static inline void klp_init_thread_info(struct threa=
d_info *ti)
> >>   	ti->livepatch_sp =3D (unsigned long *)(ti + 1) + 1;
> >>   }
> >>   #else
> >> -static void klp_init_thread_info(struct thread_info *ti) { }
> >> +static inline void klp_init_thread_info(struct thread_info *ti) { }
> >>   #endif /* CONFIG_LIVEPATCH */
> >>  =20
> >>   #endif /* _ASM_POWERPC_LIVEPATCH_H */
> >> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/inclu=
de/asm/processor.h
> >> index 353879db3e98..31873614392f 100644
> >> --- a/arch/powerpc/include/asm/processor.h
> >> +++ b/arch/powerpc/include/asm/processor.h
> >> @@ -40,7 +40,7 @@
> >>  =20
> >>   #ifndef __ASSEMBLY__
> >>   #include <linux/types.h>
> >> -#include <asm/thread_info.h>
> >> +#include <linux/thread_info.h>
> >>   #include <asm/ptrace.h>
> >>   #include <asm/hw_breakpoint.h>
> >>  =20
> >> @@ -333,7 +333,7 @@ struct thread_struct {
> >>  =20
> >>   #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
> >>   #define INIT_SP_LIMIT \
> >> -	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_sta=
ck)
> >> +	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long) &init_s=
tack)
> >>  =20
> >>   #ifdef CONFIG_SPE
> >>   #define SPEFSCR_INIT \
> >> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm=
/reg.h
> >> index e5b314ed054e..f3a9cf19a986 100644
> >> --- a/arch/powerpc/include/asm/reg.h
> >> +++ b/arch/powerpc/include/asm/reg.h
> >> @@ -1053,7 +1053,7 @@
> >>    *	- SPRG9 debug exception scratch
> >>    *
> >>    * All 32-bit:
> >> - *	- SPRG3 current thread_info pointer
> >> + *	- SPRG3 current thread_struct physical addr pointer
> >>    *        (virtual on BookE, physical on others)
> >>    *
> >>    * 32-bit classic:
> >> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/a=
sm-offsets.c
> >> index ba9d0fc98730..d1f161e48945 100644
> >> --- a/arch/powerpc/kernel/asm-offsets.c
> >> +++ b/arch/powerpc/kernel/asm-offsets.c
> >> @@ -85,10 +85,10 @@ int main(void)
> >>   	DEFINE(NMI_MASK, NMI_MASK);
> >>   	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
> >>   #else
> >> -	OFFSET(THREAD_INFO, task_struct, stack);
> >>   	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
> >>   	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
> >>   #endif /* CONFIG_PPC64 */
> >> +	OFFSET(TASK_STACK, task_struct, stack);
> >>  =20
> >>   #ifdef CONFIG_LIVEPATCH
> >>   	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
> >> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entr=
y_32.S
> >> index e58c3f467db5..12c0721f65ea 100644
> >> --- a/arch/powerpc/kernel/entry_32.S
> >> +++ b/arch/powerpc/kernel/entry_32.S
> >> @@ -1166,7 +1166,7 @@ ret_from_debug_exc:
> >>   	mfspr	r9,SPRN_SPRG_THREAD
> >>   	lwz	r10,SAVED_KSP_LIMIT(r1)
> >>   	stw	r10,KSP_LIMIT(r9)
> >> -	lwz	r9,THREAD_INFO-THREAD(r9)
> >> +	lwz	r9,TASK_STACK-THREAD(r9)
> >>   	CURRENT_THREAD_INFO(r10, r1)
> >>   	lwz	r10,TI_PREEMPT(r10)
> >>   	stw	r10,TI_PREEMPT(r9)
> >> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entr=
y_64.S
> >> index 77a888bfcb53..697406572592 100644
> >> --- a/arch/powerpc/kernel/entry_64.S
> >> +++ b/arch/powerpc/kernel/entry_64.S
> >> @@ -680,7 +680,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
> >>   2:
> >>   #endif /* CONFIG_PPC_BOOK3S_64 */
> >>  =20
> >> -	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
> >> +	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
> >>   	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
> >>   	   because we don't need to leave the 288-byte ABI gap at the
> >>   	   top of the kernel stack. */
> >> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_=
32.S
> >> index 61ca27929355..dce6f2ff07e5 100644
> >> --- a/arch/powerpc/kernel/head_32.S
> >> +++ b/arch/powerpc/kernel/head_32.S
> >> @@ -261,7 +261,7 @@ __secondary_hold_acknowledge:
> >>   	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
> >>   	beq	1f;		\
> >>   	mfspr	r11,SPRN_SPRG_THREAD;	\
> >> -	lwz	r11,THREAD_INFO-THREAD(r11);	\
> >> +	lwz	r11,TASK_STACK-THREAD(r11);	\
> >>   	addi	r11,r11,THREAD_SIZE;	\
> >>   	tophys(r11,r11);	\
> >>   1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
> >> @@ -841,7 +841,7 @@ __secondary_start:
> >>   	bl	init_idle_6xx
> >>   #endif /* CONFIG_6xx */
> >>  =20
> >> -	/* get current_thread_info and current */
> >> +	/* get current's stack and current */
> >>   	lis	r1,secondary_ti@ha
> >>   	tophys(r1,r1)
> >>   	lwz	r1,secondary_ti@l(r1)
> >> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head=
_40x.S
> >> index b19d78410511..3088c9f29f5e 100644
> >> --- a/arch/powerpc/kernel/head_40x.S
> >> +++ b/arch/powerpc/kernel/head_40x.S
> >> @@ -115,7 +115,7 @@ _ENTRY(saved_ksp_limit)
> >>   	andi.	r11,r11,MSR_PR;						     \
> >>   	beq	1f;							     \
> >>   	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
> >> -	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
> >> +	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
> >>   	addi	r1,r1,THREAD_SIZE;					     \
> >>   1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
> >>   	tophys(r11,r1);							     \
> >> @@ -158,7 +158,7 @@ _ENTRY(saved_ksp_limit)
> >>   	beq	1f;							     \
> >>   	/* COMING FROM USER MODE */					     \
> >>   	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
> >> -	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> >> +	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
> >>   1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  *=
/\
> >>   	tophys(r11,r11);						     \
> >>   	stw	r10,_CCR(r11);          /* save various registers	   */\
> >> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head=
_44x.S
> >> index 37e4a7cf0065..15d39b2499de 100644
> >> --- a/arch/powerpc/kernel/head_44x.S
> >> +++ b/arch/powerpc/kernel/head_44x.S
> >> @@ -1020,7 +1020,7 @@ _GLOBAL(start_secondary_47x)
> >>  =20
> >>   	/* Now we can get our task struct and real stack pointer */
> >>  =20
> >> -	/* Get current_thread_info and current */
> >> +	/* Get current's stack and current */
> >>   	lis	r1,secondary_ti@ha
> >>   	lwz	r1,secondary_ti@l(r1)
> >>   	lwz	r2,TI_TASK(r1)
> >> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head=
_8xx.S
> >> index 6582f824d620..e56e36aa2b3d 100644
> >> --- a/arch/powerpc/kernel/head_8xx.S
> >> +++ b/arch/powerpc/kernel/head_8xx.S
> >> @@ -124,7 +124,7 @@ turn_on_mmu:
> >>   	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
> >>   	beq	1f;		\
> >>   	mfspr	r11,SPRN_SPRG_THREAD;	\
> >> -	lwz	r11,THREAD_INFO-THREAD(r11);	\
> >> +	lwz	r11,TASK_STACK-THREAD(r11);	\
> >>   	addi	r11,r11,THREAD_SIZE;	\
> >>   	tophys(r11,r11);	\
> >>   1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
> >> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/he=
ad_booke.h
> >> index d0862a100d29..20fe0c93a0bd 100644
> >> --- a/arch/powerpc/kernel/head_booke.h
> >> +++ b/arch/powerpc/kernel/head_booke.h
> >> @@ -44,7 +44,7 @@
> >>   	mr	r11, r1;						     \
> >>   	beq	1f;							     \
> >>   	/* if from user, start at top of this thread's kernel stack */     =
  \
> >> -	lwz	r11, THREAD_INFO-THREAD(r10);				     \
> >> +	lwz	r11, TASK_STACK-THREAD(r10);				     \
> >>   	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
> >>   1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */   =
  \
> >>   	stw	r13, _CCR(r11);		/* save various registers */	     \
> >> @@ -130,7 +130,7 @@
> >>   	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
> >>   	andi.	r11,r11,MSR_PR;						     \
> >>   	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
> >> -	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> >> +	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
> >>   	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
> >>   	beq	1f;							     \
> >>   	/* COMING FROM USER MODE */					     \
> >> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kerne=
l/head_fsl_booke.S
> >> index e2750b856c8f..239ad8a4754e 100644
> >> --- a/arch/powerpc/kernel/head_fsl_booke.S
> >> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> >> @@ -243,8 +243,10 @@ set_ivor:
> >>   	li	r0,0
> >>   	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
> >>  =20
> >> +#ifdef CONFIG_SMP
> >>   	CURRENT_THREAD_INFO(r22, r1)
> >>   	stw	r24, TI_CPU(r22)
> >> +#endif
> >>  =20
> >>   	bl	early_init
> >>  =20
> >> @@ -702,7 +704,7 @@ finish_tlb_load:
> >>  =20
> >>   	/* Get the next_tlbcam_idx percpu var */
> >>   #ifdef CONFIG_SMP
> >> -	lwz	r12, THREAD_INFO-THREAD(r12)
> >> +	lwz	r12, TASK_STACK-THREAD(r12)
> >>   	lwz	r15, TI_CPU(r12)
> >>   	lis     r14, __per_cpu_offset@h
> >>   	ori     r14, r14, __per_cpu_offset@l
> >> @@ -1074,7 +1076,7 @@ __secondary_start:
> >>   	mr	r4,r24		/* Why? */
> >>   	bl	call_setup_cpu
> >>  =20
> >> -	/* get current_thread_info and current */
> >> +	/* get current's stack and current */
> >>   	lis	r1,secondary_ti@ha
> >>   	lwz	r1,secondary_ti@l(r1)
> >>   	lwz	r2,TI_TASK(r1)
> >> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> >> index 916ddc4aac44..aa53db3ba6e7 100644
> >> --- a/arch/powerpc/kernel/irq.c
> >> +++ b/arch/powerpc/kernel/irq.c
> >> @@ -663,7 +663,7 @@ void do_IRQ(struct pt_regs *regs)
> >>   	struct thread_info *curtp, *irqtp, *sirqtp;
> >>  =20
> >>   	/* Switch to the irq stack to handle this */
> >> -	curtp =3D current_thread_info();
> >> +	curtp =3D (void*)(current_stack_pointer() & ~(THREAD_SIZE - 1));
> >>   	irqtp =3D hardirq_ctx[raw_smp_processor_id()];
> >>   	sirqtp =3D softirq_ctx[raw_smp_processor_id()];
> >>  =20
> >> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_=
32.S
> >> index 695b24a2d954..24a7f18ea10c 100644
> >> --- a/arch/powerpc/kernel/misc_32.S
> >> +++ b/arch/powerpc/kernel/misc_32.S
> >> @@ -60,7 +60,7 @@ _GLOBAL(call_do_softirq)
> >>   	blr
> >>  =20
> >>   /*
> >> - * void call_do_irq(struct pt_regs *regs, struct thread_info *irqtp);
> >> + * void call_do_irq(struct pt_regs *regs, void *irqtp);
> >>    */
> >>   _GLOBAL(call_do_irq)
> >>   	mflr	r0
> >> @@ -183,10 +183,14 @@ _GLOBAL(low_choose_750fx_pll)
> >>   	or	r4,r4,r5
> >>   	mtspr	SPRN_HID1,r4
> >>  =20
> >> +#ifdef CONFIG_SMP
> >>   	/* Store new HID1 image */
> >>   	CURRENT_THREAD_INFO(r6, r1)
> >>   	lwz	r6,TI_CPU(r6)
> >>   	slwi	r6,r6,2
> >> +#else
> >> +	li	r6, 0
> >> +#endif
> >>   	addis	r6,r6,nap_save_hid1@ha
> >>   	stw	r4,nap_save_hid1@l(r6)
> >>  =20
> >> @@ -599,7 +603,7 @@ EXPORT_SYMBOL(__bswapdi2)
> >>   #ifdef CONFIG_SMP
> >>   _GLOBAL(start_secondary_resume)
> >>   	/* Reset stack */
> >> -	CURRENT_THREAD_INFO(r1, r1)
> >> +	rlwinm	r1, r1, 0, 0, 31 - THREAD_SHIFT
> >>   	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
> >>   	li	r3,0
> >>   	stw	r3,0(r1)		/* Zero the stack frame pointer	*/
> >> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proce=
ss.c
> >> index 03c2e1f134bc..111abb4df2ec 100644
> >> --- a/arch/powerpc/kernel/process.c
> >> +++ b/arch/powerpc/kernel/process.c
> >> @@ -1240,8 +1240,8 @@ struct task_struct *__switch_to(struct task_stru=
ct *prev,
> >>   		batch->active =3D 1;
> >>   	}
> >>  =20
> >> -	if (current_thread_info()->task->thread.regs) {
> >> -		restore_math(current_thread_info()->task->thread.regs);
> >> +	if (current->thread.regs) {
> >> +		restore_math(current->thread.regs);
> >>  =20
> >>   		/*
> >>   		 * The copy-paste buffer can only store into foreign real
> >> @@ -1251,7 +1251,7 @@ struct task_struct *__switch_to(struct task_stru=
ct *prev,
> >>   		 * mappings, we must issue a cp_abort to clear any state and
> >>   		 * prevent snooping, corruption or a covert channel.
> >>   		 */
> >> -		if (current_thread_info()->task->thread.used_vas)
> >> +		if (current->thread.used_vas)
> >>   			asm volatile(PPC_CP_ABORT);
> >>   	}
> >>   #endif /* CONFIG_PPC_BOOK3S_64 */
> >> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setu=
p_32.c
> >> index 8c507be12c3c..81ebf7d6f526 100644
> >> --- a/arch/powerpc/kernel/setup_32.c
> >> +++ b/arch/powerpc/kernel/setup_32.c
> >> @@ -205,10 +205,8 @@ void __init irqstack_early_init(void)
> >>   	/* interrupt stacks must be in lowmem, we get that for free on ppc32
> >>   	 * as the memblock is limited to lowmem by default */
> >>   	for_each_possible_cpu(i) {
> >> -		softirq_ctx[i] =3D (struct thread_info *)
> >> -			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> -		hardirq_ctx[i] =3D (struct thread_info *)
> >> -			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> +		softirq_ctx[i] =3D __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> +		hardirq_ctx[i] =3D __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >>   	}
> >>   }
> >>  =20
> >> @@ -226,13 +224,10 @@ void __init exc_lvl_early_init(void)
> >>   		hw_cpu =3D 0;
> >>   #endif
> >>  =20
> >> -		critirq_ctx[hw_cpu] =3D (struct thread_info *)
> >> -			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> +		critirq_ctx[hw_cpu] =3D __va(memblock_alloc(THREAD_SIZE, THREAD_SIZ=
E));
> >>   #ifdef CONFIG_BOOKE
> >> -		dbgirq_ctx[hw_cpu] =3D (struct thread_info *)
> >> -			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> -		mcheckirq_ctx[hw_cpu] =3D (struct thread_info *)
> >> -			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> >> +		dbgirq_ctx[hw_cpu] =3D __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE=
));
> >> +		mcheckirq_ctx[hw_cpu] =3D __va(memblock_alloc(THREAD_SIZE, THREAD_S=
IZE));
> >>   #endif
> >>   	}
> >>   }
> >> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> >> index 61c1fadbc644..19dd0ea55714 100644
> >> --- a/arch/powerpc/kernel/smp.c
> >> +++ b/arch/powerpc/kernel/smp.c
> >> @@ -20,6 +20,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/export.h>
> >>   #include <linux/sched/mm.h>
> >> +#include <linux/sched/task_stack.h>
> >>   #include <linux/sched/topology.h>
> >>   #include <linux/smp.h>
> >>   #include <linux/interrupt.h>
> >> @@ -812,7 +813,8 @@ static void cpu_idle_thread_init(unsigned int cpu,=
 struct task_struct *idle)
> >>  =20
> >>   #ifdef CONFIG_PPC64
> >>   	paca_ptrs[cpu]->__current =3D idle;
> >> -	paca_ptrs[cpu]->kstack =3D (unsigned long)ti + THREAD_SIZE - STACK_F=
RAME_OVERHEAD;
> >> +	paca_ptrs[cpu]->kstack =3D (unsigned long)task_stack_page(idle) +
> >> +				  THREAD_SIZE - STACK_FRAME_OVERHEAD;
> >>   #endif
> >>   	ti->cpu =3D cpu;
> >>   	secondary_ti =3D current_set[cpu] =3D ti;
> >> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> >> index 694c1d92e796..0d8d6fee892a 100644
> >> --- a/arch/powerpc/xmon/xmon.c
> >> +++ b/arch/powerpc/xmon/xmon.c
> >> @@ -2988,7 +2988,7 @@ static void show_task(struct task_struct *tsk)
> >>   	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
> >>   		tsk->thread.ksp,
> >>   		tsk->pid, tsk->parent->pid,
> >> -		state, task_thread_info(tsk)->cpu,
> >> +		state, task_cpu(tsk),
> >>   		tsk->comm);
> >>   }
> >>  =20
> >> --=20
> >> 2.13.3
> >> =20

