Message-Id: <l03130300b2d0a1474a03@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 24 Jan 1999 23:15:58 +1300
To: linuxppc-dev@lists.linuxppc.org
From: Bryan Christianson <bryanc@ihug.co.nz>
Subject: Help - Kernel Panic - 2.2.0-final
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am getting the the following panic in linuxppc-R4, with kernel 2.2.0-final.

The panic occurs when I use insmod (version 2.1.121) to load a driver that
I am working on. The statement in the module where it faults is

result = inl(base + offset)

where result is a u32 and base and offset have the values shown in the
following trace.

If there is someone that can shed any light on whats going on here I would
be really grateful. The installation is generic R4 apart from the upgrade
to the kernel and a more recent version modutils. The distributed modutils
was unable to resolve symbols and didn't even begin to load the driver.

Jan 24 20:04:57 linuxppc kernel: telsat: read_port: base = 0x00000400,
offset = 60
Jan 24 20:04:57 linuxppc kernel: Machine check in kernel mode.
Jan 24 20:04:57 linuxppc kernel: Caused by (from msr): regs c2a25ae0
Unknown values in msr
Jan 24 20:04:57 linuxppc kernel: NIP: C886117C XER: 00000000 LR: C8861168
REGS: c2a25ae0 TRAP: 0200
Jan 24 20:04:57 linuxppc kernel: MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
Jan 24 20:04:57 linuxppc kernel: TASK = c2a24000[991] 'insmod' mm->pgd
c2ae3000 Last syscall: 128
Jan 24 20:04:57 linuxppc kernel: last math 00000000
Jan 24 20:04:57 linuxppc kernel: GPR00: FE00043C C2A25BD0 C2A24000 00000035
00000001 C01990E8 C01A0000 C00D109C
Jan 24 20:04:57 linuxppc kernel: GPR08: 00000000 FE000000 00000000 C2A25B00
C2A25B00 01851C0C 01850000 01850000
Jan 24 20:04:57 linuxppc kernel: GPR16: 01850000 01850000 00000001 01850000
00009032 02A25E80 00000000 C0003A8C
Jan 24 20:04:57 linuxppc kernel: GPR24: C0003844 00000000 00000070 00000000
0000003C FFFFFFFF C88758F8 00000040
Jan 24 20:04:57 linuxppc kernel: Call backtrace:
Jan 24 20:04:57 linuxppc kernel: C8861168 C8863404 C8863518 C88637B4
C886384C C00815B8 C00E3720
Jan 24 20:04:57 linuxppc kernel: C8863964 C0016920 C0003898 01850000
01803AA0 01804208 01800F9C
Jan 24 20:04:57 linuxppc kernel: 01800E78
Jan 24 20:04:57 linuxppc kernel: Instruction DUMP: 8129e054  7c1d4a14
7fa0042c <7c0006ac> 3c60c886  38633b78  7fa4eb78  4cc63182  480148a1
Jan 24 20:04:57 linuxppc kernel: Kernel panic: machine check

--
Bryan Christianson
email:		<mailto:bryanc@ihug.co.nz>
Home Page:	<http://crash.ihug.co.nz/~bryanc>


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
