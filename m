Return-Path: <ncaruso@irobot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Mar 2005 11:58:14 -0500
Message-ID: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
From: "Caruso, Nick" <ncaruso@irobot.com>
To: <linuxppc-embedded@ozlabs.com>
Subject: Question regarding Interrupt "delivery" to user mode process
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Note that "delivery" is in quotes - I don't mean to actually deliver an
interrupt, but rather to wake the process when the interrupt occurs.

This is a broad question, but I'm hoping someone out there with real
experience in this area can comment on a design idea we're kicking
around.
If there's a better mailing list for asking this type of question,
please tell me!

We are building a device with an MPC5200 processor which needs to detect
incoming pulses at a 13 mSec rate.  We've got this incoming pulse wired
to an IRQ on the MPC5200 and we now need a method for detecting these
interrupts in a user mode process.

The design we're contemplating is a small character device driver in the
kernel that will allow a user mode process to perform a blocking read on
a file descriptor, and return from the read call whenever an interrupt
occurs. =20

We're not concerned (for the moment) with missing interrupts - we think
we can service them fast enough (we just need to record a
chronometer-type timestamp for some other incoming (serial) data).

Does this sound like a workable approach?  Does anyone know of a better
way?  My implementation plan is to derive something from the 3rd edition
Linux Device Drivers book "scull-pipe" device driver.

Any comments or suggestions would be greatly appreciated.

    thanks and best regards,
       Nick Caruso
