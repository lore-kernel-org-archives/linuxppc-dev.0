Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B1B51A0392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 21:23:33 +1100 (AEDT)
Date: Mon, 19 Oct 2015 12:23:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151019102324.GO3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151019011718.GB924@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 19, 2015 at 09:17:18AM +0800, Boqun Feng wrote:
> This is confusing me right now. ;-)
> 
> Let's use a simple example for only one primitive, as I understand it,
> if we say a primitive A is "fully ordered", we actually mean:
> 
> 1.	The memory operations preceding(in program order) A can't be
> 	reordered after the memory operations following(in PO) A.
> 
> and
> 
> 2.	The memory operation(s) in A can't be reordered before the
> 	memory operations preceding(in PO) A and after the memory
> 	operations following(in PO) A.
> 
> If we say A is a "full barrier", we actually means:
> 
> 1.	The memory operations preceding(in program order) A can't be
> 	reordered after the memory operations following(in PO) A.
> 
> and
> 
> 2.	The memory ordering guarantee in #1 is visible globally.
> 
> Is that correct? Or "full barrier" is more strong than I understand,
> i.e. there is a third property of "full barrier":
> 
> 3.	The memory operation(s) in A can't be reordered before the
> 	memory operations preceding(in PO) A and after the memory
> 	operations following(in PO) A.
> 
> IOW, is "full barrier" a more strong version of "fully ordered" or not?

Yes, that was how I used it.

Now of course; the big question is do we want to promote this usage or
come up with a different set of words describing this stuff.

I think separating the ordering from the transitivity is useful, for we
can then talk about and specify them independently.

That is, we can say:

	LOAD-ACQUIRE: orders LOAD->{LOAD,STORE}
	              weak transitivity (RCpc)

	MB: orders {LOAD,STORE}->{LOAD,STORE} (fully ordered)
	    strong transitivity (RCsc)

etc..

Also, in the above I used weak and strong transitivity, but that too is
of course up for grabs.
