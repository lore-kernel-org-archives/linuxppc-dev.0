Return-Path: <peter@programming.kicks-ass.net>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 491122C00C7
 for <linuxppc-dev@ozlabs.org>; Fri, 10 May 2013 20:45:34 +1000 (EST)
Date: Fri, 10 May 2013 12:43:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Invalid perf_branch_entry.to entries question
Message-ID: <20130510104352.GF31235@dyad.programming.kicks-ass.net>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
 <14691.1368052755@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14691.1368052755@ale.ozlabs.ibm.com>
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

On Thu, May 09, 2013 at 08:39:15AM +1000, Michael Neuling wrote:
> > Just because I'm curious.. however does that happen? Surely the CPU
> > knows where next to fetch instructions?
> 
> For computed gotos (ie. branch to a register value), the hardware gives
> you the from and to address in the branch history buffer.
> 
> For branches where the branch target address is an immediate encoded in
> the instruction, the hardware only logs the from address.  It assumes
> that software (perf irq handler in this case) can read this branch
> instruction, calculate the corresponding offset and hence the
> to/target address.
> 
> It's entirely possible that when the perf IRQ handler happens, the
> instruction in question is not readable or is no longer a branch (self
> modifying code).  Hence we aren't able to calculate a valid to address.

Ohh how cute! You've gotta love lazy hardware :-)
