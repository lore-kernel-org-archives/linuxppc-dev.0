Message-ID: <6B546A602AD2D211BFF00008C7A4288905843FFE@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'inuxppc-dev@lists.linuxppc.org'" <inuxppc-dev@lists.linuxppc.org>
Subject: DECLARE_WAIT_QUEUE_HEAD; structure badly initialized...
Date: Wed, 27 Feb 2002 10:30:32 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I write in my code:

This should initialize the structure so that .task_list.next and
.task_list.prev point ot its own .task list, but the pointers seem to point
4 bytes to far...

I added this test-code:

DEBUG("TEST: %x %x\n",&f_SCBlockReadQueue.task_list,
f_SCBlockReadQueue.task_list.next);
f_SCBlockReadQueue.task_list.next = &f_SCBlockReadQueue.task_list;
f_SCBlockReadQueue.task_list.prev = &f_SCBlockReadQueue.task_list;
DEBUG("TEST: %x %x\n",&f_SCBlockReadQueue.task_list,
f_SCBlockReadQueue.task_list.next);

And this results in:
FPGADrv >> TEST: c3044754 c3044758	==> WRONG
FPGADrv >> TEST: c3044754 c3044754	==> CORRECT

After the code corrected the the pointers, the driver starts behaving as
expected.

The preprosessor converts "DECLARE_WAIT_QUEUE_HEAD(f_SCBlockReadQueue);" to:
wait_queue_head_t  f_SCBlockReadQueue  = {	lock:		(spinlock_t)
{ 0 }  ,	task_list:	{ &(f_SCBlockReadQueue).task_list,
&(f_SCBlockReadQueue).task_list },	 }  ;
This looks ok to me

When using
init_waitqueue_head(&f_SCBlockReadQueue);
it works.

So when the structure is initialized in code it works nicely, when it is
initialized at compile-time it fails. Does anybody know why?

The compiler is 2.95.3 (HHL2.0)

Thanks,
Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
