Return-Path: <ghbfei@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 7BB2B67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 06:18:10 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so2372418pyc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Jul 2006 13:18:08 -0700 (PDT)
Message-ID: <960972fa0607051311w5fb9178fm9bfa090b4613597a@mail.gmail.com>
Date: Wed, 5 Jul 2006 16:11:48 -0400
From: "hb fei" <ghbfei@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: problem with kernel debug using BDI2000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21153_439661.1152130308779"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_21153_439661.1152130308779
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

  I met some problems when I tried to debug the 2.5.16 kernel with BDI2000
for a customerized MPC8xx.
I listed my two trials, can any one tell me what is wrong with my approachs,


[Try 1] =============================================>

(1) Build the kernel image, the map file -- System.map file

.....

c0000000 T _start

c0000000 T __start

c0000000 T _stext

c0000018 t turn_on_mmu

c0000100 t Reset

.....

(2) Copy the vmlinux into /tftpboot for load the iamge

(3) I mapped the logic address 0xc0000000 into physical address 0x00100000
in target

by loading the file through BDI telnet console, the telnet screen shows

BDI>load 0x40100000 vmlinux elf

Loading vmlinux , please wait ....

- File offset 0x00010000 to address 0x00100000 size 1728646

Loading program file passed



(4) Start the GDB command, and single step from address 0x00100000.

I tried two version of ppc gdb, both have the same result. The location of
one of

the gdb (through DENX) is,

$ which ppc_8xx-gdb

/opt/eldk/usr/bin/ppc_8xx-gdb



(5) And start the gdb through the following command,

$ ppc_8xx-gdb vmlinux (under kernel top directory)

(gdb) target remote 10.199.5.234:2001

Remote debugging using 10.199.5.234:2001

(gdb) si

0x0010000c in ?? ()

(gdb)

0x00100010 in ?? ()

(gdb)

0x00100014 in ?? ()

....

Things go well till I reach the

(gdb)

0x00100030 in ?? ()

(gdb)

Program received signal SIGSTOP, Stopped (signal).

0x00100030 in ?? ()

(gdb)

Program received signal SIGSTOP, Stopped (signal).

0x00100030 in ?? ()

(gdb)



If I check the code carefully in /arch/ppc/kernel_8xx.S, 0x00100030 address

matches the rfi comamnd in

turn_on_mmu:

mfmsr r0

ori r0,r0,MSR_DR|MSR_IR

mtspr SPRN_SRR1,r0

lis r0,start_here@h

ori r0,r0,start_here@l

mtspr SPRN_SRR0,r0

SYNC

rfi /* enables MMU */



(6) I check the BDI configuration (8xx.cfg) file, seems I had enabled the
MMI



[TARGET]

CPUCLOCK 32000000 ;the CPU clock rate after processing the init list

BDIMODE AGENT ;the BDI working mode (LOADONLY | AGENT)

BREAKMODE SOFT ;SOFT or HARD, HARD uses PPC hardware breakpoints

;STEPMODE HWBP ;TRACE or HWBP, HWPB uses one or two hardware breakpoints

;STARTUP STOP 5000 ;let the monitor initialize the system

;DCACHE FLUSH ;flush data cache, needs a workspace of 32 bytes

;WORKSPACE 0x00000040 ;workspace in target RAM for data cache flush

MMU XLAT ;translate effective to physical address

;PTBASE 0x00000f0 ;????

;REGLIST SPR ;select register to transfer to GDB

REGLIST ALL ;select register to transfer to GDB

I assume I do not need set PTBASE, since I am working on the very new
version of kernel

(2.6.15).



Question, seems to me the MMU in BDI does still map the logic address into
physical

address correctly, what did I miss here?

[Try 2 ]  ===================================================>

Exactly follow the BDI user manual,

(1) load image, BDI telnet screen shows

BDI>load 0x40100000 vmlinux elf

Loading vmlinux , please wait ....

- File offset 0x00010000 to address 0x00100000 size 1728646

Loading program file passed



(2) set hardware break point

BDI>bi 0xc0000000 0xc00fffff

Breakpoint identification is 0

(3) issue go comamnd from telnet screen

BDI>go

- TARGET: stopped

(4) Disable hardware break point

BDI> ci

(5) Start gdb from another terminal,

$ ppc_8xx-gdb vmlinux

(6) Attached target,

(gdb) target remote 10.199.5.234:2001

Remote debugging using 10.199.5.234:2001

0x00001100 in ?? ()

(7) Set software break point,

(gdb) b start_kernel

(8) let go

(gdb) c

Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.

0x00001100 in ?? ()

Seems to me the MMU still not work with BDI.

Can any one one point out what is the problem?

Thanks!

