Message-ID: <3CC46932.4040805@embeddededge.com>
Date: Mon, 22 Apr 2002 15:49:06 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: rmorin@miranda.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8240 PTE setup
References: <200204221807.g3MI7Uh27005@ares.gdc.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert Morin wrote:


> I have based my work on the Linux kernel 2.5.8 ....

You don't want to use that yet :-)  Use the 2_4_devel kernel.

> ....I can see with my BDI2000 that the
> MMU is not translating correctly virtual addresses to physical
> addresses.

The mmu always translates correctly, your programming of it
is probably incorrect :-)


> .... I made a patch to use a BAT instead of PTE but
> this cause only to move the problem further upstream

What BAT did you change, and to what?


> I have check the parameter passed with ioremap() and it's
> ok. With the BDI2000, I get this with the phys command:
>
> 	phys 0xfdfd0000          (virtual address returned by ioremap)
>
> 	PHYS = 0xfffff000	END = 0xffffffff
> instead of
> 	PHYS 0xfdf40000 END = 0xfdffffff

So, you did 'virt = ioremap(0xfdf40000)' and virt == 0xfdfd0000?
Where did you call ioremap()?  Are you trying to remap the EUMB registers
again (this is done in mpc10x_common.c for 82xx boards)?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
