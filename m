Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15804.mail.cnb.yahoo.com (web15804.mail.cnb.yahoo.com
	[202.165.102.84]) by ozlabs.org (Postfix) with SMTP id 1EDEF6884B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 17:20:09 +1100 (EST)
Message-ID: <20051202062007.52513.qmail@web15804.mail.cnb.yahoo.com>
Date: Fri, 2 Dec 2005 14:20:07 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Can I operate i2c device in a tasklet?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I found that once I operated i2c bus like 
read from i2c device in 2.4.31 kernl in a
interrupt handler or tasklet, kernel panic
would happen. Is there any way to make it
in such case? I need to write sth on RTC
alarm register with an interrupt event.

......
Scheduling in interrupt
kernel BUG at sched.c:564!

Oops: Exception in kernel mode, sig: 4

NIP: C0011F98 XER: 00000000 LR: C0011F98 
SP: C0236010 REGS: c0235f60 TRAP: 0700
    Not tainted

MSR: 00081032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0234470[0] 'swapper' Last syscall: 120 
last math c7e98000 last altivec 00000000

GPR00: C0011F98 C0236010 C0234470 0000001B 
00001032 00000001 F0000000 00000000 

GPR08: C7A8D060 C0290000 C0269BD7 C0235F20 
0000000D 10041C70 08000000 007FFF5E 

GPR16: 00000000 00000000 007FFF00 07FFA3AC 
00001032 00236340 C0290000 C0270000 

GPR24: C0230000 C0230000 F0000100 F0011860 
00000000 00000000 C0267F28 C0236010 

Call backtrace: 

C0011F98 C0012430 C0156970 C0156CA4 
C01531E0 C0153F68 C01541CC 

C0153BBC C01570B4 C016D7AC C0006D78 
C0006E34 C0005CE0 C0007360 

C000737C C0003978 C02755B0 000035F0 

Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing

 <0>Rebooting in 1 seconds..

TIA,

Sam


	

	
		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰ 
http://cn.mail.yahoo.com
