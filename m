Date: Wed, 27 Feb 2002 09:47:40 -0800
From: Mark Charlebois <mcharleb@qualcomm.com>
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'inuxppc-dev@lists.linuxppc.org'" <inuxppc-dev@lists.linuxppc.org>
Subject: Re: DECLARE_WAIT_QUEUE_HEAD; structure badly initialized...
Message-ID: <20020227094740.A12123@qualcomm.com>
References: <6B546A602AD2D211BFF00008C7A4288905843FFE@hrtades2.atea.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6B546A602AD2D211BFF00008C7A4288905843FFE@hrtades2.atea.be>; from Frederic.Goddeeris@siemens.atea.be on Wed, Feb 27, 2002 at 10:30:32AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have had similar problems with static/global initialization in USB module
code.  A wait_queue_head was not properly initialized and we had to
re-initialize it in module_init().

I also noticed that the static text strings (.rodata segment ) were not
displayed properly in /proc/bus/usb/drivers for the USB modules but they
were correct when not compiled as a module.

I have only observed this problem with modules and assumed it might have
something to do with the dcache and module initialization.

I haven't had a chance to investigate it further yet... although I am glad
to finally see that someone else has experienced something similar!

We are using a patched HHL2.0 for walnut kernel (2.4.2 + USB from 2.4.17).

- Mark

* Goddeeris Frederic (Frederic.Goddeeris@siemens.atea.be) [020227 01:36]:
>
> Hi,
>
> I write in my code:
>
> This should initialize the structure so that .task_list.next and
> .task_list.prev point ot its own .task list, but the pointers seem to point
> 4 bytes to far...
>
> I added this test-code:
>
> DEBUG("TEST: %x %x\n",&f_SCBlockReadQueue.task_list,
> f_SCBlockReadQueue.task_list.next);
> f_SCBlockReadQueue.task_list.next = &f_SCBlockReadQueue.task_list;
> f_SCBlockReadQueue.task_list.prev = &f_SCBlockReadQueue.task_list;
> DEBUG("TEST: %x %x\n",&f_SCBlockReadQueue.task_list,
> f_SCBlockReadQueue.task_list.next);
>
> And this results in:
> FPGADrv >> TEST: c3044754 c3044758	==> WRONG
> FPGADrv >> TEST: c3044754 c3044754	==> CORRECT
>
> After the code corrected the the pointers, the driver starts behaving as
> expected.
>
> The preprosessor converts "DECLARE_WAIT_QUEUE_HEAD(f_SCBlockReadQueue);" to:
> wait_queue_head_t  f_SCBlockReadQueue  = {	lock:		(spinlock_t)
> { 0 }  ,	task_list:	{ &(f_SCBlockReadQueue).task_list,
> &(f_SCBlockReadQueue).task_list },	 }  ;
> This looks ok to me
>
> When using
> init_waitqueue_head(&f_SCBlockReadQueue);
> it works.
>
> So when the structure is initialized in code it works nicely, when it is
> initialized at compile-time it fails. Does anybody know why?
>
> The compiler is 2.95.3 (HHL2.0)
>
> Thanks,
> Frederic
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
