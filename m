Message-Id: <l03130300b2dbb10d21bc@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 2 Feb 1999 08:42:28 +1300
To: linuxppc-dev@lists.linuxppc.org
From: Bryan Christianson <bryanc@ihug.co.nz>
Subject: I/O Port Conflicts with PCI devices?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following listing of /proc/pci shows that I have 2 devices reporting an
I/O port of 0x400. Is this possible or am I not seeing the whole truth
here? When I try to access the port (with inl() or outl()), the machine
panics. I published this panic on the list last week and had no response.

I notice that GPR00 contains the address of the port plus my offset
(0x043c), offset by 0xFE000000, which from my reading of the kernel source
is the remapping done for PCI devices during initialisation.

I have tried kernels 2.1.130, 2.2.0 and 2.2.1, all with the same result. If
there are any PCI gurus out there who can help, I would dearly love to get
this to work.

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola MPC106 Grackle (rev 64).
      Fast devsel.  Fast back-to-back capable.  Master Capable.  No bursts.
  Bus  0, device  14, function  0:
    Ethernet controller: SatSagem Telsat Turbo DVB (rev 1).
      Fast devsel.  IRQ 24.  Master Capable.  Latency=32.
      I/O at 0x400 [0x401].
      I/O at 0x450 [0x451].
      I/O at 0x440 [0x441].
  Bus  0, device  16, function  0:
    Unknown class: Apple Unknown device (rev 1).
      Vendor id=106b. Device id=10.
      Medium devsel.  Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].
  Bus  0, device  18, function  0:
    VGA compatible controller: ATI Mach64 GT (Rage II) (rev 154).
      Medium devsel.  Fast back-to-back capable.  IRQ 22.  Master Capable.
Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0x82000000 [0x82000000].
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0x82fff000 [0x82fff000].


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
