Message-ID: <00933BFA237CD2119B3400409543582704A282@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: I2C problems
Date: Wed, 8 Nov 2000 15:38:51 -0000 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

I've been working on a 'Simon Vogl' type I2C driver for MPC8xx (i.e. the
new I2C interface in the 2.4.0 kernels) based on the work by Dan Malek,
Kim Jorgensen and Dan Winkler.

My driver only works in master mode. So far I have only been testing it
with simple write and read transfers of one or more bytes involving a
single tx buffer for a write, or a single tx buffer plus a single rx
buffer for a read.

I am using a revision A MPC823 without a microcode patch (because
Ethernet is on SCC2, and SPI is not used).

My tests start to fail if I try a read transfer from a non-existant
slave address. As expected, this results in the BD_SC_NAK bit being set
in the tx bd. After this, write transfers to a valid slave address still
work okay until I try a read transfer of three or more bytes from a
valid slave address - I get an interrupt (busy condition - a single byte
of many has been read into the rx buffer) but the tx bd is still marked
as ready. (If the read transfer is for two bytes I get a busy condition
interrupt and a single byte in the rx buffer, but the tx bd is not
marked as ready. For a read transfer of one byte, all is well.)

Once I hit the case of the tx bd still marked ready (for the read
transfer of three or more bytes), all further read or write transfers
fail with an interrupt timeout and with the tx bd still marked ready.

This seems to match the MPC823 DEVICE ERRATA (REV. A) bug CPM4 (I2C
Receives Single-Byte Buffers After Failed Transaction), but the given
workaround (disabling and re-enabling the channel in the I2MOD register)
does not seem to work in this case. (It does work if the only
transfers to/from non-existent slaves are write transfers.)

To summarize the above behaviour for the case of a master read transfer
from a non-existent slave, followed some time later by a master read
transfer of n bytes from a valid slave:

* If n is 1 there is no problem.
* If n is 2 only 1 byte is placed in the buffer and there is a 'busy
  condition' interrupt.
* In n is 3 or more, only 1 byte is placed in the buffer, there is a
  'busy condition' interrupt, the tx bd is still marked ready, and all
  further read or write transfers fail with an interrupt timeout and
  the tx bd still marked ready (and rx bd still marked empty).

All my attempts to bring the I2C back to life when it has gone wrong in
this way have been unsuccessful, including issuing a CLOSE RX BD command
to the I2C channel, issuing an INIT TX and RX PARAMS, and setting up the
IIC parameter RAM again "manually". I've even tried playing with dual rx
buffers but things are just as bad.

I do of course use the usual workaround of disabling the I2C in the
I2MOD register after each transfer and set I2CER to 0xFF each time.

Has anyone else noticed similar problems recovering proper I2C operation
after a NAK'ed master read transfer, especially on those revisions of
the CPM that haven't had any I2C bug fixes?

--
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>             )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587              )=-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
