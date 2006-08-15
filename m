Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25915.mail.ukl.yahoo.com (web25915.mail.ukl.yahoo.com
	[217.146.176.253]) by ozlabs.org (Postfix) with SMTP id 2469367B72
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 18:48:37 +1000 (EST)
Message-ID: <20060815084156.30290.qmail@web25915.mail.ukl.yahoo.com>
Date: Tue, 15 Aug 2006 09:41:56 +0100 (BST)
From: emre kara <emrekara2002@yahoo.co.uk>
Subject: eldk4.0 ppc_85xx-gdb failure while debugging with BDI2000
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear All;
Is there any one use BDI2000 ppc_85xx-gdb (coming with
ELDK4.0 dist). Please examine the log below. 
Target is waiting in start_kernel func.

ppc_85xx-gdb vmlinux
......
......
(gdb) target remote 192.168.101.101:2001
Remote debugging using 192.168.101.101:2001
0x00000000 in ?? ()
(gdb) q

gdb can not display correct addr and debug anything.
but at this state, older version toolchain (eldk3.1)
is working properly.

Second problem, I have check denx web site for an gdb
update and found
gdb-ppc_85xx-6.3.0.0-1.21_3.ppc.rpm,but instalation
fails with the error below.
-----------------------------------------
ppc_85xx-rpm -U gdb-ppc_85xx-6.3.0.0-1.21_3.ppc.rpm
error: Failed dependencies:
        info-ppc_85xx is needed by
gdb-ppc_85xx-6.3.0.0-1.21_3.ppc
------------------------------------------

 Here is my bdi configuration file:
--------------------------------------------------
;bdiGDB configuration file for MPC8540ADS
;----------------------------------------

[INIT]
 WM32 0x000000f0 0x00000000 ;invalidate page table
base


[TARGET]
CPUTYPE     8540  ;the CPU type
JTAGCLOCK   0     ;use 16 MHz JTAG clock
STARTUP     STOP 100 ;halt core while HRESET is
asserted
BREAKMODE   SOFT  ;SOFT or HARD, HARD uses PPC
hardware breakpoint
STEPMODE    HWBP  ;JTAG or HWBP, HWBP uses a hardware
breakpoint
MMU         XLAT; for kernel debug
PTBASE      0xf0;for kernel debug
WAKEUP      500   ;give reset time to complete
POWERUP     5000  ;start delay after power-up detected
in ms

[HOST]
PROMPT 8540_KRNL>

[REGS]
FILE        $reg8560.def

How can I solve this problems?

Thanks.

Emre




	
	
		
___________________________________________________________ 
All new Yahoo! Mail "The new Interface is stunning in its simplicity and ease of use." - PC Magazine 
http://uk.docs.yahoo.com/nowyoucan.html
