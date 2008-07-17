Return-Path: <evangelion1122001@yahoo.com.cn>
Received: from n10.bullet.re3.yahoo.com (n10.bullet.re3.yahoo.com
	[68.142.237.123]) by ozlabs.org (Postfix) with SMTP id 8627DDDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 20:03:09 +1000 (EST)
Subject: Is there relationship between address translation enabled and PLB
	timeout error?
From: Evangelion <evangelion1122001@yahoo.com.cn>
To: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
In-Reply-To: <487E57F6.7020602@grandegger.com>
References: <487DD1BD.8040701@grandegger.com>
	<20080716142436.GD24045@secretlab.ca> <487E57F6.7020602@grandegger.com>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 12:20:07 +0200
Message-Id: <1216290007.6843.33.camel@zr.gii.upv.es>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, all:
    I am building a Linux kernel module for PPC405EP. My developing
board is PPChameleonEVB. I am debugging with BDI2000 and GDB, and my
problem is:
    In GDB, a section of the codes is disassembled to:
      mfmsr   r0
      ori     r0,r0,32768
      mtmsr   r0
      blr
    From BDI2000, I have checked that after "ori", GPR0 contains
"0x00029030". This value should be written into MSR by "mtmsr" to set EE
bit of MSR as 1, but after single step in BDI, "mtmsr" does not work as
hoped. MSR becomes "0x00000030", GPR0 becomes some weird number, and
there is "Step timeout detected". Meanwhile, the board traps into "Data
machine check in kernel mode". I also have tried "wrteei 1" instead of
the codes above, but failed again. However, those codes works well in
PPC440EP Yosemite board.
    I have compared PPChameleonEVB and Yosemite. It seems the most
significant difference is for PPChameleonEVB, address translation is
enabled by default (MSR[IR, DR] = 1), while for Yosemite, it is disabled
(MSR[IR, DR] = 0). And from the error message, I think there is a
problem with PLB because PLB0_BESR becomes 0x00c00000 from 0x00000000
and PLB0_BEAR becomes 0x03066004 when machine check happens. Based on
the processor manual, the PLB0_BESR shows the PLB Timeout Error Status
and the value means the error operation is reading the processor core
DCU. The PLB0_BEAR shows the address of the access on which a bus
timeout error occurred. So I have the following questions for this
moment:
    1. Is it possible or not that address translation leads to the PLB
timeout error? If that is the cause, how to fix the problem?
    2. Is the address in PLB0_BEAR a memory address (real address or
effective address) or a bus address (not an address in any kind of
memory)?
    3. Are there other reasons for the machine check in this situation?
    4. Is it an unrecoverable hardware problem (bug) or not?

Here is the debugging log:

405EP>ti
    Core number       : 0
    Core state        : debug mode
    Debug entry cause : single step
    Current PC        : 0xc32b1008
    Current CR        : 0x84000084
    Current MSR       : 0x00021030
    Current LR        : 0xc32b46c4
405EP>rd
GPR00: 00029030 c1dd9d60 c1fe7bf0 00000000
GPR04: 00000001 00000000 c32b2c8c 00000000
GPR08: c3068000 c3068000 00000001 c3062000
GPR12: 00000000 10019dd8 c32c0000 c32b0000
GPR16: 00000001 c32b0000 00000002 7ff4f670
GPR20: 00000028 c32b0000 c32b0000 10011000
GPR24: c306a000 00000000 00000000 10012c6c
GPR28: c18e4000 c32c0000 00000000 00000000
CR   : 84000084     MSR: 00021030
405EP>ti
    Core number       : 0
    Core state        : debug mode
    Debug entry cause : JTAG stop request
    Current PC        : 0xc000490c
    Current CR        : 0x42000082
    Current MSR       : 0x00000030
    Current LR        : 0xc001f1b8
# Step timeout detected
405EP>rd
GPR00: 03929800 c02f3e60 c3066000 000102f1
GPR04: 00005424 00000007 c0146f3c c0260000
GPR08: 00000000 c02d0000 c3062000 00000000
GPR12: 00000000 10019dd8 c32c0000 c32b0000
GPR16: 00000001 c32b0000 00000002 7ff4f670
GPR20: 00000028 c32b0000 c32b0000 10011000
GPR24: c306a000 00000000 00000000 10012c6c
GPR28: c02f0000 00000152 c3066000 c02f0000
CR   : 42000082     MSR: 00000030

==========================================
Here is the error message:

Data machine check in kernel mode.
PLB0: BEAR= 0x03066004 ACR=   0x00000000 BESR=  0x00c00000
PLB0 to OPB: BEAR= 0x04000000 BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#1]
NIP: 00002AD0 LR: 000005A0 CTR: C000CC58
REGS: c02f3f50 TRAP: 0202   Not tainted (2.6.19.2-eldk)
MSR: 00021000 <ME>  CR: 24000084  XER: 20000000
TASK = c3066000[0] '' THREAD: c02d2000
GPR00: 00029030 C1DD9CA0 C3066000 C1DD9CB0 00000001 00000000 C32B2C8C
00000000
GPR08: C3068000 00000000 00021032 01DD9CA0 030661B0 10019DD8 C32C0000
C32B0000
GPR16: 00000001 C32B0000 00000002 7FF4F670 00000028 C32B0000 C32B0000
10011000
GPR24: C306A000 00000000 00000000 10012C6C C18E4000 C32C0000 00000000
00000000
NIP [00002AD0] 0x2ad0
LR [000005A0] 0x5a0
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Rebooting in 180 seconds..

Thanks a lot for advice!

Best Regards

Evangelion
July 17th, 2008

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
