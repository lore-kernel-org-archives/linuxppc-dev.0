Message-ID: <37D0F88E70D96C428C19EEB865701A38EBD8C6@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Machine check
Date: Thu, 13 Jun 2002 15:22:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All!

After starting 2.4.18 kernel on MPC8260ADS (from PpcBoot) with "initrd"
(inside only static compiled /bin/bash as init and few entry in /dev :
ttyS's and cua's and console) there is machine check (register and backtrace
addresses are decoded from *.map's ):

  . . . . messages as usual
Freeing unused kernel memory: 56k init
  *** this is the last message about correct boot
tty_io.c: process 1 (swapper) used obsolete /dev/cua/2 - update software to
use /dev/ttyS2
  *** might be the cause of the machine check?

Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7

NIP: C0022634 *** inside kernel: unlock_page
XER: 00000000
LR: C00894AC *** inside kernel: rd_blkdev_pagecache_IO
SP: C0F6FC80 *** memory >15M
REGS: c0f6fbd0 *** memory >15M
TRAP: 0200    Not tainted
MSR: 00049030
EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0f6e000[1] 'bash' Last syscall: 13
last math c0f6e000 last altivec 00000000
GPR00:
00000000
C0F6FC80 *** memory >15M
C0F6E000 *** memory >15M
C0185FC4 *** memory > 1M
C0FFFFFC *** memory >15M
00000000
C0E3ABFC *** memory >14M
4CC63182
GPR08:
4BFF67B5
00000010
0000005D
0000005C
24002488
100BE1E0 *** inside BASH: =_SDA_BASE_
00000000
00000000
GPR16:
00000000
00000000
100B0000 *** inside BASH: _SDA2_BASE_
00000000
00009032
C005B98C *** inside kernel: =ext2_get_block
C00345DC *** inside kernel: =end_buffer_io_async
00000000
GPR24:
C01B7A60
00000024
00000000
00000000
C0E3E720 *** memory >14M
00000000
00000400
C0185FC4 *** memory > 1M
Call backtrace:
00000000
C008946C *** inside kernel: rd_blkdev_pagecache_IO
C00895E4 *** inside kernel: rd_make_request
C0087A68 *** inside kernel: generic_make_request
C0087B5C *** inside kernel: submit_bh
C0035F34 *** inside kernel: block_read_full_page
C005BE90 *** inside kernel: ext2_readpage
C00224BC *** inside kernel: page_cache_read
C0022534 *** inside kernel: read_cluster_nonblocking
C0023F34 *** inside kernel: filemap_sync
C001F774 *** inside kernel: do_no_page
C001F9DC *** inside kernel: handle_mm_fault
C000B6E0 *** inside kernel: do_page_fault
C0004034 *** inside kernel: ret_from_except
10007320 *** inside BASH: decode_prompt_string
1000719C *** inside BASH: prompt_again
10004E40 *** inside BASH: yylex
10003F58 *** inside BASH: yyparse
10002DA8 *** inside BASH: parse_command
10002EB0 *** inside BASH: read_command
10002AF4 *** inside BASH: reader_loop
10000814 *** inside BASH: main
1003CDB8 *** inside BASH: __libc_start_main
00000000
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

The root of the problem apparently the paging/mm system which is on the dark
side for me!

Have any hint?

	Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
