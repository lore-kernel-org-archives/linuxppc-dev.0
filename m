Return-Path: <gautam@eisodus.com>
Received: from smtp1.iitb.ac.in (smtp1.iitb.ac.in [59.163.25.49])
	by ozlabs.org (Postfix) with SMTP id E8EBE679FC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 00:05:34 +1000 (EST)
Message-ID: <444E2ABA.60400@eisodus.com>
Date: Tue, 25 Apr 2006 19:27:14 +0530
From: Gautam Borad <gautam@eisodus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Kernel panic on mpc852.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I'm trying to port linux-2.4.21 to mpc852t custom board.
The bootloader (u-boot) works fine and the kernel boots.
The kernel is _VERY_ unstable, in that it gives sig 11
( Oops: kernel access of bad area, sig: 11 ) at random
intervals.
I've created this short test program :

    int *testmem;
    g = atoi(argv[1]);
    if(( testmem =(int*)malloc(1024*g)) == NULL ) {
        printf("mem test failed at iteration : %d",i);
        exit(0);
    }
    bzero(testmem,1024*g);
    printf("mem test at 0x%08x \t i = %d\n",testmem,i);

We have 32MB RAM.The above code never returns cleanly,
it always gives panic with sig 11.
I've added a printk to arch/ppc/mm/fault.c kernel for debugging purpose

    if (!(vma->vm_flags & VM_GROWSDOWN)){
        printk("\nerror : vm_start = 0x%08x  Address = 0x%08x\n 
",vma->vm_start,address);
        goto bad_area;
    }

Sample output:

[root]$ ./b0memtest 64

mem test at 0x10010c60   i = 0
mem test at 0x10020c68   i = 1
....
mem test at 0x10140cf8   i = 19
mem test at 0x10150d00   i = 20
mem test at 0x10160d08   i = 21

<comment> The following is my printk from arch/ppc/mm/fault.c </comment>

vm_start = 0x10000000 vm_end = 0x10001000 Address = 0x00000024  <===== 
Why is it trying to access 0x00000024

 Oops: kernel access of bad area, sig: 11
 NIP: C000B80C XER: 00000000 LR: C000B7F4 SP: C1D59F00 REGS: c1d59e50 
TRAP: 0300    Not tainted
 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
 DAR: 00000024, DSISR: 0000000B
 TASK = c1d58000[32] 'b0memtest' Last syscall: 4
 last math 00000000 last altivec 00000000
 GPR00: 00000005 C1D59F00 C1D58000 00009032 C1F22C3C C1D59EA0 C0138258 
00000000
 GPR08: C1D58000 00000006 C0136050 00000000 44004082 00000000 00000000 
00000000
 GPR16: 00000000 00000000 00000000 00000000 C0160000 C0140000 C0130000 
C0140000
 GPR24: C00025C0 10000A00 7FFFFB40 00000020 C1D58000 C0144940 00000000 
C1D59F00
 Call backtrace:
 10000A00 C000286C 3003B55E 30068BF8 3006954C 300690F8 3006CA50
 30068024 10000788 300593A4 00000000

[root]$ ./b0memtest 128

mem test at 0x10010c60   i = 0
mem test at 0x10030c68   i = 1
....
mem test at 0x10190cc0   i = 12
mem test at 0x101b0cc8   i = 13

<comment> Again the same address </comment>

vm_start = 0x10000000 vm_end = 0x10001000 Address = 0x00000024   <=====

 Oops: kernel access of bad area, sig: 11
 NIP: C000B80C XER: 00000000 LR: C000B7F4 SP: C1DE1F00 REGS: c1de1e50 
TRAP: 0300    Not tainted
 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
 DAR: 00000024, DSISR: 0000000B
 TASK = c1de0000[24] 'b0memtest' Last syscall: 45
 last math 00000000 last altivec 00000000
 GPR00: 00000005 C1DE1F00 C1DE0000 00009032 00001032 000000E4 C0138258 
00000000
 GPR08: C1DE0000 00000006 C0136050 00000000 04000084 00000000 00000000 
00000000
 GPR16: 00000000 00000000 00000000 00000000 C0160000 C0140000 C0130000 
C0140000
 GPR24: C0003F78 10000A00 00000002 100004D8 C1DE0000 C0144940 00000000 
C1DE1F00
 Call backtrace:
 C000402C C000286C 30074024 10000728 300593A4 00000000

Thanks in advance.
