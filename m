Subject: Linux, I2C_RDWR, stop conditions
From: Albert ARIBAUD <albert.aribaud@free.fr>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 29 Jun 2003 14:24:45 +0200
Message-Id: <1056889496.2747.53.camel@lilith.aribaud.fr>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am experiencing an annoying I2C problem, using ELDK 2.0.2 and its 2.4
kernel, while trying to read an I2C 24C128 eeprom. Its read sequence is
composed as follows :
- start condition, slave write of two bytes : high then low part of adr.
- start condition, slave read of up to 64 bytes.
- stop condition.
(notice no stop condition in between: this is a double start).

Using either the r360 adapter or the rpx adapter, I tried a cyclic read
with a while-loop at shell level calling a C program doing the eeprom
read. This works between a couple and several hundred reads, then stops
with te following condition : the data read part fails with a short read
of 1, and from then on i2c transfers find a low SDA.

This looked like chip errata CPM6.I2C (single-byte buffer after failed
transaction) and CPM7.I2C (I2C receiver locks holding SDA low), however:
- I use an MPC855T mask rev D.4 which claims all I2C errata fixed;
- the previous write shows no sign of having failed (so no CPM6.I2C)
- I have PDIV=00 and FLT=1, so it would rule out CPM7.I2C.

This not an I2C/SPI relocation case either, since SCC1 is used as an
UART and SCC2 does not exist in the 855T.

However, I have checked i2c drivers in the following code:
- Linux kernel 2.4.4 provided with ELDK 2.0.2;
- linux-2.4 CVS from Denx;
- i2c package v2.7.0 from lm_sensors.
All versions share the following characteristic in the the I2C_RDWR
ioctl implementation: i2c-algo-8xx simply concatenates i2c reads and
writes (thus ending each individual transfer with a stop condition),
while i2c-algo-pcf and i2c-algo-bit do not send stop conditions until
after the last transfer.

Am I right in thinking that the correct I2C_RDWD behaviour is that of
pcf and bit-banging, and that the 8xx implementation is wrong in this
respect?

And would it explain the behaviour I see with the 24C128 eeprom?

Thanks in advance,

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
