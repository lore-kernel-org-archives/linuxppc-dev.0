Date: Thu, 8 May 2003 22:20:44 +0300 (IDT)
From: Eitan Rabin <rabin@mellanox.co.il>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC860 and I2C
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C0840@ORION>
Message-ID: <506C3D7B14CDD411A52C00025558DED6030191E8-100000@mtlex01.yok.mtl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The version of CPU I has requires the patch to solve the conflict  between
the ram parameters of I2C/SPI and those of Ethernet. I checked my version
against the errata at Motorola's website and it is required.

If I don't use the relocation then the command has not effect. If I use the
patch then there are i2c transaction being generated but I can only use
certain addresses.

Any advice will be appreciated.

Thanks.

Eitan






On Thu, 8 May 2003, Steven Blakeslee wrote:

> Are you sure you need to use the relocation patch?
>
> -----Original Message-----
> From: Eitan Rabin [mailto:rabin@mellanox.co.il]
> Sent: Thursday, May 08, 2003 3:04 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: MPC860 and I2C
>
>
>
> Hi All,
>
> I'm trying to use the MPC I2C controller to generate I2C transactions. I
> use  the devel kernel version and include the I2C relocation patch (seen
> in /var/log/messages).
>
> I used the standard I2C driver and also tried the driver downloaded
> directly from lmsensors.
>
> The problem occurs when I activate the master. As soon as I give the
> master the start command (i2c->i2c_i2com = 0x80) for the DMA transaction
> to start the CPU complete freezes.
> I narrowed the problem and found out the it is actually the address of the
> descriptor the one causing the CPU to hang. If I give addresses that are
> relatively small, few Kilos, then everything is OK. If I give addresses
> that are given to me by kmalloc and translated properly then the cpu
> hangs.
>
> It seems to me that maybe something is wrong with the SDMA
> configuration.
>
> The cards I'm using are CLLF from embedded planet.
>
>
> Any assistance will be highly appreciated.
>
> Thanks.
>
> Eitan.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
