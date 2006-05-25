Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 52C7167A45
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 03:53:53 +1000 (EST)
Date: Thu, 25 May 2006 13:53:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Make cpufreq_transition_notifier a raw notifier
In-Reply-To: <1148575497.24946.40.camel@cashmere.sps.mot.com>
Message-ID: <Pine.LNX.4.44L0.0605251332260.8473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	johannes@sipsolutions.net, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cpufreq code has problems with atomic vs. blocking notifier calls and
enabling vs. disabling interrupts (show up on pmac).  As a temporary
band-aid, this patch (as697) makes the cpufreq_transition_notifier_list
into a raw notifier.


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 25 May 2006, Jon Loeliger wrote:

> On Thu, 2006-05-25 at 09:44, Andrew Morton wrote:
> 
> > > In essence, the problem seemed to be that the cpufreq notifier chain is
> > > sometimes expected to be blocking and sometimes expected to be atomic,
> > > based on the "val" code passed to notifier_call_chain.  The cleanest
> > > solution would be to split the single notifier chain into two chains,
> > > one always blocking and the other always atomic.
> > > 
> > > Somebody who knows more about cpufreq than I do will have to make that
> > > change.
> > > 
> > 
> > I wouldn't describe the cpufreq project as a teeming hive of frenetic
> > activity, and we need something pronto.
> > 
> > We could go back to a raw_notifier and be as buggy as we used to be.
> 
> It _is_ actively being pursued today for a cleaned up
> implementation.  If there are issues or requirements
> here, we should really pass them on to the linux-pm list.
> 
> Thanks,
> jdl

Here's the patch Andrew asked for.  I have no idea whether it will solve 
any of these problems, and I'm certain that in the long run we shouldn't 
keep it.  Perhaps it will at least help stabilize 2.6.17.

It's up to you guys to see if the patch helps at all and to decide whether 
or not it should be applied.

Alan Stern


Index: usb-2.6/drivers/cpufreq/cpufreq.c
===================================================================
--- usb-2.6.orig/drivers/cpufreq/cpufreq.c
+++ usb-2.6/drivers/cpufreq/cpufreq.c
@@ -50,10 +50,9 @@ static void handle_update(void *data);
  * validation process for a new CPU frequency policy; the
  * "transition" list for kernel code that needs to handle
  * changes to devices when the CPU clock speed changes.
- * The mutex locks both lists.
  */
 static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
-static BLOCKING_NOTIFIER_HEAD(cpufreq_transition_notifier_list);
+static RAW_NOTIFIER_HEAD(cpufreq_transition_notifier_list);
 
 
 static LIST_HEAD(cpufreq_governor_list);
@@ -263,14 +262,14 @@ void cpufreq_notify_transition(struct cp
 				freqs->old = policy->cur;
 			}
 		}
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		raw_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_PRECHANGE, freqs);
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		raw_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
 			policy->cur = freqs->new;
@@ -1014,7 +1013,7 @@ static int cpufreq_suspend(struct sys_de
 		freqs.old = cpu_policy->cur;
 		freqs.new = cur_freq;
 
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		raw_notifier_call_chain(&cpufreq_transition_notifier_list,
 				    CPUFREQ_SUSPENDCHANGE, &freqs);
 		adjust_jiffies(CPUFREQ_SUSPENDCHANGE, &freqs);
 
@@ -1095,7 +1094,7 @@ static int cpufreq_resume(struct sys_dev
 			freqs.old = cpu_policy->cur;
 			freqs.new = cur_freq;
 
-			blocking_notifier_call_chain(
+			raw_notifier_call_chain(
 					&cpufreq_transition_notifier_list,
 					CPUFREQ_RESUMECHANGE, &freqs);
 			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
@@ -1141,7 +1140,7 @@ int cpufreq_register_notifier(struct not
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = blocking_notifier_chain_register(
+		ret = raw_notifier_chain_register(
 				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
@@ -1173,7 +1172,7 @@ int cpufreq_unregister_notifier(struct n
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = blocking_notifier_chain_unregister(
+		ret = raw_notifier_chain_unregister(
 				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