------=_Part_21153_439661.1152130308779
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi there,</div>
<div>&nbsp;</div>
<div>&nbsp; I met some problems when I tried to debug the 2.5.16 kernel with BDI2000 for a customerized MPC8xx. </div>
<div>I listed my two trials, can any one tell me what is wrong with my approachs,</div>
<div>&nbsp;</div>
<div><font size="2">
<p>[Try 1] =============================================&gt;</p>
<p>(1) Build the kernel image, the map file -- System.map file</p>
<p>.....</p>
<p>c0000000 T _start</p>
<p>c0000000 T __start</p>
<p>c0000000 T _stext</p>
<p>c0000018 t turn_on_mmu</p>
<p>c0000100 t Reset</p>
<p>..... </p>
<p>(2) Copy the vmlinux into /tftpboot for load the iamge</p>
<p>(3) I mapped the logic address 0xc0000000 into physical address 0x00100000 in target </p>
<p>by loading the file through BDI telnet console, the telnet screen shows</p>
<p>BDI&gt;load 0x40100000 vmlinux elf</p>
<p>Loading vmlinux , please wait ....</p>
<p>- File offset 0x00010000 to address 0x00100000 size 1728646</p>
<p>Loading program file passed</p>
<p>&nbsp;</p>
<p>(4) Start the GDB command, and single step from address 0x00100000. </p>
<p>I tried two version of ppc gdb, both have the same result. The location of one of </p>
<p>the gdb (through DENX) is,</p>
<p>$ which ppc_8xx-gdb</p>
<p>/opt/eldk/usr/bin/ppc_8xx-gdb</p>
<p>&nbsp;</p>
<p>(5) And start the gdb through the following command,</p>
<p>$ ppc_8xx-gdb vmlinux (under kernel top directory)</p>
<p>(gdb) target remote <a href="http://10.199.5.234:2001">10.199.5.234:2001</a></p>
<p>Remote debugging using <a href="http://10.199.5.234:2001">10.199.5.234:2001</a></p>
<p></p>
<p>(gdb) si</p>
<p>0x0010000c in ?? ()</p>
<p>(gdb)</p>
<p>0x00100010 in ?? ()</p>
<p>(gdb)</p>
<p>0x00100014 in ?? ()</p>
<p>....</p>
<p></p>
<p>Things go well till I reach the </p>
<p></p>
<p>(gdb)</p>
<p>0x00100030 in ?? ()</p>
<p>(gdb)</p>
<p>Program received signal SIGSTOP, Stopped (signal).</p>
<p>0x00100030 in ?? ()</p>
<p>(gdb)</p>
<p>Program received signal SIGSTOP, Stopped (signal).</p>
<p>0x00100030 in ?? ()</p>
<p>(gdb)</p>
<p>&nbsp;</p>
<p>If I check the code carefully in /arch/ppc/kernel_8xx.S, 0x00100030 address </p>
<p>matches the rfi comamnd in </p>
<p>turn_on_mmu:</p>
<p>mfmsr r0</p>
<p>ori r0,r0,MSR_DR|MSR_IR</p>
<p>mtspr SPRN_SRR1,r0</p>
<p>lis r0,start_here@h</p>
<p>ori r0,r0,start_here@l</p>
<p>mtspr SPRN_SRR0,r0</p>
<p>SYNC</p>
<p>rfi /* enables MMU */</p>
<p>&nbsp;</p>
<p>(6) I check the BDI configuration (8xx.cfg) file, seems I had enabled the MMI </p>
<p>&nbsp;</p>
<p>[TARGET]</p>
<p>CPUCLOCK 32000000 ;the CPU clock rate after processing the init list</p>
<p>BDIMODE AGENT ;the BDI working mode (LOADONLY | AGENT)</p>
<p>BREAKMODE SOFT ;SOFT or HARD, HARD uses PPC hardware breakpoints</p>
<p>;STEPMODE HWBP ;TRACE or HWBP, HWPB uses one or two hardware breakpoints</p>
<p>;STARTUP STOP 5000 ;let the monitor initialize the system</p>
<p>;DCACHE FLUSH ;flush data cache, needs a workspace of 32 bytes</p>
<p>;WORKSPACE 0x00000040 ;workspace in target RAM for data cache flush</p>
<p>MMU XLAT ;translate effective to physical address</p>
<p>;PTBASE 0x00000f0 ;????</p>
<p>;REGLIST SPR ;select register to transfer to GDB</p>
<p>REGLIST ALL ;select register to transfer to GDB</p>
<p>I assume I do not need set PTBASE, since I am working on the very new version of kernel</p>
<p>(2.6.15).</p>
<p>&nbsp;</p>
<p>Question, seems to me the MMU in BDI does still map the logic address into physical </p>
<p>address correctly, what did I miss here?</p>
<p>[Try 2 ]&nbsp; ===================================================&gt;</p>
<p>Exactly follow the BDI user manual,</p>
<p>(1) load image, BDI telnet screen shows</p>
<p>BDI&gt;load 0x40100000 vmlinux elf</p>
<p>Loading vmlinux , please wait ....</p>
<p>- File offset 0x00010000 to address 0x00100000 size 1728646</p>
<p>Loading program file passed</p>
<p>&nbsp;</p>
<p>(2) set hardware break point </p>
<p>BDI&gt;bi 0xc0000000 0xc00fffff</p>
<p>Breakpoint identification is 0</p>
<p></p>
<p>(3) issue go comamnd from telnet screen</p>
<p>BDI&gt;go</p>
<p>- TARGET: stopped</p>
<p></p>
<p>(4) Disable hardware break point</p>
<p>BDI&gt; ci</p>
<p></p>
<p>(5) Start gdb from another terminal,</p>
<p>$ ppc_8xx-gdb vmlinux</p>
<p></p>
<p>(6) Attached target, </p>
<p>(gdb) target remote <a href="http://10.199.5.234:2001">10.199.5.234:2001</a></p>
<p>Remote debugging using <a href="http://10.199.5.234:2001">10.199.5.234:2001</a></p>
<p>0x00001100 in ?? ()</p>
<p></p>
<p>(7) Set software break point,</p>
<p>(gdb) b start_kernel</p>
<p></p>
<p>(8) let go</p>
<p>(gdb) c</p>
<p>Continuing.</p>
<p>Program received signal SIGTRAP, Trace/breakpoint trap.</p>
<p>0x00001100 in ?? ()</p>
<p></p>
<p>Seems to me the MMU still not work with BDI.</p>
<p>Can any one one point out what is the problem? </p>
<p>Thanks!</p>
<p>&nbsp;</p></font></div>

------=_Part_21153_439661.1152130308779--
