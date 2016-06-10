Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQkLB2sGCzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:57:54 +1000 (AEST)
Message-ID: <1465520274.26682.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>
Date: Fri, 10 Jun 2016 10:57:54 +1000
In-Reply-To: <20160609175054.GY30154@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
 <20160606144659.GG30909@twins.programming.kicks-ass.net>
 <1465384845.13854.7.camel@ellerman.id.au>
 <20160608123507.GR30154@twins.programming.kicks-ass.net>
 <1465393760.10567.4.camel@ellerman.id.au>
 <20160608135903.GT30154@twins.programming.kicks-ass.net>
 <1465475008.16363.1.camel@ellerman.id.au>
 <20160609175054.GY30154@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-09 at 19:50 +0200, Peter Zijlstra wrote:
> On Thu, Jun 09, 2016 at 10:23:28PM +1000, Michael Ellerman wrote:
> > Unfortunately the patch isn't 100%.
> 
> So what I'll do; since my patch is trying to ensure all implementations
> of spin_unlock_wait() provide ACQUIRE semantics, and this patch does
> indeed do so, is skip touching PPC entirely and hope this patch lands
> before 4.8.

OK.

I don't see any reason it wouldn't make 4.8, we just need to decide whether we
use the old "while (lock->slock)" or one of the other options Boqun proposed.

cheers
