Return-Path: <jjboor@aimsys.nl>
Received: from smtp06.wanadoo.nl (smtp06.wanadoo.nl [194.134.35.146])
	by ozlabs.org (Postfix) with ESMTP id F200B2BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 17:13:16 +1000 (EST)
In-Reply-To: <415C44DC.8090508@icarus.com>
References: <415C44DC.8090508@icarus.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BE5CEC3C-1375-11D9-86F9-000A95B15278@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Fri, 1 Oct 2004 08:47:20 +0200
To: Stephen Williams <steve@icarus.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Embedded Linux, pthreads and scheduling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Steve,

On 30-sep-04, at 19:39, Stephen Williams wrote:

>
> [This is probably not unique to ppc linux, but it is imbedded
> and I am running linux on an embedded pc in this case...]
>
> I have a multi-threaded (pthreads) application running on an
> embedded PPC. One of the threads operates a scanner video input,
> and I want to give it (and only it) high priority, so that if
> a device driver wakes it up, it is scheduled as close to "now"
> as possible.
>
> I code the thread in question to capp pthread_setschedparam
> to set its policy to SCHED_FIFO and the priority to some
> number >0. I'm using glibc-ppc_4xx-2.3.1 as packaged in the
> Denx ELDK-3.0. Can I expect this to work? Is any priority >0
> enough to get it priority over other threads, or do I need
> to give it a high (i.e. 99) priority to get past the sliding
> priorities of threads with default scheduling?

yes, if you run this program as root a priority >1 and class
SCHED_FIFO should work as expected.

>
> For the particular case I'm seeing, it seems to *not* have
> any effect. My interrupt handler is activated (I see on the
> scope) and in the first few cases the response is immediate,
> but sometimes the response is delayed significantly.

Possible. What kernel version do you use? In my experience
a 2.4.x kernel with O(1) scheduler, preemptible kernel patch and low
latency patch still have significant delays (> 5 ms) sometimes.
A 2.4 kernel without these patches can have much longer response times.
I didn't experiment with the 2.6 kernel on this particular
system yet but 2.6 includes the O(1) scheduler and preemtible
kernel patch.

By the way, do you not share a lock with a lower priority thread?
If the lower priority thread has the lock, your high priority
thread needs to wait until it's finished (unlocks).

Jaap-Jan

> Where
> I look for the problem may depend on whether the collective
> understanding is that the SCHED_FIFO has the effect I expect.
>
> -- 
> Steve Williams                "The woods are lovely, dark and deep.
> steve at icarus.com           But I have promises to keep,
> http://www.icarus.com         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
