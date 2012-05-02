Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A3A3CB6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 07:22:27 +1000 (EST)
Message-ID: <1335993615.4088.1.camel@pasglop>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Thu, 03 May 2012 07:20:15 +1000
In-Reply-To: <alpine.LSU.2.00.1205021324430.24246@eggly.anvils>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
 <1335832418.20866.95.camel@pasglop>
 <alpine.LSU.2.00.1204302142310.27208@eggly.anvils>
 <20120501142208.GA2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205011410360.28232@eggly.anvils>
 <20120501232516.GR2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205021324430.24246@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-05-02 at 13:25 -0700, Hugh Dickins wrote:
> Got it at last.  Embarrassingly obvious.  __rcu_read_lock() and
> __rcu_read_unlock() are not safe to be using __this_cpu operations,
> the cpu may change in between the rmw's read and write: they should
> be using this_cpu operations (or, I put preempt_disable/enable in the
> __rcu_read_unlock below).  __this_cpus there work out fine on x86,
> which was given good instructions to use; but not so well on PowerPC.
> 
> I've been running successfully for an hour now with the patch below;
> but I expect you'll want to consider the tradeoffs, and may choose a
> different solution.

Didn't Linus recently rant about these __this_cpu vs this_cpu nonsense ?

I thought that was going out..

Cheers,
Ben.
