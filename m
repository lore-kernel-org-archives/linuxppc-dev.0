Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7A331A028E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 22:02:52 +1100 (AEDT)
Date: Fri, 9 Oct 2015 13:02:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009110246.GY3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009094039.GD26278@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> Stepping back a second, I believe that there are three cases:
> 
> 
>  RELEASE X -> ACQUIRE Y (same CPU)
>    * Needs a barrier on TSO architectures for full ordering
	+PPC

>  UNLOCK X -> LOCK Y (same CPU)
>    * Needs a barrier on PPC for full ordering


>  RELEASE X -> ACQUIRE X (different CPUs)
    * Fully ordered everywhere...
    * ... but needs a barrier on TSO + PPC to become a full barrier

>  UNLOCK X -> ACQUIRE X (different CPUs)

s/ACQUIRE/LOCK/ ?

>    * Fully ordered everywhere...
>    * ... but needs a barrier on PPC to become a full barrier

If you really meant ACQUIRE, then x86 also needs a barrier in order to
upgrade, seeing how our unlock is equivalent to smp_store_release(). Our
LOCK otoh is far heavier than smp_load_acquire() and would result in
different rules.

And I'm not sure the "(different CPUs)" bit makes sense, as the same is
true if they're on the same CPU.
