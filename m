Return-Path: <linux@sundmangroup.com>
Received: from proxy1.bredband.net (proxy1.bredband.net [195.54.101.71])
	by ozlabs.org (Postfix) with ESMTP id B6984DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 17:39:01 +1100 (EST)
Received: from ironport.bredband.com (195.54.101.120) by proxy1.bredband.net
	(7.3.127) id 4730FF890176D2D5 for linuxppc-embedded@ozlabs.org;
	Fri, 18 Jan 2008 07:38:58 +0100
Message-ID: <4790497D.3090004@sundmangroup.com>
Date: Fri, 18 Jan 2008 07:38:53 +0100
From: Matias Sundman <linux@sundmangroup.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	"Arnon Kaufman(Work)" <arnon.work@gmail.com>
Subject: Re: SCHED_FIFO & System()
References: <478EFD4C.9070706@sundmangroup.com>
	<478FD3B7.2030105@freescale.com>
In-Reply-To: <478FD3B7.2030105@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

/>>Are you running a preemptible kernel? [Scott]/
 
Yes the Kernel is configured as - Preemptible Kernel (Low-Latency Desktop)

/>>//what you actually need is a better kernel preemption such as  using 
Ingo Molnar 's  PREEMPT_RT patch. (it may reduce performance a little) 
[Arnon]
/
Ok - we can try to enable the PREEMPT_RT patches.

-------------------------------

I also tried with a sched_yield() before the call to system() in order 
to see if the behavior changed somewhat but it didn't.


Cheers // Matias :-)



Scott Wood skrev:
> Matias Sundman wrote:
>   
>> Hello,
>> I have some strange behavior in one of my systems.
>>
>> I have a real-time thread under SCHED_FIFO which is running every 10ms. 
>> It is blocking on a semaphore and released by a timer interrupt every 10ms.
>> Generally this works really well.
>>
>> However, there is a module in the system that makes a / system() / call 
>> from c-code ;
>>
>>   system("run_my_script");
>>
>> By calling and running a bash script. Independent of how the actual 
>> script looks like the real time thread does not get scheduled under 80ms 
>> -- the time it takes
>> for the system() call to finish.
>>     
>
> Are you running a preemptible kernel?
>
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   
[From : Arnon Kaufman(Work) <arnon.work@gmail.com>]

I've seen this kind of behavior. i may guess that you configure the 
kernel with PREEMPT, assuming it will solve the problem for you.

I'll split the problem into two:
1. program loading stage is finished (+ reschedule)
2. thread execution time (delay)

when executing a new application it's involved with plenty of kernel 
activity such as fetching the application from storage, loader 
relocation,allocating and remapping pages, resolving dynamic linking 
etc..., all the activity occurs under the hood of the kernel, suspending 
most of the kernel activities, due to many spin locks on the way. that 
delays other kernel threads as well, and even workqueues.

trying to bypass the symptom  - re-running the exact external 
application ,  should not be involved with a second delay, as it was 
cached. so may be running the external application in advance may be 
good enough for you.

what you actually need is a better kernel preemption such as  using Ingo 
Molnar 's  PREEMPT_RT patch. (it may reduce performance a little).

the second part is that the scheduler delays the thread execution as it 
think other kernel's entities has a higher priority such as softirqs, 
workqueue, etc...

the PREEMPT_RT may solve this problem as well as it bring a better 
priority control, with the addition of priority inheritance.
