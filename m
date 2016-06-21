Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRX2NxTzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:56 +1000 (AEST)
In-Reply-To: <20160610035128.21087-1-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>,
 "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v4] powerpc: spinlock: Fix spin_unlock_wait()
Message-Id: <3rYTRV50CZz9t0w@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-10-06 at 03:51:28 UTC, Boqun Feng wrote:
> There is an ordering issue with spin_unlock_wait() on powerpc, because
> the spin_lock primitive is an ACQUIRE and an ACQUIRE is only ordering
> the load part of the operation with memory operations following it.
...
> 
> Suggested-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> [mpe: Inline the "nop" ll/sc loop and set EH=0, munge change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6262db7c088bbfc26480d10144

cheers
