Return-Path: <jonmasters@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id 53F0D680F4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 01:22:12 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so499664nzp
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 28 Aug 2005 08:22:11 -0700 (PDT)
Message-ID: <35fb2e5905082808152031ef53@mail.gmail.com>
Date: Sun, 28 Aug 2005 16:15:38 +0100
From: Jon Masters <jonmasters@gmail.com>
To: "P. Sadik" <psadik@gmail.com>
In-Reply-To: <ea43f4f9050825183121655ba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/26/05, P. Sadik <psadik@gmail.com> wrote:

>   I have a question on how PPC addressing works. I am familiar with
> the MIPS architecture and new to PPC.

Hello!

>   On MIPS, there are KUSEG (0x0000_0000 to 0x07FF_FFFF)
> which is always translated using TLB. Then there are two
> un-translated areas KSEG0 (0x8000_0000 which is cached)
> and KSEG1 (0xA000_0000).

Lovely. We don't do it that way on 405 but we could - since the MMU is
heavy soft assisted we could do that - we actually have everything run
through the MMU once we've done initial MMU setup, but we do have the
ability to mark ranges of addresses for IO and have the concept of TLB
pinning to lock ranges of kernel addresses in large translated (BAT
like for bigger PPC users) regions using just a few TLB slots. There
is also a ZPR (zone protection register), but that's mostly used to
fake the usual USER/KERNEL page distinction.

>  On PPC I see that, the kernel .text is at 0xC000_0000. Is it a
> translated address? If it is, for running kernel code, the CPU has to
> consult the TLB always?

It's translated except during early setup and on certain exceptions -
but everything else you will do in the kernel sees virtual addresses.

>  Another question is regarding addressing local peripherals. I am using
> an ML310 board from Xilinx

That I guessed. Partly since Peter had already replied, but also
because that's a large chunk of ppc405 users currently working on new
designs. Please bear in mind that only a few of us are aware of the
issues below.

> and it has DDR mapped to 0x0000_0000
> to 0x0FFF_FFFF (256 MB). Now, I need to add an IP to the PLB.
> For that, I am thinking of using 0x2000_0000 to 0x2000_0FFF.
> Now, my driver need to access the registers within the above region.
> How will I do that? It is an I/O, hence should I use ioremap, or can
> I access it directly? What role cache will play in this case?

You'll need to do an ioremap to get at that physical address from the
kernel, then use the returned virtual address to access your
peripheral. You should always use the appropriate read function rather
than doing a stw and an eieio and you probably want to make sure your
bootloader also has setup the right ZPR/etc. if you want to write to
that before Linux.

>  The third question is, can I use de-referencing of address. Is it O.K
> to use pointers to access the registers, or do I have to use read/write
> variants?

You /can/ use a deference if you're setup that region as an IO remap
but why bother? That said, we've probably all done it and it does work
- that is your call.

>   I would appreciate a lot if you could give some insight into this. Any
> pointers or reading materials will be very helpful.

Feel free to email. I've done a bunch of ml<insert number> projects
and I'm coming up on a ML403 when I get around to buying one for home
:-)

Jon.

P.S. I've been quiet on this list for a while, standard moving and
conference season combo.
