Date: Mon, 29 Apr 2002 14:40:53 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH]IBM OCP I2C
Message-ID: <20020429144053.B6106@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is incremental to the other patches I posted. It gets the
iic_xfer that is based of the ppcboot code working. The return
values are still not correct but the data is transfered ok for
what I have tested. I do not try to do a Repeated Start for
anything yet either.

If anyone has any comments or more test conditions I would like
to hear them.

I pulled some defines from the PPCBoot code and I am not sure the
correct header file for them.

I would like to dump the iic_outb/inb as well. In the iic_xfer I
use readb/writeb directly without problems.

I put this comment in there about the driver. Does any see anything
wrong with this?
/*
 * Limits of the IBM OCP I2C driver.
 * There is no way to do lenght 0 transfers since iic->cntl TCT==00 means 1 byte
 * We can not handle I2C_M_NOSTART since there is no way to put just one bit
 * on the bus after a NA.
 * We can not handle I2C_M_REV_DIR_ADDR since the Rd/Wr bit is not
 * set directly in the address register and the controller uses the
 * Rd/Wr bit in the CNTL reg to know what to do.
 *
 * If you need to get around any of these I suggest you setup i2c-adap-ibm...
 * to use the algo-bit and provide functions to use the DirectControl Reg of
 * the IBM OCP hardware.
 */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
