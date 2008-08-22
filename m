Return-Path: <vancasperz@yahoo.com.cn>
Received: from n7.bullet.re3.yahoo.com (n7.bullet.re3.yahoo.com
	[68.142.237.92]) by ozlabs.org (Postfix) with SMTP id 50003DF654
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 04:05:59 +1000 (EST)
Subject: Why does one "stw" fail with address translation disabled in PPC405EP?
From: Zhou Rui <vancasperz@yahoo.com.cn>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 22 Aug 2008 20:27:15 +0200
Message-Id: <1219429635.8882.22.camel@zr.gii.upv.es>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, all:
    I think I meet an odd problem with PPC405EP (PPChameleonEVB Board).
    I am running a kernel module which will execute a user space
application. The entry point of the application is 0x100000a0. At the
moment when the processor tries to execute the application, 0x100000a0
is not in TLB (this can be seen from BDI by printing out TLB entries),
so DTLBMiss is called automatically and then finish_tlb_load. However,
InstructionAccess is followed and the problem arises here.
InstructionAccess starts from 0x400, and after instruction "0xc0000434
<InstructionAccess+52>:      stw     r12,64(r11)", machine check occurs.
This instruction will store the value of r12, which is 0x0 at this
moment, to address 0x03072de0. I am puzzled why this action leads to
machine check. Is it illegal to store 0x0 in a memory address? Or is
there some other cause of the machine check here?

405EP>r
GPR00: c31c5200 c3072da0 c03a97b0 100000a0
GPR04: c306a000 c306e000 c31c51b8 c306a000
GPR08: c0a64000 c0a64000 40000000 03072da0
GPR12: 00000000 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000
GPR20: 00000000 00000000 00000000 00000000
GPR24: 00000000 00000000 00000000 00000000
GPR28: 00000000 c31d0000 100000a0 c306a000
CR   : 20000000     MSR: 00001000
405EP>t
    Core number       : 0
    Core state        : debug mode
    Debug entry cause : single step
    Current PC        : 0x00000434
    Current CR        : 0x20000000
    Current MSR       : 0x00001000
    Current LR        : 0xc31c478c
405EP>r
GPR00: c31c5200 c3072da0 c03a97b0 100000a0
GPR04: c306a000 c306e000 c31c51b8 c306a000
GPR08: c0a64000 c0a64000 40000000 03072da0
GPR12: 00000000 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000
GPR20: 00000000 00000000 00000000 00000000
GPR24: 00000000 00000000 00000000 00000000
GPR28: 00000000 c31d0000 100000a0 c306a000
CR   : 20000000     MSR: 00001000
405EP>t
    Core number       : 0
    Core state        : debug mode
    Debug entry cause : single step
    Current PC        : 0x00000200
    Current CR        : 0x20000000
    Current MSR       : 0x00001000
    Current LR        : 0xc31c478c
405EP>

The error message shows more information. I am also puzzled why NIP here
is 0x440 but not 0x434:

Data machine check in kernel mode.
PLB0: BEAR= 0x03072dd4 ACR=   0x00000000 BESR=  0x00c00000
PLB0 to OPB: BEAR= 0x04000000 BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#1]
NIP: 00000440 LR: C31C478C CTR: 100000A0
REGS: c02a8f50 TRAP: 0202   Not tainted  (2.6.19.2)
MSR: 00021000 <ME>  CR: 20000000  XER: 00000000
TASK = c0399490[987] 'loader.xm' THREAD: c028a000
GPR00: C31C5200 C3072DA0 C0399490 100000A0 C306A000 C306E000 C31C51B8
C306A000 
GPR08: C0413000 C0413000 FFFFFFFF 03072DA0 00000000 00000000 00000000
00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
GPR24: 00000000 00000000 00000000 00000000 00000000 C31D0000 100000A0
C306A000 
NIP [00000440] 0x440
LR [C31C478C] jump_xm_dom+0x2c/0x48 [xm]
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
Data machine check in kernel mode.
PLB0: BEAR= 0x03072dc0 ACR=   0x00000000 BESR=  0x00800000
PLB0 to OPB: BEAR= 0x04000000 BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#2]
NIP: C0002EA8 LR: C0002E94 CTR: C31C3094
REGS: c02a8f50 TRAP: 0202   Not tainted  (2.6.19.2)
MSR: 00021030 <ME,IR,DR>  CR: 22002022  XER: 00000000
TASK = c03990d0[905] 'klogd' THREAD: c0e34000
GPR00: C0002E94 C0E35F40 C03990D0 00000FFF 00000001 00000000 00000FFF
00000000 
GPR08: 00000000 00000000 00021032 00000000 C0E34000 0804E364 100F0000
00000000 
GPR16: 101009E8 1009DF98 100F0000 08046368 08046364 07FEF08C 08046130
08004B74 
GPR24: 08004FA4 08046130 08004DB4 08004DB8 08004F70 080466BC 08046358
08046AC0 
NIP [C0002EA8] ret_from_syscall+0x14/0x3c
LR [C0002E94] ret_from_syscall+0x0/0x3c
Call Trace:
[C0E35F40] [C0002E94] ret_from_syscall+0x0/0x3c (unreliable)
Instruction dump:
614a9634 5400103a 408000a0 7d4a002e 7d4803a6 39210010 4e800021 7c661b78 
542c0024 3d400002 614a1032 7d400124 <812c0028> 3900fdfc 7120db0f
408201a4

Another question is when 0x100000a0 is missed in TLB, why the order of
calling kernel functions is DTLBMiss -- finish_tlb_load --
InstructionAccess?

Appreciate in advance for any advice!!!

Best Wishes

Zhou Rui
2008-08-22

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
