Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F279A1A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:00 +1000 (AEST)
Received: by padhk3 with SMTP id hk3so212543091pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:49:58 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 0/7] atomics: powerpc: Implement relaxed/acquire/release
 variants of some atomics
Date: Wed, 16 Sep 2015 23:49:28 +0800
Message-Id: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Link for v1: https://lkml.org/lkml/2015/8/27/798

Changes since v1:

*	avoid to introduce macro arch_atomic_op_*()

*	also fix the problem that cmpxchg, xchg and their atomic_
	versions are not full barriers in PPC implementation.

*	rebase on v4.3-rc1


Relaxed/acquire/release variants of atomic operations {add,sub}_return
and {cmp,}xchg are introduced by commit:

"atomics: add acquire/release/relaxed variants of some atomic operations"

By default, the generic code will implement a relaxed variant as a full
ordered atomic operation and release/acquire a variant as a relaxed
variant with a necessary general barrier before or after.

On powerpc, which has a weak memory order model, a relaxed variant can
be implemented more lightweightly than a full ordered one. Further more,
release and acquire variants can be implemented with arch-specific
lightweight barriers.

Besides, cmpxchg, xchg and their atomic_ versions are only RELEASE+ACQUIRE
rather that full barriers in current PPC implementation, which is incorrect
according to memory-barriers.txt.

Therefore this patchset implements the relaxed/acquire/release variants
based on powerpc memory model and specific barriers, and fix cmpxchg,
xchg and their atomic_ versions. A trivial test for these new variants
is also included in this series, because some of these variants are not
used in kernel for now, I think is a good idea to at least generate the
code for these variants somewhere.

The patchset consists of 7 parts:

1.	Add trivial tests for the new variants in lib/atomic64_test.c

2.	Allow architectures to define their own __atomic_op_*() helpers
	to build other variants based on relaxed.

3.	Implement atomic{,64}_{add,sub}_return_* variants

4.	Implement xchg_* and atomic{,64}_xchg_* variants

5.	Implement cmpxchg_* atomic{,64}_cmpxchg_* variants

6.	Make atomic{,64}_xchg and xchg full barriers

7.	Make atomic{,64}_cmpxchg and cmpxchg full barriers

This patchset is based on v4.3-rc1 and all patches are built and boot
tested for little endian powernv and pseries, and also tested by 0day.


Looking forward to any suggestion, question and comment ;-)

Regards,
Boqun
