Return-Path: <john.stultz@linaro.org>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E0912C008B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 04:59:49 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <john.stultz@linaro.org>;
 Mon, 20 Aug 2012 12:59:45 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CF5C519D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 12:59:11 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id q7KIx2QM125120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 12:59:03 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KIwwmq007180
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 12:58:59 -0600
Message-ID: <503288ED.10306@linaro.org>
Date: Mon, 20 Aug 2012 11:58:53 -0700
From: John Stultz <john.stultz@linaro.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home>
In-Reply-To: <m2fw7ilhnm.fsf@igel.home>
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

On 08/19/2012 02:02 PM, Andreas Schwab wrote:
> John Stultz <john.stultz@linaro.org> writes:
>
>> The timekeeper struct has a xtime_nsec, which keeps the
>> sub-nanosecond remainder.  This ends up being somewhat
>> duplicative of the timekeeper.xtime.tv_nsec value, and we
>> have to do extra work to keep them apart, copying the full
>> nsec portion out and back in over and over.
>>
>> This patch simplifies some of the logic by taking the timekeeper
>> xtime value and splitting it into timekeeper.xtime_sec and
>> reuses the timekeeper.xtime_nsec for the sub-second portion
>> (stored in higher res shifted nanoseconds).
>>
>> This simplifies some of the accumulation logic. And will
>> allow for more accurate timekeeping once the vsyscall code
>> is updated to use the shifted nanosecond remainder.
> This (together with b44d50d "time: Fix casting issue in tk_set_xtime and
> tk_xtime_add") is causing resume to hang on the iBook (PowerBook6,7).
> The fact that the add-on commit is needed to uncover the bug might give
> a hint, but I'm unable to decipher it.

Thanks for the bug report and narrowing this down.

I'm not very familiar w/ the iBook hardware, but does it use a 
clocksource, or does it use arch_gettimeoffset()?

I suspect that the casting has avoided clipping some strange values from 
the persistent clock.

Could you try with the following patch against Linus' HEAD? I suspect it 
will let the box resume (although it will seem as though no time was 
spent in resume) and then let me know what the JDB lines print out?

thanks
-john

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e16af19..03f5a82 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -753,10 +753,14 @@ static void timekeeping_resume(void)
  	clocksource_resume();
  
  	write_seqlock_irqsave(&tk->lock, flags);
+	printk("JDB: suspend_time: %ld:%ld  resume_time: %ld:%ld\n",
+		timekeeping_suspend_time.tv_sec, timekeeping_suspend_time.tv_nsec,
+		ts.tv_sec, ts.tv_nsec);
  
  	if (timespec_compare(&ts, &timekeeping_suspend_time) > 0) {
  		ts = timespec_sub(ts, timekeeping_suspend_time);
-		__timekeeping_inject_sleeptime(tk, &ts);
+		printk("JDB: Trying to add: %ld:%ld\n", ts.tv_sec, ts.tv_nsec);
+		//__timekeeping_inject_sleeptime(tk, &ts);
  	}
  	/* re-base the last cycle value */
  	tk->clock->cycle_last = tk->clock->read(tk->clock);
