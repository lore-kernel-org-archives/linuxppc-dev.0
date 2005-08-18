Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 882416807A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 04:08:24 +1000 (EST)
Date: Thu, 18 Aug 2005 11:08:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050818110821.M14235@cox.net>
References: <521x4tha7i.fsf@cisco.com> <20050818175642.GA7523@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050818175642.GA7523@dmt.cnet>;
	from marcelo.tosatti@cyclades.com on Thu, Aug 18, 2005 at
	02:56:42PM -0300
Cc: Roland Dreier <rolandd@cisco.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PPC: Don't sleep in flush_dcache_icache_page()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2005 at 02:56:42PM -0300, Marcelo Tosatti wrote:
> 
> Hi Roland,
> 
> On Tue, Aug 16, 2005 at 01:56:49PM -0700, Roland Dreier wrote:
> > flush_dcache_icache_page() will be called on an instruction page
> > fault.  We can't sleep in the fault handler, so use kmap_atomic()
> > instead of just kmap() for the Book-E case.
> > 
> > Signed-off-by: Roland Dreier <rolandd@cisco.com>
> 
> Why do you need to disable interrupts during the kmap_atomic/flush_dcache_icache
> operation ? 
> 
> I fail to see how an interrupt could have any reference to the data
> being dealt with here (the user page).

We just took care of this offline.  The original patch is sharing
a kmap slot with another kmap_atomic user I put in before...the
sync page user.  If an interrupt came in causing the DMA API to
be used, we would have a problem.

The clean solution was to use a different kmap slot.

-Matt
