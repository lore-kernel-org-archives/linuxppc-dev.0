Return-Path: <john.stultz@linaro.org>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFDEB2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 13:38:12 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <john.stultz@linaro.org>;
 Mon, 20 Aug 2012 21:38:10 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A0A2C3E40039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 21:38:07 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7L3c678153530
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 21:38:06 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7L3dQh3015673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 21:39:27 -0600
Message-ID: <5033029A.2030201@linaro.org>
Date: Mon, 20 Aug 2012 20:38:02 -0700
From: John Stultz <john.stultz@linaro.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home> <503288ED.10306@linaro.org>
 <m2fw7h4ab5.fsf@igel.home> <503296C1.4070906@linaro.org>
 <m2boi549ed.fsf@igel.home>
In-Reply-To: <m2boi549ed.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Prarit Bhargava <prarit@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Richard Cochran <richardcochran@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2012 01:04 PM, Andreas Schwab wrote:
> John Stultz <john.stultz@linaro.org> writes:
>
>> Huh.  Yea, that looks fine.  And without the
>> __timekeeping_inject_sleeptime() call, the system resumed ok?
> Yes, it does.

So I'm mostly still stumped on this. But I did find one possible related 
bugfix that maybe you can try?

Let me know if the patch below dodges the problem, and if not, please 
send me the JDB printk output.
(if the resume hangs without any output, add a "return;" before the 
tk_xtime_add() call between the JDB printks).

thanks
-john



diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e16af19..1a9b9c5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -115,6 +115,7 @@ static void tk_xtime_add(struct timekeeper *tk, const struct timespec *ts)
  {
  	tk->xtime_sec += ts->tv_sec;
  	tk->xtime_nsec += (u64)ts->tv_nsec << tk->shift;
+	tk_normalize_xtime(tk);
  }
  
  static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec wtm)
@@ -695,9 +696,22 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  					"sleep delta value!\n");
  		return;
  	}
+
+	printk("JDB: pre xt %ld:%ld  wtm: %ld:%ld st: %ld:%ld\n",
+		tk_xtime(tk).tv_sec, tk_xtime(tk).tv_nsec,
+		tk->wall_to_monotonic.tv_sec,tk->wall_to_monotonic.tv_nsec,
+		tk->total_sleep_time.tv_sec, tk->total_sleep_time.tv_nsec);
+	printk("JDB: Adding %ld:%ld\n", delta->tv_sec, delta->tv_nsec);
+
  	tk_xtime_add(tk, delta);
  	tk_set_wall_to_mono(tk, timespec_sub(tk->wall_to_monotonic, *delta));
  	tk_set_sleep_time(tk, timespec_add(tk->total_sleep_time, *delta));
+
+	printk("JDB: post xt %ld:%ld  wtm: %ld:%ld st: %ld:%ld\n",
+		tk_xtime(tk).tv_sec, tk_xtime(tk).tv_nsec,
+		tk->wall_to_monotonic.tv_sec,tk->wall_to_monotonic.tv_nsec,
+		tk->total_sleep_time.tv_sec, tk->total_sleep_time.tv_nsec);
+
  }
  
  /**
