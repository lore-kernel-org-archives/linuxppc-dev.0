Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) by ozlabs.org (Postfix) with ESMTP id C0F1467BAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 19:41:03 +1100 (EST)
Received: from l-dhlii.dlasys.net ([206.223.20.247]:2898)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GnWJ0-0001Qt-Ra by authid <dhlii> with plain_server
	for <linuxppc-embedded@ozlabs.org>; Fri, 24 Nov 2006 03:21:06 -0500
Message-ID: <4566ACD4.3020606@dlasys.net>
Date: Fri, 24 Nov 2006 03:27:00 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Hardware/Software Debugging - general PPC405 Q.
Content-Type: multipart/alternative;
	boundary="------------040001080707010504010203"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040001080707010504010203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    I have been trying to add hardware/software breakpoints to the elf 
loader I am using for Linux on the Pico E12/E14 boards.
    I have had no trouble setting up an exception handler - I found 
several including the one inside the kernel to "borrow" from.
    Using the Xilinx/IBM PPC reference I have had no problem setting a 
breakpoint - either by replacing an instruction with a trap, or by 
setting  the IAC registers.
    I have no problem catching the exception  - exactly as I expected.
    But despite the fact that I have cleared the dbsr, dbcr0, esr, and 
the appropriate bits in the msr/ appropriate srr for the exception,
     I can not exit from the excretion handler (back through restoring 
registers (except for the above changes) , without having the exception 
re-occur again at exactly the same place.
    I have poured over the Xilinx/IBM docs looking for something I am 
missing, some bit I need to wiggle, ... but can't find anything.

    Is anyone aware of a clean example dealing with ppc405 software 
debugging (or something similar enough to be useful)  that I could use 
as a reference ?
    Anyone have any ideas what I might be missing ? Or a mailing list 
that might be a more appropriate target this question ?

    I have pasted a trace of what I am seeing - the trace is my own code 
- part of the software debugger I am trying to build into the bootloader.
    The trace at each exception only shows the registers that have 
changed since the last display.
   
    MonitorK.elf is the debugging version of my boot loader.
    Anything prefixed with a "!" is a command to MonitorK.
   

File MonitorK.elf updated from C:\Pico\MonitorK.elf.
Loading MonitorK.elf.
!boot -vvTS kernel.elf
Entrypoint: 0x000064e0 Cmdline @ 0x0fff0200: <>
    lr=0x000064e0     r3=0x0fffb000     r6=0x0fff0200     
r9=0x10000000   srr0=0x000064e0  dbcr0=0x08000000
  iac1=0x000064f0     r1=0x0fff0000
DBCR0: IC
Traps:    0x000064ec

Program Exception 00000007 @ 000064ec
   bch=0x0fff010c    blr=0x07000780     pc=0x000064ec     
cr=0x40000000    r11=0x0006fa3c   srr0=0x000064ec
   esr=0x02000000    tsr=0xc4000000   dbsr=0x98100300  dbcr0=0x09000000
DBSR: IC TDE UDE IDE
DBCR0: IC TDE
ESR: PEU
TSR: ENW WIS
Traps:    0x000064ec
000064ec: 41820008 bc      12,2,0x8

!step
Program Exception 00000007 @ 000064ec
   tsr=0x04000000   dbsr=0x90100000
DBSR: IC TDE IDE
DBCR0: IC TDE
ESR: PEU
TSR:
Traps:    0x000064f0
000064ec: 41820008 bc      12,2,0x8

!step
Program Exception 00000007 @ 000064ec
   tsr=0xc4000000
DBSR: IC TDE IDE
DBCR0: IC TDE
ESR: PEU
TSR: ENW WIS
Traps:    0x000064f0 0x000064f0
000064ec: 41820008 bc      12,2,0x8

!step
Program Exception 00000007 @ 000064ec
   tsr=0x04000000
DBSR: IC TDE IDE
DBCR0: IC TDE
ESR: PEU
TSR:
Traps:    0x000064f0 0x000064f0 0x000064f0
000064ec: 41820008 bc      12,2,0x8


I can get this to repeat pretty much infinitely with nothing changing 
except TSR_ENW and  TSR_WIS




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040001080707010504010203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">&nbsp;&nbsp;&nbsp; I have been trying to add hardware/software
breakpoints to the elf loader I am using for Linux on the Pico E12/E14
boards.<br>
&nbsp;&nbsp;&nbsp; I have had no trouble setting up an exception handler - I found
several including the one inside the kernel to "borrow" from.<br>
&nbsp;&nbsp;&nbsp; Using the Xilinx/IBM PPC reference I have had no problem setting a
breakpoint - either by replacing an instruction with a trap, or by
setting&nbsp; the IAC registers.<br>
&nbsp;&nbsp;&nbsp; I have no problem catching the exception&nbsp; - exactly as I expected.<br>
&nbsp;&nbsp;&nbsp; But despite the fact that I have cleared the dbsr, dbcr0, esr, and
the appropriate bits in the msr/ appropriate srr for the exception, <br>
&nbsp;&nbsp;&nbsp;&nbsp; I can not exit from the excretion handler (back through restoring
registers (except for the above changes) , without having the exception
re-occur again at exactly the same place.<br>
&nbsp;&nbsp;&nbsp; I have poured over the Xilinx/IBM docs looking for something I am
missing, some bit I need to wiggle, ... but can't find anything.<br>
<br>
&nbsp;&nbsp;&nbsp; Is anyone aware of a clean example dealing with ppc405 software
debugging (or something similar enough to be useful)&nbsp; that I could use
as a reference ?<br>
&nbsp;&nbsp;&nbsp; Anyone have any ideas what I might be missing ? Or a mailing list
that might be a more appropriate target this question ?<br>
<br>
&nbsp;&nbsp;&nbsp; I have pasted a trace of what I am seeing - the trace is my own
code - part of the software debugger I am trying to build into the
bootloader.<br>
&nbsp;&nbsp;&nbsp; The trace at each exception only shows the registers that have
changed since the last display.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; MonitorK.elf is the debugging version of my boot loader.<br>
&nbsp;&nbsp;&nbsp; Anything prefixed with a "!" is a command to MonitorK.<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
File MonitorK.elf updated from C:\Pico\MonitorK.elf.<br>
Loading MonitorK.elf.<br>
!boot -vvTS kernel.elf<br>
Entrypoint: 0x000064e0 Cmdline @ 0x0fff0200: &lt;&gt;<br>
&nbsp;&nbsp;&nbsp; lr=0x000064e0&nbsp;&nbsp;&nbsp;&nbsp; r3=0x0fffb000&nbsp;&nbsp;&nbsp;&nbsp; r6=0x0fff0200&nbsp;&nbsp;&nbsp;&nbsp;
r9=0x10000000&nbsp;&nbsp; srr0=0x000064e0&nbsp; dbcr0=0x08000000 <br>
&nbsp; iac1=0x000064f0&nbsp;&nbsp;&nbsp;&nbsp; r1=0x0fff0000 <br>
DBCR0: IC <br>
Traps:&nbsp;&nbsp;&nbsp; 0x000064ec <br>
<br>
Program Exception 00000007 @ 000064ec<br>
&nbsp;&nbsp; bch=0x0fff010c&nbsp;&nbsp;&nbsp; blr=0x07000780&nbsp;&nbsp;&nbsp;&nbsp; pc=0x000064ec&nbsp;&nbsp;&nbsp;&nbsp;
cr=0x40000000&nbsp;&nbsp;&nbsp; r11=0x0006fa3c&nbsp;&nbsp; srr0=0x000064ec <br>
&nbsp;&nbsp; esr=0x02000000&nbsp;&nbsp;&nbsp; tsr=0xc4000000&nbsp;&nbsp; dbsr=0x98100300&nbsp; dbcr0=0x09000000
<br>
DBSR: IC TDE UDE IDE <br>
DBCR0: IC TDE <br>
ESR: PEU <br>
TSR: ENW WIS <br>
Traps:&nbsp;&nbsp;&nbsp; 0x000064ec <br>
000064ec: 41820008 bc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,2,0x8<br>
<br>
!step<br>
Program Exception 00000007 @ 000064ec<br>
&nbsp;&nbsp; tsr=0x04000000&nbsp;&nbsp; dbsr=0x90100000 <br>
DBSR: IC TDE IDE <br>
DBCR0: IC TDE <br>
ESR: PEU <br>
TSR: <br>
Traps:&nbsp;&nbsp;&nbsp; 0x000064f0 <br>
000064ec: 41820008 bc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,2,0x8<br>
<br>
!step<br>
Program Exception 00000007 @ 000064ec<br>
&nbsp;&nbsp; tsr=0xc4000000 <br>
DBSR: IC TDE IDE <br>
DBCR0: IC TDE <br>
ESR: PEU <br>
TSR: ENW WIS <br>
Traps:&nbsp;&nbsp;&nbsp; 0x000064f0 0x000064f0 <br>
000064ec: 41820008 bc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,2,0x8<br>
<br>
!step<br>
Program Exception 00000007 @ 000064ec<br>
&nbsp;&nbsp; tsr=0x04000000 <br>
DBSR: IC TDE IDE <br>
DBCR0: IC TDE <br>
ESR: PEU <br>
TSR: <br>
Traps:&nbsp;&nbsp;&nbsp; 0x000064f0 0x000064f0 0x000064f0 <br>
000064ec: 41820008 bc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,2,0x8<br>
<br>
<br>
I can get this to repeat pretty much infinitely with nothing changing
except TSR_ENW and&nbsp; TSR_WIS<br>
<br>
<br>
<br>
<br>
</font>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------040001080707010504010203--
