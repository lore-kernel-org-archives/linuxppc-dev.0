From: kd@flaga.is
Subject: Ram disk crashing
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFAAA8096E.505BEEA4-ON00256943.005AE08A@flaga.is>
Date: Tue, 22 Aug 2000 16:51:51 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a slight problem with the ramdisk in our custom MPC823 board.
When reading/writing large chunks of data from the ramdisk (dev/ram) I
frequently get a kernel crash.
This inhibits me to use the initrd to boot the board.
Booting from NFS and running applications for days is no problem (and
ignoring /dev/ram).

Sometimes I get a "direct" kernel crash with a register dump, but some
times I get strange messages from kmem_alloc and the enet driver, although
I am copying data from /dev/zero to /dev/ram or from /dev/ram to /dev/null,
which I believe should be independendt of the ethernet driver.
example,
/ # dd if=/dev/zero of=/dev/ram bs=64k count=25
kmem_alloc: Bad slab magic (corrupt) (name=skbuff_head_cache)
eth0: Memory squeeze, dropping packet.
etc...

or a direct crash like

/ # dd if=/dev/zero of=/dev/ram bs=64k count=24
24+0 records in
24+0 records out
/ # dd if=/dev/ram of=/dev/null bs=64k count=24
NIP: C001532C XER: 2000CB18 LR: C0015848 REGS: c0ba1d70 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ba0000[22] 'dd' mm->pgd c00c5000 Last syscall: 1
last math 00000000
GPR00: 2D204750 C0BA1E20 C0BA0000 C0BA0000 00008000 C0119000 00000000
C0119000
GPR08: C0172120 C00C0000 C01721A0 C016F7E4 24000044 1004234C 10044C50
00010000
GPR16: 00000003 00000004 00010000 00000000 00009032 00BA1E80 00000000
<3>kmem_al
loc: Bad slab magic (corrupt) (name=skbuff_head_cache)
eth0: Memory squeeze, dropping packet.

I suspect the the ramdisk driver is overwriting some kernel data when
beeing read/written from.

The environment I am using is
busybox 0.46. Kernel is 2.2.13 from ftp.mvista.com. Same behaviour is with
copyback cahe enabled or writethrough cache enabled.
The board has 16Mb of ram and the initial boot info from fadsrom is (for a
non initrd kernel):

rmon> bl 0xfe020000
loaded at:     FE020000 FE02C204
relocated to:  00100000 0010C204
board data at: 001001C4 001001E8
relocated to:  00200100 00200124
zimage at:     FE027000 FE0877C4
avail ram:     00201000 00F00000

Similar things happen when I try to boot from my initrd (unless it is very
small (only a hello world)) or
if I ignore the initrd and try to read it through /dev/initrd.

Have you seen such a strange behaviour on your boards and maybe know a fix?

Thanks,

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
