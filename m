Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01E1D67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 11:46:17 +1000 (EST)
Date: Tue, 5 Apr 2005 17:26:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050405202604.GA9291@logos.cnet>
References: <20050404191718.GA30281@logos.cnet>
	<ba633c3356ff1ec71f53d4a0998132ff@embeddededge.com>
	<20050405114109.GA888@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050405114109.GA888@logos.cnet>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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

On Tue, Apr 05, 2005 at 08:41:09AM -0300, Marcelo Tosatti wrote:
> On Tue, Apr 05, 2005 at 11:58:17AM -0400, Dan Malek wrote:
> > 
> > On Apr 4, 2005, at 3:17 PM, Marcelo Tosatti wrote:
> > 
> > >Problem is that the "dcbst" instruction will, _sometimes_ (the 
> > >failure/success rate is about 1/4
> > >with my test application) fault as a _write_ operation on the data.
> > 
> > Oh, geeze .... It's all coming back to me now ....
> > 
> > The 8xx cache operations don't always operate as defined in the PEM.
> > There are likely to be some archive discussions within the Freescale
> > knowledge data base that describe the different behaviors I've seen
> > with the chip variants and revisions.  I can't find any of those e-mail
> > discussions, so I'll try to recall from memory.
> > 
> > The PEM cache instructions are all implemented in a microcode that
> > uses the 8xx unique cache control SPRs.  Depending upon the state
> > of the cache and MMU, it seems in some cases the EA translation is
> > subject to a "normal" protection match instead of a load operation 
> > match.
> > 
> > The behavior of these operations isn't consistent across all of the 8xx
> > processor revisions, especially with early silicon if people are still
> > using those.  During conversations with Freescale engineers, it seems
> > the only guaranteed operation was to use the 8xx unique SPRs, but
> > I think I only did that in 8xx specific functions.
> 
> How sweet.  :)
> 
> > We have way too much code in the TLB exception handlers already,
> > so let's just try a tlbia of the EA in the update_mmu_cache, with an 
> > #ifdef
> > for the 8xx.  
> 
> Are you sure this is the best solution ? 
> 
> Problem is that update_mmu_cache() is called from other context's where
> the tlb invalidate is not necessary (because it has already been invalidated).
> 
> For example all ptep_set_access_flags() (which does the tlb invalidate) -> 
> update_mmu_cache() sequences.
> 
> Moreover jumping directly from DataTLBMiss to the page fault handler
> shortcuts the process: there is no need to jump back to execution if we
> know in advance that DataTLBError exception is going to happen. 
> 
> But hey, you are the boss. Even with the above facts you prefer 
> to leave the DataTLBMiss untouched? 
> 
> About size: I think it is the smaller expection handler present.

Well, you know what you're talking about. Whatever you prefer.

Can we just ask someone to send the _tlbie patch around #ifdef CONFIG_M8XX?  
