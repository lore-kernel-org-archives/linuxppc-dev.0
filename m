Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D87@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx pcmcia cardmgr problem
Date: Thu, 18 Sep 2003 08:42:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Tom,

I did search on google but found no patch againt airo.c for 2.4.18. Anything
you or anybody else aware of?

Thanks for help.

Lokesh

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Wednesday, September 17, 2003 3:56 PM
To: Lokesh Kumar
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: mpc8xx pcmcia cardmgr problem


On Wed, Sep 17, 2003 at 03:47:59PM -0400, Lokesh Kumar wrote:
>
> Hi Guys,
>
> I am trying to bring pcmcia up on my mpc855 based board. I am using
> kernel-2.4.18 and have pcmcia extensions.
>
> I am making pcmcia as module, so  I can insmod pcmcia_core and m8xx_pcmcia
> and ds. When I insert the card and start cardmgr, this is what I get.
>
>
> Starting PCMCIA services: cardmgr[79]: watching 2 sockets
> done.
> cardmgr[80]: starting, version is 3.2.5
> cardmgr[80]: socket 1: 350 Series Wireless LAN Adapter
> # insmod: insmod: char-major-4: no module by that name found
> cardmgr[80]: executing: 'modprobe airo'
> cardmgr[80]: + Using
/lib/modules/2.4.18/kernel/drivers/net/wireless/airo.o
> cardmgr[80]: executing: 'modprobe airo_cs '
> cardmgr[80]: + Using
> /lib/modules/2.4.18/kernel/drivers/net/wireless/airo_cs.o
> m8xx_pcmcia: voltage_set slot=B, vcc=5, vpp=5
>  <7>m8xx_pcmcia: Service(1, 4, 0xc1e9180c)
> m8xx_pcmcia: WRX voltage_set slot=B, vcc=5, vpp=5
>  <7>m8xx_pcmcia: Service(1, 8, 0xc1e91870)
> Kernel panic: request_irq
>  <0>Rebooting in 180 seconds..
>
> What am I missing here?? why is it trying to insmod char-major-4?? and why
> does the kernel panic??

The kernel panics because in 2.4.18 a call to request_irq() would simply
panic.  If you hit google, you can probably find a patch to airo.c to
make it use request_8xxirq() and 'work', or if you update to 2.4.21 (or
was it 2.4.20, I forget now), this is not an issue.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
