Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 964C9686BC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 02:17:14 +1100 (EST)
Date: Mon, 7 Nov 2005 08:16:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <20051107101618.GA15522@logos.cnet>
References: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org,
	Dan Malek <dan@embeddedalley.com>, gtolstolytkin@ru.mvista.com
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joakim!

On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim Tjernlund wrote:
> Hi Marcelo
> 
> [SNIP] 
> > The root of the problem are the changes against the 8xx TLB 
> > handlers introduced
> > during v2.6. What happens is the TLBMiss handlers load the 
> > zeroed pte into
> > the TLB, causing the TLBError handler to be invoked (thats 
> > two TLB faults per 
> > pagefault), which then jumps to the generic MM code to setup the pte.
> > 
> > The bug is that the zeroed TLB is not invalidated (the same reason
> > for the "dcbst" misbehaviour), resulting in infinite TLBError faults.
> > 
> > Dan, I wonder why we just don't go back to v2.4 behaviour.
> 
> This is one reason why it is the way it is:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> This details are little fuzzy ATM, but I think the reason for the
> current
> impl. was only that it was less intrusive to impl.

Ah, I see. I wonder if the bug is processor specific: we don't have such
changes in our v2.4 tree and never experienced such problem.

It should be pretty easy to hit it right? (instruction pagefaults should
fail).

Grigori, Tom, can you enlight us about the issue on the URL above. How
can it be triggered?
