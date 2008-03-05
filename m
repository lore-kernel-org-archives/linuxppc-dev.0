Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id A701EDDFC3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Mar 2008 02:21:51 +1100 (EST)
Message-ID: <404729222.13333@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 05 Mar 2008 23:00:22 +0800
Subject: The question about the linux Exception during the GETH test on
	MPC8360?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

HI,friends,

I tested the GETH on MPC8360 by "iperf", after several times test, the linux is
dead, please see follow information. Then I slow down the core frequency from
667MHZ to 533MHZ, the test is OK, could you tell me where has the problem?
Thanks.



/ # iperf -c 192.168.0.2 -i 6 -t 600
------------------------------------------------------------
Client connecting to 192.168.0.2, TCP port 5001
TCP window size: 27.9 KByte (default)
------------------------------------------------------------
[  3] local 192.168.0.202 port 2079 connected with 192.168.0.2 port 5001
[  3]  0.0- 6.0 sec    267 MBytes    374 Mbits/sec
[  3]  6.0-12.0 sec    268 MBytes    375 Mbits/sec
[  3] 12.0-18.0 sec    267 MBytes    374 Mbits/sec
[  3] 18.0-24.0 sec    266 MBytes    372 Mbits/sec
[  3] 24.0-30.0 sec    256 MBytes    358 Mbits/sec
[  3] 30.0-36.0 sec    264 MBytes    369 Mbits/sec
[  3] 36.0-42.0 sec    268 MBytes    374 Mbits/sec
[  3] 42.0-48.0 sec    268 MBytes    375 Mbits/sec
kernel BUG in skb_checksum at net/core/skbuff.c:1120!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C00FC1D8 LR: C00FC004 SP: C01A9BF0 REGS: c01a9b40 TRAP: 0700    Tainted: P  

 
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0191ab0[0] 'swapper' THREAD: c01a8000
Last syscall: 120 
GPR00: 00000000 C01A9BF0 C0191AB0 00000000 00000000 001A3916 00000008 CED5C080 
GPR08: 0E874000 CED5C660 CED5C0A0 CED5C05E C01D58B4 FAEA00A8 0FFFE000 007FFF00 
GPR16: 0FFF8450 00000000 00000003 007FFEB0 00259DF0 0FFFF8E8 00800000 00000020 
GPR24: C04EB360 00000000 BE570CCD 00000042 C0101174 000005A8 00000042 00000020 
Call trace: [c0100f80]  [c0101300]  [c0118308]  [c01186dc]  [c0129678] 
[c012ad1c]
 [c012d238]  [c001e3f8]  [c0019d94]  [c0019e60]  [c0005 
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..




Follow is the UBoot information about my mpc8360 board:

U-Boot 1.2.0 (Mar  5 2008 - 17:47:06) MPC83XX

CPU:   e300c1, MPC8360E, Rev: 20 at 660 MHz, CSB:  330 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:  
DIMM type:       32MX64U-40B       
SPD size:        128
EEPROM size:     256
Memory type:     7
Row addr:        13
Column addr:     10
# of rows:       1
Row density:     64
# of banks:      4
Data width:      64
Chip width:      8
Refresh rate:    82
CAS latencies:   0C
Write latencies: 02
tRP:             72
tRCD:            72


   DDR DIMM: data bus width is 64 bit without ECC2   
   DDRC ECC mode: OFF

   SDRAM on Local Bus: 64 MB
   DDR RAM: 256 MB
FLASH: 16 MB
PCI clock is 66MHz
PCI 32bit bus on PMC1 & PMC2 & PMC3
In:    serial
Out:   serial
Err:   serial
Net:   UEC: PHY is Marvell 88E11x1 (1410cc1)
FSL UEC0: Full Duplex
FSL UEC0: Speed 1000BT
FSL UEC0: Link is up
FSL UEC0
Hit any key to stop autoboot:  0 
=> clocks
Clock configuration Guo Jing:
  Core:                 660 MHz
  Coherent System Bus:  330 MHz
  QE:                   396 MHz
  BRG:                  198 MHz
  Local Bus Controller: 330 MHz
  Local Bus:             82 MHz
  DDR:                  330 MHz
  DDR Secondary:        330 MHz
  SEC:                  110 MHz
  I2C1:                 330 MHz
  I2C2:                 330 MHz
