Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67DB267A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 09:53:44 +1100 (EST)
In-Reply-To: <20050322175815.GB7846@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
	<20050322175815.GB7846@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 22 Mar 2005 17:53:40 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Smith, Craig" <craig.d.smith@siemens.com>, paulus@samba.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 22, 2005, at 12:58 PM, Marcelo Tosatti wrote:

> Newbie question: What prevents the initial kernel map (tuple of 8Mbyte 
> I/D-TLB entries)
> and the IMMR 8Mbyte D-TLB entry from getting unmapped by translation 
> pressure,
> in case CONFIG_PIN_TLB is disabled ?

Nothing.  In fact, they are likely invalidated shortly after the kernel
page tables are set up.  This was only done to ensure we could get the
kernel initialized without taking page faults.

> By a counter at the end of _tlbie function, similar to other counters 
> which
> you suggested.

OK.

> Dont think thats the case given that v2.4 calls tlbia through 
> flush_tlb_mm() at exit_mmap()
> only. And at vmalloc_free which shouldnt be called at all.

Hmmm ...  Then, the 2.6 looks to be much less efficient with the MMU
resources than 2.4 was.  This is going to affect everyone, it's just 
easier
to measure on this processor.

> I just noticed this conditional at switch_mm() (v2.6), which _can_ 
> partly
> explain the reduced tlbie's  (its just a guess for now, though):

What is your guess?  I don't know how this would reduce the number
of tlbie instructions, since stealing a context (as part of 
get_context())
will simply whack the whole TLB with a tlbia.  On 8xx, both instructions
could be simply implemented as macros.

> Spent part of the day reading the MMU section of 860 manual, I think I 
> have kind
> of a clue how things are supposed to work at the lowlevel now.

:-)

> PS: I can't reproduce the invalid TLB crash anymore. i.e. even by 
> removing
> the _tlbie() at update_mmu_cache() everything is working as expected.

Well, that's interesting.  It's likely to only happen on an 860 variant 
that
has the large TLB.

> How can I reproduce it again? Guillaume, what kernel version are you 
> using?

It used to happen on early 2.6 versions as soon as you entered user
space programs.


	-- Dan
