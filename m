Date: Thu, 7 Sep 2000 16:06:25 +0200 (MEST)
From: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SPI Port on the MPCXX / microcode patches
Message-ID: <Pine.LNX.4.21.0009071605380.11678-100000@odoaker.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I was wondering if you had any success getting Ethernet and the SPI
> port working together.

On my 860 I now have SPI working in loopback mode. The real SPI traffic
will be tested in the next days when I have put together my external
hardware...

> I am also using I2C.  Did you end up using the microcode patch or
> swapping between I2C and SPI, or some other method.

My understanding of that microcode/relocation stuff is as follows,
ANYBODY PLEASE CORRECT ME IF ANYTHING IS WRONG HERE:

When using Ethernet on SCC1, it's not possible to use I2C without a patch
because extended SCC1 parameters overlay I2C parameter RAM area. However,
SPI parameter RAM should not be affected. So it should be possible to use
Ethernet on SCC1 and SPI together without the patch.

When applying one of these microcode patches, depending on the setting of
the 4 risc controller trap registers relocation is activated for SPI
and/or I2C parameter RAM. The meaning of the values in these registers is
unclear to me. However, RCTR1/RCTR2 affect SPI parameter RAM relocation
and RCTR3/RCTR4 affect I2C parameter RAM relocation. I would be glad to
have more information here. I assumed that 0 in these trap registers means
that CP does not relocate the areas.

Otherwise (when relocation takes place) the CP looks in the I2C's/SPI's
RPBASE registers for the start address of their relocated parameter RAM
areas instead of using 0x3c80 and 0x3d80. Programmers can decide where to
put the relocated parameter RAM.

In my case, I use a MBX board. The EPPCbug Firmware does the following
steps (regarding this stuff) after reset: It ...

... loads a microcode patch into parameter RAM
... writes 0x1cc0 to I2C's RPBASE register, 0 to SPI's RPBASE register
... writes 0x802a to RCTR1 and 0x8028 to RCTR2 to activate SPI relocation
... writes 0x802e to RCTR3 and 0x802c to RCTR4 to activate I2C relocation
... writes 1 to register RCCR to enable microcode execution

Booting my kernel (compiled without the microcode patch option enabled)
all these parameters are left untouched. So I was left with a
configuration that relocated SPI parameter RAM to the beginning of the
DPRAM what should be a prohibited area because microcode is located there.
Not knowing about this relocation stuff, I had a hard time searching for
non-existent faults in my SPI initialisation code.

Finally, using default SPI parameter RAM location I tried two methods to
get it working:

* clear RCTR1/2 - disabling only SPI relocation
or
* clear RCCR[ERAM] - disabling microcode execution at all

Both methods worked for me. I first applied them together to be on the
safe side but seams to be not necessary.

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
