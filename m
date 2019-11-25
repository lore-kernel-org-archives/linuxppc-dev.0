Return-Path: <SRS0=uOHI=ZR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE2CC432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 10:34:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC152082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 10:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GccwnDO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC152082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47M3Lh72RczDqXv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 21:34:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47M3JC5nlTzDqXb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 21:32:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="GccwnDO3"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47M3JC08lPz9sPf;
 Mon, 25 Nov 2019 21:32:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1574677947;
 bh=wMnGZ8xSm6Bxvf7nFGXPylCgH+dhgGjKCMlcSzJ+TCs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GccwnDO3NbIS+aKssYRnp1UoFnIX7dCkiOA6cJX5K3dIUzLJ9mdjXWfKcB4MnlSW2
 1bPmb+64cYkqi26IL4kiPDHs/pVkWwm7UeWutP8AGjmUk6TMXc8zrtAtgMbrDQSF9P
 dTR/g0XfvjIF6Z3o2OL/PbIYKEuwdot6snUt655Wcz8bNamqsS9bZ89hwDsCF9s8Bc
 PUBLQHgBp4Ys4l+nqfa1tQ2fPtFlibjojzkOrNnb0lyc6VKJqzypXkbitw+3xVVX+j
 kTlvFzssouBgO4RzWzFTt4zB6/VBLqPz8gOMNolnNI6dMR79mJGA+0BTqpDUkGCmFa
 fvxF4GNOxHTVg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
In-Reply-To: <20191121101552.GR16031@gate.crashing.org>
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr>
 <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr>
 <877e3tbvsa.fsf@mpe.ellerman.id.au>
 <20191121101552.GR16031@gate.crashing.org>
Date: Mon, 25 Nov 2019 21:32:23 +1100
Message-ID: <87y2w49rgo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Nov 21, 2019 at 05:14:45PM +1100, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> That breaks 64-bit with GCC9:
>> 
>>   arch/powerpc/kernel/irq.c: In function 'do_IRQ':
>>   arch/powerpc/kernel/irq.c:650:2: error: PIC register clobbered by 'r2' in 'asm'
>>     650 |  asm volatile(
>>         |  ^~~
>>   arch/powerpc/kernel/irq.c: In function 'do_softirq_own_stack':
>>   arch/powerpc/kernel/irq.c:711:2: error: PIC register clobbered by 'r2' in 'asm'
>>     711 |  asm volatile(
>>         |  ^~~
>> 
>> 
>> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>> > index 04204be49577..d62fe18405a0 100644
>> > --- a/arch/powerpc/kernel/irq.c
>> > +++ b/arch/powerpc/kernel/irq.c
>> > @@ -642,6 +642,22 @@ void __do_irq(struct pt_regs *regs)
>> >  	irq_exit();
>> >  }
>> >  
>> > +static inline void call_do_irq(struct pt_regs *regs, void *sp)
>> > +{
>> > +	register unsigned long r3 asm("r3") = (unsigned long)regs;
>> > +
>> > +	/* Temporarily switch r1 to sp, call __do_irq() then restore r1 */
>> > +	asm volatile(
>> > +		"	"PPC_STLU"	1, %2(%1);\n"
>> > +		"	mr		1, %1;\n"
>> > +		"	bl		%3;\n"
>> > +		"	"PPC_LL"	1, 0(1);\n" :
>> > +		"+r"(r3) :
>> > +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
>> > +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
>> > +		"r0", "r2", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>> > +}
>> 
>> If we add a nop after the bl, so the linker could insert a TOC restore,
>> then I don't think there's any circumstance under which we expect this
>> to actually clobber r2, is there?
>
> That is mostly correct.

That's the standard I aspire to :P

> If call_do_irq was a no-inline function, there would not be problems.
>
> What TOC does __do_irq require in r2 on entry, and what will be there
> when it returns?

The kernel TOC, and also the kernel TOC, unless something's gone wrong
or I'm missing something.

cheers
