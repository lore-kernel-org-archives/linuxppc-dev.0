Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79AF71A0456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 20:51:34 +1100 (AEDT)
Received: by iody8 with SMTP id y8so24713795iod.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 02:51:32 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/locking/core v5 0/6] atomics: powerpc: Implement
 relaxed/acquire/release variants of some atomics
Date: Mon, 26 Oct 2015 17:50:51 +0800
Message-Id: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This is v5 of the series.

Link for v1: https://lkml.org/lkml/2015/8/27/798
Link for v2: https://lkml.org/lkml/2015/9/16/527
Link for v3: https://lkml.org/lkml/2015/10/12/368
Link for v4: https://lkml.org/lkml/2015/10/14/670

Changes since v4:

*	define PPC_ATOMIC_ENTRY_BARRIER as "sync" (Paul E. Mckenney)

*	remove PPC-specific __atomic_op_fence().


Relaxed/acquire/release variants of atomic operations {add,sub}_return
and {cmp,}xchg are introduced by commit:

"atomics: add acquire/release/relaxed variants of some atomic operations"

and {inc,dec}_return has been introduced by commit:

"locking/asm-generic: Add _{relaxed|acquire|release}() variants for
inc/dec atomics"

Both of these are in the current locking/core branch of the tip tree.

By default, the generic code will implement a relaxed variant as a full
ordered atomic operation and release/acquire a variant as a relaxed
variant with a necessary general barrier before or after.

On PPC, which has a weak memory order model, a relaxed variant can be
implemented more lightweightly than a full ordered one. Further more, release
and acquire variants can be implemented with arch-specific lightweight
barriers.

Besides, cmpxchg, xchg and their atomic_ versions are only RELEASE+ACQUIRE
rather that fully ordered in current PPC implementation, which is incorrect
according to memory-barriers.txt. Further more, PPC_ATOMIC_ENTRY_BARRIER, the
leading barrier of fully ordered atomics, should be "sync" rather than "lwsync"
if SMP=y, to guarantee fully ordered semantics.

Therefore this patchset fixes the order guarantee of cmpxchg, xchg and
value-returning atomics on PPC and implements the relaxed/acquire/release
variants based on PPC memory model and specific barriers, Some trivial tests
for these new variants are also included in this series, because some of these
variants are not used in kernel for now, I think is a good idea to at least
generate the code for these variants somewhere.

The patchset consists of 6 parts:

1.	Make value-returning atomics, futex atomics, xchg and cmpxchg fully
	ordered

2.	Add trivial tests for the new variants in lib/atomic64_test.c

3.	Allow architectures to define their own __atomic_op_*() helpers
	to build other variants based on relaxed.

4.	Implement atomic{,64}_{add,sub,inc,dec}_return_* variants

5.	Implement xchg_* and atomic{,64}_xchg_* variants

6.	Implement cmpxchg_* atomic{,64}_cmpxchg_* variants


This patchset is based on current locking/core branch of the tip tree
and all patches are built and boot tested for little endian pseries, and
also tested by 0day.


Looking forward to any suggestion, question and comment ;-)

Regards,
Boqun
