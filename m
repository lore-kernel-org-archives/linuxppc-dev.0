Subject: RE: BogoMIPS on 8xx vs 82xx
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 24 Mar 2003 13:03:44 -0500
Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B093BE1@mail1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: "Wojciech Kromer" <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The ppc function used in calibration is __delay.
It is located in arch/ppc/kernel/misc.S.
It uses instruction bdnz, looping on itself.
On 860, it takes 2 cycles per bdnz.
On 8260, it takes 3 cycles per bdnz.
I guess it is because both CPUs have different pipelines.
The result is later multiplied by 2 prior to be displayed,
around line 197 in init/main.c.
This is why it gives 1BogoMips = 1MHz on 860.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

> -----Original Message-----
> From: Wojciech Kromer [mailto:krom@dgt-lab.com.pl]
> Sent: 24 mars, 2003 02:17
> To: Linuxppc-Embedded (E-mail)
> Subject: BogoMIPS on 8xx vs 82xx
>
>
>
> On 8xx running 50 MHz gives ~ 50 BogoMIPS, runnig 65 gives
> approx 65 and
> so on, close to linear...
> but on 8250 running core 266Mhz  (66 on bus, 133 cpm) i get only
> 175BogoMIPS. Why???

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
