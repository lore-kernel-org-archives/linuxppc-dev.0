Message-ID: <3BA18C7C.F2D4B343@india.infogain.com>
Date: Fri, 14 Sep 2001 10:20:04 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address"  vs "Physical"
References: <6B546A602AD2D211BFF00008C7A42889041D6BDE@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have been working on a PPC platform, running Linux 2.2. This platform has
> a register where you can enable different options and where you can control
> several LED's. The vendor mentions that this register is mapped in memory at
> FA400000.
>
> When I write (in a driver)
>
> char *p=0xFA40000;
>
> *p = ..; (I know I should use writeb to be more portable.)
>
> it seems to work; the leds can be manipulated. But as FA400000 is a physical
> address, I thought that it had to be *p=__va(0xFA40000);
>
> Who can help me out? Where do I find a nice document about this?

actually when you refer to adress mentioned 0xFA400000 in driver this address is already virtual adress hence no need to  use __va macro.
this address was originally a physical adress and unaccessible from device untill earlier in code
a call for ioremap would have taken place.
after ioremapping it is a virtual address and can be used nicely in a driver.
transaction for this address would be valid as processor has now a entry for it and would be decoded by host bridge and forwarded to LED.
without ioremapping if you use you will get a kernel panic.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
