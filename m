Message-ID: <00933BFA237CD2119B3400409543582704A290@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: [i2c] Do I need ucode relocation patch?
Date: Mon, 4 Dec 2000 19:29:44 -0000 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Monday, December 04, 2000 5:15 PM you wrote:

> I'm using SCC1 as ethernet and SMC1 as ttyS0.
>
> Do I need ucode relocation patch to work with i2c bus?

Yes. This is because the size of the parameter area for SCC1 ethernet is
bigger than the area allocated it, so they overlap the usual I2C
parameter area. (There is a similar conflict between SCC2 ethernet and
SPI.) The relocation patch moves the I2C and SPI parameters to a new
parameter area.

Be aware that the CPM I2C commands for initializing RX and TX buffer
parameters, etc. do not work when using the relocation patch.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
