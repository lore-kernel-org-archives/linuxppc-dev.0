Message-Id: <5.2.1.1.0.20030811150058.00b59008@dns.struinfo.it>
Date: Mon, 11 Aug 2003 15:03:52 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: GDB crash during module debugging
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm debugging a device driver through the ppc-linux-gdb/BDI2000 system.
Everything works fine until I inspect the variables. For example:

(gdb) n
152             this = (struct nand_chip *) (&ppchameleon_mtd[1]);
(gdb) n
155             memset((char *) ppchameleon_mtd, 0, sizeof(struct mtd_info));
(gdb) n
156             memset((char *) this, 0, sizeof(struct nand_chip));
(gdb) n
159             ppchameleon_mtd->priv = this;
(gdb) p *(struct mtd_info *)ppchameleon_mtd
$1 = {type = 0x0, flags = 0x0, size = 0x0, erasesize = 0x0, oobblock = 0x0,
   oobsize = 0x0, ecctype = 0x0, eccsize = 0x0, name = 0x0, index = 0x0,
   oobinfo = {useecc = 0x0, eccpos = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0}},
   numeraseregions = 0x0, eraseregions = 0x0, bank_size = 0x0, erase = 0,
   point = 0, unpoint = 0, read = 0, write = 0, read_ecc = 0, write_ecc = 0,
   read_oob = 0, write_oob = 0, read_user_prot_reg = 0, read_fact_prot_reg = 0,
   write_user_prot_reg = 0, readv = 0, readv_ecc = 0, writev = 0,
   writev_ecc = 0, sync = 0, lock = 0, unlock = 0, suspend = 0, resume = 0,
   priv = 0x0, owner = 0x0, usecount = 0x0}
(gdb) n
Program received signal SIGSTOP, Stopped (signal).
serial_in (info=0xc015da18, offset=0x5) at serial.c:423
423                     return readb((unsigned long) info->iomem_base +
(gdb)

When I perform the next istruction, after displaying the struct, the
following message appears on the linux console:

eth1: Phy @ 0x2, type STE100P (0x1c040011)
Reset ethernet interfaces
[ppchameleon_init]
Oops: kernel access of bad area, sig: 11
NIP: C01435D8 XER: 00000000 LR: C01435D8 SP: C01F1FA0 REGS: c01f1ef0 TRAP:
0800dMSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000000, ESR: 00000000
TASK = c01f0000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0x00000010 acr=   0x00000000 besr=  0x00000000
PLB0 t

To start the debugging session I put a break with the BDI2000 in the init
function of the driver (it is statically linked in the kernel). Once the
break is reached, I "attach" the GDB to the kernel.

Anybody can help me?

Many thanks in advance and best regards,

llandre

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
