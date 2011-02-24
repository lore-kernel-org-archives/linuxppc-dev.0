Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F7F5B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 08:23:42 +1100 (EST)
Subject: Re: PowerPC BUG: using smp_processor_id() in preemptible code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1298581675.5226.840.camel@laptop>
References: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
	<1293705910.17779.60.camel@pasglop>
	<alpine.LSU.2.00.1102241216420.1708@sister.anvils>
	<1298581675.5226.840.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Feb 2011 08:23:26 +1100
Message-ID: <1298582606.8833.509.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-24 at 22:07 +0100, Peter Zijlstra wrote:
> 
> Lovely problem :-), benh mentioned it on IRC, but I never got around
> to
> finding the email thread, thanks for the CC.
> 
> > What would be better for 2.6.38 and 2.6.37-stable?  Moving that call
> to
> > vunmap_page_range back under vb->lock, or the partial-Peter-patch
> below?
> > And then what should be done for 2.6.39?
> 
> I think you'll also need the arch/powerpc/kernel/process.c changes
> that
> cause context switches to flush the tlb_batch queues.

I don't think that's needed here as there shall be no batching happening
on the vmalloc space, but it can't hurt to merge it regardless :-)

Cheers,
Ben.
