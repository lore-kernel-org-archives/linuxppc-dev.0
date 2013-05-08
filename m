Return-Path: <peter@programming.kicks-ass.net>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A15C2C00F3
 for <linuxppc-dev@ozlabs.org>; Thu,  9 May 2013 02:01:13 +1000 (EST)
Date: Wed, 8 May 2013 17:59:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Invalid perf_branch_entry.to entries question
Message-ID: <20130508155929.GA8459@dyad.programming.kicks-ass.net>
References: <25394.1367890528@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25394.1367890528@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 eranian@google.com, Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 07, 2013 at 11:35:28AM +1000, Michael Neuling wrote:
> Peter & Stephane,
> 
> We are plumbing the POWER8 Branch History Rolling Buffer (BHRB) into
> struct perf_branch_entry.
> 
> Sometimes on POWER8 we may not be able to fill out the "to" address.  

Just because I'm curious.. however does that happen? Surely the CPU knows where
next to fetch instructions?

> We
> initially thought of just making this 0, but it's feasible that this
> could be a valid address to branch to. 

Right, while highly unlikely, x86 actually has some cases where 0 address is
valid *shudder*..

> The other logical value to indicate an invalid entry would be all 1s
> which is not possible (on POWER at least).
> 
> Do you guys have a preference as to what we should use as an invalid
> entry?  This would have some consequences for the userspace tool also.
> 
> The alternative would be to add a flag alongside mispred/predicted to
> indicate the validity of the "to" address.

Either would work with me I suppose.. Stephane do you have any preference?
