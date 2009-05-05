Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8795CDDE00
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 15:23:54 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M1D8A-0007fo-Nj
	for linuxppc-dev@ozlabs.org; Mon, 04 May 2009 22:23:50 -0700
Message-ID: <23381214.post@talk.nabble.com>
Date: Mon, 4 May 2009 22:23:50 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: PPC8247 booting error
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


i want to mapping FIFO memory to bank 3 by configure br3 and or3
the boot info as following.

in my code, i have mapped FIFO to 0xD0000000, then i red the value from this
address.

the prompts as following 

there is some wrong with BRx and ORx set? or something others?

please give me some suggestion, thanks everyone.


## Booting image at 00400000 ...
   Image Name:   Linux-2.6.11
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    818473 Bytes = 799.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
OK
Linux version 2.6.11 (root@localhost.localdomain) (gcc version 4.0.0 (DENX
ELDK 4.0 4.0.0)) 

#108 Mon May 4 22:54:23 EDT 2009

Motorola PQ2 ADS PowerPC port

Built 1 zonelists

Kernel command line: mem=32M console=ttyCPM0,9600 root=/dev/nfs/ rw 

nfsroot=192.168.0.131:/root/chengmo/fs_folder/rootfs 

ip=192.168.0.100:192.168.0.131:#:255.0.0.0:::off

PID hash table entries: 256 (order: 8, 4096 bytes)

Warning: real time clock seems stuck!

Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Memory: 30632k available (1420k kernel code, 272k data, 88k init, 0k
highmem)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

scheduling while atomic: swapper/0x00000002/0

Call trace: [c015fe20]  [c0003fe0]  [c01a09b4]  [c0194614]  [000035fc] 

NET: Registered protocol family 16

Sauce : fifo mapping to bank3 !	// here, indicate has enter fifo_init
function, but after 

this...

Oops: kernel access of bad area, sig: 11 [#1]

PREEMPT 

NIP: C01A2108 LR: C01A2104 SP: C0227FC0 REGS: c0227f10 TRAP: 0300    Not
tainted

MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

DAR: D0000000, DSISR: 20000000

TASK = c0220ab0[1] 'swapper' THREAD: c0226000

Last syscall: 120 

GPR00: C01A2104 C0227FC0 C0220AB0 00000025 00000467 FFFFFFFF F00000A0
00000022 

GPR08: 001FF1A0 D0000000 F00000A8 C0227ED0 00000001 7FBDFFFF 02000000
00000000 

GPR16: 00800000 01FFF9E8 FFFFFFFF 00000000 007FFF00 01FFA4DC 01BD92B8
00000001 

GPR24: 00000000 00400000 C01B0000 C0160000 C01A0000 00000001 C0226000
C01A86A8 

Call trace: [c0003a40]  [c0006504] 

Kernel panic - not syncing: Attempted to kill init!

here, i have other questions about these information.

what dose mean by "NIP : C01A2108" ? i supposed "C01A2108" may be a address
of user space, 

what about NIP ?
and what the expression "DAR, DSISR, TASK, and GPR00-24" represent.

i hope some will let me know those or recommand some book for me. thanks
-- 
View this message in context: http://www.nabble.com/PPC8247-booting-error-tp23381214p23381214.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
