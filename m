Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200108232122.QAA24130@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: breakpointing with bdi2000
Date: Thu, 23 Aug 2001 17:24:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to set a break in mem_init. I take a machine check soon after
that and want to take at look at things right before it crashes. Normally, I
could just look at the values of srr0 and the msr, but those seem to be in
an odd state, i.e. they are the same and what is expected..

Anyway so here's what I'm doing.

1. Power on the box and let ppcboot load my vmlinux file via tftp
2. start up gdb and do the following:

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
0x1fd3540 in ?? ()
(gdb) add-sym vmlinux 0xc0000000
add symbol table from file "vmlinux" at
	.text_addr = 0xc0000000
Reading symbols from vmlinux...done.
(gdb) break mem_init
Breakpoint 1 at 0xc014c424: file init.c, line 861.
(gdb) c
Continuing.

3. Pop back over to ppcboot and then type:
bootm 00100000

The kernel starts but never stops at mem_init. If I pop over to the telnet
window for the bdi and manually stop the box I can step, but it won't break.

I've tried using both hard and soft breakpoint settings on the bdi. So, I'm
a bit confused why this won't work. I understand the previous e-mails that
you can't break before the MMU is set up, but now that I'm in virtual
address space, I should be fine.

-bmb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
