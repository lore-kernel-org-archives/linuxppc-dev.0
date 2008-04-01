Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 436D5DDF40
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 08:24:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Access physical memory via mmap() on ppc440epx.
Date: Tue, 1 Apr 2008 14:12:19 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C033A981B@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I am trying to read from NOR flash, located on address 0xfc000000, on my
ppc440epx board (similar to Sequoia) from user space. Mmap call returns
fine, but actual access fails - here is GDB output:

Breakpoint 1, f_EVLOG_GetSectorInfo (sector=3D18, si=3D0x1004a398)
    at
/home/leonid/LM300/software/u-boot/apps/diags/common/event_log.c:1580
1580
/home/leonid/LM300/software/u-boot/apps/diags/common/event_log.c: No
such file or di.
        in
/home/leonid/LM300/software/u-boot/apps/diags/common/event_log.c
(gdb) p sector
$1 =3D 18
(gdb) p/x buf
$2 =3D 0x30028000
(gdb) x/10 0x30028000
0x30028000:     Cannot access memory at address 0x30028000
(gdb) x/10 0x30028200
0x30028200:     Cannot access memory at address 0x30028200
(gdb)

0x30028200 is mmap() result, next step leads to crash:

(gdb)
Machine check in kernel mode.
Data Read PLB Error
OPB to PLB3: BSTAT=3D 0x00000000
PLB3 to PLB4: BEAR=3D0x5c00819442310a80 BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB4 to PLB3: BEAR=3D0xa5876840c012269b BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB3 to OPB: BEAR=3D0xf0dffd99 BESR0=3D0x00000000 BESR1=3D0x00000000
PLB3 arbiter: BEAR=3D0xc1fcef0c ACR=3D0x90000000 BESR=3D0x00000000
PLB4 to OPB1: BEAR=3D0x0000000b9fbdfdb8 BESR0=3D0x00000000 =
BESR1=3D0x00000000
PLB40 Arbiter: BEAR=3D0x00000000fc240000 ACR=3D0xde000000 =
BESR0=3D0x0f000000
PLB41 Arbiter: BEAR=3D0xe7fb1dfdf3820fcb ACR=3D0xdf000000 =
BESR0=3D0x00000000
POB0: BEAR=3D0xc27e3194f0dffd99 BESR0=3D0x00000000 BESR1=3D0x00000000
OPB0: BEAR=3D0x0000000000000000 BSTAT=3D0x00000000
Oops: machine check, sig: 7 [#6]
NIP: C0000DF8 LR: 10010474 CTR: 00000000
REGS: c02acf50 TRAP: 0202   Not tainted  (2.6.19)
MSR: 00001000 <ME>  CR: 40000044  XER: 20000000
TASK =3D cfc00bf0[77] 'diags_server' THREAD: cf9de000
GPR00: 00000000 CF9DFF40 3001F040 30028000 7FB5FA00 00000000 61736800
FEFEFEFF
GPR08: 00000000 0002D200 10010474 CF9DFF40 10010494 1004B074 10360000
44004042
GPR16: 10413BFC 7FAF1F5F 7FAF1F5F 00000000 00000001 10440000 00000000
00000000
GPR24: 1016B924 00000002 00000000 30026E5C 30027A18 10027B4C 0FFEA73C
7FB5FA20
NIP [C0000DF8] Debug+0x78/0x130
LR [10010474] 0x10010474
Call Trace:
[CF9DFF40] [C00026EC] do_user_signal+0x74/0xc4 (unreliable)
Instruction dump:
7d4802a6 914b00a0 7d9d0aa6 918b00b4 7d3e0aa6 912b00b8 7d9a0aa6 902b0014
7d3b0aa6 902b0000 7d615b78 55290398 <900b0010> 906b001c 908b0020
90ab0024

Program terminated with signal SIGBUS, Bus error.
The program no longer exists.

I suspect it has something to do with memory configiration. Note that
Linux kernel is loaded by u-boot where all peripherals (NOR flash
included) configured properly and work.

I have BDI2000 connected and can (after stopping the board) see
registers and TLB entries:

440EPx>rd ebc0_b0cr
ebc0_b0cr: 0xfc0da000  -66215936

BUS configuration looks OK.

TLB entries look strange though. That what it was on u-boot stage:

440EPx>tlb 0 10
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 00 40000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
 1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
 2 : 00 c0000000 256MB V0 -> 1_c0000000 U:0000 -I-G- XWRXWR
 3 : 00 f0000000 256MB V0 -> 1_f0000000 U:0000 WI-G- XWRXWR
 4 : 00 80000000 256MB V0 -> 1_80000000 U:0000 -I-G- -WR-WR
 5 : 00 90000000 256MB V0 -> 1_90000000 U:0000 -I-G- -WR-WR
 6 : 00 a0000000 256MB V0 -> 1_a0000000 U:0000 -I-G- -WR-WR
 7 : 00 b0000000 256MB V0 -> 1_b0000000 U:0000 -I-G- -WR-WR
 8 : 00 d0000000   1KB V0 -> 1_d0000000 U:0000 -I-G- XWRXWR
 9 : 00 e0000000  16MB V0 -> 0_e0000000 U:0000 -I--- XWRXWR
10 : 00 ea000000   1MB V0 -> 1_ea000000 U:0000 -I-G- XWRXWR

On Linux stage it looks rather different:

440EPx>tlb 0 40
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 26 0ff9d000   4KB V0 -> 0_0fdc8000 U:0000 --MG- X-RX-R
 1 : 26 30017000   4KB V0 -> 0_0fe3e000 U:0000 --MG- --R-WR
 2 : 2a 10165000   4KB V0 -> 0_0028d000 U:0000 --MG- -WR-WR
 3 : 2a 100a4000   4KB V0 -> 0_00767000 U:0000 ---G- X-RX-R
 4 : 2a 1016b000   4KB V0 -> 0_00290000 U:0000 --MG- -WR-WR
 5 : 2a 10077000   4KB V0 -> 0_007ac000 U:0000 ---G- X-RX-R
 6 : 2a 10164000   4KB V0 -> 0_00295000 U:0000 --MG- --R-WR
 7 : 2a 1019c000   4KB V0 -> 0_00536000 U:0000 --MG- -WR-WR
 8 : 2a 100be000   4KB V0 -> 0_00774000 U:0000 ---G- X-RX-R
 9 : 2a 10114000   4KB V0 -> 0_007b7000 U:0000 ---G- --R--R
10 : 2a 00000000   1KB -0 -> 0_007ef000 U:0000 ---G- --R--R
11 : 2a 10057000   4KB V0 -> 0_007ef000 U:0000 ---G- X-RX-R
12 : 2a 10117000   4KB V0 -> 0_007ba000 U:0000 ---G- --R--R
13 : 2a 10097000   4KB V0 -> 0_00792000 U:0000 ---G- X-RX-R
14 : 2a 10048000   4KB V0 -> 0_0fc27000 U:0000 ---G- X-RX-R
15 : 2a 10087000   4KB V0 -> 0_007db000 U:0000 ---G- X-RX-R
16 : 2a 10166000   4KB V0 -> 0_00299000 U:0000 --MG- -WR-WR
17 : 2a 10086000   4KB V0 -> 0_007da000 U:0000 ---G- X-RX-R
18 : 2a 1013c000   4KB V0 -> 0_00754000 U:0000 ---G- --R--R
19 : 2a 1008e000   4KB V0 -> 0_007a9000 U:0000 ---G- X-RX-R
20 : 2a 30000000   4KB V0 -> 0_00704000 U:0000 --MG- -WR-WR
21 : 2a 7fa1c000   4KB V0 -> 0_0fe37000 U:0000 --MG- -WR-WR
22 : 2a 1008d000   4KB V0 -> 0_007a8000 U:0000 ---G- X-RX-R
23 : 2a 1008c000   4KB V0 -> 0_007a7000 U:0000 ---G- X-RX-R
24 : 2a 100bd000   4KB V0 -> 0_00773000 U:0000 ---G- X-RX-R
25 : 00 fdfec000   4KB V0 -> 1_ef600000 U:0000 -IMG- ----WR
26 : 00 d1050000   4KB V0 -> 1_ef600000 U:0000 -IMG- ----WR
27 : 00 d1054000   4KB V0 -> 1_ef600000 U:0000 -IMG- ----WR
28 : 00 d1056000   4KB V0 -> 0_e0000000 U:0000 -IMG- ----WR
29 : 00 ff100000   4KB V0 -> 0_006b0000 U:0000 -IMG- ---XWR
30 : 26 10027000   4KB V0 -> 0_0fe80000 U:0000 --MG- --R-WR
...........................

Probably under MMU it should look this way? How to use mmap() then?

Thanks,

Leonid.
