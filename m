Date: Mon, 24 Feb 2003 17:00:03 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Oops when inserting PCMCIA flash card (IDE)
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18nL1U-0007Ag-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

For a number of kernel versions (at least 4 months) I get a kernel oops
when inserting a CF card in my TiBook's PCMCIA slot.

I started debugging the problem today, and have thus far come to this:

Oops: kernel access of bad area, sig: 11
NIP: C00D9948 XER: 00000000 LR: C00D834C SP: D70D7530 REGS: d70d7480 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d70d6000[355] 'cardmgr' Last syscall: 54
last math d5608000 last altivec 00000000
GPR00: 00000F94 D70D7530 D70D6000 00000107 000088B8 00000001 D70D7520 C0270000
GPR08: 00000000 C00D9948 0000001F D70D7470 82002422 10021F3C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 C59440E0 FFFFFFFF 0000011E
GPR24: C0230000 00000000 00000000 C0230000 C0230000 00418570 C02A2400 000088B7
Call backtrace:
C00D83E0 C00D85A4 C00D933C C00DF820 C00E0420 C00F0304 C00F0760
C00F0A0C C0114FC8 C01165CC C00F01B0 C0111EE4 C0112C74 C004F024
C00064FC 20202020 10003428 100048F8 0FEC3E24 00000000

which ksymoops decodes:

Trace; c00d83e0 <autoirq_report+e44/f10>
Trace; c00d85a4 <probe_hwif+f8/3d4>
Trace; c00d933c <export_probe_for_drive+180/700>
Trace; c00df820 <ide_probe_module+30/4c>
Trace; c00e0420 <ide_register_hw+160/1b0>
Trace; c00f0304 <proc_ide_destroy+3b4/13bc>
Trace; c00f0760 <proc_ide_destroy+810/13bc>
Trace; c00f0a0c <proc_ide_destroy+abc/13bc>
Trace; c0114fc8 <pcmcia_register_client+270/298>
Trace; c01165cc <CardServices+170/891c>
Trace; c00f01b0 <proc_ide_destroy+260/13bc>
Trace; c0111ee4 <unregister_pccard_driver+62c/16bc>
Trace; c0112c74 <unregister_pccard_driver+13bc/16bc>
Trace; c004f024 <kill_fasync+49c/4c0>
Trace; c00064fc <set_context+27c4/29f8>

The NIP in the oops points to ide_mm_inb(); it's trying to read from the
IDE ports. However, the port the new IDE interface got assinged seems to
be 0x100 (see r3: 0x107, which is port_base + IDE_STATUS_OFFSET). This
is of course outside of the range the PCMCIA controller has:

pooh:/etc/ppp# cat /proc/ioports
00000000-007fffff : /pci@f2000000
  00001000-00008fff : PCI CardBus #11
  00009000-000090ff : PCI CardBus #11
00802000-01001fff : /pci@f0000000
  00802400-008024ff : ATI Technologies Inc Rage Mobility M3 AGP 2x
ff7fe000-ffffdfff : /pci@f4000000

So the problem seems to be the PCMCIA code gets the wrong ports for the
PCMCIA card?

Anybody with any help as to where I can look for the problem?

This used to work OK, but as I said, broke a few onths ago.

Cheers, and thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
