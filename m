Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6C85B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 07:54:14 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 2 May 2012 15:54:12 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 99AB1C90052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2012 17:54:06 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q42Ls8Fe113268
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2012 17:54:08 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q42Ls7ME016711
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2012 15:54:07 -0600
Date: Wed, 2 May 2012 14:54:06 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
Message-ID: <20120502215406.GL2450@linux.vnet.ibm.com>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
 <1335832418.20866.95.camel@pasglop>
 <alpine.LSU.2.00.1204302142310.27208@eggly.anvils>
 <20120501142208.GA2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205011410360.28232@eggly.anvils>
 <20120501232516.GR2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205021324430.24246@eggly.anvils>
 <1335993615.4088.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335993615.4088.1.camel@pasglop>
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2012 at 07:20:15AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-05-02 at 13:25 -0700, Hugh Dickins wrote:
> > Got it at last.  Embarrassingly obvious.  __rcu_read_lock() and
> > __rcu_read_unlock() are not safe to be using __this_cpu operations,
> > the cpu may change in between the rmw's read and write: they should
> > be using this_cpu operations (or, I put preempt_disable/enable in the
> > __rcu_read_unlock below).  __this_cpus there work out fine on x86,
> > which was given good instructions to use; but not so well on PowerPC.
> > 
> > I've been running successfully for an hour now with the patch below;
> > but I expect you'll want to consider the tradeoffs, and may choose a
> > different solution.
> 
> Didn't Linus recently rant about these __this_cpu vs this_cpu nonsense ?
> 
> I thought that was going out..

Linus did rant about __raw_get_cpu_var() because it cannot use the x86
%fs segement overrides a bit more than a month ago.  The __this_cpu
stuff is useful if you have preemption disabled -- avoids the extra
layer of preempt_disable().

Or was this a different rant?

							Thanx, Paul
