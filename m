Message-ID: <40530EA4.1070305@iti.fi>
Date: Sat, 13 Mar 2004 15:37:40 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPX8xx: MMC over SPI....
References: <20040309235955.BC6B7C0655@atlas.denx.de>
In-Reply-To: <20040309235955.BC6B7C0655@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <404E51E7.4070909@iti.fi> you wrote:
>
>
>>There is simple spi driver arch/ppc/8260_io/cpm_spi.c but i think that
>>one like
>>i2c subsystem will be much more usefull. I have been planning make one based
>>on i2c driver.
>>
>>
>
>Arghh.... Why do you think you need all this overhead?
>
>
Base idea is just make abstraction layer that allows to use diferent devices
via same SPI with unified programmin interface.

>>I am plannigg 3-layer model like in i2c or USB. interface-HW-driver in
>>lowest level,
>>then subsystem driver and then target HW driver. Like in this case
>>PSC_SPI-> SPI_subsystem->MMC  ---->FS
>>
>>
>
>Remember that SPI is always very board-specific. I'm not sure that it
>really makes sense to create a special "SPI subsystem"  -  especially
>when you use I2C as a model (which IMHO is just a lot of overkill).
>
>
>
Just for that reason i like to create abstraction layed that hides board
specific
things inside. Even the SPI interfaces are board specific, still the SPI
works
basically same way.

I even donn't think that i2c model is overkill. Like in this my
itipower5200 board
there is in base configuration MMC card and then TSC2301 audio codec/
touchscreen ADC / generic ADC chip. To addition there may be other
SPI-interfaced stuff depending of applitation where the board is used.

To application layer there should be MMC visible as disc, touch screen
visible as pointer device, Audio codec as audio device and then
the ADC visible as own device driver. In this audio part. The control
port of this codec is SPI but the actual audio data goes via I2S

So, when there may be even multiple diferent SPI interfaces and many
high level devices that have multiple stantard interfaces and all used
by separate tasks i think that the same type than used in I2S is not
overkill at all.

>>Of cource it does not give best performance but it is also wery simple
>>glueless
>>interface to cheap small low cost mass media. If we like to have full fast
>>MMC/SD interface then we should consider some FPGA implementation
>>but in most cases simpler will give enough proformace.
>>
>>
>
>I don't know your exact application,  but  it  always  gives  me  the
>creeps when I read the phrases "mass storage device" and "SPI bus" in
>the same sentence. I tend to summarize this as follows:
>"mass storage device"  + "SPI bus" = need for redesign :-)
>
>
>
SPI is still stantard mode in MMC cards. The other "native" mode
is also single bit serial mode but it does need extra glue logic.
Also speed is still wery equivalent than USB memories.

The higest performance is
not allways goal. In my board i have two mass device options. CF card
connected to 5200 IDE port CF used in IDE emulation mode and then
MMC connected to SPI and Nand flas as "fixed disc".

MMC is smaal cheap and common. It can be interfaced to about
any processor about null or minimum interface logic.
It is easiest implement as hot-swap removable device becuase
there is just so few signals. I

I still think that MMC has lot of advantages in many applications
but at finally i let user to make choice between them. CF is
choice if non hot swap faster mass memory is needed. MMC or USB
memory is choice if cheap small hot swap memory is needed.



Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
