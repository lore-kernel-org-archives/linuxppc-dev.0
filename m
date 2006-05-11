Return-Path: <dwilder@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52077679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 09:37:12 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4ANb9ek020865
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 19:37:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4ANb9YQ273884
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 17:37:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4ANb8Dt018089
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 17:37:08 -0600
Received: from [9.47.18.65] (dyn9047018065.beaverton.ibm.com [9.47.18.65])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k4ANb8Pl018074
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 17:37:08 -0600
Message-ID: <44628316.80600@us.ibm.com>
Date: Wed, 10 May 2006 17:19:34 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC-PATCH] Prevent tasks from sleeping in die()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am seeing an issue in die() when voluntary preemption is enabled.
die() 
->>show_regs()->>show_instructions()->>__get_user_nocheck()->>might_sleep()
If multiple CPUs call die() and one should sleep other CPUs may block on 
the die_lock held by the sleeping CPU.  This problem is seen when a 
soft-reset is issued as all CPUs call die() at roughly the same time.

Is this the correct way to fix this problem?

Signed-of-by: <wilder@us.ibm.com>

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..dc45bcd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -101,6 +101,15 @@ int die(const char *str, struct pt_regs
    if (debugger(regs))
        return 1;

+    /* If voluntary preemption is on we can sleep
+     * in show_regs().  This is bad as we hold the
+    * die_lock. Ether the task is exiting or the system
+    * is crashing so there is no need to restore the
+    * NEED_RESCHED flag.
+    */
+    clear_need_resched();
+
+
        console_verbose();
        spin_lock_irq(&die_lock);
        bust_spinlocks(1);

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789
