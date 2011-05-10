Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C869B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 00:47:54 +1000 (EST)
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJoE3-0008GF-Df
	for linuxppc-dev@lists.ozlabs.org; Tue, 10 May 2011 14:47:51 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219]
	helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1QJoE1-00023O-Rc
	for linuxppc-dev@lists.ozlabs.org; Tue, 10 May 2011 14:47:50 +0000
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <4DC85BFE.7060900@linux.vnet.ibm.com>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>  <1303294056.8345.122.camel@twins>
	<1303336869.2513.26.camel@pasglop>
	<4DC85BFE.7060900@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 May 2011 16:09:23 +0200
Message-ID: <1305036563.2914.80.camel@laptop>
Mime-Version: 1.0
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-09 at 16:26 -0500, Jesse Larrew wrote:
> 
> According the the Power firmware folks, updating the home node of a
> virtual cpu happens rather infrequently. The VPHN code currently
> checks for topology updates every 60 seconds, but we can poll less
> frequently if it helps. I chose 60 second intervals simply because
> that's how often they check the topology on s390. ;-)

This just makes me shudder, so you poll the state? Meaning that the vcpu
can actually run 99% of the time on another node?

What's the point of this if the vcpu scheduler can move the vcpu around
much faster?

> As for updating the memory topology, there are cases where changing
> the home node of a virtual cpu doesn't affect the memory topology. If
> it does, there is a separate notification system for memory topology
> updates that is independent from the cpu updates. I plan to start
> working on a patch set to enable memory topology updates in the kernel
> in the coming weeks, but I wanted to get the cpu patches out on the
> list so we could start having these debates. :) 

Well, they weren't put out on a list (well maybe on the ppc list but
that's the same as not posting them from my pov), they were merged (and
thus declared done) that's not how you normally start a debate.

I would really like to see both patch-sets together. Also, I'm not at
all convinced its a sane thing to do. Pretty much all NUMA aware
software I know of assumes that CPU<->NODE relations are static,
breaking that in kernel renders all existing software broken.
