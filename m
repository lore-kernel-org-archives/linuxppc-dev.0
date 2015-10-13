Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 566421A0902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 23:27:26 +1100 (AEDT)
Date: Tue, 13 Oct 2015 14:27:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 0/6] atomics: powerpc: Implement
 relaxed/acquire/release variants of some atomics
Message-ID: <20151013122713.GS3604@twins.programming.kicks-ass.net>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2015 at 10:14:00PM +0800, Boqun Feng wrote:
 
> The patchset consists of 6 parts:
> 
> 1.	Make xchg, cmpxchg and their atomic_ versions a full barrier
> 
> 2.	Add trivial tests for the new variants in lib/atomic64_test.c
> 
> 3.	Allow architectures to define their own __atomic_op_*() helpers
> 	to build other variants based on relaxed.
> 
> 4.	Implement atomic{,64}_{add,sub,inc,dec}_return_* variants
> 
> 5.	Implement xchg_* and atomic{,64}_xchg_* variants
> 
> 6.	Implement cmpxchg_* atomic{,64}_cmpxchg_* variants
> 
> 
> This patchset is based on current locking/core branch of the tip tree
> and all patches are built and boot tested for little endian pseries, and
> also tested by 0day.
> 

I don't see any immediate problems with this series at this point. Will,
Paul?
