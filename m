Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EDA667AD5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 05:52:46 +1100 (EST)
Date: Thu, 10 Feb 2005 13:04:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050210150437.GA19134@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
Cc: "Smith, Craig" <craig.d.smith@siemens.com>,
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

On Tue, Sep 21, 2004 at 01:03:29PM -0400, Dan Malek wrote:
> 
> On Sep 21, 2004, at 7:59 AM, Smith, Craig wrote:
> 
> >Genius. That patch appears to work for me as well.
> 
> The fact this works indicates a subtle memory management
> problem elsewhere.  I don't know what that is at this
> point.  This hack is in a piece of generic code that works
> properly on all other PowerPC cores, so it isn't going to
> ever appear in the public sources.
> 
> I suggested this change to a few people hoping the information
> would lead them to finding the real problem, not that it
> should be perpetuated as a "fix" to make 8xx work.
> I don't personally have time to work on this right now,
> so anyone using 8xx should be looking for the real
> cause and solution, not using this to create products.

Hi Dan,

Does anyone have a clue of what is/can be wrong with the TLB entry for the 
address being flushed at __flush_dcache_icache()? 

Can we assume such TLB entry is corrupted in some way? 


This is v2.6.10 on m8xx - with the TLB invalidate everything works as
expected.

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00049F8 LR: C000A3E0 SP: C48D1E10 REGS: c48d1d60 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 100113A0, DSISR: C2000000
TASK = c4e1eba0[1230] 'netserver' THREAD: c48d0000
Last syscall: 20
GPR00: C4ED7D60 C48D1E10 C4E1EBA0 10011000 00000100 000954A0 10011000 C01C8090
GPR08: C02E64B8 C4ED7D60 00009032 00000000 00020591 100B46A8 00000000 100CA328
GPR16: 100CA1E8 2FEED1FF F657FFF4 00000000 00000000 00000000 C48D1E28 00000000
GPR24: C1148100 00000000 C1147EA4 C4ED7D60 100113A0 C1229418 04AA5889 C02E64A0
NIP [c00049f8] __flush_dcache_icache+0x14/0x40
LR [c000a3e0] update_mmu_cache+0x64/0x98
Call trace:
 [c003f3a4] do_no_page+0x2ec/0x364
 [c003f588] handle_mm_fault+0xa4/0x17c
 [c0009968] do_page_fault+0x168/0x394
 [c0002c68] handle_page_fault+0xc/0x80
