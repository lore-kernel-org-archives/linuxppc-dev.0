Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B0D@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Pavel Bartusek'" <pba@sysgo.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MDIO clock speed computation
Date: Mon, 22 Jul 2002 14:19:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel,

You have found a interesting problem in the calculation of the MII_SPEED.
And it seems to be there since a long time!

However, your fix seems incomplete.
If I have a frequency of 82,5MHz, for example,
it yields exactly to the same result before and after your patch,
that is an MDIO clock of 2.58MHz.

Since the divisor is 2 * MDCLOCK,
I would suggest something like:

  (((bd->bi_intfreq + (2 * 2500000 - 1 )) / 2500000 / 2) & 0x3F) << 1;

Regards,

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
