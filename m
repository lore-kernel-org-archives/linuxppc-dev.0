Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 279241A010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 01:24:55 +1100 (AEDT)
Received: by mail-ob0-x235.google.com with SMTP id sd4so7628490obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 06:24:55 -0800 (PST)
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
Subject: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Date: Tue, 15 Dec 2015 22:24:13 +0800
Message-Id: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This is v6 of the series.

Link for v1: https://lkml.org/lkml/2015/8/27/798
Link for v2: https://lkml.org/lkml/2015/9/16/527
Link for v3: https://lkml.org/lkml/2015/10/12/368
Link for v4: https://lkml.org/lkml/2015/10/14/670
Link for v5: https://lkml.org/lkml/2015/10/26/141


Changes since v5:

*	rebase on the next branch of powerpc.

*	pull two fix and one testcase patches out, which are already
	sent separately

*	some clean up or code format fixing.


Paul, Peter and Will, thank you for your comments and suggestions in the review
of previous versions. From this version on, This series is against the next
branch of powerpc tree, because most of the code touch arch/powerpc/*.


Relaxed/acquire/release variants of atomic operations {add,sub}_return and
{cmp,}xchg are introduced by commit:

"atomics: add acquire/release/relaxed variants of some atomic operations"

and {inc,dec}_return has been introduced by commit:

"locking/asm-generic: Add _{relaxed|acquire|release}() variants for inc/dec
atomics"

By default, the generic code will implement a relaxed variant as a full ordered
atomic operation and release/acquire a variant as a relaxed variant with a
necessary general barrier before or after.

On PPC, which has a weak memory order model, a relaxed variant can be
implemented more lightweightly than a full ordered one. Further more, release
and acquire variants can be implemented with arch-specific lightweight
barriers.

Therefore this patchset implements the relaxed/acquire/release variants based
on PPC memory model and specific barriers.

The patchset consists of 4 parts:

1.	Allow architectures to define their own __atomic_op_*() helpers
	to build other variants based on relaxed.

2.	Implement atomic{,64}_{add,sub,inc,dec}_return_* variants

3.	Implement xchg_* and atomic{,64}_xchg_* variants

4.	Implement cmpxchg_* atomic{,64}_cmpxchg_* variants


This patchset is against:
	
	git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
	commit 5f337e3e5b04b32793fd51adab438d46df99c933 

and has been tested by 0day. I also have run build and boot tests of this in
both guest(pseries) and host(powernv) environments.

Looking forward to any suggestion, question and comment ;-)

Regards,
Boqun
