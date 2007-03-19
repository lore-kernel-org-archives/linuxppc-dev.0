Return-Path: <jonandia@aotek.es>
Received: from smtp1.sarenet.es (smtp1.sarenet.es [194.30.0.4])
	by ozlabs.org (Postfix) with ESMTP id 155D9DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 00:58:30 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp1.sarenet.es (Postfix) with ESMTP id B8D73125CD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 14:28:16 +0100 (CET)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C76A29.84DD9271"
Subject: RE: Howto set DIO on MPC-5200 Lite
Date: Mon, 19 Mar 2007 14:18:20 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
From: "Josu Onandia" <jonandia@aotek.es>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C76A29.84DD9271
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Some sample code. Hope this helps.

Regards

Josu Onandia

//   PSC2_0  ---->  J20 pin 2
//   PSC2_1  ---->  J20 pin 4
//   PSC2_2  ---->  J20 pin 6
//   PSC2_3  ---->  J20 pin 8
//
//   GND ---- J20 pins 15,17,19,20

static void psc2_configure_pins(void)
{
	struct mpc5xxx_gpio *gpio;
=09
	gpio =3D (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
=09
	gpio->port_config &=3D ~(0x00000070);
	gpio->simple_gpioe |=3D 0x000000F0;
	gpio->simple_ode &=3D ~0x000000F0;
	gpio->simple_ddr |=3D 0x000000F0;
}
/* PSC2   0 to 3 pins */
static inline void psc2_pin_on(int pin)
{
	struct mpc5xxx_gpio *gpio;
=09
	if((pin < 0) || (pin > 3))
		return;
	gpio =3D (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
	gpio->simple_dvo |=3D (1 << (pin + 4));
}
static inline void psc2_pin_off(int pin)
{
	struct mpc5xxx_gpio *gpio;
=09
	if((pin < 0) || (pin > 3))
		return;
=09
	gpio =3D (struct mpc5xxx_gpio*) MPC5xxx_GPIO;
=09
	gpio->simple_dvo &=3D ~ (1 << (pin + 4));
}



-----Mensaje original-----
De: linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org en nombre =
de Matthias Fechner
Enviado el: lun 19/03/2007 8:31
Para: linuxppc-embedded@ozlabs.org
Asunto: Howto set DIO on MPC-5200 Lite
=20
Hi,

how can I set the DIO ports from a MPC-5200 Lite?


Best regards,
Matthias

--=20

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


------_=_NextPart_001_01C76A29.84DD9271
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiQNAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAIwAAAFJFOiBIb3d0byBzZXQgRElP
IG9uIE1QQy01MjAwIExpdGUACQoBBYADAA4AAADXBwMAEwAOABIAFAABACkBASCAAwAOAAAA1wcD
ABMADgAVACMAAQA7AQEJgAEAIQAAAEJCRUU1NUZBMEM5MTdBNEM5NzMyRjAyMzM5QkI1NjlCAFEH
AQOQBgC4CwAAOAAAAAMAJgAAAAAAAwA2AAAAAABAADkAX0puEClqxwEeAD0AAQAAAAUAAABSRTog
AAAAAAIBRwABAAAAOQAAAGM9RVM7YT0gO3A9RkFHT1I/QVVUT01BVElPTjtsPUNPUlJFTy0wNzAz
MTkxMzIxMzVaLTM5OTMzAAAAAB4ASQABAAAAHwAAAEhvd3RvIHNldCBESU8gb24gTVBDLTUyMDAg
TGl0ZQAAQABOAAAPx574accBHgBaAAEAAAA3AAAAbGludXhwcGMtZW1iZWRkZWQtYm91bmNlcytq
b25hbmRpYT1hb3Rlay5lc0BvemxhYnMub3JnAAACAVsAAQAAAIsAAAAAAAAAgSsfpL6jEBmdbgDd
AQ9UAgAAAABsaW51eHBwYy1lbWJlZGRlZC1ib3VuY2VzK2pvbmFuZGlhPWFvdGVrLmVzQG96bGFi
cy5vcmcAU01UUABsaW51eHBwYy1lbWJlZGRlZC1ib3VuY2VzK2pvbmFuZGlhPWFvdGVrLmVzQG96
bGFicy5vcmcAAAIBXAABAAAAPAAAAFNNVFA6TElOVVhQUEMtRU1CRURERUQtQk9VTkNFUytKT05B
TkRJQT1BT1RFSy5FU0BPWkxBQlMuT1JHAB4AXQABAAAAEQAAAE1hdHRoaWFzIEZlY2huZXIAAAAA
AgFeAAEAAABBAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAATWF0dGhpYXMgRmVjaG5lcgBTTVRQ
AGlkZWZpeEBmZWNobmVyLm5ldAAAAAACAV8AAQAAABgAAABTTVRQOklERUZJWEBGRUNITkVSLk5F
VAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAANwAAAGxpbnV4cHBjLWVtYmVkZGVkLWJvdW5j
ZXMram9uYW5kaWE9YW90ZWsuZXNAb3psYWJzLm9yZwAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkA
AQAAABMAAABpZGVmaXhAZmVjaG5lci5uZXQAAB4AcAABAAAAHwAAAEhvd3RvIHNldCBESU8gb24g
TVBDLTUyMDAgTGl0ZQAAAgFxAAEAAAAbAAAAAcdp+Lz/+WekgbLZRsu/0EyQaqOy4wAMFNuiAB4A
dAABAAAAHQAAAGxpbnV4cHBjLWVtYmVkZGVkQG96bGFicy5vcmcAAAAAHgAaDAEAAAANAAAASm9z
dSBPbmFuZGlhAAAAAB4AHQ4BAAAAHwAAAEhvd3RvIHNldCBESU8gb24gTVBDLTUyMDAgTGl0ZQAA
AgEJEAEAAABbBAAAVwQAABIJAABMWkZ1k4IH8wMACgByY3BnMTI14jIDQ3RleAVBAQMB9/8KgAKk
A+QHEwKAD/MAUARWPwhVB7IRJQ5RAwECAGNo4QrAc2V0MgYABsMRJfYzBEYTtzASLBEzCO8J97Y7
GB8OMDURIgxgYwBQ8wsJAWQzNhZQC6YGAANw4GUgc2FtC1AdIAWgQQEALiBIb3AdIHQCaAQAIGhl
bHBzji4KogqECoBSZWcLEQJzHxpKb3N1IE8abgBwZAcwHxovLyBBIqBQU0MyXxZQIKotI1E+IqBK
HMFwC4DWIA5QIj0xIz80Ii4UQNUjTjYiLjMnnzgiJiIpOEdORCNDI7YEIDE1yCwxNy1QOSwMAR8p
CnMBkHQN4CB2b2keZCPwBPAjAAWgbmZpUmcIcGVfLOIoLxIpnx8VAAAfJAGRHTB0chrQIwVAHWBj
NXgy0F9n8SQAbyAqMxIZMDGIMXkxMxM9ICgyLzMwKikJBdBQQzLDR1BJTzczvzTII4BwF8EvpSAm
QTVwfigweDA6wzf8MCk3yjk0AJAdYjMDHSD2fDVwOqZGGSE7fzyEBHHHOkM9fz6PX2RkBcA9T3Uf
Qn0iJSoiwyKhFlB0dzNAKbAs4yorVS6lC4BsnwuAHSAvGCQBP5BuKAuAfwVAJAEw7zH/Mw84LwaQ
KJooJAI8QrA24Hx8NYDzJAIjkDMpSJY4Q0mSGCD6dAhwbkDONW82fzeOQYxrLxBCgiglUDxNUE0D
K/8mYE5QQ21GP0dKASBIH0kv/0o/S09MX01vTn9Pj0/vUP//Ug83r1N/VIY6UlUvQ21pT7IKI1It
TQnwHUBqHSA/BbAv8AuAB0Bqwx8URGVEOiBXsXV4cFtQLU5lBtAJgAEAZC0G4HVkbmMHkCtqAiAh
cz0kYW8OsGsuB5BAb3p6C2BiHvAFsDowCfAgqm4DcGIYICA/sU0uwFUeYWEEIEYFkGhX0HLRHxRF
bnYHMGRb8B7AB2zhbkAtIDkvMDMvZwHQOxAqwDozGvMKgFC9CsBhbO8JgG+5HxRBISBtAjBvdTAe
EHdFERQRIN5EZMBrgAOgZCEtDkA6wDggTGkOsB8UYYVIabosHxpoeAAdoAORSXhDPx5gHSB4kjmS
BCADUiBh5Xj8P2mvCkIHkAVAGCA/H/N6xXFGagxhhh8jIlB3A2AJwB1QbQuAOjBFEGR8YXlXgAQg
faB1EG5gIPltsHR3CeEdMFjghRAKwL8dIAnwa8EJ4BQAWsJpcsCzg8MfFGJ1AxAvQGIv8P5nEoEh
cYTiDrAFwC8wW+D4dC1wA2BY4CPwg0SAcD+Ic3xybkCG0IZhHkFyefuG+omRZBrQhNGIL4kzHvB/
HOF9QArAinCK2x6BA/BucwMAg8AuIiNBH3UN4GjpEiFvax8UX5JPk1+UKv8fFHmQbS1bMAtwV7E6
MFewvy6glT92D3s1AkAe4DoigO1vyC+WsgOBL5cyC4ACEBebkW0tHxp9nhAAHgA1EAEAAAAwAAAA
PDkxOEVCMTk5RERERkZBNDJCRUEyRUIzQTFDNjAyMUYzNjBDMDg1QENPUlJFTz4AHgBHEAEAAAAP
AAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAABSAAAAUgBFACUAMwBBACAASABvAHcA
dABvACAAcwBlAHQAIABEAEkATwAgAG8AbgAgAE0AUABDAC0ANQAyADAAMAAgAEwAaQB0AGUALgBF
AE0ATAAAAAAACwD2EAAAAABAAAcwX0puEClqxwFAAAgwOH7phClqxwEDAN4/r28AAAMA8T8KDAAA
HgD4PwEAAAANAAAASm9zdSBPbmFuZGlhAAAAAAIB+T8BAAAAWQAAAAAAAADcp0DIwEIQGrS5CAAr
L+GCAQAAAAAAAAAvTz1GQUdPUl9BVVRPTUFUSU9OL09VPUFVVE9NQVRJT04vQ049UkVDSVBJRU5U
Uy9DTj1TVE9OQU5ESUEAAAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAAAgH7
PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMAGUAAAAAA
AwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAKAAAAU1RPTkFORElBAAAAHgAxQAEAAAAK
AAAAU1RPTkFORElBAAAAHgAyQAEAAAA3AAAAbGludXhwcGMtZW1iZWRkZWQtYm91bmNlcytqb25h
bmRpYT1hb3Rlay5lc0BvemxhYnMub3JnAAAeADNAAQAAABMAAABpZGVmaXhAZmVjaG5lci5uZXQA
AB4AOEABAAAACgAAAFNUT05BTkRJQQAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAA
CwAjAAAAAAADAAYQd1My/wMABxC6BAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAFNPTUVT
QU1QTEVDT0RFSE9QRVRISVNIRUxQU1JFR0FSRFNKT1NVT05BTkRJQS8vUFNDMjAtLS0tSjIwUElO
Mi8vUFNDMjEtLS0tSjIwUElONC8vUFNDMjItLS0tSjIwUElONi8AAAAAAgF/AAEAAAAwAAAAPDkx
OEVCMTk5RERERkZBNDJCRUEyRUIzQTFDNjAyMUYzNjBDMDg1QENPUlJFTz4Ayg8=

------_=_NextPart_001_01C76A29.84DD9271--
