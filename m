Date: Tue, 23 Nov 1999 01:59:22 -0500 (EST)
From: "Christopher A. Shepherd" <cshepher@linux-florida.com>
Message-Id: <199911230659.BAA17280@parliament.linux-florida.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Odd SCSI Panic
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


List,

I am running a 2.2.13 kernel rsync'ed just a few days ago from Paul's
stable tree. This error has been happening to me for some time, and I'm
finally finding the time to start tracking it down:

I have a Blue/White PowerMac G3/400 with the Adaptec 2940U2W card and two
U2W disks. In older kernels, a large amount of disk activity (ie certain
compiles, or a tar command) would induce this, although lately I've only
been seeing it after successive copying of large amounts of data between
two different SCSI disks.

The kernel panic looks like this:
  hal9000 kernel: NIP: C002EB90 XER: 00000000 LR: C0020E38 REGS: c42c1b30 TRAP: 0300 
  hal9000 kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 
  hal9000 kernel: TASK = c42c0000[600] 'mv' mm->pgd cffa8000 Last syscall: 4  
  hal9000 kernel: last math c42c0000 
  hal9000 kernel: GPR00: C0020E38 C42C1BE0 C42C0000 C0681C78 C0681C90 C0681C90 00000000 00000003  
  hal9000 kernel: GPR08: 00020000 00000004 0000C814 C0190000 4224284B 018514F4 00000000 7FFFFA98  
  hal9000 kernel: GPR16: 7FFFFA9C CED2E078 CED2E060 C42C1DFC 00000001 00000002 00000001 00000400  
  hal9000 kernel: GPR24: C42C1DFC C01A0000 C01A0000 C0681C78 C01A0000 C01A0000 00000004 00000004  
  hal9000 kernel: Call backtrace:  
  hal9000 kernel: C06B2000 C0020E38 C0027110 C0027304 C0027DB0 C002EA5C C002D7AC  
  hal9000 kernel: C002D9B0 C0046918 C004711C C00474B8 C0044EEC C002B85C C0003888  
  hal9000 kernel: 00470F05 01802414 018034C8 01803E30 0180139C 018016F0 01801D44  
  hal9000 kernel: 016DF7D4 00000000  
  hal9000 kernel: Kernel panic: kernel access of bad area pc c002eb90 lr c0020e38 address 24 tsk mv/600 

... And from my System.map file, c002eb90 is init_buffer, from fs/buffer.c

Is this a known issue? Where's a good place to start digging for more info?

Thanks,
Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
