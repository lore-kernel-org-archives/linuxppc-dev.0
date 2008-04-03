Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43413DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 08:46:31 +1100 (EST)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <200804031347.54517.hollisb@us.ibm.com>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<200804031347.54517.hollisb@us.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 08:45:47 +1100
Message-Id: <1207259147.10388.332.camel@pasglop>
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


On Thu, 2008-04-03 at 13:47 -0500, Hollis Blanchard wrote:
> 
> x86 virtualization implementations often needs a trampoline that's
> mapped into 
> both host and guest virtual address space, so that's part of what
> you're 
> seeing.
> 
> In general though, it can be very useful for the host to own a piece
> of the 
> guest's virtual address space. For example, the host could rewrite 
> problematic guest instructions to branch to host-optimized code which
> avoids 
> hypercalls. However, this is impossible unless the host knows it can 
> overwrite some portion of the guest's effective address space.
> 
> reserve_top_address() doesn't look complicated, so we might as well
> keep it ?

Agreed. In fact, using the top of the address space for that is a good
idea as you can do the branching there using absolute branch
instructions which is simpler.

Ben.
