Message-ID: <C08678384BE7D311B4D70004ACA371050B7632B1@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FW: Linux on 857T?
Date: Tue, 22 Jan 2002 18:36:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan:

Per your suggestions, I tried clearing BIH for OR1 (my
SDRAM is on CS1); no difference except the greek character
on "Freeing unused kernel:  36k i*t" is now an epsilon, not
a theta.

Copy-back cache was already disabled.

I started taking a look at head_8xx.S as you suggested, but
I had a realization, as follows (sorry for the length of
this message, but it does get interesting toward the end.)

We have three alpha boards which are in some working order.
Board A, let's call it, is the best one, and the one I've
been using for all the things I discussed in my recent
postings.  Boards B and C, on the other hand, haven't been
"working" for a few weeks, so I pretty much forgot about
them, as I will explain.

Some basic things about my debug monitor:

* One copy of my debug monitor is flashed in as reset code.
  It runs some generic processor-init code (modified from
  mot.com as I mentioned) then jumps into crt0 and thence
  into my C code.  Text is taken from flash; read/write
  data is in SRAM.  (We have 1MB SRAM and 64MB SDRAM.)

* Also, I have two more copies of my debug monitor.
  Neither one includes processor-init code: only crt0 & my
  C code.  One runs entirely from SRAM.  By this I mean
  that text, data, bss, and stack (I don't use a heap) are
  all in SRAM.  The other copy runs entirely from SDRAM.

* All three copies have my TFTP client code in them; I can
  be running one copy, then TFTP up another and jump into
  it.

* No interrupts are used; devices are polled.

* Every 10,000 poll cycles or so (which comes out to something
  like a few times a second, less when running from flash) I
  update the LED to provide a heartbeat.  This is an 8-bit LED
  *not* in any of ports A-D in the IMMR space, but rather a
  memory-mapped access to our CPLD, which among other duties
  takes a certain chip select & updates the 8 LEDs.

* I successfully use SMC1 all the time for my terminal
  (simple command-line stuff), and I successfully use the
  FEC all the time for TFTP'ing things to the board.

* I don't set up the MMU at all.

So: on all of the three boards, I run my debug monitor
from flash at power-up.  Then, I can TFTP up an SRAM-only
or SDRAM-only debug monitor, or zvmlinux.initrd.  On all
three boards, the kernel runs as far as "Freeing unused
kernel:  36k i*t"; all are the same in this regard.
However, while on board A (my good board) I can also TFTP
up an SRAM-only or SDRAM-only debug monitor, on boards B
and C I cannot.  The last thing the flash debug monitor
says is "Jumping to {address}"; the SRAM-only or SDRAM-only
copies never print anything out.

This is the point at which I forgot about these two boards
a few weeks ago.  However, more recently I've been making
more extensive use of the logic analyzer and the Macraigor
probe (which seems to work passably well for debugging my
debug monitor, since I don't use interrupts).  So I thought
I'd devote a little more time to *why* these two boards are
having the problems they are.

It turns out that the following happens:

* My flash debug monitor receives the TFTP'ed SRAM-only
  or SDRAM-only executable and writes it to the specified
  address range in SRAM or SDRAM.

* The flash debug monitor jumps into the start address for
  the SRAM-only or SDRAM-only executable.

* The crt0 code in SRAM or SDRAM starts running and
  zero-fills the bss, etc.

* The crt0 code jumps into my C code.

* One of the first things my C code does in main() is write
  LEDs to provide initialization status.  Then, once init
  code is done (e.g. setting up SMC & FEC BDs etc.), the
  LEDs are written periodically as described above.

* On board A, this works fine.  But on boards B and C,
  the probe reveals that I am taking an ITLB miss (!!!)
  while trying to return from the LED-write routine.
  The latter is very simple; it looks like this:

	#define CPLD_ADDR 0x38100002
	#define CPLD_REG  (*(volatile int16u *)CPLD_ADDR)

	void LED_dev_write(
		int32u value)
	{
	#ifndef NO_LED // In the build file
		CPLD_REG = ((~(int16u)value & 0xff) << 8);
	#endif
	}

  which just boils down to about a half-dozen instructions,
  ending in an sth and a blr.

* The probe shows instructions up to the sth, but not the blr.
  Instead, the next value for the PC, as I single-step in the
  probe, is 0x00001104 (which is the NIP for ITLB-miss exception).

Now, if I #define NO_LED in my build file, then the debug
monitor doesn't write LEDs -- and runs fine (!) on all
three boards.  And the only code change between those two
cases is whether or not I do that LED write via the CPLD.

There are two very weird things:

* On all three boards, currently the MMU and cache are
  never enabled by any copy of my debug monitor.  Only
  Linux enables them, when and if I run it. I don't see how
  I can *possibly* be taking an ITLB miss in my code when
  the MMU is not even enabled.  In fact, I can print out the
  MSR in my debug monitor & see that bits 24-25 are zero.

* Even if the TLBs are somehow used when the MMU is not
  enabled (I need to check the 857 manual), I see *no* way
  I should ever be getting any TLB miss.  The DTLB and ITLB
  are both supposedly 32 entries each; I am only loading up
  21 entries for data and 11 for instructions with a very
  simple 1-1 virtual-physical mapping, with 8MB page sizes.
  TLB entries should (in my understanding) *never* get
  pushed out, if I'm not putting new ones in.

In short, I was puzzled by problems which I was seeing in
the OS, but not in my debug monitor nor in the secondary
boot loader.  In fact, that statement is only true for 1 of
3 boards.  For the other two, my debug monitor is
apparently encountering some of the *same* problems as the
kernel is.  I could believe that one board has a cold
solder joint, etc. -- after all, these are low-volume alpha
boards (we made a total of 8, only three of which have been
modded up to where they will run).  But I don't believe
that two of them have the same assembly problem.  Maybe
there is something wrong in our CPLD code, or maybe in my
BR/ORs for the CPLD's CS, or maybe something else.

At this point the discussion seems no longer to pertain to
a Linux-PPC mailing list, so I think I'll stop.  Anyway, if
you were losing sleep awaiting a reply from me (hee hee),
please don't.  I think I have some questions for my
hardware guys.

Thanks very much for the help.


-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Tuesday, January 22, 2002 1:42 PM
To: Kerl, John
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: FW: Linux on 857T?


Kerl, John wrote:

> Sorry, forgot to cc the mailing list.

Set burst inhibit (BIH) in the memory controller ORx register for
your DRAM banks.  If that has no effect (but I suspect it will),
disable copyback cache (this is a configuration option).  If this
has no effect (but I suspect it will), modify the code in head_8xx.S
to globally disable (or actually not enable) the cache.  If you need
help with this last one, let me know.

None of the ICEs you listed are Linux friendly.....run without them.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
