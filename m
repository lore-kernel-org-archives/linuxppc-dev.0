Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFA262C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 04:53:36 +1100 (EST)
Date: Mon, 10 Feb 2014 18:53:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2] powerpc ticket locks
Message-ID: <20140210175325.GA27965@twins.programming.kicks-ass.net>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
 <20140210155217.GF2107@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140210155217.GF2107@lst.de>
Cc: Tom Musta <tommusta@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 10, 2014 at 04:52:17PM +0100, Torsten Duwe wrote:
> Opinions, anyone?

Since the holder thing is a performance thing, not a correctness thing;
one thing you could do is something like:

static const int OWNER_HASH_SIZE = CONFIG_NR_CPUS * 4;
static const int OWNER_HASH_BITS = ilog2(OWNER_HASH_SIZE);

u16 lock_owner_array[OWNER_HASH_SIZE] = { 0, };

void set_owner(struct arch_spinlock_t *lock, int owner)
{
	int hash = hash_ptr(lock, OWNER_HASH_BITS);
	lock_owner_array[hash] = owner;
}

void yield_to_owner(struct arch_spinlock_t *lock)
{
	int hash = hash_ptr(lock, OWNER_HASH_BITS);
	int owner = lock_owner_array[hash];
	yield_to_cpu(owner);
}

And call set_owner() after the ticket lock is acquired, and don't bother
clearing it again; a new acquire will overwrite, a collision we have to
live with.

It should on average get you the right yield and does away with having
to track the owner field in place.

It does however get you an extra cacheline miss on acquire :/

One could consider patching it out when you know your kernel is not
running on an overloaded partition.
