Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <4522-80798@sneakemail.com>
Date: Tue, 02 Mar 2004 10:48:42 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init
References: <20040302085159.1174CC0655@atlas.denx.de>
In-Reply-To: <20040302085159.1174CC0655@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wd-at-denx.de |PPC Linux Embedded| wrote:
 > In message <19122-27221@sneakemail.com> you wrote:
 >
 >>I have a PPC405GPr based board w/ 128Meg SDRAM, and I'm building
 >>kernel 2.4.24 (devel CVS) for it. I also have U-Boot ported to
 >>it, and I'm using U-Boot as the bootstrap loader.
 >
 > ...
 >
 >>## Transferring control to Linux (at address 00000000) ...
 >
 >
 > Did you check the FAQ? See
 > http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Good point, I missed that. However, that particular FAQ doesn't seem
to apply. I'm using 2.4.24+ (>2.4.5), the CFG_IMMR value doesn't seem
to apply (PPC405GPr, not a MPC8xx system) and I double-checked that
the bd_t structure matches. Besides, it's nowhere neer trying to access
any of the arguments yet.

I put some progress checking code in the source to see where it
goes, and I see it enters early_init, calls early_init (there is
an initial MMU setup active at the time) and calls reloc_offset.
However, it never actually seems to *arrive* in reloc_offset.

Humm... The MMU comment makes me think. U-Boot is running with the
MMU off. The head_4xx.S entry code sets up a temporary MMU mapping
that includes the linked kernel address space, but that is only 32meg.
The stack at the time is still where U-Boot left it, near the end of
the 128Meg memory. Is this something I should address (pardon the pun)?

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
