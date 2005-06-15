Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27DF7679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 23:55:00 +1000 (EST)
Date: Wed, 15 Jun 2005 14:54:34 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Message-Id: <20050615145434.315a4b94.ajz@cambridgebroadband.com>
In-Reply-To: <42B02AAD.6050805@anagramm.de>
References: <20050614104749.387910e0.ajz@cambridgebroadband.com>
	<42B02AAD.6050805@anagramm.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart_Wed__15_Jun_2005_14:54:34_+0100_08445298"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Anyone got drivers/mtd/maps/pm828.c?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart_Wed__15_Jun_2005_14:54:34_+0100_08445298
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Clemens,

Thanks for your help.  I've done it now (see attached).  The
partitioning is specific to our application but it is easily modified.

I noticed a buggette in the mtd code while doing this.  If you build
everything as a module then the sub-module loading doesn't work
properly.  For example in gen_probe.c it says

#ifdef CONFIG_MTD_CFI_INTELEXT
	case 0x0001:
	case 0x0003:
		return cfi_cmdset_0001(map, primary);
#endif

where it should really say

#if defined(CONFIG_MTD_CFI_INTELEXT) ||
    defined(CONFIG_MTD_CFI_INTELEXT_MODULE)
	case 0x0001:
	case 0x0003:
		return cfi_cmdset_0001(map, primary);
#endif

There are several problems like this.  In the end I gave up and just
built everything except the actual mapping driver as kernel resident.

Alex


On Wed, 15 Jun 2005 15:18:37 +0200
Clemens Koller <clemens.koller@anagramm.de> wrote:

> Hi, Alex!
> 
> Hmm, I don't know the PM828 much in detail, but have you
> tried the "generic" physmap driver which is in the kernel?
> Just give it the base address and the size, and it should
> probe the cfi and you are done (well, it was working fine
> for me on my PM854).
> Of course, you need to make sure, that your hardware / memory
> mapping is initialized properly (which happens usually in the
> boot loader). If it's not, let me know and I can give you
> some code to mess around with the registers in a kernel module.
> 
> Best greets,
> 
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
> 
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
> 
> 
> Alex Zeffertt wrote:
> > Hi there,
> > 
> > I need to get flash partitions working on my PM828 development
> > board. Has anybody already written a pm828.c?  If so I'd appreciate
> > a look at it.
> > 
> > TIA,
> > 
> > Alex
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 

--Multipart_Wed__15_Jun_2005_14:54:34_+0100_08445298
Content-Type: application/x-gzip;
 name="pm828-icu.c.gz"
Content-Disposition: attachment;
 filename="pm828-icu.c.gz"
Content-Transfer-Encoding: base64

