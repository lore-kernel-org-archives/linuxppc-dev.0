Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6BE4@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'ashish anand'" <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: "Kernel logical address"  vs "Physical"
Date: Fri, 14 Sep 2001 13:47:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


So the key is that by address is above ioremap_base. That I initially got
away with not using ioremap is a coincidence? Right?

Where could I find a complete discussion of how all this is organized? The
documents I find are or very vague, or explain a small issue and suppose you
have already solid knowledge about it.

Thanks,
Frederic

-----Original Message-----
From: ashish anand [mailto:ashisha@india.infogain.com]
Sent: vrijdag 14 september 2001 8:07
To: Goddeeris Frederic; linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address" vs "Physical"
Importance: High



> Thank you for your reply! I am afraid that I am still confused...
>
> You say "actually when you refer to address mentioned 0xFA400000 in driver
> this address is already virtual address". The address 0xFA40000 is an
> address that I found in the documentation of the hardware vendor (Embedded
> Planet, the board is an CLLF_BW32), where there is no reference to any OS.
> The table containing the chip select mappings mentions that the "Control
and
> Status register" is mapped at FA40. So I assume that 0xfA400000 is a pure
> physical address. Or is this a false assumption?
>
> When I write "char *p=0xFA40000;" it works.
> When I write "char *p=0xFA40000; p = ioremap(p,1);" I get another pointer
> and it works as well... I suppose this could not work when 0xFA40000 was
not
> a physical address. When I use p=__va(p); or p=pa(p); it crashes


documentation is alright.
your documentation says that address 0xF4A00000 is a PHYSICAL address mapped
for
 LED.but you will not be able to use this adress from processor without
ioremapping.
in mmu of processor thee should be entry for virtual ----> physical
addreses.

initially this is not , after using ioremap it is created there.

in your case you are getting virtual address = physical addres , probably
because of
ioremap_base in the implementation of ioremap.
your physical address is above ioremap_base.
hence physical = virtual.

now path of your transaction from processor -> host bridge -> LED is clear.
this is all about your confusion.
I don't have any idea about your specific board.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
