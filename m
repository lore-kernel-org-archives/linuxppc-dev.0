Message-Id: <200204221907.g3MJ7th27102@ares.gdc.ca>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Robert Morin <rmorin@miranda.com>
Reply-To: rmorin@miranda.com
To: Dan Malek <dan@embeddededge.com>
Subject: Re: MPC8240 PTE setup
Date: Mon, 22 Apr 2002 15:08:10 -0400
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200204221807.g3MI7Uh27005@ares.gdc.ca> <3CC46932.4040805@embeddededge.com>
In-Reply-To: <3CC46932.4040805@embeddededge.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

> > I have based my work on the Linux kernel 2.5.8 ....
>
> You don't want to use that yet :-)  Use the 2_4_devel kernel.
>

Ok, I will look to it.

> > ....I can see with my BDI2000 that the
> > MMU is not translating correctly virtual addresses to physical
> > addresses.
>
> The mmu always translates correctly, your programming of it
> is probably incorrect :-)
>

This is my problem and I think it's related to the pSOS bootloader
but I have difficulties pointing to the problem.

> > .... I made a patch to use a BAT instead of PTE but
> > this cause only to move the problem further upstream
>
> What BAT did you change, and to what?
>

In my file mxhost2_setup.c in function mxhost2_map_io(), I've
added:

    io_block_mapping(0xfdf00000, 0xfdf00000, 0x00100000, _PAGE_IO );

as a work-around and modify also my find_bridge() to prevent using the
ioremap_base.


> > I have check the parameter passed with ioremap() and it's
> > ok. With the BDI2000, I get this with the phys command:
> >
> > 	phys 0xfdfd0000          (virtual address returned by ioremap)
> >
> > 	PHYS = 0xfffff000	END = 0xffffffff
> > instead of
> > 	PHYS 0xfdf40000 END = 0xfdffffff
>
> So, you did 'virt = ioremap(0xfdf40000)' and virt == 0xfdfd0000?
> Where did you call ioremap()?  Are you trying to remap the EUMB registers
> again (this is done in mpc10x_common.c for 82xx boards)?
>

I made my trace inside the mpc10x_common.c to have this result. I am
not making changes in the kernel, I want to keep as is as much as
possible.

For the moment, I will move my platform into 2_4_devel to see if
the situation improved.

>
> 	-- Dan

Thanks.

Robert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