H4sICNX0r0ICA3BtODI4LWljdS5jAK1Ze3PaSBL/Gz5FH67kEME2YEIRHPsu2Dih1q/yo3brcimV
kEZmzpKG0oxs2Evus1/3jF5gIN6tpSpeaXq6+9c93T3d2v1GFRrwxYm8gEHozGY8egDhg5oy8ANH
TiFkoYgX4LgukxJikSgeMUlcIoIL7sbidiHh+qLf6cNEOLG3R7RrJ1ZccdyinAmKljPmcp+7oAQ4
cOKEk5h7DwyGsXC8CaonpvHJPQl1UmmzwFG+iEMSSOSJI5lHG9yk3+nuuenyLXKLGDwWoTTniUVN
GAr56ARcpjvuplyCKzwG+N/P1+fMM4T9anU/3cBSnVNHQju1HGE9Snjmakp7ujCHcaRYAJ3+Wa/b
OjkY7vZbUG/34GLClQU8QmxMc0G91wVchEkin7mnphZJQFvQNiWUE5CLDzoXQ6Mph5mgOoYYnhj5
yZ0KyQZE2YXbZDYTsYJed7csF46O4eTq8mz82b64O7VPzsb2sL/M0d11p3yWmsTRgDhgpOAl57hr
fLLDIzdI0FsfAx4l831XRD5/2JseE8mH+t885mMMePUXmi34/h02kcddy6rusDhGN9QuEqnAbAQj
X2r/FPaBTA3A40XnayMK+DWUFHncf4mWR1wR1tX1UHhJwNZR1GLG5DrCI4sjFixTHBnuc5E6Y0WD
8ujfWuVEcmabSLMsW+QaZSEy2v1Or7WOmwvy0RKlNgsxkne5m+xNa4gyidDPldPR8P6zPsDibSc7
AY9NkofHuh+qphM/yL29Pasyi9Hbeg2aOzu0TKcXSLaVrTiWdM/w/vbX8endF+gXaxe3n+3rm9HZ
+LcU7KBW2W/ALEbyXIeBSGJIAVh/lxSVOe/d6fi0ApCZ2dKsxIOOJD/KI8jdScWMIloqR2HtkSpO
XEUbbR75AhpahI3vh/ke206w8uj1mDleH+oZF56C4cKnJiSR5A8Y5RAIXTHRO/+tVmKmkjiCRr2u
5TQsqOPu3WNiRnue7Da805utw+qPsk6sIoVSfPnzWpH59WoPOiW1+PLn1SLz69VidSzU4sufV4vM
r1T7JLiXanXFbGH7sQg3KK5WKhRh+NNMDSVWsRBzE6TkvzNbQcAijQyvSjeVzAXUia1uJKyFSPus
pubeAPQ55optDEEdYt4qNMeLNZjtMUi7LDgCb5vmzXFo4szLPLUNwcZ4fBWEzTFpYu5VEDbG5qsg
bI5PE38/gZCkb16MitZCOKxW0kgGz1EObnuLgFJGvLcfZP4Wyjh/lngNerZZeRLYK3Hss0oUP/7a
+YaFrUKvtpZT138x2ipuwOsWEW0bLxnbRlsyGfhSr4U+CoY3rRoMoHYU19B7MrYGxJrrJXu0dnr+
foRl/cY+u07f3x7B/+p6ZdSC74Y2am9RiU6shcpo/XdUo1cuF5Frngf0D2oZkJ/Ikcr3oN2EVv1N
x0IBALQa4GK62rJSFaWd7WyttK+TrsFA/zEA6JAwb/UznSs9T/A5c7tVrfwVduZ+NtbGTCoRrx7k
5vqGDeTW6rYcrVSrsA/DpswUrK0FTgkqb9tKmxLoFCNjtbytYkrvYGcGGE+oI3JCNigueDjTjeuQ
uuqdVg3RZ73vAPLmoknuwcta85Uu73S93VshtHsp5aCzQjnopJRedwBLlF4XKfnNMVi9SpBoqnVJ
oFnIKIhimaJRpFVuhaRhpNVnhVTgUKIgpQvN6o/D8lDjiyAQz9QGmfZJ6sEu748gcBY40NE0Uhrg
ZDZw3TKcmExXub++WdWNlxZt5JnJkXipySr0mENPYraXzzoMGnjqc1sPJjYFGk1nBA9XeZiEMBMY
f5N0LsVANSMM7SQJz1PuToklEgoiRtOpE/NgoUU4qAynrIJjD8YYczR0uCLGVJoJM3JiltD+JydI
8iEVVeEsZ5CYgbhkYTrcwGSRWVorRbTHpIt2caGfato9JKhQSuJCB6eZSPtiP2vJy8PY9aebu/Hd
+OryNj3Kv3qa3l/TEReHZSKqOGZbD8Jf33/TCQqA/bZOxzYJoiTJs7aWXCSB4rUmlhjcdU4xA2aK
Ah46iPAdxE7ocflIvBXh+5IpzJjWvN/CH0Y2Hdag0pp3zIIRBO/bnV+GZO0BzszESYuhIx9NORzQ
WGD/ejO+G30ano+Qa9/M2y4Dyt1dEQWLSor2R3MFtI6STxnoNsaIj7VaLqRioYFdKYM9gI8foVNg
7aXvKVRCiEA/GKCbFQ5RIYDm6eCEu1Xlh+0qPxiV7fc/03lS6DzRQ/d2te33K3rby3q1QlLc26JY
YiCxQu99lEjmLalpzbsrh98tnX3nfc8cvYmBTI0udNlQeDm0r87qc7yKSAIWIXreh/zla+ubZa3L
tJOL0/Px5Uhn3G0V502qjZLZbuhhwWOlJCgu03x6xPhTLC5NC2uzqdGY6bG0tM9ctO7UiVEIifPw
hjSDsz6aDfhMtVi3rSgY5XGXzMmwSDuaYPq2DrdmfiPfbvZqj9g21T6gP3Y+MJvBRjcFZWuI16bv
KYa/MvGwe2hMPHytm2fLxttUUkOz1BhPvN3jCTeXASKMVdHm0s2wsgGXSAKh89gTx9rviyTyjFL6
RrXmE1ThIwvevl23Y8nZ2MRpk9BW7n1tt74d5p82ir6APumk+FJMmqY/XED9l9HNpX15dTc+GS1/
8ojFhK6B1vxNqx/MwVHZI/aATS2pqf2CUUHyVhSWGi306lIbZwHHFpF6Kd2YGlllKfrz3TpRlq7s
5pfhL2P2HSwUHqVhqgGhpoLpl87ku6Px1WGanyXQik7GE7ZRJyYMBwzX5+YZLX6bI1rFmgtYwpct
7h6L54hR+Nx9Gd/aF1en9+ejAlQ5NN69O9x+0f6sNmRCpfYOQtOB0TTfo0qeWEm4zeUktwLtz5ma
Jt5K8rhRVcg8hpaVU7U7SjlXc0UY0gdTUld7bVF5gZ2Ar20CNtppKvB6ppI11bWgTUmqpemz1uqP
mNrlGHhNnkWi1Onqku08YRhTB7UcvT+Avmv+QemJpBx+I0s6ijZRJ3JuY0kV/TA17aW6uxwNy8GQ
u6CM9zW3wFrDOOaCLg/58La2GGQ5nH9sW66yeBbwD0z2y9/GVzgUt16MobbN5nhluAFzomS27tbY
muAeC1YcVNpXCkHTcKtYLODFhh+rKjaWuz/kky2luJUpRmeY/9lgLs768s2JglKq9lH9hZNo2jel
zD7HoLu8HWG5/Hx9ThGbrn+6v/tydYPLnwI2h38x32exUuD85/d/utkwMMlmgT2sCSXe09Htyc34
muIEBWDckB/BQyuwktK8Up4Eie//uB7VgyMcAAA=

--Multipart_Wed__15_Jun_2005_14:54:34_+0100_08445298--
