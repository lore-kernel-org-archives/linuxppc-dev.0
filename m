Subject: radeonfb: PLL? problems with radeon 7000 in embedded PPC
From: Matevz Langus <matevy@arhitektova-delavnica.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1080771003.6224.14.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 01 Apr 2004 00:10:04 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody,

I am new in graphics in PPC and would like to ask if somebody can help
me.

I have a PPC (e500) embedded system with PCI bus and ATI Radeon 7000
with 64 MB DDR. PCI detects the card and opens all memory spaces as it
should.

However I have 2 problems:
- radeonfb driver detects SDRAM instead of DDR and also size is not
correct 192xxx kB instead of 64 MB.
- in function radeon_write_pll_regs system hangs in

	while ((INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK) !=
	       (mode->ppll_ref_div & PPLL_REF_DIV_MASK)) {
		OUTPLLP(PPLL_REF_DIV, mode->ppll_ref_div, 		~PPLL_REF_DIV_MASK);
	}

It loops in this while for ever.
Is the reason for this problem in PLL not locking?

I have seen that settings for PLL can be obtained from OF or BIOS. I
don't have anything like this in my embedded system.
How can I calculate appropriate values for PLL? Default ones are
obviously not correct.

Has anybody managed to use this card in embedded system without BIOS or
OF?

thanks,
  Matevz Langus


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
