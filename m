Date: Fri, 1 Jan 1999 16:57:24 +0100 (CET)
From: Mark Wielaard <M.J.Wielaard@cable.a2000.nl>
Reply-To: Mark Wielaard <M.J.Wielaard@cable.a2000.nl>
To: Jason Haas <jhaas@madison-web.com>
cc: Multiple recipients of list <linux-pmac@samba.anu.edu.au>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2-pre2 kernel posted (2 crashes - also with vger kernel)
Message-ID: <Pine.LNX.3.96.990101163039.383A-100000@node1c5f.a2000.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> We've put a new 2.2 development kernel up on ftp.linuxppc.org.  It
> should run on any machine. 
> 
> ftp://ftp.linuxppc.org/linuxppc/linuxppc-pre-R5/RedHat.installer/vmlinux-2.2.0-pre2

I tried that kernel and I also updated my vger source this morning, but I
can crash both kernels with the following commands:

# cd /dev/
# cat zero > audio & cat zero > audio & cat zero > audio &
# kill %1

This also works with real audio files. Then the system crashes as soon as
the first audio file has finished playing. The above example just makes it
easy to reproduce (but doesn't produce any sound). It seems to be some
sort of queueing prolem, since it only happens when three or more
processes try to write to /dev/audio and then the first process stops
playing. (If in the above problem you first kill %2 and %3 and then %1 it
doesn't crash.) 

The other way to crash the kernel is:

# cat /proc/sys/net/ipv4/conf/default/proxy_arp

I thought it might be my setup/.config or egcs version, but the above
kernel [Linux version 2.2.0-pre2 (trini@globe.linuxppc.org) (gcc version
egcs-2.90.25 980302 (egcs-1.0.2 prerelease))] also crashes.

I have an PowerMac G3, but two other people with a Performa 6500 and a
PowerMac 5400 could also reproduce these crashes (but I don't know what
kernel they were using).

Below I have attached the kernel messages and ksymoops output. Please tell
me if you need more info. I have tried to look at the kernel source to
figure out what is happening, but it has been a long time ago that I read
C code and could not figure it out myself. Sorry.

Thanks,

Mark

P.S. Happy New Year!

===

Jan  1 16:10:45 node1c5f kernel: NIP: C00106C8 XER: 20000000 LR: C00106B0 REGS: c3c99cb0 TRAP: 0300
Jan  1 16:10:45 node1c5f kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan  1 16:10:45 node1c5f kernel: TASK = c3c98000[426] 'bash' mm->pgd c41b2000 Last syscall: 5
Jan  1 16:10:45 node1c5f kernel: last math c3dde000
Jan  1 16:10:45 node1c5f kernel: GPR00: 00000000 C3C99DA0 C3C98000 00000001 00008000 00079C4E C017BB58 0000003B
Jan  1 16:10:45 node1c5f kernel: GPR08: 00000001 00000000 00008000 C01F02A0 C3C99D60 018A31D0 018A9FE8 018AA478
Jan  1 16:10:45 node1c5f kernel: GPR16: 7FFFF960 00000000 00000000 00000000 00009032 03C99E80 00000000 C0003A8C
Jan  1 16:10:45 node1c5f kernel: GPR24: C0003844 00000001 00000000 00000054 C3C99DA8 C01F02A4 00009032 C3C99DA0
Jan  1 16:10:45 node1c5f kernel: Call backtrace:
Jan  1 16:10:45 node1c5f kernel: C00106A8 C012ACB0 C0127C54 C002B84C C0029D78 C0029E30 C0029FE0
Warning, Code line not seen, dumping what data is available

>>EIP: c00106c8 <interruptible_sleep_on_timeout+90/ec>
Trace: c00106a8 <interruptible_sleep_on_timeout+70/ec>
Trace: c012acb0 <sq_open+5c/148>
Trace: c0127c54 <soundcore_open+78/a4>
Trace: c002b84c <chrdev_open+60/7c>
Trace: c0029d78 <filp_open+114/1ac>
Trace: c0029e30 <do_open+20/60>
Trace: c0029fe0 <sys_open+5c/b8>

====

Jan  1 16:16:47 node1c5f kernel: NIP: ED13ED10 XER: 00000000 LR: C001AB64 REGS: c247bd30 TRAP: 0400
Jan  1 16:16:47 node1c5f kernel: MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan  1 16:16:47 node1c5f kernel: TASK = c247a000[377] 'cat' mm->pgd c1d14000 Last syscall: 3
Jan  1 16:16:47 node1c5f kernel: last math c0956000
Jan  1 16:16:47 node1c5f kernel: GPR00: ED13ED13 C247BE20 C247A000 C021BD64 00000000 C1ADEF20 018452B8 C247BE28
Jan  1 16:16:47 node1c5f kernel: GPR08: 00000000 00000000 00000000 C247A13C C247BE20 0184CF90 018A9768 018A9660
Jan  1 16:16:47 node1c5f kernel: GPR16: 00000000 00000000 01840000 01840000 00009032 0247BE80 00000000 C0003A8C
Jan  1 16:16:47 node1c5f kernel: GPR24: C0003844 00001000 01840000 018452B8 00001000 C1ADEF20 00000000 C021BD64
Jan  1 16:16:47 node1c5f kernel: Call backtrace:
Jan  1 16:16:47 node1c5f kernel: C001AB30 C001ABB8 C002A7A8 C0003898 01802A08 01800E14 0180187C
Jan  1 16:16:47 node1c5f kernel: 01800AB4
Jan  1 16:16:47 node1c5f kernel: Kernel panic: kernel access of bad area pc ed13ed10 lr c001ab64 address ED13ED10 tsk cat/377
Warning, Code line not seen, dumping what data is available

>>EIP: ed13ed10 <END_OF_CODE+2cf3b210/????>
Trace: c001ab30 <do_rw_proc+7c/d0>
Trace: c001abb8 <proc_readsys+34/44>
Trace: c002a7a8 <sys_read+10c/178>
Trace: c0003898 <syscall_ret_1+0/a0>
Trace: 01802a08 Before first symbol
Trace: 01800e14 Before first symbol
Trace: 0180187c Before first symbol
Trace: 01800ab4 Before first symbol
>>EIP: ed13ed10 <END_OF_CODE+2cf3b210/????>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
