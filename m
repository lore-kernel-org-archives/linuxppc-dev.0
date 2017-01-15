Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1qSg6LbwzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 08:36:51 +1100 (AEDT)
Date: Mon, 16 Jan 2017 08:36:00 +1100
From: Anton Blanchard <anton@samba.org>
To: behanw@converseincode.com, ying.huang@intel.com, a.p.zijlstra@chello.nl,
 akpm@linux-foundation.org, oleg@redhat.com, Segher Boessenkool
 <segher@kernel.crashing.org>, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: llist code relies on undefined behaviour, upsets llvm/clang
Message-ID: <20170116083600.47175073@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was debugging a hang on a ppc64le kernel built with clang, and it
looks to be undefined behaviour with pointer wrapping in the llist code.

A test case is below. llist_for_each_entry() does container_of() on a
NULL pointer, which wraps our pointer negative, then adds the same
offset back in and expects to get back to NULL. Unfortunately clang
decides that this can never be NULL and optimises it into an infinite
loop.

Build with -DFIX, such that the llist_node has a zero offset from the
start of the struct, and things work.

Is anyone other than ppc64le building kernels with llvm/clang these
days? This should reproduce on ARM64 and x86-64.

Anton
--

#include <stdio.h>

#define __compiler_offsetof(a, b)                                       \
        __builtin_offsetof(a, b)

#undef offsetof
#ifdef __compiler_offsetof
#define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
#else
#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
#endif

struct llist_node {
        struct llist_node *next;
};

#define container_of(ptr, type, member) ({                      \
        const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
        (type *)( (char *)__mptr - offsetof(type,member) );})

#define llist_entry(ptr, type, member)          \
        container_of(ptr, type, member)

#define llist_for_each_entry(pos, node, member)                         \
        for ((pos) = llist_entry((node), typeof(*(pos)), member);       \
             &(pos)->member != NULL;                                    \
             (pos) = llist_entry((pos)->member.next, typeof(*(pos)), member))

struct foo {
#ifndef FIX
	unsigned long a;
#endif
	struct llist_node ll;
};

void working(void);

struct llist_node *ptr;

void bar(void)
{
	struct foo *f;

	llist_for_each_entry(f, ptr, ll) {
	}

	working();
}
