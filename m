Return-Path: <linuxppc-dev+bounces-28819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865C9CA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 09:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxgQf6QBdz2y1W;
	Sat, 03 Oct 2026 19:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791019914;
	cv=none; b=fi2XuwKDBse1OXvrH3wgFcuPUn6tpngN+XfTjIHe6ulkUmIH2WRzPlnDv0S20I2Yg73dCVBYmwqu4LLvkJBe6tR52ke9m5DopD6pMVFk1aQM9d9IXaJGPLxORfWPBUemss04sY0SWYV1RKDOnrIqxqEvRSSejmEuZ50IwmgECgcee7IuIH3XC7JKjwoDZ/h7KOClSVMWOsu73v4e1Cf74yF/axADfwK0rFP+lLfoTUmSg/7ju598UvuNHsgykI2mnJQrtn/rbpUHip22QPPetskMWq/e1fj9+VCb+/kp3SdBY3csMjBlixdAI5YJLXqqaqea2MvQBM0pLEUDs/r+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791019914; c=relaxed/relaxed;
	bh=F8YAiFdZQfKL2vYUOmLOKntCFlon8PTZjXEJkeu5RQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5GZqZ3Jr26fo4vdCtpLqFaX38SPXtOsWU7xKoq8PMDuhTnUtdIN0BEsjG+ZpBG2Vy1b/PCzuAWrEsU6XXZirsEdeeKrluk5b5+8x5oKBfv5yf8nwBvooioSSK0gYn0ZMkO8u3RrarcJHjTUKXMIlpnEHUt0SpISp9udXBUBE1LtjXrW5Pbys2TOWT4S3xBnlVw/z1dICL39TTOOJJA4YPCF20pJLNA7SyHq4/PXe7KmlqZeKp6VhKTVa6FXz9umCF/ZJzceiyra2bfotypXzDqz/CXTxqVBupU5+BclmVEZuONBTuSBP99x5adaziKB9usVl5kM4teUNsMl45aHbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7JdbWt5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7JdbWt5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com [IPv6:2607:f8b0:4864:41::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxgQc72yFz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 19:31:51 +1000 (AEST)
Received: by mail-yx2-x2a.google.com with SMTP id 956f58d0204a3-675617094f5so140781d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791019908; x=1791624708; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8YAiFdZQfKL2vYUOmLOKntCFlon8PTZjXEJkeu5RQ4=;
        b=P7JdbWt5Fwm1Je6TmMI6jIvDWBUAI4TYz9t2novI3aVmKv7/rhXfHR/uC5OvQDHJH/
         EDKfRRwXINJT6iSqgXaeIEwGT0nu/KjbcxgkcYy2K/6t4DSzrMOUkehShssLwxcCEAUR
         YE22+hxRs7DzjHxY3Dv9HNVGpzZnGG9hV5WVcGYpRgevBirqDK4bClDjCBk197wXKson
         xNCi1QOtYYCvOF56d7Dpl9xXBETkqaPFLuje88ehzmYhiSUQuoEPVuHEI9mP74r7Wk4A
         WfXiOye6fhmZMx++BPaEE5R0SYA6u4eX8h+doox/q0hQjYfBooKUxT+VQmuTySDzaUDh
         UFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791019908; x=1791624708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F8YAiFdZQfKL2vYUOmLOKntCFlon8PTZjXEJkeu5RQ4=;
        b=x4nHhQsDrMp/XDLn8y1CqNbR/SFBW7PM0ezpElC/vM2XR3J99qupTjbL3T8LFkBoa9
         cOHC9Grtuv0r1Q2PhZQYHe0MHHCrg6cWu2NsaYanwvyZx3lX/WEeFdqR6j7H2W5wL3n1
         fHfpS7FdK4CYhVYSh4y0MjdPvTUJlYm9cpchuOqQhNYmlkrkdLX0q6dh9Wy1z9BeP+iV
         7/RIZ+dyTLpgg+mCOe/+3xA0uLmP3T/O6YB8CbJdhNgZKtakFyDlIj81txensi1Rf+vc
         Di1lIP7sHKp/GcUsK1Fm9musElyTcLfR8r+mX7pGjLq8FpbjPsZhRTC+4fBHtH9P2w0T
         2n3g==
X-Forwarded-Encrypted: i=1; AKwUvBz8Ol9ytlEmiaNWHUN02BxdeFViUfe+U75fOVm4fYAMoyoXylHXsmRLTjnR8BbwRNQDckAHzW+mPgM2eWY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIi0s8DTzu5sX05H8c0/ZrLlNt25cgDrOXIyDnWVYjtOD1AEary
	4VZBIuoafkYABug78ccy/FoaI3NhliGkiVItyDy4ZAwU25UPxrCLXIMf
X-Gm-Gg: AYBFou1eNPgH8RXzwA2qG7ZuMfuvoXhDJ0QK6eo+WdsErfUdPxgnUhlshgqntRAIuqo
	PNlvTJAeFWvjh69RW+GRj/dENv+8aIJycPqi+KK1LzOKVjPuzjJXpbZuJIRZplRe2pLdcyo9EKC
	A6qrRENdWUvV3NM65onFxIftEDg/isUIOd49Y725lHjfl3X2+4ayazcKmTCb3jiXBcVp3SxrYTE
	QSemHQQARl8KPBBnkWL5W9BFAp0Nt3uNfTL9W9ouYByC84lrEO2gmxTkwrWyRwp7WJMy5Ymst06
	wGmLbx54IbXaJ/zFxNYY9ko8DMUxYiFKQ2N/g8ynN5LTQVwA+UTp6YfGMszyt4g7pSJGk6Unkvm
	2cMvmtFb1JOAyTzvafFcNwLeJsv7zqx71rcfLpafFj+pCE64/VfBqU1VNhSmXScSLFhrXx0aCNR
	u3RE/gK7THJEVJSZWsOSbaGXKgHVUXgtBHsuQjySRG/ooiqRGsnQjKKfMsu1w4w3Nq9kXrk1/Lw
	z/piYanLJNZs3mC6e0rDNmeUN3vqvnTv/r2vizLm7dm
X-Received: by 2002:a05:690e:1289:b0:677:b861:e946 with SMTP id 956f58d0204a3-677b861fe94mr1812374d50.62.1791019907931;
        Sat, 03 Oct 2026 02:31:47 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b1b828sm520694d50.4.2026.10.03.02.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:31:47 -0700 (PDT)
Date: Sat, 3 Oct 2026 15:01:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, apw@canonical.com, 
	joe@perches.com, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, mkchauras@linux.ibm.com, 
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: fix NMI exit ordering: restore soft masks after
 irqentry_nmi_exit()
Message-ID: <asDLVug2VgtCJOue@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260929071600.2963954-1-mkchauras@gmail.com>
 <ar9qRKA1mavDruDR@kunlun.suse.cz>
 <5409ae4d-1d1d-426b-a810-f12ef40bf86b@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5409ae4d-1d1d-426b-a810-f12ef40bf86b@linux.ibm.com>

On Fri, Oct 02, 2026 at 04:26:43PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 10/2/26 1:54 PM, Michal Suchánek wrote:
> > On Tue, Sep 29, 2026 at 12:46:00PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > When running with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y and LOCKDEP=y, an
> > > Oops is triggered during NMI exit:
> > > 
> > >    [  202.258332] Oops: Exception in kernel mode, sig: 4 [#1]
> > >    NIP [000000000003e178] 0x3e178
> > >    LR  [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
> > >    TRAP: 0700  MSR: 0000000000081000 <ME>
> > > 
> > > The faulting instruction at NIP is a 'trap' (0fe00000) inside the
> > > rfi_flush_fallback trampoline at a userspace-looking low address, reached
> > > after a bad rfid caused by an incorrect SRR0 value.
> > > 
> > > Root cause
> > > ----------
> > > DEFINE_INTERRUPT_HANDLER_NMI used to call arch_interrupt_nmi_exit_prepare()
> > > *before* irqentry_nmi_exit(), giving this sequence:
> > > 
> > >    arch_interrupt_nmi_enter_prepare()   // saves irq_soft_mask, irq_happened
> > >    irqentry_nmi_enter()                 // __nmi_enter() -> nmi_count++, in_nmi()=true
> > >    ____func(regs)                       // NMI handler body
> > >    arch_interrupt_nmi_exit_prepare()    // RESTORES irq_soft_mask=0 (IRQS_ENABLED)
> > >                                         // RESTORES irq_happened with pending bits
> > >    irqentry_nmi_exit()                  // instrumentation block runs here...
> > >      trace_hardirqs_on_prepare()        //   ...with in_nmi()==true still
> > >      lockdep_hardirqs_on_prepare()      //   ...and irq_soft_mask already restored to 0
> > >        -> arch_local_irq_restore(0)     // mask=0 -> enable path entered
> > >             WARN_ON_ONCE(in_nmi())      // FIRES: __nmi_exit() hasn't run yet
> > >      __nmi_exit()                       // nmi_count-- (too late)
> > > 
> > > arch_interrupt_nmi_exit_prepare() restores irq_soft_mask to whatever
> > > the interrupted thread had (IRQS_ENABLED / 0) and restores irq_happened
> > > with any pending deferred-interrupt bits that were present when the NMI
> > > fired.  This is correct and necessary before rfid back to the interrupted
> > > context, but it must not happen until irqentry_nmi_exit() has fully
> > > completed.
> > > 
> > > With irq_soft_mask=0 and pending bits in irq_happened, the
> > > trace_hardirqs_on_prepare() call inside irqentry_nmi_exit()'s
> > > instrumentation block reaches lockdep_hardirqs_on_prepare() which
> > > calls __trace_hardirqs_on_caller(), which eventually calls
> > > arch_local_irq_restore(0) (the IRQS_ENABLED / enable path).
> > > 
> > > arch_local_irq_restore() with mask=0 hits the CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> > > guards at irq_64.c:217:
> > > 
> > >    WARN_ON_ONCE(in_nmi());   // TRUE: __nmi_exit() not yet called
> > > 
> > > The WARN_ON_ONCE fires a 'trap' instruction (tw 31,0,0 / 0fe00000) in
> > > kernel mode with MSR_PR=0, MSR_IR=0 (real-mode).  The program check
> > > handler (TRAP 0700) takes the sig:4 (SIGILL) path via do_program_check()
> > > and calls die(), producing the Oops.
> > > 
> > > The RESTART_TABLE mechanism in arch_local_irq_restore then causes the
> > > bad rfid that lands at the userspace-looking address visible in the NIP.
> > > 
> > > The bug is invisible with LOCKDEP=n because trace_hardirqs_on_prepare()
> > > is a no-op when CONFIG_TRACE_IRQFLAGS is not set (TRACE_IRQFLAGS is
> > > selected by PROVE_LOCKING which selects LOCKDEP).
> > > 
> > > Fix
> > > ---
> > 
> > Hello,
> > 
> > please avoid excessive formatting in commit messages.
> > 
> > When git am is used to apply this patch it strips everything after this
> > line
> 
> Yes. Good catch. Please run ./scripts/checkpatch.pl --strict always.
> 
> I am seeing this pattern quite often these days.
> Maybe it is worth updating checkpatch.pl to catch such things.
> 
> ERROR: Invalid commit separator - some tools may have problems applying this
> #18:
> ----------
> It flags this one, but if i remove that line it doesn't flag subsequent the --- tag.
> 
> What I would want checkpatch to see if there are multiple --- in the commit message,
> Flag it and show it as error.
> 
> +cc Andy, Joe. Do you think that's good to fix it?
> 
Hey Michal and Shrikanth,

Thanks, i'll fix this and send out a new vesion.

Regards,
Mukesh
> > 
> > > Move arch_interrupt_nmi_exit_prepare() to after the irqentry_nmi_exit()
> > > block, so that:
> > > 
> > >    irqentry_nmi_exit()                 // __nmi_exit() -> nmi_count--, in_nmi()=false
> > >    arch_interrupt_nmi_exit_prepare()   // now safe to restore soft mask state
> > > 
> > > The instrumentation inside irqentry_nmi_exit() now executes while
> > > in_nmi() is still true (nmi_count not yet decremented), but
> > > irq_soft_mask is still IRQS_ALL_DISABLED (NMI-entry value), so
> > > arch_local_irq_restore() is never called with mask=0 from that path.
> > > After __nmi_exit() returns, arch_interrupt_nmi_exit_prepare() restores
> > > the pre-NMI soft mask and irq_happened, which is the correct state for
> > > the rfid back to the interrupted context.
> > > 
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/all/d4cccba9-ce5c-424b-864c-2248fb0d99e6@linux.ibm.com/
> > > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > ---
> > 
> > because it's the same as this line that marks the end of the commit
> > message.
> > 
> > Thanks
> > 
> > Michal
> > 
> > >   arch/powerpc/include/asm/interrupt.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> > > index 1b45a49e9bed..56f855c6f07e 100644
> > > --- a/arch/powerpc/include/asm/interrupt.h
> > > +++ b/arch/powerpc/include/asm/interrupt.h
> > > @@ -301,7 +301,6 @@ interrupt_handler long func(struct pt_regs *regs)			\
> > >   		state = irqentry_nmi_enter(regs);			\
> > >   	}								\
> > >   	ret = ____##func (regs);					\
> > > -	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
> > >   	if (mfmsr() & MSR_DR) {						\
> > >   		/* nmi_exit if relocations are on */			\
> > >   		irqentry_nmi_exit(regs, state);				\
> > > @@ -317,6 +316,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
> > >   	} else {							\
> > >   		irqentry_nmi_exit(regs, state);				\
> > >   	}								\
> > > +	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
> > >   									\
> > >   	return ret;							\
> > >   }									\
> > > -- 
> > > 2.55.0
> > > 
> > > 
> 

