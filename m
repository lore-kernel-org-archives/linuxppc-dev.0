Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <404E51E7.4070909@iti.fi>
Date: Wed, 10 Mar 2004 01:23:19 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPX8xx: MMC over SPI....
References: <20040309152515.A912DC0655@atlas.denx.de>
In-Reply-To: <20040309152515.A912DC0655@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>>I am going to write a SPI driver and on top of that a MMC driver for linux for
>>the MPC852T, unless there is something already out there.
>>Anyone tried this before and has some sources to share? Or pointers to
>>sources?
>>
>>
I am just doing same thing for mpc5200 ( http://www.iti.fi/iti5200.php )
board.
In this board there is MMC connector connected to PSC

>
>The SPI driver is there, but I don't recommend to use it for any type
>of data transfers that require any  significant  bandwidth.  Motorola
>writes:
>
>
There is simple spi driver arch/ppc/8260_io/cpm_spi.c but i think that
one like
i2c subsystem will be much more usefull. I have been planning make one based
on i2c driver.

I am plannigg 3-layer model like in i2c or USB. interface-HW-driver in
lowest level,
then subsystem driver and then target HW driver. Like in this case
PSC_SPI-> SPI_subsystem->MMC  ---->FS

>        The SPI was not designed to be a high-bandwidth channel. It
>        can run very quickly for bursts of up to 16-bits. But the
>        peripheral has no FIFO and low priority in the MPC860 and
>        thus you cannot burst lots of data quickly through the
>        interface.
>        ...
>        Note that the SPI is of lower priority internally than the
>        SCCs, thus, the SPI will be the first device to be "starved".
>        Since it has no FIFO, it is especially sensitive to underruns.
>        The best way to prevent this is to use a buffer size of 1
>        "character" (of size programmed in the mode register).
>        ...
>
>
>
There is same problem in mpc5200 SPI and for this reason i am planning to
use PSC in SPI mode. Then i will have fifo etc. I am also considering to
use bestcom DMA. I just have heard that there is lot of problems with it
when used with I2S. What is actually causing the problems ?
Bestcom API library ? Should it be better to use directly bestcom HW
without library ?

>Also, you should be aware that the SPI  protocol  is  implemented  as
>microcode  running  on the CPM, so any high-speed data transfers will
>suck up CPM performance.
>
>

Of cource it does not give best performance but it is also wery simple
glueless
interface to cheap small low cost mass media. If we like to have full fast
MMC/SD interface then we should consider some FPGA implementation
but in most cases simpler will give enough proformace.

Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
