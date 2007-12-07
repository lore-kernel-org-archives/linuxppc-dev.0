Return-Path: <sensantanu_82@yahoo.com>
Received: from web53605.mail.re2.yahoo.com (web53605.mail.re2.yahoo.com
	[206.190.37.38]) by ozlabs.org (Postfix) with SMTP id D3EAFDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 23:33:25 +1100 (EST)
Date: Fri, 7 Dec 2007 04:33:23 -0800 (PST)
From: Santanu Sen <sensantanu_82@yahoo.com>
Subject: NAND JFFS2 wbuf non-contiguous write problem in linux-2.4.20
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <563033.16638.qm@web53605.mail.re2.yahoo.com>
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

I am facing some non-contiguous write bug in
"fs/jffs2/wbuf.c". I have a Hynix 512Mb NAND flash
mounted on a board running linuxppc-2.4.20 (gcc-2.96)
on an MPC852T processor (Yeah, we are living in the
21st century but cannot afford to port all our drivers
to 2.6 if we have to meet the deadline). 

I have seen a fix for the 2.6 kernel
(http://www.infradead.org/pipermail/linux-mtd/2006-January/014740.html).
Do not know how to make the patch work in 2.4.20. Any
help is appreciated. Attaching the OOPS messages
herewith.

Thanks and Regards,
Santanu



bash-2.03# jffs2_flush_wbuf(): Write failed with -5
Write of %zd bytes at 0x000000a0 failed. returned
8243708, retlen %zd
Not marking the space at 0x007dc9fc as dirty because
the flash driver returned retlen zero
jffs2_flash_writev(): Non-contiguous write to 007dc9fc
wbuf was previously 007dc800-007dca00
kernel BUG at wbuf.c:305!
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C0099994 XER: 00000000 LR: C0099994 SP: C3999D50
REGS: c3999ca0 TRAP: 1000    Tainted: PF
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3998000[109] 'syslogd' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C0099994 C3999D50 C3998000 0000001A 00001032
00000001 00000020 0000001A
GPR08: FFFFFFFF 00000000 00002A59 C3999C80 007DCA00
10056C78 00000000 C39B63E0
GPR16: C2AB3BDC 00000000 00000000 C3999DE8 007DC9FC
00000000 00000000 C3999DD8
GPR24: FFFFFFFF C02C50C4 00000002 007DC9FC C02C50C4
00000053 00000000 007DC9FC
Call backtrace:
C0099994 C0092C2C C00931D8 C008F338 C0029648 C00352AC
C000453C
00000000 0FF23A58 0FF23964 0FF23358 0FF20A0C 1001BD34
1001BF68
1001C14C 1001C3D4 1001C514 1002BD38 1002B940 0FECED14
00000000
mtd->read(0x%zx bytes from 0x7efd90) returned ECC
error
Node CRC 00000000 != calculated CRC 06cb30c5 for node
at 007efd90
jffs2_flush_wbuf(): Write failed with -5
jffs2_flush_wbuf(): Write failed with -5
Write of %zd bytes at 0x0000026c failed. returned
3571712, retlen %zd
Not marking the space at 0x00368000 as dirty because
the flash driver returned retlen zero
mtd->read(0x%zx bytes from 0x36fe80) returned ECC
error
mtd->read(0x%zx bytes from 0x36fec4) returned ECC
error
jffs2_flush_wbuf(): Write failed with -5
Write of %zd bytes at 0x0000026c failed. returned
3571712, retlen %zd
Not marking the space at 0x00368000 as dirty because
the flash driver returned retlen zero
mtd->read(0x%zx bytes from 0x36fe80) returned ECC
error
mtd->read(0x%zx bytes from 0x36fec4) returned ECC
error
jffs2_flush_wbuf(): Write failed with -5



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
