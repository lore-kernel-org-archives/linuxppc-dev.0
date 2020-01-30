Return-Path: <SRS0=bRiG=3T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFDC33C9E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 11:28:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F9B206D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 11:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F9B206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 487dQJ1ZsyzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jan 2020 22:28:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 487dLl6Xq6zDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2020 22:25:19 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00UBPDSX026018;
 Thu, 30 Jan 2020 05:25:13 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 00UBPCkD026017;
 Thu, 30 Jan 2020 05:25:12 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 30 Jan 2020 05:25:12 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: powerpc Linux scv support and scv system call ABI proposal
Message-ID: <20200130112512.GS22482@gate.crashing.org>
References: <87tv4fd8wp.fsf@oldenburg2.str.redhat.com>
 <1580218232.2tezmthp1x.astroid@bobo.none>
 <20200128154026.GI22482@gate.crashing.org>
 <87o8unbm8u.fsf@oldenburg2.str.redhat.com>
 <20200128200133.GJ22482@gate.crashing.org>
 <87wo9a8cc8.fsf@oldenburg2.str.redhat.com>
 <20200129162947.GN22482@gate.crashing.org>
 <87imku8ac5.fsf@oldenburg2.str.redhat.com>
 <20200129175104.GO22482@gate.crashing.org>
 <87k1595iok.fsf@oldenburg2.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1595iok.fsf@oldenburg2.str.redhat.com>
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

On Thu, Jan 30, 2020 at 11:42:51AM +0100, Florian Weimer wrote:
> * Segher Boessenkool:
> > No, that *is* supported: as input to or output from an asm, a local
> > register asm variable *is* guaranteed to live in the specified register.
> > This is the *only* supported use.  Other uses may sometimes still work,
> > but they never worked reliably, and it cannot be made reliable; it has
> > been documented as not supported since ages, and it will not work at all
> > anymore some day.
> 
> I must say I find this situation *very* confusing.

Local register variables live in that register when they are operands to
an (extended) inline asm.  There are no other guarantees.  That is all.

> You said that r0 & 1 is undefined.

I said that in

  int reg asm("r0");
  ...
  ...  reg & 1  ...

in that last expression, reg can be in any register, not necessarily r0.
The code is still perfectly well-defined of course, it just might not do
what you expected.

>  I *assumed* that I would still get
> the value of r0 (the register) from the associated extended asm in this
> expression, even if it may now be a different register.  Your comment
> made me think that this is undefined.

Please show full(er) examples, I think we are talking about something
else?

> But then the syscall wrappers use
> this construct:
> 
>     __asm__ __volatile__						\
>       ("sc\n\t"								\
>        "mfcr  %0\n\t"							\
>        "0:"								\
>        : "=&r" (r0),							\
>          "=&r" (r3), "=&r" (r4), "=&r" (r5),				\
>          "=&r" (r6), "=&r" (r7), "=&r" (r8)				\
>        : ASM_INPUT_##nr							\
>        : "r9", "r10", "r11", "r12",					\
>          "cr0", "ctr", "memory");					\
> 	  err = r0;  \
>     r3;  \
> 
> That lone r3 at the end would be equally undefined because it is not
> used in an input or output operand of an extended asm statement.

Nothing is undefined.  That r3 variable at the end might not live in
register r3 there; but the output from the asm does (the compiler can
have swapped registers around already, or even put this in memory
(which is what will probably happen here at -O0!), etc.

> The GCC documentation has this warning:
> 
> |  _Warning:_ In the above example, be aware that a register (for
> | example 'r0') can be call-clobbered by subsequent code, including
> | function calls and library calls for arithmetic operators on other
> | variables (for example the initialization of 'p2').

Yes.  This does not matter for the only supported use.  This is why that
*is* the only supported use.  The documentation could use a touch-up, I
think.  Unless we still have problems here?

> On POWER, the LOADARGS macros attempt to deal with this by using
> non-register temporaries.  However, I don't know how effective this is
> if the compiler really doesn't deal with call-clobbered registers
> properly.

It worked on old compilers.  This isn't necessary on newer compilers.

> For the extended asm use case (to express register assignments that
> cannot be listed in constraints), I would expect that these variables
> retain their values according to the C specification (so they are never
> clobbered by calls), but that they only reside in their designated
> registers when used as input or output operands in extended asm
> statements.

That is what is done now.

In the old days (more than ten years ago), local register variables had
more guarantees, guarantees that were broken once by one (or all all of
the time, depends on your viewpoint ;-) )  Such variables *did* live in
the specified register everywhere, well, not *everywhere*, and there
the problems started.

Nowadays:

Local register variables live in that register when they are operands to
an (extended) inline asm.  There are no other guarantees.  That is all.


Segher
