Message-Id: <4.3.2.20010104155613.00be8a20@falcon.si.com>
Date: Thu, 04 Jan 2001 16:03:15 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Critical section - pSOS+
In-Reply-To: <Pine.SCO.3.91.1010104092854.21798A-100000@vayudoot>
References: <XFMail.20010103201404.gthomas@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I forgot if splx() returns the current value of the interrupt enable
bit.  If it doesn't, modify it to do so.  If I recall correctly, the
routine is in the BSP (been a little while since I messed with PPC
pSOS).  If I recall wrongly, you may need to write your own version of
splx(), naming it something else to avoid name collisions, and use it
instead of the provided splx().

Once your splx() routine returns the current value of the EE flag, save
it in a variable, and restore the value when you exit your critical region.

Something like...

void foo()
{
     int ee;

     ee = splix(1);      /* mask interrupts */
     bar()
     splx(ee);           /* restore the interrupt level */
}

gvb


At 09:37 AM 1/4/01 +0530, Srinivas Rao.M wrote:

>Hi to all,
>
>  I am sorry, This question is not releated to the list directly.
>
>  We have a custom board built using MPC860 processor and running the
>pSOS+ kernel. We are running a multitasking application on this. we are
>facing a problem with the critical section.
>we have in pSOS+, splx(1) and splx(0) calls for disabling and enabling the
>interrupts respectively. Having multiple tasks running on the kernel,
>suppose if one task disables the interrupt by calling splx(1),
>The other task can enable the interrupts back to the old posture by
>calling splx(0). Hence the critical section code is left in the non
>critical section area. Unlike UNIX, pSOS+ doesnot provide, the interrupts
>locking (and unlocking) mechanism at the task level.
>In such contexts how can we solve this problem.
>
>Thanks in advance.
>Srini...
>
>--
>
>The beginning of knowledge is the discovery of something we do not
>understand.
>-Frank Herbert
>(contributed by Chris Johnston)
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
