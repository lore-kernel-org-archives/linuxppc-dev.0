Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1ACFDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 23:06:24 +1000 (EST)
Message-ID: <49F5A4FC.5070604@embedded-sol.com>
Date: Mon, 27 Apr 2009 15:28:44 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>,
	linux-mtd@lists.infradead.org
Subject: Machine check in 4xx NAND driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've got the following error on custom board based on AMCC 405EXr
running 2.6.27 kernel, with ndfc driver back ported from 2.6.29 (to support
OF partitions on NAND).  This happened once, right after reboot. I was
unable to reproduce this. The NAND device is Samsung K9K8G08U0B,
1GB with 2k page.

Oops: Machine check, sig: 7 [#1]

Modules linked in:
NIP: c0155bd0 LR: c014ff30 CTR: 0000003b
REGS: dfffdf50 TRAP: 0202   Not tainted  (2.6.27)
MSR: 00029030 <EE,ME,IR,DR>  CR: 44024084  XER: 00000000
TASK = df82c000[1] 'swapper' THREAD: df82a000
GPR00: 82bfe51c df82bb90 df82c000 c02c7ae0 dfade884 000000fc 000001fe 0000006b 
GPR08: 00000000 e1018000 c02c7ad8 00000040 00000000 ffffffef c024c3b0 00000000 
GPR16: 00000000 00000000 00000000 0000003f 00000000 dfade870 c02aa7f4 00000003 
GPR24: df824040 df824000 00000100 00000008 c02c7ae0 df824000 c02c7b9c dfade870 
NIP [c0155bd0] ndfc_read_buf+0x30/0x5c
LR [c014ff30] nand_read_page_hwecc+0x70/0x174
Call Trace:
[df82bb90] [c014fff8] nand_read_page_hwecc+0x138/0x174 (unreliable)
[df82bbd0] [c0152e74] nand_do_read_ops+0x15c/0x3dc
[df82bc30] [c01534bc] nand_read+0xa8/0xe4
[df82bc60] [c014800c] part_read+0x5c/0xe4
[df82bc70] [c00f2154] jffs2_flash_read+0x68/0x258
[df82bca0] [c00ebbc0] jffs2_fill_scan_buf+0x34/0x64
[df82bcc0] [c00ec0a0] jffs2_scan_medium+0x4b0/0x1204
[df82bd40] [c00eed00] jffs2_do_mount_fs+0x178/0x6c8
[df82bd80] [c00f11f8] jffs2_do_fill_super+0xc4/0x258
[df82bda0] [c00f18a0] jffs2_fill_super+0xc0/0xd4
[df82bdc0] [c0147128] get_sb_mtd_aux+0xa0/0xf0
[df82bdf0] [c0147280] get_sb_mtd+0x84/0x1c8
[df82be30] [c00f1670] jffs2_get_sb+0x1c/0x2c
[df82be40] [c0072230] vfs_kern_mount+0x58/0xe0
[df82be60] [c0072308] do_kern_mount+0x40/0xf8
[df82be80] [c008b740] do_new_mount+0x88/0xb8
[df82bea0] [c008b8f4] do_mount+0x184/0x1d4
[df82bf20] [c008b9d4] sys_mount+0x90/0xe0
[df82bf50] [c0274a04] do_mount_root+0x30/0xb8
[df82bf60] [c0274c78] mount_block_root+0xac/0x244
[df82bfb0] [c02750ac] prepare_namespace+0x18c/0x218
[df82bfd0] [c02741bc] kernel_init+0xc8/0xf4
[df82bff0] [c000dd5c] kernel_thread+0x44/0x60
Instruction dump:
7cab2b79 4c810020 38a5fffc 396bffff 2f85fffd 556bf0be 3d20c02c 396b0001 
39497ad8 7d6903a6 419c0028 812a0004 <7c0004ac> 80090008 0c000000 4c00012c 

Any hints what could be the problem are much appreciated.

Thanks.

Felix.
