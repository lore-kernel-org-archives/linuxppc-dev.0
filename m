Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 760F6679F4
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 02:16:09 +1000 (EST)
Received: from [84.135.205.239] (helo=johannes.berg)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.61) (envelope-from <johannes@sipsolutions.net>)
	id 1Fh7dv-0005Hy-9h
	for linuxppc-dev@ozlabs.org; Fri, 19 May 2006 17:15:59 +0100
Subject: [RFC] snd-aoa and interrupts (headphone detection etc)
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DShkcKawPC72vVfs63sq"
Date: Fri, 19 May 2006 18:15:59 +0200
Message-Id: <1148055359.6228.20.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-DShkcKawPC72vVfs63sq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

I thought about this a bit, but I'm not sure what the right way to
handle this is. First, I guess an introduction is on order about how the
fabrics and codecs currently work together.

As codecs can have arbitrary inputs and outputs, we have to keep this
generic enough. The tas for example has one analog output, and two
analog inputs (line-in and microphone). The analog output it has is
connected to the amps and then you can select where you want to hear
sound (possibly line-out, headphone, speakers) by controlling the amps
via the GPIOs.
On the other hand, the onyx for example has digital and analog output
along with two analog inputs. Instead of limiting myself to any fixed
items I decided to keep this generic. I probably should change this to
introduce fixed bits for various items though.

Anyway, the fabric has the hardcoded list of how things are hooked up,
and then creates a bitmap of which in/outputs of a codec are connected
and gives this bitmap to the codec driver which creates the appropriate
controls if applicable. This is currently only implemented properly for
the Onyx chip though.

Now, in- and output detection comes into play. The interrupt is always
generated via GPIOs.

Headphone detection is easy: We make the fabric register the interrupt
via the GPIO layer and when we get an interrupt we actually simply do
whatever the user wanted (this ought to be controllable).

The problematic part is things that the codec must control. Say we want
line-in detection to automatically switch to line-in if microphone is
selected (does anyone ever want this?). Then the problem is that the
interrupt arrives at the GPIO layer, and I can easily make it seen in
the fabric too. However, then propagating it to the codec is a bit
harder. Or we don't have it in the fabric but have the codec register
for that interrupt (through our GPIO layer). This is the first option.

The second option is changing the whole in-/output control code that we
have and moving it from the codec to the fabric layer. The fabric
already knows what in- and outputs a codec has (in order to know what is
connected), hence if we added a codec driver function to turn on/off any
in- or output we could have the fabric control this. But then we'd also
have to make known to the codec which of those are mutually exclusive,
and generally make it more complicated.

I currently favour the first option, the codec driver can know when it
makes sense to try registering the interrupt (if it isn't present it
fails anyway) and then do the appropriate stuff (possibly giving the
user a choice).

Comments?
johannes

--=-DShkcKawPC72vVfs63sq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3vPKVg1VMiehFYAQIB4A//cAArt4j9eK4D/UpXlEPFtx/1EDeJk2Wn
DHSwjr4j1aZtyphSOSzrXuyqLD41QZu5V1ydakFZ2/2zPqzbv+0HgI5pGiQ4JU7i
xzjt3J08SlpjPj9BiPh1FRg/KKX9UslePwTYOgDgbcAzK+Glkos+KrBKmW6a2VAp
83o5AZ8B6Sq0femgXG0o+8eH0ir0mt00oWGtRd2pyng5mUnd5s20ym60KZx6hCvS
I+LrGbRpEXOIu2qSMsRKR4gu0UizMbYSFnjsy1srtRbF0H9KYHTJDQSfCDjb4/EE
ZH/odKBDbe0BecE7/ZiVRozAeARaqNObqc5MtZaVUCG2sodo94GLtb/R0XKpC/gh
uooglwGa5NG4+eDxAdMcpSgnsscksAP2KqCKo5/BHR84yqxC8J9M/cJwZMZjlOx4
CtgXl4d0KVWkCwPpDkypnCmsn1Ln+g1eTZze2ovZX3TEmud+duAb7Zt6URF8gM3/
vD2Xe/vHq0kpxEvD3u1X6NzQP3b8jdmQ5YGQ4Ee2B+6OYXj4511pX/Kr9gbywFh1
L7KoebyhESh5qQ6sg6XV598ADcFvtbSyNHGIBi3TrN5xwQHKoRWZTCwTviPuMQeS
9jg0pTCaDaJe2CIBZdqt7p7shqJWVBy2UI1MezbGHGFm3qm3z+uzF6mqzecKE0Nc
k2I0rphzTlg=
=tnvI
-----END PGP SIGNATURE-----

--=-DShkcKawPC72vVfs63sq--
