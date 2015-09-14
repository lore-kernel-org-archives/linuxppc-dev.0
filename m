Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1468F1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 21:35:37 +1000 (AEST)
Date: Mon, 14 Sep 2015 13:35:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150914113520.GP18489@twins.programming.kicks-ass.net>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
 <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com> <20150911124507.GB16833@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150911124507.GB16833@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Sorry for being tardy, I had a wee spell of feeling horrible and then I
procrastinated longer than I should have.

On Fri, Sep 11, 2015 at 01:45:07PM +0100, Will Deacon wrote:

> Peter, any thoughts? I'm not au fait with the x86 memory model, but what
> Paul's saying is worrying.

Right, so Paul is right -- and I completely forgot (I used to know about
that).

So all the TSO archs (SPARC-TSO, x86 (!OOSTORE) and s390) can do
smp_load_acquire()/smp_store_release() with just barrier(), and while:

	smp_store_release(&x);
	smp_load_acquire(&x);

will provide full order by means of the address dependency,

	smp_store_release(&x);
	smp_load_acquire(&y);

will not. Because the one reorder TSO allows is exactly that one.

> Peter -- if the above reordering can happen on x86, then moving away
> from RCpc is going to be less popular than I hoped...

Sadly yes.. We could of course try and split LOCK from ACQUIRE again,
but I'm not sure that's going to help anything except confusion.
