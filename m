Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D0D22C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 02:47:29 +1100 (EST)
Date: Wed, 19 Mar 2014 16:47:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140319154705.GB8557@laptop.programming.kicks-ass.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140319152619.GB10406@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 davidlohr@hp.com, paulus@samba.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 08:56:19PM +0530, Srikar Dronamraju wrote:
> There are 332 tasks all stuck in futex_wait_queue_me().
> I am able to reproduce this consistently.
> 
> Infact I can reproduce this if the java_constraint is either node, socket, system.
> However I am not able to reproduce if java_constraint is set to core.

What's any of that mean?

> I ran git bisect between v3.12 and v3.14-rc6 and found that
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b0c29f79ecea0b6fbcefc999e70f2843ae8306db
> 
> commit b0c29f79ecea0b6fbcefc999e70f2843ae8306db
> Author: Davidlohr Bueso <davidlohr@hp.com>
> Date:   Sun Jan 12 15:31:25 2014 -0800
> 
> futexes: Avoid taking the hb->lock if there's nothing to wake up
> 
> was the commit thats causing the threads to be stuck in futex.
> 
> I reverted b0c29f79ecea0b6fbcefc999e70f2843ae8306db on top of v3.14-rc6 and confirmed that
> reverting the commit solved the problem.

Joy,.. let me look at that with ppc in mind.
