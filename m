Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 9D5652BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 01:39:45 +1000 (EST)
Received: from icarus.com (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id i91Fdie19329
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Oct 2004 08:39:44 -0700
Message-ID: <415D7A40.5040407@icarus.com>
Date: Fri, 01 Oct 2004 08:39:44 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <415C44DC.8090508@icarus.com>
	<BE5CEC3C-1375-11D9-86F9-000A95B15278@aimsys.nl>
In-Reply-To: <BE5CEC3C-1375-11D9-86F9-000A95B15278@aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Jaap-Jan Boor wrote:
> Steve,
> 
> On 30-sep-04, at 19:39, Stephen Williams wrote:
>> I have a multi-threaded (pthreads) application running on an
>> embedded PPC. One of the threads operates a scanner video input,
>> and I want to give it (and only it) high priority, so that if
>> a device driver wakes it up, it is scheduled as close to "now"
>> as possible.

> yes, if you run this program as root a priority >1 and class
> SCHED_FIFO should work as expected.

The program is run by root and I'm using the pthread interface
to set the thread policy.

>>
>> For the particular case I'm seeing, it seems to *not* have
>> any effect. My interrupt handler is activated (I see on the
>> scope) and in the first few cases the response is immediate,
>> but sometimes the response is delayed significantly.
> 
> 
> Possible. What kernel version do you use? In my experience
> a 2.4.x kernel with O(1) scheduler, preemptible kernel patch and low
> latency patch still have significant delays (> 5 ms) sometimes.
> A 2.4 kernel without these patches can have much longer response times.
> I didn't experiment with the 2.6 kernel on this particular
> system yet but 2.6 includes the O(1) scheduler and preemtible
> kernel patch.

This is linuxppc-2.4 from bitkeeper. The last pull I did was a
few months ago, I think.

The process environment should be under control. There are a
half dozen idle daemons (init, boa, syslogd, mostly busybox)
and about a dozen threads in the application at hand. The
network and serial console should be idle during the test,
only my hardware should be going.

> By the way, do you not share a lock with a lower priority thread?
> If the lower priority thread has the lock, your high priority
> thread needs to wait until it's finished (unlocks).

The program is working with in-house devices, I've written the
drivers. The device driver can be used in a pipeline-like fashion,
so the driver itself can be used for most synchronization. In
fact, The thread in question synchronizes entirely through the
driver. I guess that means its a candidate for a seperate process,
eh?

But that means, for this thread, all the synchronization is inside
the kernel. I can also see that there *should* be no cause to block
on anything at the instant I see the delay, hence my puzzlement.

Of course, I'm processing 24bit color images at 30MPixels/sec,
so I might well be hitting *PCI* scheduling issues as easily as
anything else.
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
