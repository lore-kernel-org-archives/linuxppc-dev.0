Message-ID: <6B546A602AD2D211BFF00008C7A4288905844003@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Mark Charlebois'" <mcharleb@qualcomm.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'inuxppc-dev@lists.linuxppc.org'" <inuxppc-dev@lists.linuxppc.org>
Subject: RE: DECLARE_WAIT_QUEUE_HEAD; structure badly initialized...
Date: Thu, 28 Feb 2002 10:18:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,
Hi all,

I have been struggling with the global static variables as well! The funny
thing is that the output of insmod shows where the variables are in memory
correctly, but the debugger takes a complete wrong address when the variales
are static.

Here the variable f_PWMCounter is defined as static and f_PWMValue is not:
c305e720 D f_bRun
c305e721 D f_bCanExit
c305e724 D f_pBCSR0
c305e728 d f_PWMCounter		==> Here we seem to have a "d" instead of a
"D"...
c305e729 D f_PWMValue
c305e72a D f_Auto
c305e72b D f_AutoCounter

In GDB:
(gdb) p &f_PWMValue
$1 = (unsigned char *) 0xc305e729 "\005"	==> The address is correct
(gdb) p &f_PWMCounter
$2 = (unsigned char *) 0xc305e720 "\001"	==> The address in not
correct!!


I asked MV to look into this problem.

I also noticed a it is not always possible to step into a function that is
static (a C-function).

I am very surprised that these issues exist in a development environment so
many people use.

Regards,
Frederic

-----Original Message-----
From: Mark Charlebois [mailto:mcharleb@qualcomm.com]
Sent: woensdag 27 februari 2002 18:48
To: Goddeeris Frederic
Cc: 'linuxppc-embedded@lists.linuxppc.org';
'inuxppc-dev@lists.linuxppc.org'
Subject: Re: DECLARE_WAIT_QUEUE_HEAD; structure badly initialized...


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
> .task_list.prev point ot its own .task list, but the pointers seem to
point
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
> The preprosessor converts "DECLARE_WAIT_QUEUE_HEAD(f_SCBlockReadQueue);"
to:
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
