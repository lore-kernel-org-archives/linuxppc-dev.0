Return-Path: <fabio.ubaldi@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 811F8DDFB0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 04:49:57 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 07814434012
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 17:48:59 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id gJV7SHrZN6lq for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 17:48:57 +0100 (CET)
Received: from [192.168.2.8] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 4D35F43400E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 17:48:57 +0100 (CET)
Message-ID: <47D95C17.80700@coritel.it>
Date: Thu, 13 Mar 2008 17:53:43 +0100
From: Fabio Ubaldi <fabio.ubaldi@coritel.it>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: console kernel parameter problem 
Content-Type: text/plain; charset=ISO-8859-1
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
I'm working with a board with a MPC8548 processor. I built the uboot,
the DTS file (myboard.dtb) and a kernel 2.6.21 .
When I try to boot the kernel via NFS I have some exception mode when
parsing the kernel parameters. Specifically I obtained an error during
the parsing of "console"  parameter.
My host computer is connected to the board via console using a standard
8250 port.

I append the log in this post.

Has anyone any suggestion?

Thanks in advance for the reply.



root=/dev/nfs rw nfsroot=192.168.0.90:/home/ftpuser/workspace/rootfs
ip=192.168.0.11:192.168.0.90:192.168.0.90:255.255.255.0:MYBOARD:eth2:off
console=ttyS1,115200

=>
=>
=> run nfsboot
Enet starting in 1000BT/FD
Speed: 1000, full duplex
Using eTSEC2 device
TFTP from server 192.168.0.90; our IP address is 192.168.0.11
Filename 'uImage'.
Load address: 0x1000000
Loading: *
Enet starting in 1000BT/FD
Speed: 1000, full duplex
Using eTSEC2 device
TFTP from server 192.168.0.90; our IP address is 192.168.0.11
Filename 'myboard.dtb'.
Load address: 0x3000000
Loading: *
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.21.7
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1509390 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x3000000
   Loading Device Tree to 007fc000, end 007fd313 ... OK
Parsing ARGS: root=/dev/nfs rw
nfsroot=192.168.0.90:/home/ftpuser/workspace/rootfs
ip=192.168.0.11:192.168.0.90:192.168.0.90:255.255.255.0:MYBOARD:eth2:off
console=ttyS1,115200
early options: Parameter `root'
Unknown argument: calling c02dc5f0
return parse_one 0 early options: Parameter `root'
early options: Parameter `rw'
Unknown argument: calling c02dc5f0
return parse_one 0 early options: Parameter `rw'
early options: Parameter `nfsroot'
Unknown argument: calling c02dc5f0
return parse_one 0 early options: Parameter `nfsroot'
early options: Parameter `ip'
Unknown argument: calling c02dc5f0
return parse_one 0 early options: Parameter `ip'
early options: Parameter `console'
Unknown argument: calling c02dc5f0
return parse_one 0 early options: Parameter `console'
Using MYBOARD machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=256Mb residual: 256Mb
Linux version 2.6.21.7 (gcc version 4.1.2 ) #2 PREEMPT Thu Mar 13
16:30:01 GMT 2008
setup_arch: bootmem
setup_arch()


arch: exit
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   262144
early_node_map[1] active PFN ranges
    0:        0 ->   262144
Built 1 zonelists.  Total pages: 260096
Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.90:/home/ftpuser/workspace/rootfs
ip=192.168.0.11:192.168.0.90:192.168.0.90:255.255.255.0:MYBOARD:eth2:off
console=ttyS1,115200
Parsing ARGS: root=/dev/nfs rw
nfsroot=192.168.0.90:/home/ftpuser/workspace/rootfs
ip=192.168.0.11:192.168.0.90:192.168.0.90:255.255.255.0:MYBOARD:eth2:off
console=ttyS1,115200
Booting kernel: Parameter `root'
Unknown argument: calling c02dc318
return parse_one 0 Booting kernel: Parameter `root=/dev/nfs'
Booting kernel: Parameter `rw'
Unknown argument: calling c02dc318
return parse_one 0 Booting kernel: Parameter `rw'
Booting kernel: Parameter `nfsroot'
Unknown argument: calling c02dc318
return parse_one 0 Booting kernel: Parameter
`nfsroot=192.168.0.90:/home/ftpuser/workspace/rootfs'
Booting kernel: Parameter `ip'
Unknown argument: calling c02dc318
return parse_one 0 Booting kernel: Parameter
`ip=192.168.0.11:192.168.0.90:192.168.0.90:255.255.255.0:MYBOARD:eth2:off'
Booting kernel: Parameter `console'
Unknown argument: calling c02dc318
Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
Modules linked in:
NIP: C02E7B30 LR: C02E7C28 CTR: 00000000
REGS: c031be80 TRAP: 0700   Not tainted  (2.6.21.7)
MSR: 00021000 <ME>  CR: 24084022  XER: 00000000
TASK = c02fe5b8[0] 'swapper' THREAD: c031a000
GPR00: 00000000 C031BF30 C02FE5B8 C0332184 C031BF58 C035595A C031BF5E
C0300000
GPR08: 0000000A C0332184 00000001 C0332184 00000000 60000000 3FFFC400
03000000
GPR16: 00000001 00000000 007FFF00 00000000 00000000 007FFEB0 00000000
C02D6000
GPR24: 00000044 00021000 00000000 C035595A 00000001 C031BF58 C0332184
00000000
NIP [C02E7B30] add_preferred_console+0xac/0xd8
LR [C02E7C28] console_setup+0xcc/0xe4
Call Trace:
[C031BF30] [C03017C0] 0xc03017c0 (unreliable)
[C031BF50] [C02E7C28] console_setup+0xcc/0xe4
[C031BF70] [C02DC400] unknown_bootoption+0xe8/0x260
[C031BF90] [C003DDC8] parse_args+0x1f8/0x310
[C031BFC0] [C02DC7F4] start_kernel+0x16c/0x2b4
[C031BFF0] [C0000388] skpinv+0x2b8/0x2f4
Instruction dump:
48000048 3d20c030 38600000 93e9ff98 48000038 3d20c030 93e9ff98 3d20c033
39292184 57eb2036 7d6b4a14 38000000 <7d3d44aa> 7d2b45aa 38600000 938b0008
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..
