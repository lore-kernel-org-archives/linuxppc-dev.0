Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id BD589DE297
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Aug 2008 05:56:13 +1000 (EST)
Subject: Strange Badness with RT Spin Lock
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 12:56:11 -0700
Message-Id: <1218225371.3465.51.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a very unusual bug I have been trying to get to the bottom of.

First the background...

   AMCC PPC405EP on embedded network device (simpler than a Taihu)
   Kernel 2.6.25.8-rt7 with incremental patches up to 2.6.25.13
   mPCI slot with a WiMax radio card

This is an RT-Preemption kernel.

In my system, in a real time radio (WiMax) driver, I have code that
makes use of a spinlock to control access to a tree structure...

spinlock_t tree_lock;

...

Then I added the following to check if my code is about to generate a
kernel oops that normally happens when a spinlock is locked twice by the
same task.  I did this because I can't find any logical code path that
would cause it to be locked twice so now I look for strange badness.

Note that in an RT Preemption kernel, the spinlock is implemented using
rtmutex.

#define USE_MUTEX_CHECK_HACK	1
#ifdef USE_MUTEX_CHECK_HACK
// This is just a temporary debug hack lifted from rtmutex code in the kernel.
#define RT_MUTEX_OWNER_MASKALL	3UL
static inline struct task_struct *rt_mutex_owner(spinlock_t * lock)
{
	struct rt_mutex * rtlock = (struct rt_mutex *)lock;
	return (struct task_struct *)
		((unsigned long)rtlock->owner & ~RT_MUTEX_OWNER_MASKALL);
}

#define MUTEX_CHECK_SAVE_LOCKED \
   spinlock_t saved_locked = tree_lock;

#define MUTEX_CHECK_SAVE_UNLOCKED \
   spinlock_t saved_unlocked = tree_lock;

#define MUTEX_CHECK_DUMP_ON_BUG do { \
   if (rt_mutex_owner(&tree_lock) == current) { \
      int i; \
      printk("\n\nMUTEX_CHECK_DUMP_ON_BUG:\nsaved locked  ..."); \
      for (i = 0; i < sizeof(spinlock_t); i++) \
         printk("%02x", ((uint8_t*)(&saved_locked))[i]); \
      printk("\nsaved unlocked..."); \
      for (i = 0; i < sizeof(spinlock_t); i++) \
         printk("%02x", ((uint8_t*)(&saved_unlocked))[i]); \
      printk("\ncurrent state ..."); \
      for (i = 0; i < sizeof(spinlock_t); i++) \
         printk("%02x", ((uint8_t*)(&tree_lock))[i]); \
      printk("\nGoodbye cruel world! ...\n\n"); \
   } } while (0)

static inline void rt_mutex_owner_check(char * s)
{
   if (rt_mutex_owner(&tree_lock) == current)
   {
      printk("rt_mutex_owner_check() - recursive spin_lock about to happen - %s\n", s);
   }
   BUG_ON(rt_mutex_owner(&tree_lock) == current);
}
#endif

Two of the above macros copy/save binary content of the spinlock to
local variables on the stack.  The third one, checks and dumps them out
if it is determined the system is about to die.

Below is the code where I put the macro hooks.  (I use the macro hooks
because I have multiple chunks of code as variant of the below).  The
spin lock is released before passing an skbuff to the clbk() function
(which in turn invokes netif_receive_skb() as part of injecting a PDU
received from the radio MAC layer into the kernel's network stack).

After invoking the clbk() function (which is an indirect call since clbk
is really a local function pointer) the spinlock is grabbed again since
this is inside a loop handling a case where one radio MAC PDU has
multiple network PDUs packed inside it).


         // We dispatch the PDU.
         ...

#ifdef USE_MUTEX_CHECK_HACK
         MUTEX_CHECK_SAVE_LOCKED;
#endif
         spin_unlock(&tree_lock);
#ifdef USE_MUTEX_CHECK_HACK
         rt_mutex_owner_check("process_packed_pdu() - no frag - before cblk()");
         MUTEX_CHECK_SAVE_UNLOCKED;
