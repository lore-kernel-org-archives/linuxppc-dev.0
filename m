Message-ID: <3BA19E71.F4A82D9B@india.infogain.com>
Date: Fri, 14 Sep 2001 11:36:41 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address"  vs "Physical"
References: <6B546A602AD2D211BFF00008C7A42889041D6BE3@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Thank you for your reply! I am afraid that I am still confused...
>
> You say "actually when you refer to address mentioned 0xFA400000 in driver
> this address is already virtual address". The address 0xFA40000 is an
> address that I found in the documentation of the hardware vendor (Embedded
> Planet, the board is an CLLF_BW32), where there is no reference to any OS.
> The table containing the chip select mappings mentions that the "Control and
> Status register" is mapped at FA40. So I assume that 0xfA400000 is a pure
> physical address. Or is this a false assumption?
>
> When I write "char *p=0xFA40000;" it works.
> When I write "char *p=0xFA40000; p = ioremap(p,1);" I get another pointer
> and it works as well... I suppose this could not work when 0xFA40000 was not
> a physical address. When I use p=__va(p); or p=pa(p); it crashes


documentation is alright.
your documentation says that address 0xF4A00000 is a PHYSICAL address mapped for
 LED.but you will not be able to use this adress from processor without ioremapping.
in mmu of processor thee should be entry for virtual ----> physical addreses.

initially this is not , after using ioremap it is created there.

in your case you are getting virtual address = physical addres , probably because of
ioremap_base in the implementation of ioremap.
your physical address is above ioremap_base.
hence physical = virtual.

now path of your transaction from processor -> host bridge -> LED is clear.
this is all about your confusion.
I don't have any idea about your specific board.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
