Message-ID: <3D3E597E.9050305@sysgo.de>
Date: Wed, 24 Jul 2002 09:38:38 +0200
From: Pavel Bartusek <pba@sysgo.de>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MDIO clock speed computation
References: <2702075D4DE2B043BF5EB82E9CFAD45B093B12@mail1.mediatrix.com>
Content-Type: multipart/mixed;
 boundary="------------080400020805010109070500"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080400020805010109070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jean-Denis Boyer wrote:

>>Will this work for all cases? :
>>
>>((((bd->bi_intfreq + 4999999) / 2500000) / 2 ) & 0x3F ) << 1;
>>
>
>I hope so ;-)
>
Because hoping is not enough, I wrote a little brute force program for testing (see attachment).
The algorithm above is OK :-) It produces MDIO frequencies from 1.875MHz to 2.5 MHz.

BTW: Wolfgang, similar problem is in the PPCboot.

----------------------------------------------------------------------
|                          Pavel Bartusek                            |
|                                                                    |
| Sysgo RTS GmbH,                     phone: +49 (0) 6136 9948-722   |
| Am Pfaffenstein 14                  fax:   +49 (0) 6136 9948-10    |
| D-55270 Klein-Winternheim           email: pba@sysgo.de            |
| Germany                                                            |
|                                                                    |
|       http://www.sysgo.de           http://www.elinos.com          |
|                                                                    |
----------------------------------------------------------------------



--------------080400020805010109070500
Content-Type: text/plain;
 name="fec_speed.test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec_speed.test.c"

#include <stdio.h>
#include <limits.h>

#define ALGORITHM ((((bi_intfreq + 4999999) / 2500000) / 2 ) & 0x3F ) << 1

int main(void)
{
unsigned long bi_intfreq, mdio_clock_min=INT_MAX, mdio_clock_max=0, mii_speed,mii_speed_reg;

for(bi_intfreq=10000000; bi_intfreq<200000000; bi_intfreq++) {
 mii_speed_reg = ALGORITHM;
 mii_speed = bi_intfreq / (mii_speed_reg & ~1);
 if (mii_speed > mdio_clock_max) mdio_clock_max = mii_speed;
 if (mii_speed < mdio_clock_min) mdio_clock_min = mii_speed;
}
 printf("MDIO clocks are from %ldHz to %ldHz\n",mdio_clock_min,mdio_clock_max);
}

--------------080400020805010109070500--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