#endif
         clbk(new_skb, gen_header_p->cid);

#ifdef USE_MUTEX_CHECK_HACK
         MUTEX_CHECK_DUMP_ON_BUG;
         rt_mutex_owner_check("process_packed_pdu() - no frag - after cblk()");
#endif
         spin_lock(&tree_lock);


Here is what I have observed...

[   42.764547] 
[   42.764568] 
[   42.764574] MUTEX_CHECK_DUMP_ON_BUG:
[   42.764585] saved locked  ...c9565570c9565570c9565578c9565578c3a1a2c000000000
[   42.779039] saved unlocked...c9565570c9565570c9565578c95655780000000000000000
[   42.786860] current state ...c9565570c9565570c9565578c9565578c3a1a2c000000000
[   42.794706] Goodbye cruel world! ...
[   42.794723] 
[   42.800124] rt_mutex_owner_check() - recursive spin_lock about to happen - process_packed_pdu() - no frag - after cblk()
[   42.811254] Oops: Exception in kernel mode, sig: 5 [#1]
[   42.816477] PREEMPT Taihushui
[   42.819458] Modules linked in: ebt_smac_limit ebtable_nat ssMacDrv adi9352_3Drv ieee802_16d sharkDrv hal ws_pci cryptoSoft cryptoReg services logDrv ebt_arp ebtable_filter ebtables bridge llc tr_fake_eeprom(P) tr_led(P) tr_global(P) [last unloaded: logDrv]
[   42.842499] NIP: c94e86a8 LR: c94e881c CTR: c0146fd8
[   42.847473] REGS: c31c5db0 TRAP: 0700   Tainted: P          (2.6.25.13-rt7)
[   42.854425] MSR: 00029030 <EE,ME,IR,DR>  CR: 44004022  XER: 00000000
[   42.860893] TASK = c3a1a2c0[1014] 'rx_proc' THREAD: c31c4000
[   42.866374] GPR00: 00000001 c31c5e60 c3a1a2c0 0000007f 00002e88 ffffffff c014a114 c01b52b5 
[   42.874850] GPR08: c3a1a2c0 c02c4fb8 00002e88 c02c5000 00005b88 1008bd90 c953626c c9536258 
[   42.883326] GPR16: c9536244 c953620c c9568238 c2981100 c2a8eb00 c9565570 c953623c c956528c 
[   42.891803] GPR24: c29815f1 00000258 c94dd3cc 0000004a c3358da0 00000018 c9565570 c9565570 
[   42.900468] NIP [c94e86a8] process_packed_pdu+0x324/0x9ec [ssMacDrv]
[   42.907166] LR [c94e881c] process_packed_pdu+0x498/0x9ec [ssMacDrv]
[   42.913765] Call Trace:
[   42.916222] [c31c5e60] [c94e881c] process_packed_pdu+0x498/0x9ec [ssMacDrv] (unreliable)
[   42.924672] [c31c5ef0] [c94e9edc] pdu_proc_task+0x790/0xbb4 [ssMacDrv]
[   42.931549] [c31c5fc0] [c930182c] task_init_2_6+0xd4/0x1a4 [services]
[   42.938081] [c31c5ff0] [c000e01c] kernel_thread+0x44/0x60
[   42.943530] Instruction dump:
[   42.946524] 91010018 90e1001c 4e800421 801e0010 5400003a 7f801000 419e00ac 801e0010 
[   42.954399] 5400003a 7c001278 7c000034 5400d97e <0f000000> 7ea3ab78 48042db1 801702fc 

Now if I don't trigger the BUG_ON myself, it will trigger inside the
rt_spin_lock_slowlock and spit out the following instead.  The BUG_ON
there claims that the caller already has the lock, which is confirmed by
my MUTEX_CHECK_DUMP_ON_BUG macro (even though I don't know why).


[  156.735910] PREEMPT Taihushui
[  156.738892] Modules linked in: ebt_smac_limit ssMacDrv adi9352_3Drv ieee802_16d sharkDrv hal ws_pci cryptoSoft cryptoReg services logDrv ebt_arp ebtable_filter ebtables bridge llc tr_fake_eeprom(P) tr_led(P) tr_global(P) [last unloaded: logDrv]
[  156.760887] NIP: c020f6b8 LR: c020f698 CTR: c020fc10
[  156.765861] REGS: c1251dc0 TRAP: 0700   Tainted: P          (2.6.25.9-rt7)
[  156.772726] MSR: 00021030 <ME,IR,DR>  CR: 84004028  XER: 00000000
[  156.778918] TASK = c1a005c0[1013] 'rx_proc' THREAD: c1250000
[  156.784399] GPR00: 00000001 c1251e70 c1a005c0 00000001 000002e6 00008000 c0276724 000002e6 
[  156.792891] GPR08: f8000000 00000001 c1a005c0 c1250000 2235fafd 1008bd90 c74cd258 c1135c80 
[  156.801394] GPR16: c748aeec 00000000 00000871 c756e730 c75713f4 c0055174 00000794 00000000 
[  156.809878] GPR24: 00002001 c15a5e60 c7570000 c09ca100 c756e730 00029030 c09ca000 c756e44c 
[  156.818562] NIP [c020f6b8] rt_spin_lock_slowlock+0x54/0x25c
[  156.824187] LR [c020f698] rt_spin_lock_slowlock+0x34/0x25c
[  156.829707] Call Trace:
[  156.832155] [c1251e70] [c020f698] rt_spin_lock_slowlock+0x34/0x25c (unreliable)
[  156.839524] [c1251ee0] [c74f2888] pdu_proc_task+0x2b8/0xf68 [ssMacDrv]
[  156.846385] [c1251fc0] [c730182c] task_init_2_6+0xd4/0x1a4 [services]
[  156.852917] [c1251ff0] [c000e890] kernel_thread+0x44/0x60
[  156.858357] Instruction dump:
[  156.861348] 57a0045e 7c000124 38600001 4be127a1 801c0004 2f800000 419e01ec 801c0010 
[  156.869227] 5400003a 7c001278 7c000034 5400d97e <0f000000> 3d20c002 7f83e378 38800001 


What doesn't make sense is how the spinlock "forgets" that it was
unlocked.  Something else very strange is that if I add at least one
dummy spinlock variable instance (don't even have to use it) as static
(or global scope) storage (not on stack like my two saved copies), this
condition mysteriously vanishes.

Also, if I comment out all the spinlock usage in this module, it works
fine (that is until down the road when I trigger what the spinlock is
protecting access to the tree for).

I even populated some dummy variables around the spinlock with magic
values and checked for corruption (e.g. catch a bad pointer or a buffer
overrun, etc).  The magic values are untouched.

Other relevant information...

The task that triggers the oops is at RT priority of 75.  Two other task
run at higher priority.  The IRQ for the radio card's PCI interface is
at Rt priority 95.  Other RT tasks in the driver are at RT Priorities
higher than 50 but below 75.

The kernel's softirq and all other IRQs are run at RT priority 50 (the
system defaults).  Normal user space stuff all at lower priorities.

The system is stressed by cramming small UDP messages, multiple packed
per radio MAC PDU, to the bandwidth limit for the WiMax channel (approx
12Mb/s) these are processed and passed through the network stack,
through a bridge and about 2.1 Mb/s makes it out the Ethernet port.  The
rest are dropped.  Between the radio driver RT tasks and the Ethernet
driver, the CPU is 100% utilized.

I don't care if packets get dropped when someone slams it with this
scenario.  I don't care that it blocks all incoming Ethernet traffic
destined to go upstream to the radio.  What I care is that the system
survives and resumes "normal" behavior once this condition ceases.  The
system should not oops and require a reboot to recover.  This sums up my
requirement.

-----

The value in the "right" place inside the spinlock makes me suspect
something fundamental such as cache, shared lockable memory, etc.  I
hope that someone recognizes this strangeness and can point me in the
right direction.

Is it possible for cache or other memory locking mechanisms to get
messed up by depriving all the Linux stuff at priority 50 from being
able to run?

Should tasks running at high RT priorities in an RT Preemption system be
using something different than spinlocks?


-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
