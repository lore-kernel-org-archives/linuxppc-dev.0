Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59D38DDFD4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 07:30:15 +1000 (EST)
Subject: Re: [PATCH v3 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb	invalidates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rafal Jaworowski <raj@semihalf.com>
In-Reply-To: <48C03439.1000301@semihalf.com>
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
	<48C03439.1000301@semihalf.com>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 07:30:06 +1000
Message-Id: <1220563806.4879.82.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-04 at 21:17 +0200, Rafal Jaworowski wrote:
> Kumar Gala wrote:
> [...]
> > The intent of this change is to handle SMP based invalidates via IPIs instead
> > of broadcasts as the mechanism scales better for larger number of cores.
> 
> Hi Kumar,
> 
> How is the inter-IPI deadlock avoidance designed in this new approach? I don't
> know the close details of low-level Book-E VM design in Linux, but am thinking
> about a scenario when we have two TLB misses hitting almost immediately on two
> different cores and they both want to send a TLB invalidate IPI to each other.
> How do you manage this?

Simple.. Just look how it's done on x86 :-) The flush_tlb_* operations
happen with interrupt enabled and no major lock held. They shouldn't
deadlock.

> The reason I ask is we had similar considerations (and problems) when bringing
> SMP to the dual core e500 on FreeBSD and ended up not using IPIs, at least for
> now, because of such concerns (and actual problems of this kind).

Well, it depends how your VM is designed. The linux one has beeing doing
IPIs for invalidations forever on x86 so it's not hard to adapt.

Ben.
