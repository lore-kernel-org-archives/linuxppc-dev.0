Message-ID: <B895EFF5AF34724880036BDB5B5B81481355E7@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Virtex-II Pro/405 MMU-cache interaction?
Date: Wed, 30 Apr 2003 18:15:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have a puzzler which I hope someone can shed some
light on.

For our Virtex-II Pro development board, we have two
bit files:  one with SDRAM at address 0x00000000 and
few peripherals, and another with SDRAM at address
0x80000000 and many periperhals.  (I won't go into
why; the details don't concern this mailing list.)

I've successfully ported ELDK to the SDRAM-at-0 system.
It runs great; I have a BusyBox prompt and commands
are functional.

Also, our simple debug monitor runs fine with SDRAM at
either 0x00000000 or 0x80000000.  Exhaustive memory tests
pass with cache on or off, for both systems.  It only
remains to get Linux running as well with the second
bit file as it does with the first.  (Why bother?  The
reason is that with the second bit file, I have access
to the flash for non-volatile storage.)

(Side note:  With the SDRAM at address 0, on the PLB bus,
memory performance is about 3x faster than when using
the bit file with SDRAM at 0x80000000 on the OPB bus.
This is believed to be due to propagation delay through
the PLB-to-OPB bridge.)

For the SDRAM-at-0x80000000, of course I needed to make
the necessary mods to the tophys and tovirt macros for
assembly code, and ___pa and ___va for C code, as well
as misc. fixups in the boot wrapper (e.g. misc-embedded.c
gunzips to a hard-coded 0 address).

Having made those changes, the early init code runs
fine -- i.e. machine_init() and MMU_init(), before
start_kernel.  Note that this code runs with a pair
of 16MB TLB mappings that cover all of the 32MB SDRAM.
During this time, the "real" mappings are prepared
in SDRAM -- 1st level in swapper_pg_dir (here, at
0xc011d000) and 2nd level (here, at 0xc015f000).

Here is the puzzler:

*	While the MMU is still on, in MMU_init et al.,
	I can see data 0xc015f000 at 0xc011dc00.  Also
	I see ASCII text at 0xc011e000 (cmd_line).

*	In head_4xx.S, after return from MMU_init,
	the MMU is briefly switched off and a tlbia
	is done.  Here, I still see ASCII text at
	0x8011e000, but I read zeroes at 0x8011dc00!!

	(Note:  In perhaps 1 of 20 or 30 runs, I
	will successfully data at 0x8011dc00 here.)

	When the MMU is switched back on and head_4xx.S
	rfi's to start_kernel, the first ITLB miss (which
	is expected) fails to read page-table data from
	swapper_pg_dir at 0x8011dc00, so there is now
	an endless cycle of exceptions.

*	Here is the odd part:  Leaving the SDRAM intact
	(our board has SRAM), I now download our debug
	monitor to SRAM, and use it to view the SDRAM.

	And here, I manually set up TLB entries mapping *not*
	0xc0000000 => 0x80000000 like Linux did, but rather
	0x80000000 => 0x80000000 like Linux did.

	The result is clear:

	avmon> tlb enable
	avmon> $b 0x8011dc00 0x10
	8011dc00: c0 15 f0 00  c0 16 00 00  c0 16 10 00  c0 16 20 00 |
.............. .

	avmon> tlb disable
	avmon> $b 0x8011dc00 0x10
	8011dc00: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 |
................

	avmon> tlb enable
	avmon> $b 0x8011dc00 0x10
	8011dc00: c0 15 f0 00  c0 16 00 00  c0 16 10 00  c0 16 20 00 |
.............. .

	avmon> tlb disable
	avmon> $b 0x8011dc00 0x10
	8011dc00: 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 |
................

	avmon> tlb enable
	avmon> $b 0x8011dc00 0x10
	8011dc00: c0 15 f0 00  c0 16 00 00  c0 16 10 00  c0 16 20 00 |
.............. .

That is, the data goes away when the MMU is off, but comes back again
when the MMU is on!

I thought this might be cache staleness, but the weird thing is that:
*	The kernel populated swapper_pg_dir with 0xc011dc00 virtual mapping.
*	At physical address 0x8011dc00, the data is gone.
*	When I map to a *different* virtual address, namely virtual
0x8011dc00,
	the data returns -- so I don't see how some cache line for
0xc011dc00
	could be used, given that I'm reading from a different virtual
address
	and getting the same data.

Has anyone any advice?  I've been through the IBM 405 errata document and
haven't seen anything that seems to apply ... any and all advice is
appreciated.

Thanks.

For reference, here are my actual console printouts:

MMU_init: total_lowmem 02000000
adjust_total_lowmem: total_memory=02000000 total_lowmem=02000000
max_low_mem=30000000
MMU_init: total_lowmem 02000000
MMU_init: total_lowmem 02000000
MMU:hw init
swapper_pg_dir @ c011dc00 = 00000000
MMU:mapin
mapinram: total_lowmem = 02000000
MMU:mapin_ram done
swapper_pg_dir @ c011dc00 = c015f000
MMU:setio
board_io_mapping: a0000000 => fdfff000  (Note:  ioremap() for my UART)
swapper_pg_dir @ c011dc00 = c015f000
MMU:exit
spd @ c011dc00 = c015f000
hi                   (Note:  this is in head_4xx.S with the MMU still on)
3:c011dc00:c015f000  (swapper_pg_dir data still vislble)
3:c011e000:636f6e73  (cmd_line data visible)
ph                   (Note:  this is in head_4xx.S with the MMU off now)
4:8011dc00:00000000  (swapper_pg_dir data is *invisible*)
4:8011e000:636f6e73  (cmd_line data is visible)

(Note: At this point XMD reveals an endless cycle of ITLB misses, since
the ITLB miss handler can't read swapper_pg_dir.  Nothing more prints
to the screen.)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
