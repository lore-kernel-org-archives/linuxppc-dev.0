Message-ID: <4045A8FC.1090303@ru.mvista.com>
Date: Wed, 03 Mar 2004 12:44:28 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init
References: <20040302085159.1174CC0655@atlas.denx.de> <4522-80798@sneakemail.com>
In-Reply-To: <4522-80798@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen Williams wrote:
> I'm using ... PPC405GPr ...
...
>
> Humm... The MMU comment makes me think. U-Boot is running with the
> MMU off. The head_4xx.S entry code sets up a temporary MMU mapping
> that includes the linked kernel address space, but that is only 32meg.
> The stack at the time is still where U-Boot left it, near the end of
> the 128Meg memory. Is this something I should address (pardon the pun)?
>

Just a suggestion. Check that the whole data cache is invalidated.
The kernel often relies on the bootloader to initialize dcache properly.
And there is a chance that the bootloader was written for 405GP, but
405GPr's data cache is two times bigger. If this is the case
you can either fix the bootloader, or invalidate dcache in the kernel's
secondary bootloader (see arch/ppc/boot/simple/embed_config.c,
embed_config() for Xilinx ML300 as an example).

Best regards,
Andrei


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
