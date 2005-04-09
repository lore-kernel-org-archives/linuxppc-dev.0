Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FA1A67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 15:17:58 +1000 (EST)
In-Reply-To: <20050408110724.GG19449@logos.cnet>
References: <20050407120013.GF14822@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHGEGHCLAA.Joakim.Tjernlund@lumentis.se>
	<20050407193846.GE19449@logos.cnet>
	<19116173cb07648317c2a73a9c822c70@embeddededge.com>
	<20050408110724.GG19449@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <86e2fa4b5afe5bd8afc33ca47a7ab50c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 9 Apr 2005 01:16:50 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 8, 2005, at 7:07 AM, Marcelo Tosatti wrote:

> 1) _tlbie() on update_mmu_cache() surrounded by CONFIG_8xx #ifdef
> Did you give up about it?

I think a tlbia() of the vaddr should work here.  No sense blowing
away the whole TLB cache for this.

> What else you think can be done?

It would be interesting to change __flush_dcache_icache()
to use the 8xx SPR cache operations instead of the dcbst instruction.
I wouldn't be surprised if it worked differently, but I'd not be
able to explain it :-)

Thanks.

	-- Dan
