Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6BE3@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'ashish anand'" <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: "Kernel logical address"  vs "Physical"
Date: Fri, 14 Sep 2001 12:52:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thank you for your reply! I am afraid that I am still confused...

You say "actually when you refer to address mentioned 0xFA400000 in driver
this address is already virtual address". The address 0xFA40000 is an
address that I found in the documentation of the hardware vendor (Embedded
Planet, the board is an CLLF_BW32), where there is no reference to any OS.
The table containing the chip select mappings mentions that the "Control and
Status register" is mapped at FA40. So I assume that 0xfA400000 is a pure
physical address. Or is this a false assumption?

When I write "char *p=0xFA40000;" it works.
When I write "char *p=0xFA40000; p = ioremap(p,1);" I get another pointer
and it works as well... I suppose this could not work when 0xFA40000 was not
a physical address. When I use p=__va(p); or p=pa(p); it crashes.

Regards,
Frederic

-----Original Message-----
From: ashish anand [mailto:ashisha@india.infogain.com]
Sent: vrijdag 14 september 2001 6:50
To: Goddeeris Frederic; linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address" vs "Physical"
Importance: High



> I have been working on a PPC platform, running Linux 2.2. This platform
has
> a register where you can enable different options and where you can
control
> several LED's. The vendor mentions that this register is mapped in memory
at
> FA400000.
>
> When I write (in a driver)
>
> char *p=0xFA40000;
>
> *p = ..; (I know I should use writeb to be more portable.)
>
> it seems to work; the leds can be manipulated. But as FA400000 is a
physical
> address, I thought that it had to be *p=__va(0xFA40000);
>
> Who can help me out? Where do I find a nice document about this?

actually when you refer to adress mentioned 0xFA400000 in driver this
address is already virtual adress hence no need to  use __va macro.
this address was originally a physical adress and unaccessible from device
untill earlier in code
a call for ioremap would have taken place.
after ioremapping it is a virtual address and can be used nicely in a
driver.
transaction for this address would be valid as processor has now a entry for
it and would be decoded by host bridge and forwarded to LED.
without ioremapping if you use you will get a kernel panic.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
