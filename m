Message-ID: <3843ED00.20D47DF4@netx4.com>
Date: Tue, 30 Nov 1999 10:28:00 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Real Time response/latency question
References: <19991130034844.1B3E0F380@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
> 
> Hi folks,
> 
> I'm looking at software architecture questions, and wondering how much
> application domain work I can move out of driver land and into user space,

I believe this is a good programming practice, and in many
cases I don't even write a driver when the application is
allowed to run with root privilege.

> .... Can anyone give me a rough idea of the maximum
> latency in user space I could expect on an 860T based system with multiple
> threads, where only one thread has SCHED_RR realtime scheduling priority?


You can't answer this question due to the design and implementation
of the kernel.  Most "real-time" systems can't either once you
throw protocol stacks, file systems, disk drives, and other
external devices or distributed services into the feature mix.

I have successfully written applications that required
sub-millisecond latency.  You just have to be careful about
other applications in the system, and remember that you can't
preempt the kernel.

If you have hard real-time requirements, check into the RT-Linux
features.  These are starting to mature, and can make scheduling
guarantees within the confined real-time domain.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
