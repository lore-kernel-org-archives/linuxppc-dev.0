Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F2E867A7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 02:19:52 +1100 (EST)
Date: Wed, 23 Mar 2005 07:25:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050323102501.GF7846@logos.cnet>
References: <28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
	<20050322175815.GB7846@logos.cnet>
	<ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>
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

On Tue, Mar 22, 2005 at 05:53:40PM -0500, Dan Malek wrote:
> 
> On Mar 22, 2005, at 12:58 PM, Marcelo Tosatti wrote:
> 
> >Newbie question: What prevents the initial kernel map (tuple of 8Mbyte 
> >I/D-TLB entries)
> >and the IMMR 8Mbyte D-TLB entry from getting unmapped by translation 
> >pressure,
> >in case CONFIG_PIN_TLB is disabled ?
> 
> Nothing.  In fact, they are likely invalidated shortly after the kernel
> page tables are set up.  This was only done to ensure we could get the
> kernel initialized without taking page faults.

OK.

> >By a counter at the end of _tlbie function, similar to other counters 
> >which
> >you suggested.
> 
> OK.
> 
> >Dont think thats the case given that v2.4 calls tlbia through 
> >flush_tlb_mm() at exit_mmap()
> >only. And at vmalloc_free which shouldnt be called at all.
> 
> Hmmm ...  Then, the 2.6 looks to be much less efficient with the MMU
> resources than 2.4 was.  This is going to affect everyone, it's just 
> easier
> to measure on this processor.

Many codepaths are longer (eg. but the difference 

> 
> >I just noticed this conditional at switch_mm() (v2.6), which _can_ 
> >partly
> >explain the reduced tlbie's  (its just a guess for now, though):
> 
> What is your guess?  I don't know how this would reduce the number
> of tlbie instructions, since stealing a context (as part of 
> get_context())
> will simply whack the whole TLB with a tlbia.  On 8xx, both instructions
> could be simply implemented as macros.

You misunderstood: get_mmu_context() _wont_ be called if the mm structures 
are the same.

v2.4 didnt had this optimization. 

> >Spent part of the day reading the MMU section of 860 manual, I think I 
> >have kind
> >of a clue how things are supposed to work at the lowlevel now.
> 
> :-)
> 
> >PS: I can't reproduce the invalid TLB crash anymore. i.e. even by 
> >removing
> >the _tlbie() at update_mmu_cache() everything is working as expected.
> 
> Well, that's interesting.  It's likely to only happen on an 860 variant 
> that
> has the large TLB.

For what reasoning? 

> >How can I reproduce it again? Guillaume, what kernel version are you 
> >using?
> 
> It used to happen on early 2.6 versions as soon as you entered user
> space programs.

Will let you know of any findings...
