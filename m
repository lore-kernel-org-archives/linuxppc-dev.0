Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 55A3C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 04:38:10 +1000 (EST)
Received: from icarus.com (wing [192.168.1.7]) (authenticated)
	by icarus.com (8.11.6/8.11.6) with ESMTP id i8UHdhe05413
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Sep 2004 10:39:43 -0700
Message-ID: <415C44DC.8090508@icarus.com>
Date: Thu, 30 Sep 2004 10:39:40 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Embedded Linux, pthreads and scheduling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


[This is probably not unique to ppc linux, but it is imbedded
and I am running linux on an embedded pc in this case...]

I have a multi-threaded (pthreads) application running on an
embedded PPC. One of the threads operates a scanner video input,
and I want to give it (and only it) high priority, so that if
a device driver wakes it up, it is scheduled as close to "now"
as possible.

I code the thread in question to capp pthread_setschedparam
to set its policy to SCHED_FIFO and the priority to some
number >0. I'm using glibc-ppc_4xx-2.3.1 as packaged in the
Denx ELDK-3.0. Can I expect this to work? Is any priority >0
enough to get it priority over other threads, or do I need
to give it a high (i.e. 99) priority to get past the sliding
priorities of threads with default scheduling?

For the particular case I'm seeing, it seems to *not* have
any effect. My interrupt handler is activated (I see on the
scope) and in the first few cases the response is immediate,
but sometimes the response is delayed significantly. Where
I look for the problem may depend on whether the collective
understanding is that the SCHED_FIFO has the effect I expect.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
