Date: Thu, 8 May 2003 22:04:03 +0300 (IDT)
From: Eitan Rabin <rabin@mellanox.co.il>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 and I2C
Message-ID: <506C3D7B14CDD411A52C00025558DED603018B6A-100000@mtlex01.yok.mtl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm trying to use the MPC I2C controller to generate I2C transactions. I
use  the devel kernel version and include the I2C relocation patch (seen
in /var/log/messages).

I used the standard I2C driver and also tried the driver downloaded
directly from lmsensors.

The problem occurs when I activate the master. As soon as I give the
master the start command (i2c->i2c_i2com = 0x80) for the DMA transaction
to start the CPU complete freezes.
I narrowed the problem and found out the it is actually the address of the
descriptor the one causing the CPU to hang. If I give addresses that are
relatively small, few Kilos, then everything is OK. If I give addresses
that are given to me by kmalloc and translated properly then the cpu
hangs.

It seems to me that maybe something is wrong with the SDMA
configuration.

The cards I'm using are CLLF from embedded planet.


Any assistance will be highly appreciated.

Thanks.

Eitan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
