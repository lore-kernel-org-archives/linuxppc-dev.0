Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5594ADDEEB
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 19:55:07 +1000 (EST)
Date: Mon, 14 Jul 2008 19:55:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc/generic-ipi tree build failure
Message-Id: <20080714195503.38728a34.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next build (powerpc allmodconfig) failed like this:

ERROR: ".save_stack_trace" [tests/backtracetest.ko] undefined!

But save_stack_trace is exported in arch/powerpc/kernel/stacktrace.c

I couldn't figure it out until I noticed these earlier warnings:

arch/powerpc/kernel/stacktrace.c:47: warning: data definition has no type or storage class
arch/powerpc/kernel/stacktrace.c:47: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/powerpc/kernel/stacktrace.c:47: warning: parameter names (without types) in function declaration

I applied the patch below.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

>From 91ec767c487ff260455e416fee161015a8bdb0c5 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 14 Jul 2008 19:45:59 +1000
Subject: [PATCH] powerpc/stacktrace: EXPORT SYMBOL_GPL needs module.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/stacktrace.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 9861f17..3cf0d94 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -12,6 +12,7 @@
 
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include <linux/module.h>
 #include <asm/ptrace.h>
 
 /*
-- 
1.5.6.2
