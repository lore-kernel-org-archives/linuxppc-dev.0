Date: Fri, 5 Jan 2001 10:49:15 +0530 (IST)
From: "Srinivas Rao.M" <msrao@vxl.co.in>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Critical section - pSOS+
In-Reply-To: <4.3.2.20010104155613.00be8a20@falcon.si.com>
Message-ID: <Pine.SCO.3.91.1010105104420.9387A-100000@vayudoot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jerry,
Thanks for your reply.
   I have the splx() routine given from pSOS+, I am also having the
wrapper code which calls the psos 's system call to disable the
preemption of the task. I can do this successfully. But My problem is,
how can i implement the interrupts enabling/disabling mechanism at the
task level.

 Present mechanism has got a loophole: whenever we disable interrupts any
other task enables it. I want to have a mechanism, which is there UNIX.
something like splnet,splclock,splhigh,splimp,splx, at each task level.

any suggestions...
-Srini...



On Thu, 4 Jan 2001, Jerry Van Baren wrote:

>
> I forgot if splx() returns the current value of the interrupt enable
> bit.  If it doesn't, modify it to do so.  If I recall correctly, the
> routine is in the BSP (been a little while since I messed with PPC
> pSOS).  If I recall wrongly, you may need to write your own version of
> splx(), naming it something else to avoid name collisions, and use it
> instead of the provided splx().
>
> Once your splx() routine returns the current value of the EE flag, save
> it in a variable, and restore the value when you exit your critical region.
>
> Something like...
>
> void foo()
> {
>      int ee;
>
>      ee = splix(1);      /* mask interrupts */
>      bar()
>      splx(ee);           /* restore the interrupt level */
> }
>
> gvb
>
>
> At 09:37 AM 1/4/01 +0530, Srinivas Rao.M wrote:
>
> >Hi to all,
> >
> >  I am sorry, This question is not releated to the list directly.
> >
> >  We have a custom board built using MPC860 processor and running the
> >pSOS+ kernel. We are running a multitasking application on this. we are
> >facing a problem with the critical section.
> >we have in pSOS+, splx(1) and splx(0) calls for disabling and enabling the
> >interrupts respectively. Having multiple tasks running on the kernel,
> >suppose if one task disables the interrupt by calling splx(1),
> >The other task can enable the interrupts back to the old posture by
> >calling splx(0). Hence the critical section code is left in the non
> >critical section area. Unlike UNIX, pSOS+ doesnot provide, the interrupts
> >locking (and unlocking) mechanism at the task level.
> >In such contexts how can we solve this problem.
> >
> >Thanks in advance.
> >Srini...
> >
> >--
> >
> >The beginning of knowledge is the discovery of something we do not
> >understand.
> >-Frank Herbert
> >(contributed by Chris Johnston)
> >
>
>
>

--

There is one thing even more vital to science than intelligent methods; and
that is, the sincere desire to find out the truth, whatever it may be.
-Charles Sanders Pierce


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
