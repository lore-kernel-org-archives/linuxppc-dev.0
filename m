Subject: Re: Linux, I2C_RDWR, stop conditions
From: Albert ARIBAUD <albert.aribaud@free.fr>
To: Albert ARIBAUD <albert.aribaud@free.fr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1056889496.2747.53.camel@lilith.aribaud.fr>
References: <1056889496.2747.53.camel@lilith.aribaud.fr>
Content-Type: text/plain; charset=ISO-8859-15
Date: 30 Jun 2003 13:05:31 +0200
Message-Id: <1056971137.2468.12.camel@lilith.aribaud.fr>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Replying to myself:

Le dim 29/06/2003 à 14:24, Albert ARIBAUD a écrit :
>
> I am experiencing an annoying I2C problem, using ELDK 2.0.2 and its 2.4
> kernel, while trying to read an I2C 24C128 eeprom. Its read sequence is
> composed as follows :
> - start condition, slave write of two bytes : high then low part of adr.
> - start condition, slave read of up to 64 bytes.
> - stop condition.
> (notice no stop condition in between: this is a double start).
>
> Using either the r360 adapter or the rpx adapter, I tried a cyclic read
> with a while-loop at shell level calling a C program doing the eeprom
> read. This works between a couple and several hundred reads, then stops
> with te following condition : the data read part fails with a short read
> of 1, and from then on i2c transfers find a low SDA.
>
> This looked like chip errata CPM6.I2C (single-byte buffer after failed
> transaction) and CPM7.I2C (I2C receiver locks holding SDA low), however:
> - I use an MPC855T mask rev D.4 which claims all I2C errata fixed;
> - the previous write shows no sign of having failed (so no CPM6.I2C)
> - I have PDIV=00 and FLT=1, so it would rule out CPM7.I2C.
>
> This not an I2C/SPI relocation case either, since SCC1 is used as an
> UART and SCC2 does not exist in the 855T.
>
> However, I have checked i2c drivers in the following code:
> - Linux kernel 2.4.4 provided with ELDK 2.0.2;
> - linux-2.4 CVS from Denx;
> - i2c package v2.7.0 from lm_sensors.
> All versions share the following characteristic in the the I2C_RDWR
> ioctl implementation: i2c-algo-8xx simply concatenates i2c reads and
> writes (thus ending each individual transfer with a stop condition),
> while i2c-algo-pcf and i2c-algo-bit do not send stop conditions until
> after the last transfer.
>
> Am I right in thinking that the correct I2C_RDWD behaviour is that of
> pcf and bit-banging, and that the 8xx implementation is wrong in this
> respect?
>
> And would it explain the behaviour I see with the 24C128 eeprom?
>
> Thanks in advance,
>
> Albert.
I have implemented a more correctly-behaving, albeit badly-styled,
solution by heavily patching i2c-algo-8xx.c and i2c-rpx.c. Miracle : the
eeprom that I could not write to suddenly works like a charm, and reads
seem not to break anymore. Hurray!

Well, to be honest, I have a small quirk left (wouldn't be fun if it all
worked OK, would it?): when doing an i2c read, I sometimes get TXE set
in I2CER along with the expected RXB. However, the data was read
correctly, as far as I can tell. I'll run a check (zero-fill the receive
buffer before starting the I2C exchange.

Broadly, my solution prepares as many Tx and Rx buffers as required to
realize the whole exchange in a single run. This effectively makes the
I2C_RDWR ioctl work as expected.

I expect few people were using I2C_RDWR with double-start sequences,
since they would have failed :), but anyone simply interested in i2c on
the MPC8xx may have a look at the code and try it; I would like to know
if this approach is a good candidate for a patch submission, both to
lm_sensors and the linux ppc kernel, so a little regression testing
would only be fair. :)

Note, however, that my solution is currently a bit lavish with
allocating Rx and Tx BDs; before considering a patch, I will change it
so that it creates Rx/TxBD templates in kmalloc()ed memory, and 'hot
swap' them in real time into the 2 Rx and 2 Tx BDs currently allocated
in i2c-rpx.c.

All the best,

Albert, simply happy to be able to write to an i2c eeprom. :)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
