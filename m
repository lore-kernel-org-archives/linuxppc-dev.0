Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Dec 2008 16:13:19 +1100
Subject: [PATCH 0/10] powerpc: Preliminary work to enable SMP BookE (v3)
Message-Id: <1229663599.904385.502157196243.qpush@grosgo>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
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
some better IPI mechanism, lock less fast path in the MMU context
switch, etc... but it should basically work.

This version addresses the issues raised about some of the patches
in the previous batch, removes the ones that were already merged
in -next and and rebases the remaining ones when needed.
