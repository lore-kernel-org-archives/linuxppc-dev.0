Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 5A30A67B56
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 06:55:12 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FqcHs-0003Hf-00
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:48:28 +0200
Date: Wed, 14 Jun 2006 22:48:28 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [OOPS] 2.6.17-rc3 on an mpc8241
Message-ID: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"dhclient eth1" (zd1211rw driver) caused the following:

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C004151C LR: C0039850 CTR: 00000000
REGS: c6a15c70 TRAP: 0300   Not tainted  (2.6.17-rc3-kuroboxHG)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44000488  XER: 00000000
DAR: 00000038, DSISR: 20000000
TASK = c7d4a850[2546] 'dhclient' THREAD: c6a14000
GPR00: 00030017 C6A15D20 C7D4A850 00000038 C03CBF00 00000000 00000038 C6A15D50 
GPR08: 00000000 00000004 00000000 00000004 00000000 100383F4 C76557C8 00000001 
GPR16: 00000000 C6A15D50 00000000 C6A15EA0 C6A15DF0 00000001 00000000 C75C7F00 
GPR24: 30017000 00000000 00000000 C03CBF00 C7655868 30017000 C6A45E07 00000038 
NIP [C004151C] put_page+0x0/0x40
LR [C0039850] do_generic_mapping_read+0x354/0x480
Call Trace:
[C6A15D20] [C0040EB0] page_cache_readahead+0xd0/0x224 (unreliable)
[C6A15D40] [C0039838] do_generic_mapping_read+0x33c/0x480
[C6A15DE0] [C003C004] __generic_file_aio_read+0x1b4/0x208
[C6A15E30] [C003C224] generic_file_aio_read+0x3c/0x5c
[C6A15E40] [C0059768] do_sync_read+0xc4/0x134
[C6A15EF0] [C0059874] vfs_read+0x9c/0x1a4
[C6A15F10] [C0059CA0] sys_read+0x4c/0x90
[C6A15F40] [C0004220] ret_from_syscall+0x0/0x38
Instruction dump:
912700e4 7d000124 4bffc4a9 80010014 38210010 7c0803a6 4e800020 812700e8 
3929ffff 912700e8 7d000124 4bffffdc <80030000> 700a4000 40820034 80030004 

Corrupted stack?...

Thanks
Guennadi
---
Guennadi Liakhovetski
