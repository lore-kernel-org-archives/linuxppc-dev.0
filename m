Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7060DB7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 10:05:06 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3D2FDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 10:05:05 +1000 (EST)
Message-ID: <4A4BE8C9.7070909@embedded-sol.com>
Date: Thu, 02 Jul 2009 01:52:57 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
Subject: Instruction machine check during NAND access on 405EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm getting the following error on custom 405EX based system
running 2.6.30 kernel. It happens rarely, only on boot, while
mounting 250M ubifs partition. It happens also with jffs2.
To me it looks like some callback pointer is corrupted, but
I cannot see any problem in the code. Any ideas about what
goes wrong here are much appreciated.

Thanks a lot

Felix.

Creating 4 MTD partitions on "f8000000.ndfc.nand":
0x00000000-0x0fa00000 : "ROOT_1"
0x0fa00000-0x1f400000 : "ROOT_2"
0x1f400000-0x25800000 : "CONFIG"
0x25800000-0x3e800000 : "VAR"
UBI: attaching mtd6 to ubi0
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
Instruction machine check in kernel mode.
Oops: Machine check, sig: 7 [#1]
mlnx405ex
Modules linked in:
NIP: c0187840 LR: c018783c CTR: c018d1c0
REGS: dfffdf50 TRAP: 0202   Not tainted  (2.6.27)
MSR: 00029030 <EE,ME,IR,DR>  CR: 22022084  XER: 20000000
TASK = df82c000[1] 'swapper' THREAD: df82a000
GPR00: c018783c df82bc60 df82c000 00000000 df824080 df824040 df824000 
000000ff
GPR08: 00000000 00000100 00000000 00000000 00000000 1004a354 c02a63ac 
00000000
GPR16: 00000000 00000000 00000000 0000003f 00000000 df824080 c02fc974 
00000003
GPR24: df824040 df824000 00000100 00000000 c0319b60 00000008 c0319c1c 
df824080
NIP [c0187840] nand_read_page_hwecc+0x13c/0x174
LR [c018783c] nand_read_page_hwecc+0x138/0x174
Call Trace:
[df82bc60] [c018783c] nand_read_page_hwecc+0x138/0x174 (unreliable)
[df82bca0] [c018a6f0] nand_do_read_ops+0x15c/0x3dc
[df82bd00] [c018ad38] nand_read+0xa8/0xe4
[df82bd30] [c017f850] part_read+0x5c/0xe4
[df82bd40] [c0195e60] ubi_io_read+0x70/0x150
[df82bd80] [c0196360] ubi_io_read_ec_hdr+0x34/0x35c
[df82bdb0] [c0199604] ubi_scan+0x150/0x758
[df82be20] [c0190e58] ubi_attach_mtd_dev+0x340/0xb04
[df82bf10] [c02dd4e4] ubi_init+0x180/0x2d8
[df82bf60] [c0002368] do_one_initcall+0x38/0x188
[df82bfd0] [c02c617c] kernel_init+0x88/0xf4
[df82bff0] [c000dd60] kernel_thread+0x44/0x60
Instruction dump:
901c0094 7f7bba14 7fffd214 41820044 801e00b4 7fe4fb78 7cb8da14 7cd9da14
7c0903a6 7f83e378 4e800421 2c030000 <4080ffc4> 813c0098 37bdffff 39290001
---[ end trace 3d1f8dede54b62b1 ]---
