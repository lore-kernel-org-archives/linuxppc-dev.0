To: Kate Alhola <kate@iti.fi>
Cc: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPX8xx: MMC over SPI.... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Mar 2004 01:23:19 +0200."
             <404E51E7.4070909@iti.fi>
Date: Wed, 10 Mar 2004 00:59:50 +0100
Message-Id: <20040309235955.BC6B7C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <404E51E7.4070909@iti.fi> you wrote:
>
> There is simple spi driver arch/ppc/8260_io/cpm_spi.c but i think that
> one like
> i2c subsystem will be much more usefull. I have been planning make one based
> on i2c driver.

Arghh.... Why do you think you need all this overhead?

> I am plannigg 3-layer model like in i2c or USB. interface-HW-driver in
> lowest level,
> then subsystem driver and then target HW driver. Like in this case
> PSC_SPI-> SPI_subsystem->MMC  ---->FS

Remember that SPI is always very board-specific. I'm not sure that it
really makes sense to create a special "SPI subsystem"  -  especially
when you use I2C as a model (which IMHO is just a lot of overkill).

> There is same problem in mpc5200 SPI and for this reason i am planning to
> use PSC in SPI mode. Then i will have fifo etc. I am also considering to
> use bestcom DMA. I just have heard that there is lot of problems with it
> when used with I2S. What is actually causing the problems ?

The design of the available (at the moment) bestcomm code.

> Bestcom API library ? Should it be better to use directly bestcom HW
> without library ?

Do yourself a favour and use the official API. Otherwise you will end
up relying on a lot of internal things that may (and will) be cahnged
with the next version of the bestcomm code.

> Of cource it does not give best performance but it is also wery simple
> glueless
> interface to cheap small low cost mass media. If we like to have full fast
> MMC/SD interface then we should consider some FPGA implementation
> but in most cases simpler will give enough proformace.

I don't know your exact application,  but  it  always  gives  me  the
creeps when I read the phrases "mass storage device" and "SPI bus" in
the same sentence. I tend to summarize this as follows:
"mass storage device"  + "SPI bus" = need for redesign :-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
