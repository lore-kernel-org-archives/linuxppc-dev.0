Message-ID: <3E63C25F.3080607@embeddededge.com>
Date: Mon, 03 Mar 2003 16:00:15 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kamalesh B <kamal@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem porting 2.4.17 linux to MPC8260ADS
References: <3E5650A4.39677CB0@tataelxsi.co.in> <3E565C04.9020603@embeddededge.com> <3E59BF74.8C163181@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kamalesh B wrote:

> [KAMAL]:
> All memory mapping is handled correctly.
> SDRAM is mapped to 0xC0000000 from 0x00000000
> Flash is mapped to 0xFF800000 from 0xFF800000
> Board control/status register is mapped to 0xF0100000 from 0x04500000
> IMMR is mapped to 0xF0000000 from 0x04700000
>
> Iam using BATs to do this (BAT0 and BAT1)

If I understand correctly (and I may not), this isn't being done
correctly.  Linux is going to take over the BATs for it's own mapping.
It doesn't matter what you have set in them.

You must ensure the IMMR is physically mapped to 0xf0000000.  That is,
you have to change the IMMR register to this value, you can't use
a BAT to map this value to the virtual 0xf0000000 and then call Linux.

The SDRAM will be remapped by Linux to use the BAT 3/4 registers based
upon how much memory you tell it is available in the board descriptor
structure.

The Flash and board control register will have to be mapped using ioremap()
and you will have to use the subsequent returned virtual address to
access these regions.



> [KAMAL]:
> After turning on MMU, iam using the LED code to flash leds and it is
> working. Memory map of board control status register after turning on MMU is
> 0xf0100000. Only at this point it won't.

No, they are not mapped there.  The only thing Linux knows about early
in the kernel is a small portion of the ram.  Linux completely changes the
MMU mapping, it doesn't matter what you have mapped when you call the kernel.
Your board control registers are not mapped any longer shortly after you
call the Linux kernel.


> [KAMAL]:
> Led flashing code looks something like this
> --- Code begins ---
> lis r20, 0xf010
> lis r21, 0
> stw r21, 0(r20)
> --- Code ends ---

That will crash the kernel shortly after you start it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
