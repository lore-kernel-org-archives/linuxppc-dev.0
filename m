Return-Path: <arnon.work@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 7A14BDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 09:14:52 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so420356uge.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 14:14:50 -0800 (PST)
Message-ID: <a7742ef40801171414s39a1051am66104937a14964d0@mail.gmail.com>
Date: Fri, 18 Jan 2008 00:14:50 +0200
From: "Arnon Kaufman(Work)" <arnon.work@gmail.com>
To: linuxppc-embedded@ozlabs.org, linux@sundmangroup.com
Subject: Re: SCHED_FIFO & System()
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2398_23540080.1200608090497"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2398_23540080.1200608090497
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Hello,
> I have some strange behavior in one of my systems.
>
> I have a real-time thread under SCHED_FIFO which is running every 10ms.
> It is blocking on a semaphore and released by a timer interrupt every
> 10ms.
> Generally this works really well.
>

I've seen this kind of behavior. i may guess that you configure the kernel
with PREEMPT, assuming it will solve the problem for you.

I'll split the problem into two:
1. program loading stage is finished (+ reschedule)
2. thread execution time (delay)

when executing a new application it's involved with plenty of kernel
activity such as fetching the application from storage, loader
relocation,allocating and remapping pages, resolving dynamic linking etc...,
all the activity occurs under the hood of the kernel, suspending most of the
kernel activities, due to many spin locks on the way. that delays other
kernel threads as well, and even workqueues.

trying to bypass the symptom  - re-running the exact external application ,
should not be involved with a second delay, as it was cached. so may be
running the external application in advance may be good enough for you.

what you actually need is a better kernel preemption such as  using Ingo
Molnar 's  PREEMPT_RT patch. (it may reduce performance a little).

the second part is that the scheduler delays the thread execution as it
think other kernel's entities has a higher priority such as softirqs,
workqueue, etc...

the PREEMPT_RT may solve this problem as well as it bring a better priority
control, with the addition of priority inheritance.


> However, there is a module in the system that makes a / system() / call
> from c-code ;
>
>  system("run_my_script");
>
> By calling and running a bash script. Independent of how the actual
> script looks like the real time thread does not get scheduled under 80ms
> -- the time it takes
> for the system() call to finish.
>
> I can see when running a LTT session that the wake_up event occurs for
> the real time thread 10ms into the system call but nevertheless the real
> time thread does not get scheduled.
>
> Anybody who recognize this or similar situations?
>
>
>
> Cheers // Matias
>

------=_Part_2398_23540080.1200608090497
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,
<br>I have some strange behavior in one of my systems.<br><br>I have a real-time thread under SCHED_FIFO which is running every 10ms.<br>It is blocking on a semaphore and released by a timer interrupt every 10ms.<br>Generally this works really well.
<br></blockquote><div><br>I&#39;ve seen this kind of behavior. i may guess that you configure the kernel with PREEMPT, assuming it will solve the problem for you.<br><br>I&#39;ll split the problem into two:<br>1. program loading stage is finished (+ reschedule)
<br>2. thread execution time (delay)<br><br>when executing a new application it&#39;s involved with plenty of kernel activity such as fetching the application from storage, loader relocation,allocating and remapping pages, resolving dynamic linking etc..., all the activity occurs under the hood of the kernel, suspending most of the kernel activities, due to many spin locks on the way. that delays other kernel threads as well, and even workqueues.
<br><br>trying to bypass the symptom&nbsp; - re-running the exact external application ,&nbsp; should not be involved with a second delay, as it was cached. so may be running the external application in advance may be good enough for you.
<br><br>what you actually need is a better kernel preemption such as&nbsp; using Ingo Molnar &#39;s&nbsp; PREEMPT_RT patch. (it may reduce performance a little).<br><br>the second part is that the scheduler delays the thread execution as it think other kernel&#39;s entities has a higher priority such as softirqs, workqueue, etc...
<br><br>the PREEMPT_RT may solve this problem as well as it bring a better priority control, with the addition of priority inheritance.<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>However, there is a module in the system that makes a / system() / call<br>from c-code ;<br><br> &nbsp;system(&quot;run_my_script&quot;);<br><br>By calling and running a bash script. Independent of how the actual<br>script looks like the real time thread does not get scheduled under 80ms
<br>-- the time it takes<br>for the system() call to finish.<br><br>I can see when running a LTT session that the wake_up event occurs for<br>the real time thread 10ms into the system call but nevertheless the real<br>time thread does not get scheduled.
<br><br>Anybody who recognize this or similar situations?<br><br><br><br>Cheers // Matias<br></blockquote></div>

------=_Part_2398_23540080.1200608090497--
