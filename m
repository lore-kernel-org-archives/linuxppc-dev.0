Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01309C4743C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 00:26:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF0A60FEB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 00:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF0A60FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G86dP1ldrz3bs9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 10:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4G86cx24CLz2xfw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 10:25:51 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 15M0FcLB031530;
 Mon, 21 Jun 2021 19:15:38 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 15M0FYP5031529;
 Mon, 21 Jun 2021 19:15:34 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 21 Jun 2021 19:15:34 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
Message-ID: <20210622001534.GC5077@gate.crashing.org>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
 <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu>
 <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com>
 <4d2026cc-28e1-7781-fc95-e6160bd8db86@csgroup.eu>
 <20210619150202.GZ5077@gate.crashing.org>
 <52451ce4-3eb2-e14b-81a9-99da2c0a2328@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52451ce4-3eb2-e14b-81a9-99da2c0a2328@csgroup.eu>
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
Cc: maged michael <maged.michael@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Watson <davejwatson@fb.com>,
 Will Deacon <will.deacon@arm.com>, "Russell King,
 ARM Linux" <linux@armlinux.org.uk>, David Sehr <sehr@google.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
 Andrew Hunter <ahh@google.com>, Greg Hackmann <ghackmann@google.com>,
 Ingo Molnar <mingo@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
 Paul <paulmck@linux.vnet.ibm.com>, Andrea Parri <parri.andrea@gmail.com>,
 Avi Kivity <avi@scylladb.com>, Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-api <linux-api@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Mon, Jun 21, 2021 at 04:11:04PM +0200, Christophe Leroy wrote:
> Le 19/06/2021 à 17:02, Segher Boessenkool a écrit :
> >The point of the twi in the I/O accessors was to make things easier to
> >debug if the accesses fail: for the twi insn to complete the load will
> >have to have completed as well.  On a correctly working system you never
> >should need this (until something fails ;-) )
> >
> >Without the twi you might need to enforce ordering in some cases still.
> >The twi is a very heavy hammer, but some of that that gives us is no
> >doubt actually needed.
> 
> Well, I've always been quite perplex about that. According to the 
> documentation of the 8xx, if a bus error or something happens on an I/O 
> access, the exception will be accounted on the instruction which does the 
> access. But based on the following function, I understand that some version 
> of powerpc do generate the trap on the instruction which was being executed 
> at the time the I/O access failed, not the instruction that does the access 
> itself ?

Trap instructions are never speculated (this may not be architectural,
but it is true on all existing implementations).  So the instructions
after the twi;isync will not execute until the twi itself has finished,
and that cannot happen before the preceding load has (because it uses
the loaded register).

Now, some I/O accesses can cause machine checks.  Machine checks are
asynchronous and can be hard to correlate to specific load insns, and
worse, you may not even have the address loaded from in architected
registers anymore.  Since I/O accesses often take *long*, tens or even
hundreds of cycles is not unusual, this can be a challenge.

To recover from machine checks you typically need special debug hardware
and/or software.  For the Apple machines those are not so easy to come
by.  This "twi after loads" thing made it pretty easy to figure out
where your code was going wrong.

And it isn't as slow as it may sound: typically you really need to have
the result of the load before you can go on do useful work anyway, and
loads from I/O are slow non-posted things.

> /*
>  * I/O accesses can cause machine checks on powermacs.
>  * Check if the NIP corresponds to the address of a sync
>  * instruction for which there is an entry in the exception
>  * table.
>  *  -- paulus.
>  */

I suspect this is from before the twi thing was added?

> It is not only the twi which bother's me in the I/O accessors but also the 
> sync/isync and stuff.
> 
> A write typically is
> 
> 	sync
> 	stw
> 
> A read is
> 
> 	sync
> 	lwz
> 	twi
> 	isync
> 
> Taking into account that HW ordering is garanteed by the fact that __iomem 
> is guarded,

Yes.  But machine checks are asynchronous :-)

> isn't the 'memory' clobber enough as a barrier ?

A "memory" clobber isn't a barrier of any kind.  "Compiler barriers" do
not exist.

The only thing such a clobber does is it tells the compiler that this
inline asm can access some memory, and we do not say at what address.
So the compiler cannot reorder this asm with other memory accesses.  It
has no other effects, no magical effects, and it is not comparable to
actual barrier instructions (that actually tell the hardware that some
certain ordering is required).

"Compiler barrier" is a harmful misnomer: language shapes thoughts,
using misleading names causes misguided thoughts.

Anyway :-)

The isync is simply to make sure the code after it does not start before
the code before it has completed.  The sync before I am not sure.


Segher
