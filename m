Message-ID: <C78540EA349B2D4BB83D1B0AD748E26F1BE4C0@amer20.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Prakash kanthi'" <pkanthi@yahoo.com>,
	"Kerl, John" <John.Kerl@Avnet.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Virtex-II Pro tlbia exception
Date: Fri, 28 Mar 2003 17:13:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Excellent; I now get past the tlbia.
What happens soon thereafter, though, is troubling.

What I see is, from the beginning of vmlinux:

*	At phys. 00000000, save regs.
*	bl initial_mmu (still running from real memory)
	-	map c0000000 to 00000000, 16 MB
	-	return
*	back near the top of head_4xx.S:
	-	set SRR1 to 0x1032
	-	set SRR0 to c00022dc (vrt. start_here)
	-	rfi
*	Processor starts to fetch from address 0xc00022dc.

Problem:  c000xxxx is still apparently not mapped!
I can dump out 0000xxxx region & still see expected
vmlinux data; I dump out c000xxxx region and see zeroes.
(This is a strange fact of MicroBlaze & VII-Pro --
non-existent address ranges do provide data on a read,
and read back as zeroes.)

Furthermore, XMD (if it can be trusted) tells me the
MSR is still zero!

The 0x0030 in 0x1032 should set MSR[IR] and MSR[DR].
Xilinx notes that the 0x0002 bit is reserved; I also
tried setting SRR1 to just 0x1030, but with no difference.

I'm at a loss here, as the Xilinx docs are quite clear
that you set SRR1 to your desired MSR value, SRR0 to
return address, then rfi.  But it seems to simply *not
happen*.

Has anyone gotten a VII-Pro system off the ground and
is willing to share advice and/or code?

Thanks.


-----Original Message-----
From: Prakash kanthi [mailto:pkanthi@yahoo.com]
Sent: Friday, March 28, 2003 2:00 PM
To: Kerl, John; 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: Virtex-II Pro tlbia exception


John,

I had similar problems. Here is what i would do.

1. Check the ESR register for the exception. If the
exception indicates "Illegal Instruction", problem
could be because your hw folks i have mmu_enable
signal set to 'net_gnd'. Ask them to change it to
'net_vcc', and you are good to go.

2. If the ESR does not help you much, double check
your code that does I/D cache cleanups.

Prakash


--- "Kerl, John" <John.Kerl@Avnet.com> wrote:
>
> Hello all,
>
> After several weeks on other projects I am picking
> up on
> the VII-Pro again.
>
> For reference, we have our firmware up and running
> fine on
> the board; we can talk to the UART, and SDRAM tests
> fine.
> (The hardware-level verification is actually
> something we are
> good at doing.)
>
> Using arch/ppc/boot/avnet (modified from
> arch/ppc/boot/common),
> along with our firmware, I'm able to build a
> zImage.initrd.elf,
> TFTP to the board, and jump into
> arch/ppc/boot/avnet/misc-embedded.c.
> This code reports on the bd_t parameters passed from
> the firmware
> (all parameters are as expected), and decompresses
> the kernel to
> address 0.  I can hex-dump the address-0 region & I
> find that
> what I see in vmlinux on the host PC really is what
> I see at
> address 0 and above.
>
> Then the arch/ppc/boot code jumps to address 0,
> entering vmlinux
> per se.  The first few instructions (head_4xx.S)
> save boot args
> r3-r7 to r31-27, then jump to initial_mmu.  The very
> first thing
> there is a tlbia.
>
> Now, when I single-step through this, I find that
> the debugger
> (XMD) shows me tlbia being executed twice (e.g.
> "stp" once and
> I'm still at the tlbia, "stp" again and continue),
> and also
> the next instruction after that is fetched from
> address 0xedba0700.
>
> Now, the 0xedba0000 prefix is, as far as I can tell,
> garbage.
> 8xx's have an MSR bit that specifies whether
> exception prefixes
> are 0x00000000 or 0xfff00000; I see no such bit for
> the VII-Pro 405.
> And the 0700 suffix looks like a program check; yet,
> my MSR is 00000000
> indicating that I am indeed in privileged mode.
> SRR0 is just the
> address of the tlbia.
>
> Since I've been running simple-minded firmware up to
> this point, I
> think it highly likely that I haven't yet told the
> 405 to be in
> some mode it needs to be in.  But I don't know what.
>  I checked
> around in PPCBoot source for the ML2 board, thinking
> that perhaps
> someone else porting to Virtex-II Pro might have
> found some magic
> ingredient, but actually the initialization there
> appears to be
> minimal (as expected).
>
> Does anyone know why (a) the prefix 0xedba is so
> bizarre, (b)
> why I appear to be taking a program check, and/or
> (c) am I
> missing some initialization steps that the firmware
> should
> have done?
>
> Thanks.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
