Return-Path: <powerpc440@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id ACF1E67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Oct 2006 23:45:59 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id n29so622372nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Oct 2006 06:45:57 -0700 (PDT)
Message-ID: <452A52B4.1010303@googlemail.com>
Date: Mon, 09 Oct 2006 15:46:28 +0200
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problem with OPB access on 440GX and Linux 2.6.15
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm having a PPC440GX based board, based on Ocotea.
On the board is a Xilinx CPLD chip, connected with OPB (On-Chip
Peripheral Bus).
Under U-Boot I can communicate – reading and writing, without any
problems, but when the Linux kernel ones is loaded, then I'm getting
error message: “Bus error”. This error message appears on reading or
writing.
How I can access the units, which are connected with OPB?

There are the source code from the driver, that I use :

static void io_addr = ioremap(0x48300000, 0x100000); /* allocate 1MB
adress space */
long value = readl(io_addr + 0x7000);

and the error message:

VA: 0xe2180000
Machine check in kernel mode.
Data Read PLB Error
PLB0: BEAR=0x0000000048307000 ACR= 0x9b000000 BESR= 0x0c000000
POB0: BEAR=0x00000000040c0020 BESR0=0x00000000 BESR1=0x00000000
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
Oops: machine check, sig: 7 [#4]
NIP: E107D078 LR: E107D068 CTR: 00000000
REGS: c0335f50 TRAP: 0202 Not tainted (2.6.16.27-himadef-0)
MSR: 00029000 <EE,ME> CR: 22004024 XER: 20000000
TASK = dfa1cc10[412] 'cat' THREAD: dcc54000
GPR00: E107D068 DCC55E80 DFA1CC10 00000010 00000010 E107D7AB D490F704
00000010
GPR08: 00000000 E2180000 00000000 FFFFFFFF 22004048 1001C334 00000000
00000400
GPR16: 00000001 100B0000 10014344 00000000 00000002 00000000 00000000
DDAC8600
GPR24: 00000000 DCC55EB8 DD3E5000 00000C00 E1080000 00000010 10014204
00001000
NIP [E107D078] sensor_proc_read+0x58/0x94 [himaio]
LR [E107D068] sensor_proc_read+0x48/0x94 [himaio]
Call Trace:
[DCC55E80] [E107D068] sensor_proc_read+0x48/0x94 [himaio] (unreliable)
[DCC55EB0] [C008C6EC] proc_file_read+0x2a4/0x354
[DCC55EF0] [C00564F0] vfs_read+0xcc/0x1a0
[DCC55F10] [C0057228] sys_read+0x4c/0x90
[DCC55F40] [C00019C4] ret_from_syscall+0x0/0x3c
Instruction dump:
7cf93b78 4800048d 80dce160 3ca0e108 38a5d7a0 7f43d378 7f64db78 48000485
813ce160 7c7d1b78 38c97000 7cc0342c <0c060000> 4c00012c 3ca0e108 7c7a1a14

Thanks in advance!
