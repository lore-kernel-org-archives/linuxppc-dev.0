Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093B11@mail1.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: Pavel Bartusek <pba@sysgo.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MDIO clock speed computation
Date: Tue, 23 Jul 2002 11:47:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> try this (since the problem is the divisor register truncation):
>
> (((((bd->bi_intfreq + 500000) / 2500000) + 1) / 2 ) & 0x3F ) << 1;

This is bad :-(
With a frequency of 46.5MHz, you get a MII clock of 2.58MHz.

Why adding 500000 (0.5MHz) to the internal clock in this computation?
We usually do that to round up (or down) to the nearest integer.
But we do NOT want to round down, or the divisor (MII_SPEED) will be too
low.
We want to round up to the nearest integer when divided by 2*2.5MHz.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
