Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 16:39:49 +1100
Subject: [PATCH 0/9] powerpc: Preliminary work to enable SMP BookE
Message-Id: <1228714789.103940.266501677728.qpush@grosgo>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches is aimed at supporting SMP on non-hash
based processors. It consists of a rework of the MMU context
management and TLB management, clearly splitting hash32, hash64
and nohash in both cases, adding SMP safe context handling and
some basic SMP TLB management.

There is room for improvements, such as implementing lazy TLB
flushing on processors without invalidate-by-PID support HW,
some better IPI mechanism, support for variable sizes PID,
lock less fast path in the MMU context switch, etc...
but it should basically work.

There are some semingly unrelated patches in the pile as they
are dependencies of the main ones so I'm including them in.
