Return-Path: <SRS0=Ynhu=3R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B963C2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jan 2020 20:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A4C2070A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jan 2020 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486cxP28JTzDqND
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jan 2020 07:03:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486cvX3SQszDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2020 07:01:41 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00SK1YWp006436;
 Tue, 28 Jan 2020 14:01:34 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 00SK1XmX006435;
 Tue, 28 Jan 2020 14:01:33 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 28 Jan 2020 14:01:33 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: powerpc Linux scv support and scv system call ABI proposal
Message-ID: <20200128200133.GJ22482@gate.crashing.org>
References: <1580207907.c96c1lh9t0.astroid@bobo.none>
 <87tv4fd8wp.fsf@oldenburg2.str.redhat.com>
 <1580218232.2tezmthp1x.astroid@bobo.none>
 <20200128154026.GI22482@gate.crashing.org>
 <87o8unbm8u.fsf@oldenburg2.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8unbm8u.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: libc-alpha@sourceware.org,
 Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 28, 2020 at 05:04:49PM +0100, Florian Weimer wrote:
> * Segher Boessenkool:
> 
> >> > I don't think we can save LR in a regular register around the system
> >> > call, explicitly in the inline asm statement, because we still have to
> >> > generate proper unwinding information using CFI directives, something
> >> > that you cannot do from within the asm statement.
> >
> > Why not?
> 
> As far as I knowm there isn't a CFI directive that allows us to restore
> the CFI state at the end of the inline assembly.  If we say that LR is
> stored in a different register than what the rest of the function uses,
> that would lead to incorrect CFI after the exit of the inline assembler
> fragment.
> 
> At least that's what I think.  Compilers aren't really my thing.

.cfi_restore?  Or .cfi_remember_state / .cfi_restore_state, that is
probably easiest in inline assembler.

> >> > GCC does not model the condition registers,
> >
> > Huh?  It does model the condition register, as 8 registers in GCC's
> > internal model (one each for CR0..CR7).
> 
> But GCC doesn't expose them as integers to C code, so you can't do much
> without them.

Sure, it doesn't expose any other registers directly, either.

> >> > We don't have an ELFv2 ABI for 32-bit.  I doubt it makes sense to
> >> > provide an ELFv1 port for this given that it's POWER9-specific.
> >
> > We *do* have a 32-bit LE ABI.  And ELFv1 is not 32-bit either.  Please
> > don't confuse these things :-)
> >
> > The 64-bit LE kernel does not really support 32-bit userland (or BE
> > userland), *that* is what you want to say.
> 
> Sorry for the confusion.  Is POWER9 running kernels which are not 64-bit
> LE really a thing in practice, though?

Linux only really supports 64-bit LE userland on p9.  Anything else is
not supported.

> >> > From the glibc perspective, the major question is how we handle run-time
> >> > selection of the system call instruction sequence.
> >
> > Well, if it is inlined you don't have this problem either!  :-)
> 
> How so?  We would have to put the conditional sequence into all inline
> system calls, of course.

Ah, if you support older systems in your program as well, gotcha.  That
is not the usual case (just like people use -mcpu=power9 frequently,
which means the resulting program will not run on any older CPU).


Segher
