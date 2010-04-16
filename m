Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6272CB7CF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Apr 2010 07:26:41 +1000 (EST)
Received: from e35131.upc-e.chello.nl ([213.93.35.131]
	helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O2t3b-0008EA-Qu
	for linuxppc-dev@lists.ozlabs.org; Fri, 16 Apr 2010 21:26:36 +0000
Subject: Re: Possible bug with mutex adaptative spinning
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1271212509.13059.135.camel@pasglop>
References: <1271212509.13059.135.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 23:26:24 +0200
Message-ID: <1271453184.1674.483.camel@laptop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 12:35 +1000, Benjamin Herrenschmidt wrote:

> [PATCH] mutex: Don't spin when the owner CPU is offline or other weird cases
> 
> The current code might spin forever if the CPU owning the mutex has been
> offlined, and the last CPU in the system is trying to acquire it, since
> mutex_spin_on_owner() will always return 1, telling the caller to spin
> until the mutex has been released.
> 
> This patch changes mutex_spin_on_owner() to return 0 (don't spin) in any
> case where we aren't sure about the owner struct validity or CPU number,
> and if the said CPU is offline. There is no point going back &
> re-evaluate spinning in corner cases like that, let's just go to sleep.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Right, patch looks good, comments are a tad misleading.


I've queued the below patch

---
Subject: mutex: Don't spin when the owner CPU is offline or other weird cases
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri Apr 16 23:20:00 CEST 2010

Due to recent load-balancer changes that delay the task migration to
the next wakeup, the adaptive mutex spinning ends up in a live lock
when the owner's CPU gets offlined because the cpu_online() check
lives before the owner running check.

This patch changes mutex_spin_on_owner() to return 0 (don't spin) in
any case where we aren't sure about the owner struct validity or CPU
number, and if the said CPU is offline. There is no point going back &
re-evaluate spinning in corner cases like that, let's just go to
sleep.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
LKML-Reference: <1271212509.13059.135.camel@pasglop>
---
 kernel/sched.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -3647,7 +3647,7 @@ int mutex_spin_on_owner(struct mutex *lo
 	 * the mutex owner just released it and exited.
 	 */
 	if (probe_kernel_address(&owner->cpu, cpu))
-		goto out;
+		return 0;
 #else
 	cpu = owner->cpu;
 #endif
@@ -3657,14 +3657,14 @@ int mutex_spin_on_owner(struct mutex *lo
 	 * the cpu field may no longer be valid.
 	 */
 	if (cpu >= nr_cpumask_bits)
-		goto out;
+		return 0;
 
 	/*
 	 * We need to validate that we can do a
 	 * get_cpu() and that we have the percpu area.
 	 */
 	if (!cpu_online(cpu))
-		goto out;
+		return 0;
 
 	rq = cpu_rq(cpu);
 
@@ -3683,7 +3683,7 @@ int mutex_spin_on_owner(struct mutex *lo
 
 		cpu_relax();
 	}
-out:
+
 	return 1;
 }
 #endif
