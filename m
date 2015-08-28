Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com
 [IPv6:2607:f8b0:4001:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 737AE1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 12:48:41 +1000 (AEST)
Received: by iodv127 with SMTP id v127so78988508iod.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:48:39 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/5] atomics: powerpc: implement relaxed/acquire/release
 variants of some atomics
Date: Fri, 28 Aug 2015 10:48:14 +0800
Message-Id: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Relaxed/acquire/release variants of atomic operations {add,sub}_return and
{cmp,}xchg are introduced by commit:

"atomics: add acquire/release/relaxed variants of some atomic operations"

which is now on locking/core branch of tip tree.

By default, the generic code will implement relaxed variants as a full
ordered atomic operation and release/acquire variants as a relaxed variants
with a necessary general barrier before or after.

On powerpc, which has a weak memory order model, a relaxed variant can be
implemented more lightweightly than a full ordered one. Further more,
release and acquire variants can be implemented with arch-specific
lightweight barriers.

Therefore this patchset implements the relaxed/acquire/release variants
based on powerpc memory model and specific barriers. A trivial test for
these new variants is also included in this series, because some of these
variants are not used in kernel for now, I would like to make the code of
these variants at least generated somewhere.

The patchset consists of 5 parts:

1.	add trivial tests for the new variants in lib/atomic64_test.c

2.	introduce arch_atomic_op_*() helpers as the arch-specific helpers
	to build other variants based on relaxed.

3.	implement atomic{,64}_{add,sub}_return_* variants

4.	implement xchg_* and atomic{,64}_xchg_* variants

5.	implement cmpxchg_* atomic{,64}_cmpxchg_* variants

This patchset is based on locking/core branch of tip tree and all patches
are built and boot tested for LE pseries.

Regards,
Boqun

-- 
2.5.0
