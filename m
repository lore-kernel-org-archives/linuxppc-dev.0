Date: Sat, 29 Jul 2000 23:38:22 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel panic in current benh tree (chrp)
Message-ID: <20000729233822.A31230@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the current benh tree gives me a kernel panic whit a chrp only config.

Any ideas whats going on here?

Total memory = 768MB; using 2048kB for hash table (at c0400000)
Linux version 2.2.17pre13-ben2 (olh@nectarine) (gcc version 2.95.2
19991024 (release)) #1 Sat J
ul 29 22:56:55 CEST 2000
Boot arguments: root=/dev/fd0 load_ramdisk=1 fake_initrd
console=ttyS0,9600
Warning: no mac-io found
PCI bus 0 controlled by pci at 80000000
RTAS Event Scan Rate: 1 (2999 jiffies)
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at f8dc0000
OpenPIC timer frequency is not set
time_init: decrementer frequency = 1246869360/60
Console: colour dummy device 80x25
Calibrating delay loop... <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000055 (error 0)
NIP: F8DAE000 XER: 20000000 LR: 0000466C REGS: c01ebac0 TRAP: 0600
MSR: 00003912 [FPDRME]
TASK = c01ea260[0] 'swapper' mm->pgd c01e8000 Last syscall: 0
GPR00: 00001012 C01EBB70 C01EA260 001EBBF0 01000000 410006DC 0000466C
001EBAB0
GPR08: 010006DC 00001002 C01EBC0C 00000008 84842022 00000000 00000000
00000000
GPR16: 00000000 00000000 20000002 00000000 00001032 001EC090 00000000
C0004154
GPR24: C0007388 C0210000 00000007 C01EC068 00000001 00001032 C01EBBF0
00000004
Call backtrace:
C02424F4 C0005A7C C0007408 C0004154 C0018E44 C020E320 C020E764
C0003CF0
Kernel panic: kernel access of bad area pc f8dae000 lr 466c address 55
tsk swapper/0
In swapper task - not syncing
Rebooting in 180 seconds..<1>Unable to handle kernel NULL pointer
dereference at virtual address 00000055 (error 0)
NIP: F8DAE000 XER: 20000000 LR: 0000466C REGS: c01eb820 TRAP: 0600
MSR: 00003912 [FPDRME]
TASK = c01ea260[0] 'swapper' mm->pgd c01e8000 Last syscall: 0
GPR00: 00001012 C01EB8D0 C01EA260 001EB950 01000000 410006DC 0000466C
001EB810


It hangs a short time in calibrating delay loop, then it panics a few
times and finally it has a paging request panic loop, like that:

Unable to handle kernel paging request at virtual address 24842030
(error 40000000)
NIP: C0007CD0 XER: 20000000 LR: C0007CC8 REGS: c01f3e70 TRAP: 0300
MSR: 00001032 [IRDRME]
Unable to handle kernel paging request



The ksymoops output looks like that:


>>NIP: f8dae000 <END_OF_CODE+38b1a248/????>
Trace: c02424f4 <call_rtas+70/1bc>
Trace: c0005a7c <chrp_event_scan+70/80>
Trace: c0007408 <timer_interrupt+80/a8>
Trace: c0004154 <int_return+0/0>
Trace: c0018e44 <printk+68/260>
Trace: c020e320 <calibrate_delay+24/178>
Trace: c020e764 <start_kernel+ec/1cc>
Trace: c0003cf0 <start_here+ec/264>
>>NIP: f8dae000 <END_OF_CODE+38b1a248/????>


3 warnings issued.  Results may not be reliable.


Any ideas what can cause the problem?
I will update the diffs of the last benh changes at
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/devel/kernel/benh/

The kernel works fine on pmac.
Of course :)



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
