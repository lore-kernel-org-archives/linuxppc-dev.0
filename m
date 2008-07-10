Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6D77DDF8C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:40:07 +1000 (EST)
Date: Thu, 10 Jul 2008 16:07:57 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200807081801.38026.rusty@rustcorp.com.au>
References: <200807081801.38026.rusty@rustcorp.com.au>,
	<200807081750.55536.rusty@rustcorp.com.au>,
	<200807081756.02838.rusty@rustcorp.com.au>,
	<200807081756.47140.rusty@rustcorp.com.au>
Message-Id: <for-27-patch0-1@bga.com>
Subject: [PATCH -next-20080709] fixup stop_machine use cpu mask vs ftrace
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi Rusty, Ingo.

Rusty's patch [PATCH 3/3] stop_machine: use cpu mask rather than magic numbers
didn't find kernel/trace/ftrace.c in -next, causing an immediate almost NULL
pointer dereference in ftrace_dynamic_init.


Signed-off-by: Milton Miller <miltonm@bga.com>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0f271c4..c29acb5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -587,7 +587,7 @@ static int __ftrace_modify_code(void *data)
 
 static void ftrace_run_update_code(int command)
 {
-	stop_machine_run(__ftrace_modify_code, &command, NR_CPUS);
+	stop_machine_run(__ftrace_modify_code, &command, NULL);
 }
 
 void ftrace_disable_daemon(void)
@@ -787,7 +787,7 @@ static int ftrace_update_code(void)
 	    !ftrace_enabled || !ftraced_trigger)
 		return 0;
 
-	stop_machine_run(__ftrace_update_code, NULL, NR_CPUS);
+	stop_machine_run(__ftrace_update_code, NULL, NULL);
 
 	return 1;
 }
@@ -1564,7 +1564,7 @@ static int __init ftrace_dynamic_init(void)
 
 	addr = (unsigned long)ftrace_record_ip;
 
-	stop_machine_run(ftrace_dyn_arch_init, &addr, NR_CPUS);
+	stop_machine_run(ftrace_dyn_arch_init, &addr, NULL);
 
 	/* ftrace_dyn_arch_init places the return code in addr */
 	if (addr) {
