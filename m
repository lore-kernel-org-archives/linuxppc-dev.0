Date: Mon, 1 Dec 2003 11:09:09 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel oops when inserting a pcmcia card (2.6.0-test11)
Message-ID: <20031201100909.GA26654@router.mmk-hagen.de>
Mime-Version: 1.0
From: uwe.steinmann@mmk-hagen.de (Uwe Steinmann)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I find myself in xmon as soon as I insert a pcmcia card into
my Pismo PowerBook. I suspect the memory range which is
working for 2.4.21.
Here is what I found in syslog.

   Uwe

Nov 30 08:32:40 pb kernel: Oops: machine check, sig: 7 [#1]
Nov 30 08:32:40 pb kernel: NIP: D9BF531C LR: D9BF52F0 SP: D7237630 REGS:
d7237580 TRAP: 0200    Not tainted
Nov 30 08:32:40 pb kernel: MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR:
11
Nov 30 08:32:40 pb kernel: TASK = c0ae7120[400] 'cardmgr' Last syscall:
54
Nov 30 08:32:40 pb kernel: GPR00: 000000FF D7237630 C0AE7120 D9806000
00000000 00000021 00000002 D72376AA
Nov 30 08:32:40 pb kernel: GPR08: D7FEF238 D9807000 00009032 00001000
22002482 10022860 00000001 00000001
Nov 30 08:32:40 pb kernel: GPR16: 10020000 10020000 00000003 00000001
7FFFFD78 7FFFF548 11000000 00000000
Nov 30 08:32:40 pb kernel: GPR24: D72376AA 00000021 00000002 C194F42C
00000000 00000000 00000002 D72376AA
Nov 30 08:32:40 pb kernel: Call trace:
Nov 30 08:32:40 pb kernel:  [d9bf5628] read_cis_cache+0x144/0x168
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf5c74] pcmcia_get_next_tuple+0x9c/0x2c0
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf598c] pcmcia_get_first_tuple+0xb4/0x148
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf7584] pcmcia_validate_cis+0x6c/0x1fc
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf7b58] readable+0x90/0xb0 [pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf7d58] cis_readable+0xec/0xf4
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf8014] do_mem_probe+0x1d0/0x1e8
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf80d0] validate_mem+0xa4/0xe4
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf5134] set_cis_map+0xa4/0x10c
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf52f0] read_cis_mem+0x154/0x1b8
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf5628] read_cis_cache+0x144/0x168
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf5c74] pcmcia_get_next_tuple+0x9c/0x2c0
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf598c] pcmcia_get_first_tuple+0xb4/0x148
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bf7584] pcmcia_validate_cis+0x6c/0x1fc
[pcmcia_core]
Nov 30 08:32:40 pb kernel:  [d9bed090] ds_ioctl+0x344/0x5d0 [ds]

--
  MMK GmbH, Universitaetsstr. 11, 58097 Hagen
  Uwe.Steinmann@mmk-hagen.de
  Tel: +2331 840446    Fax: +2331 843920

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
