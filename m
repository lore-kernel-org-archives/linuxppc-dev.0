Message-ID: <C08678384BE7D311B4D70004ACA371050B7635EA@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC857T FEC/MII failure
Date: Wed, 4 Sep 2002 11:01:07 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

This one is for the archives.  I resolved the problem a
few weeks ago; if any in the future finds my original
posting, I would like them to find the resolution as well.

Before:

My FEC code (in our debug monitor, not in Linux) set the
FEC's MII_SPEED register as appropriate to give approximately
a 1.24 MHz MDC.  It left MII_DATA uninitialized.  Thus, the
MDC was always running, and my MII_read() and MII_write()
functions would just write the MII_DATA register in order to
do the MII transaction.  This did not work, as my previous
posting described.

After:

My FEC-init code now sets MII_SPEED to 0 and MII_DATA to
0xffffffff.  My MII_read() and MII_write() routines
do the following:

*	Write the FEC's MII_SPEED register to non-zero
*	Write the FEC's MII_DATA register
*	Read back MII_DATA, if doing a read operation
*	Write the FEC's MII_SPEED register to zero

Thus, the MDC now runs only during a transaction, then
gets turned off again.  & now, I can read and write
the PHY's MII registers just fine.



-----Original Message-----
>From: Kerl, John [mailto:John.Kerl@avnet.com]
Sent: Thursday, August 22, 2002 1:13 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: MPC857T FEC/MII failure



Hello,

I am experiencing a problem with the MPC857T FEC's MII interface.

I want to read MII registers for our PHY (ID 24 on our board).  Per the
MPC857T
manual:

*	I write 0x36 to MII_SPEED (IMMR + 0xe84).  An oscilloscope probe
	on the PHY's MDC pin reveals a 1.235 MHz rate, within spec.

*	I write 0x6c060000 to MII_DATA (IMMR + 0xe80).
	This is:

	-	ST=01
	-	OP=10
	-	ID=11000
	-	REG=00001
	-	TA=10

The data read back in the second 16 bits of MII_DATA are always 0xffff.
This is
in fact regardless of the PHY ID (I've tried all 32) or register (I've tried
all 32).
There are two concomitant symptoms:

*	If I put oscilloscope probes on the PHY's MDC and MDIO pins, then
look
	at the MDIO pin's values at the rising edges of MDC, I see that the
FEC
	has actually written the following:

	-	ST=01
	-	OP=10
	-	ID=11000
	-	REG=00001
	-	TA=11

	which is *not* what I asked it to do.

*	If I read back the MII_DATA register, *even though* I wrote
0x6c060000,
	I read back the value 0x6c07ffff.  Note that the second 6 is now a
	7.

In short, I formulate a compliant request (TA=10), then the FEC mangles it
(TA=11) and drives that out.  It is no wonder the PHY doesn't respond.

This problem is observable in our debug monitor using simple peek and poke.
Thus, this is more of a PPC question than a Linux question.

Has anyone seen anything similar?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
