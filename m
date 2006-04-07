Return-Path: <vatsa@in.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 791DB67B48
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 18:45:05 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k376WlC2016728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:32:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k376Wf5W025038
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:32:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k376Ztlo163220
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 00:35:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k376WeqN023313
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 00:32:41 -0600
Date: Fri, 7 Apr 2006 12:00:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: anton@samba.org, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/4] tickless idle cpu - Allow any CPU to update jiffies
Message-ID: <20060407063044.GA22416@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sri_vatsa_v@yahoo.com
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, only boot CPU calls do_timer to update jiffies. This prevents
idle boot CPU from skipping ticks. Patch below, against 2.6.17-rc1-mm1,
allows jiffies to be updated from any CPU.

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff -puN arch/powerpc/kernel/time.c~boot_cpu_fix arch/powerpc/kernel/time.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/time.c~boot_cpu_fix	2006-04-07 04:13:53.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c	2006-04-07 04:14:03.000000000 +0530
@@ -685,19 +685,17 @@ void timer_interrupt(struct pt_regs * re
 		if (!cpu_is_offline(cpu))
 			account_process_time(regs);
 
-		/*
-		 * No need to check whether cpu is offline here; boot_cpuid
-		 * should have been fixed up by now.
-		 */
-		if (cpu != boot_cpuid)
-			continue;
-
 		write_seqlock(&xtime_lock);
-		tb_last_jiffy += tb_ticks_per_jiffy;
-		tb_last_stamp = per_cpu(last_jiffy, cpu);
-		do_timer(regs);
-		timer_recalc_offset(tb_last_jiffy);
-		timer_check_rtc();
+		if (tb_ticks_since(tb_last_stamp) >= tb_ticks_per_jiffy) {
+			tb_last_jiffy += tb_ticks_per_jiffy;
+			tb_last_stamp += tb_ticks_per_jiffy;
+			/* Handle RTCL overflow on 601 */
+			if (__USE_RTC() && tb_last_stamp >= 1000000000)
+				tb_last_stamp -= 1000000000;
+			do_timer(regs);
+			timer_recalc_offset(tb_last_jiffy);
+			timer_check_rtc();
+		}
 		write_sequnlock(&xtime_lock);
 	}
 	

_
-- 
Regards,
vatsa
