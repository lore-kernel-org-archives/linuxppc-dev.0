Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE8C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 10:23:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CF860F42
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 10:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67CF860F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzNYr3lWfz2yKW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 20:23:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GRQbXhOs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ardb@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GRQbXhOs; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzNY66Cvmz2xsT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 20:22:34 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDAB260FED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630405350;
 bh=CopK0+RPrdW0NrpmXSqnJg7a/FM6saM8cfHvnciJNVw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GRQbXhOspGBkkIdQarG+TUlyTgZ1ZIu+lRu3XB3bAPtMaH3eeOK7uUszP3UV0esUN
 y+omubUOvniXV0SqWGkdDSfBAtuuQumR4kSh6W5bi0l+6wO3MXGuyVRv68ET1Tbadm
 SYPfB/GK3EE/z7vpkowN6sqqsJ9V6JtkW/ZzOF42L7ocM4APl7HcV0qsY6mKRnyEGm
 UZ8NJ7hvZrRIx+QS4okWIKDi7lK0d0aNsP1XF2qxaPP0JXIEVVM67k6khIXNvnAu6v
 DscgIH027byMmXT8p7jQyR18P72N7Bx5hNzbxAzvid0I4NCz363bRF/ckN37pe3f+g
 cySVbxwB8TE+w==
Received: by mail-oi1-f176.google.com with SMTP id w19so23712218oik.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 03:22:29 -0700 (PDT)
X-Gm-Message-State: AOAM530f09RjkXDW4GP9WICbnFs4tieV/cWh5Ofsp7gFFj7CTnSLrBaw
 d2sskxTX4vOQqXfvZdwz2thwgdNfoan+xH98td8=
X-Google-Smtp-Source: ABdhPJzjKuTh+epTj5FSATkHPUdlZkAtu32PUzfeNKRcR5oIb4mMVRmSAXwtJww3FuIzehctC2Gstt7OAkN8JJpuuG4=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr2567189oih.174.1630405349269; 
 Tue, 31 Aug 2021 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <cbfc0376461d02867c75cee72bb9167e16f4d0b0.1630396954.git.christophe.leroy@csgroup.eu>
 <YS3t/s9nojyCn9ev@hirez.programming.kicks-ass.net>
In-Reply-To: <YS3t/s9nojyCn9ev@hirez.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 31 Aug 2021 12:22:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERf18cKD6v2vDkue4wosqBSnB4B6xjj4yz0H-c7DKyzw@mail.gmail.com>
Message-ID: <CAMj1kXERf18cKD6v2vDkue4wosqBSnB4B6xjj4yz0H-c7DKyzw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Add support for out-of-line static calls
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
 Jason Baron <jbaron@akamai.com>, Paul Mackerras <paulus@samba.org>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 31 Aug 2021 at 10:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 31, 2021 at 08:05:21AM +0000, Christophe Leroy wrote:
>
> > +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)                     \
> > +     asm(".pushsection .text, \"ax\"                         \n"     \
> > +         ".align 4                                           \n"     \
> > +         ".globl " STATIC_CALL_TRAMP_STR(name) "             \n"     \
> > +         STATIC_CALL_TRAMP_STR(name) ":                      \n"     \
> > +         "   blr                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         ".type " STATIC_CALL_TRAMP_STR(name) ", @function   \n"     \
> > +         ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > +         ".popsection                                        \n")
>
> > +static int patch_trampoline_32(u32 *addr, unsigned long target)
> > +{
> > +     int err;
> > +
> > +     err = patch_instruction(addr++, ppc_inst(PPC_RAW_LIS(_R12, PPC_HA(target))));
> > +     err |= patch_instruction(addr++, ppc_inst(PPC_RAW_ADDI(_R12, _R12, PPC_LO(target))));
> > +     err |= patch_instruction(addr++, ppc_inst(PPC_RAW_MTCTR(_R12)));
> > +     err |= patch_instruction(addr, ppc_inst(PPC_RAW_BCTR()));
> > +
> > +     return err;
> > +}
>
> There can be concurrent execution and modification; the above doesn't
> look safe in that regard. What happens if you've say, done the first
> two, but not the latter two and execution happens (on a different
> CPU or through IRQ context, etc..)?
>
> > +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> > +{
> > +     int err;
> > +     unsigned long target = (long)func;
> > +
> > +     if (!tramp)
> > +             return;
> > +
> > +     mutex_lock(&text_mutex);
> > +
> > +     if (!func)
> > +             err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
> > +     else if (is_offset_in_branch_range((long)target - (long)tramp))
> > +             err = patch_branch(tramp, target, 0);
>
> These two are single instruction modifications and I'm assuming the
> hardware is sane enough that execution sees either the old or the new
> instruction. So this should work.
>
> > +     else if (IS_ENABLED(CONFIG_PPC32))
> > +             err = patch_trampoline_32(tramp, target);
> > +     else
> > +             BUILD_BUG();
> > +
> > +     mutex_unlock(&text_mutex);
> > +
> > +     if (err)
> > +             panic("%s: patching failed %pS at %pS\n", __func__, func, tramp);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_static_call_transform);
>
> One possible solution that we explored on ARM64, was having the
> trampoline be in 2 slots:
>
>
>         b 1f
>
> 1:      blr
>         nop
>         nop
>         nop
>
> 2:      blr
>         nop
>         nop
>         nop
>
> Where initially the first slot is active (per "b 1f"), then you write
> the second slot, and as a final act, re-write the initial branch to
> point to slot 2.
>
> Then you execute synchronize_rcu_tasks() under your text mutex
> (careful!) to ensure all users of your slot1 are gone and the next
> modification repeats the whole thing, except for using slot1 etc..
>
> Eventually I think Ard came up with the latest ARM64 proposal which puts
> a literal in a RO section (could be the text section I suppose) and
> loads and branches to that.
>

Yes. The main reason is simply that anything else is premature
optimization: we have a clear use case (CFI) where out-of-line static
calls are faster than compiler generated indirect calls, even if the
static call sequence is based on a literal load and an indirect
branch, but CFI is not upstream [yet].

Once other use cases emerge, we will revisit this.



> Anyway, the thing is, you can really only modify a single instruction at
> the time and need to ensure concurrent execution is correct.
