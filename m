Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D859E67A41
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 04:00:39 +1100 (EST)
Subject: Re: new sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1143020119.11724.41.camel@localhost>
References: <1143020119.11724.41.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+qAgw57I6hFLcJcYjblk"
Date: Thu, 23 Mar 2006 18:00:31 +0100
Message-Id: <1143133231.8395.12.camel@localhost>
Mime-Version: 1.0
Cc: Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+qAgw57I6hFLcJcYjblk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Obviously, I'm still collecting information. For future reference and
archiving, here's the contents of a file I just added to my code
describing how apple derives i2s clocks. Well, as far as I can see from
their code.=20

Short description of the i2s clock derivation system Apple uses.


The i2s chip Apple uses has three available clocks: 18432000, 45158400 and
49152000 Hz. These are used to drive the codec's system clock as well as th=
e
i2s transfer bus.

The clocks for these are derived as follows:
First, you need to know the sampling frequency you want to use, and the
system clock the codec requires. The pcm3052 (onyx) for example requires a
system clock of 256*sampling frequency.

Thus, you divide the clock source speed by the sampling frequency and then
the factor the codec chip requires. This is the 'mclk divisor'.
Now you can derive the system clock from the clock source by taking only
every 'mclk divisor' transition of the clock, and thus you get a system
clock of the required speed.

Next, you need to know the i2s bus speed wrt. the sampling frequency. For
Sony and I2S 32x serial formats, this is 32*sampling frequency, for the I2S
64x format it is 64*sampling frequency. Since the i2s wire clock is derived
from the system clock we have already derived from the clock source, you
need to put as 'sclk divisor' the factor between the system clock of the
codec and the bus clock, for example 256/32 (=3D8) if the codec is driven i=
n
Sony mode.

For the 'sclk divisor' you have to take care that it is an even number or 1
or 3, other values cannot be represented to the i2s chip (see logic in
i2sbus.h).


With a codec system clock (MClk) of 256*sampling frequency, you can have th=
e
following frequencies (in the range from 8KHz to 96KHz) depending on the
clock source you use:
18432000: 9000 12000 14400 18000 24000 36000 72000
45158400: 8820 9800 11025 12600 14700 17640 22050 29400 35280 44100 58800 8=
8200
49152000: 8000 9600 12000 16000 19200 24000 32000 38400 48000 64000 96000
(this is exactly what we can do with the onyx chip)

to create this table use calc (debian package apcalc):
min=3D8000
max=3D96000
clock=3D49152000
factor=3D256
for (f=3Dmin;f<=3Dmax;f++) {
  if ((clock%f=3D=3D0) && ((clock/f)%factor =3D=3D 0)) {
    div =3D clock/f/factor ;
    n =3D ceil(div/2-1) ;
    if ((div=3D=3D1||div=3D=3D3||div=3D=3D5||div=3D=3D14||(2*(n+1)=3D=3Ddiv=
 && n<0x1f))
       && (1))
      print f,
  }
}
print ''


--=-+qAgw57I6hFLcJcYjblk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCLULqVg1VMiehFYAQIFKw/+IIP1CY6KTILqBWF1JdN1Eb82K/FNDwhu
2uBZm+Fd/Ga0vQ5BXJo14aVOoH6IZeMSdWgdSqKcWXqEO/q34nD8NExUiDWC8uua
ZskaDpDABHZb/usTV2Qzj9eT7CAL6Qcc85nO0koj23V7gNwoSCDid8M7H+4XoGhj
YtGaEdOxQOCyeJrZSun380bfQATWNq69v1ALzTfKxO13x28WrmpvfS/KnDfDrZ3e
onzfVPADOWGK63DrhXOu4GKBZJWn5wjQ7m4VBexHL59YcNTNSAtT+Z9e/Hsb/Q7a
/Pt71XttEACARip34ER8iRUA2sSUzY0hqPyMFAfPKcVaOE7huRg91Y0k4/PylvgB
usIHfemB97NnOvnRJdJ1ElTQSwV6J+dkiQIGgByHDc0cyluH7iSEkwUkBNckvgWK
jlkcBb8EdaAjoHVE0qryZMIyD2olmSrQo7FvdOvAxIbYJ/t52KHryH5dY8b/1l5G
7xUxvd8ZpfixALZo4k2I+8Q+4pMOg9uXofFZ+VGsVWtcRj0aYNQb22w1IXHUPZa8
3qwbSjabeLVgat2lmeY0zT6iaiZq8CMUQ0G84zbVyUHqGjTqM6ty7uudgPt2b8X/
6NRftQ4YeaLYYj2uYAAEF5FPowCh9CCXcq28zKOUUtLnoV6qH/em0aq3KghKCvZE
iHE6qYpWXAY=
=YW9v
-----END PGP SIGNATURE-----

--=-+qAgw57I6hFLcJcYjblk--
