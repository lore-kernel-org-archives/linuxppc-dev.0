Return-Path: <manninej@students.cc.tut.fi>
Received: from mozart.cc.tut.fi (mozart.cc.tut.fi [130.230.10.30])
	by ozlabs.org (Postfix) with SMTP id A92BD67A9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 22:28:58 +1100 (EST)
Date: Tue, 8 Feb 2005 13:28:56 +0200 (EET)
From: Jarno Manninen <manninej@students.cc.tut.fi>
To: Martin Krause <Martin.Krause@tqs.de>
In-Reply-To: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B71@TQ-MAILSRV-1>
Message-ID: <Pine.LNX.4.58.0502081323590.17665@mozart.cc.tut.fi>
References: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B71@TQ-MAILSRV-1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: AW: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 8 Feb 2005, Martin Krause wrote:

> Hm, the SM501 has 8 MB internal RAM. The framebuffer lies within this
> memory. The SM501 is connected with the MPC5200 over the local bus
> interface (not over PCI) and mapped with CS1 to address range
> 0xE0000000-0xE3FFFFFF. The SM501 configuration registers are within
> the mapped memory area at 0xE3E00000. I can't imagine, why the byte
> swapping should only affect accesses to the famebuffer memory and not
> to the configuration registers (where also single bits at the right
> position must be set correctly). I could configure CS1 to do byte
> swapping, but then access to the SM501 configuration registers does
> not work any longer, because this bytes are swapped, too.

Um. Have you written a kernel FB driver? If so then the write/read macros
do this swapping for you. Assuming that you use those for accessing the
device registers. At least SM722 requires those writes to be swapped too.

> Geert, I've seen, you have done much of the fb stuff in the linux
> kernel (thank you for that!). Could you please point me to the best
> place, where byte swapping should be done if I want to use the linux
> text console in 16 bit mode with the MPC5200?

Perhaps the pseudopalette would suffice here, I guess? And supposing that
you have written a FB driver. If not then you have to do the patching at
the gfx-library level.

- Jarno
