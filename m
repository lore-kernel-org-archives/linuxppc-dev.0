Message-ID: <C08678384BE7D311B4D70004ACA37105111946FB@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'ADharankar@attbi.com'" <ADharankar@attbi.com>,
	Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Relocating PPCBoot into SRAM
Date: Tue, 18 Feb 2003 16:27:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> If PPCBoot/U-Boot were to be relocated into SRAM in the first place,
> is there a potential for any problem (the CPM SDMA? probably not -
> the buffer descriptors are in DPRAM...)?

I've run software out of both SRAM & SDRAM; the CPM doesn't
seem to care.  (For some simple devices (e.g. UARTs) the
BDs might have to be in DPRAM; for others (e.g. SCC, FEC)
the BDs can be in external memory -- SRAM or SDRAM.  & I
think that for all CPM devices I've seen, the I/O buffers
(what the BDs point to) can be in any memory.  You have to
make sure you tell the CPM the physical, not virtual addresses,
and also make sure the CPU doesn't have those areas cached.
But these issues apply equally to SDRAM, SRAM and DPRAM.)

> To test the region of SDRAM where PPCBoot/U-Boot resides, how could
> a non-destructive test be implemented? Perhaps, would one way would be
>  do these test for that region of PPCBoot/U-Boot before it is
> located to SDRAM?
>
> Some of the x86 PC BIOSs/Bootloaders/Monitors seem to be able to do
> full/destructive memory test without a reboot. That is what seems
> to be appealing to for PPCBoot/U-Boot.

1.	BIOSes, at startup, seem to have code in about 1K of RAM, and
	do a minimal test of the *rest*.  (I think, just 1-pass
	address uniqueness.)  This is a weak test.

2.	If you run out of one memory (e.g. SRAM) you can test all of
	another memory.  This is what we do at Avnet Design Services
	-- run out of SRAM to test SDRAM.

	If you don't have an SRAM, then you might be able to fit a
	very compact memory tester entirely into DPRAM.

	(On one previous project, not with a PPC, I ran an SDRAM
	test while taking instructions from flash & with stack/data
	in a small on-chip RAM.  The memory test passed.  Then I
	ran the same test code, but with instructions taken from
	SRAM.  The test now failed because I was hitting the memory
	more quickly, & found a timing problem.  Caveat emptor.)

3.	memtest86 runs out of main memory (whatever is on your PC
	-- SDRAM, DDRAM, etc.) and does shared-library/ELF tricks
	to run out of one position to test some memory, then copy
	itself to another location & then test the memory it had
	been running out of.  Nice trick, if you want to pull it off,
	but it does take a fair amount of setup & personally I think
	option 2 above is preferable when possible.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
