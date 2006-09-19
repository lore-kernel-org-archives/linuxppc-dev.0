Return-Path: <rimas@cnmat.berkeley.edu>
Received: from cnmat.berkeley.edu (cnmat.CNMAT.Berkeley.EDU [128.32.122.12])
	by ozlabs.org (Postfix) with ESMTP id 8CAA1679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 10:06:06 +1000 (EST)
Received: from [128.32.122.77] (account rimas@cnmat.berkeley.edu)
	by cnmat.berkeley.edu (CommuniGate Pro WebUser 5.0.4)
	with HTTP id 1997652 for linuxppc-embedded@ozlabs.org;
	Mon, 18 Sep 2006 17:06:05 -0700
From: "rimas" <rimas@cnmat.berkeley.edu>
Subject: problems with PLB_TEMAC & xilinx_gige driver under linux 2.4
 ...
To: linuxppc-embedded@ozlabs.org
Date: Mon, 18 Sep 2006 17:06:05 -0700
Message-ID: <web-1997652@cnmat.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,

i am having problems using the xilinx_gige driver under linux 2.4.26 running 
on  a Virtex-4 FX12 Mini Module board (from avnet).  I am using the plb_temac 
and hard_temac blocks under ISE/EDK 8.1.02.

the machine boots fine and the network interface seems to work okay but it 
randomly panics sometimes (rather quickly if i'm generating network traffic):

Oops: Exception in kernel mode, sig: 4
NIP: C00DA340 XER: 20000000 LR: C00D34F8 SP: C3945B20 REGS: c3945a70 TRAP: 
0700
    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3944000[52] 'telnetd' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: 00000004 C3945B20 C3944000 C02E49F4 C02E4800 00000004 00000001 C0456260
GPR08: C0177424 00000031 C50D8000 00021F03 0008C8E4 10122AA8 00000000 C01A0000
GPR16: 00000000 0000001A 00000000 C3945F18 00001032 03945BA0 00000000 C00038E0
GPR24: C0004800 00000020 C04C06E0 C01864E0 C3945BB0 0000001F 00000000 C02E49F4
Call backtrace:
C0190000 C00D34F8 C0004748 C000483C C00038E0 C00D398C C00F8094
C00EE04C C01039B0 C0104D70 C0115570 C01163A8 C010A600 C012A61C
C00E52F4 C00E5574 C003AB2C C000369C 100572BC 10005064 10005108
0FD9221C 00000000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
  <0>Rebooting in 180 seconds..

it always causes a trap on the same instruction (c00da340) which is inside of
XTemac_IntrFifoHandler()

c00da330:       81 6a 00 28     lwz     r11,40(r10)
c00da334:       0c 0b 00 00     twi     0,r11,0
c00da338:       4c 00 01 2c     isync
c00da33c:       81 2a 00 20     lwz     r9,32(r10)
c00da340:       0c 09 00 00     twi     0,r9,0
c00da344:       4c 00 01 2c     isync

this code corresponds to two consecutive in_be32() calls

extern inline unsigned in_be32(volatile unsigned *addr)
{
	unsigned ret;

	__asm__ __volatile__("lwz%U1%X1 %0,%1;\n"
			     "twi 0,%0,0;\n"
			     "isync" : "=r" (ret) : "m" (*addr));
	return ret;
}

resulting from this line of code:

CorePending = XTemac_mGetIpifReg(XTE_IPIER_OFFSET) & 
XTemac_mGetIpifReg(XTE_IPISR_OFFSET);

i recently got a new mini module that has the later stepping of the V4FX12 
part (PVR 20011470) so I got rid of the patch i had applied to disable the 
caches  (which was required on the earlier stepping of the part to get the 
board to even boot reliably).

I still have the patch applied which sets bits 1 and 3 in the CCR0 register.

does anyone have any clue as to what's going on and what to do about it ?

this problem seems rather non-deterministic and weird, i can't help but think 
its likely related to some silicon errata or something but nothing on this 
page

http://www.xilinx.com/xlnx/xil_ans_display.jsp?iCountryID=1&iLanguageID=1&getPagePath=20658&BV_SessionID=@@@@0135296752.1158623889@@@@&BV_EngineID=cccdaddikmdkkifcefeceihdffhdfkf.0

seems to apply

any advice is very greatly appreciated !

-rimas
