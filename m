Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 370AADE197
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 23:05:55 +1100 (EST)
Date: Mon, 12 Jan 2009 13:05:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.29-rc1 - Badness at kernel/sched.c:4440 with
	CONFIG_DEBUG_PREEMPT
Message-ID: <20090112120538.GB24266@elte.hu>
References: <20090112113914.GC8409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090112113914.GC8409@linux.vnet.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, dhaval@linux.vnet.ibm.com,
	mel@csn.ul.ie, vatsa@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev@ozlabs.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Hi Ingo,
> 
> 	While booting up 2.6.29-rc1 kernel on powerpc machine, Kernel
> Badness warning is seen, when compiled with CONFIG_DEBUG_PREEMPT=y

> kernel warning is not seen after reverting the patch.
> 
> commit 7317d7b87edb41a9135e30be1ec3f7ef817c53dd
> Author: Nick Piggin <nickpiggin@yahoo.com.au>
> Date:   Tue Sep 30 20:50:27 2008 +1000
> 
>     sched: improve preempt debugging

thanks. This has been bisected before by Alexey Zaytsev so i've now 
reverted the commit in tip/sched/urgent and will send it to Linus ASAP. 
The revert commit can be found below.

	Ingo

--------------------->
>From 01e3eb82278bf45221fc38b391bc5ee0f6a314d6 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 12 Jan 2009 13:00:50 +0100
Subject: [PATCH] Revert "sched: improve preempt debugging"

This reverts commit 7317d7b87edb41a9135e30be1ec3f7ef817c53dd.

This has been reported (and bisected) by Alexey Zaytsev and
Kamalesh Babulal to produce annoying warnings during bootup
on both x86 and powerpc.

kernel_locked() is not a valid test in IRQ context (we update the
BKL's ->lock_depth and the preempt count separately and non-atomicalyy),
so we cannot put it into the generic preempt debugging checks which
can run in IRQ contexts too.

Reported-and-bisected-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reported-and-bisected-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 8be2c13..3b630d8 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4440,7 +4440,7 @@ void __kprobes sub_preempt_count(int val)
 	/*
 	 * Underflow?
 	 */
-       if (DEBUG_LOCKS_WARN_ON(val > preempt_count() - (!!kernel_locked())))
+	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
 		return;
 	/*
 	 * Is the spinlock portion underflowing?
