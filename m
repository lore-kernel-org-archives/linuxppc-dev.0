Date: Fri, 27 Aug 2004 13:59:04 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Subject: Kernel oops when initializing ethernet driver
Message-ID: <15261.1093607944@www2.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm getting a kernel oops that's triggered by the device driver
initialization code (Xilinx VirtexII-Pro on-chip ethernet).

It crashes when executing the code
XIIF_V123B_RESET(InstancePtr->BaseAddress);
(line 554, function XEmac_Reset() in drivers/net/xilinx_enet/xemac.c)

The oops message looks like this:
> Instruction machine check in kernel mode.
> Oops: machine check, sig: 7
> NIP: C00BBA78 XER: C000005F LR: C00BBA6C SP: C1FEFF20 REGS: c1fefe70 TRAP:
0200    Not tainted
> MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c1fee000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 0000000A C1FEFF20 C1FEE000 00000020 00001030 00000001 0000068D
C015377F
> GPR08: 00000000 C3000000 00000034 C1FEFE30 C0160000 00003104 00000000
00000000
> GPR16: 00000000 00000000 00000000 FFFFC430 00000000 FFFFC488 FFFFC420
FFFFC4A0
> GPR24: 00000000 08100000 00000000 C0130A60 C1FD7560 00000000 C0160000
C1FD75E8
> Call backtrace:
> C00BBA6C C00BB5E0 C0162890 C0162AA4 C015A618 C00024B0 C0006BD4

I don't know jack about kernel oopses, but I learned that this is probably a
access violation (Address not mapped in MMU, or whatever).

The address that the driver wants to access is 0xc3000040, which is the
virtual address of some ethernet softcore register. The physical registers
of the NIC begin at 0x80000000, and IIRC they are mapped to 0xc3000000 by
cfg->BaseAddress = (u32) ioremap(lp->save_BaseAddress, remap_size);
in the module's probe() function in xilinx_enet/adapter.c
where remap_size is well above 0x40 (it's 0x4000, AFAIK)

Does anybody know what could be the problem? Do I have to do some I/O
mapping by hand, before the driver's init routine is invoked? Do I have to
configure the FPGA bitstream in some magic way, before the Linux drivers can
be used?

I'm using the linuxppc_2_4_devel tree from Montavista and a gcc-3.3.2
toolchain.
I'm linking the ethernet driver straight into the kernel (not as loadable
module).

Thanks in advance,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
