Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
	[195.238.6.176]) by ozlabs.org (Postfix) with ESMTP id 82BAEDE06E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 01:00:55 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [MPC8272ADS]Can not configure the ttyCPM0
Date: Fri, 13 Mar 2009 15:00:47 +0100
References: <8cad0aa0903130638w6fab6299kcd23d92d4c2d0a8@mail.gmail.com>
In-Reply-To: <8cad0aa0903130638w6fab6299kcd23d92d4c2d0a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2081549.JTRpCZSdyA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200903131500.51446.laurentp@cse-semaphore.com>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2081549.JTRpCZSdyA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean-Michel,

On Friday 13 March 2009 14:38:55 Jean-Michel Hautbois wrote:
> Hi all !
>
> I am currently facing a big problem on my MPC8272ADS development board.
> I have tried to use the /dev/ttyCPM1 port in order to send data over
> the serial cable to another device.
>
> This is just not working but nothing is sent, my DTR signal is down:
> > cat /proc/tty/driver/ttyCPM
>
> 0: uart:CPM UART mmio:0xF0011A00 irq:40 tx:296 rx:0 RTS|CTS|DTR|DSR|CD
> 1: uart:CPM UART mmio:0xF0011A60 irq:43 tx:0 rx:0 CTS|DSR|CD
>
> So, I have tried to use the serial port /dev/ttyCPM0. It is
> successfully sending out my bytes, but I can't configure it !!
> When I am trying to use the tcsetattr() function, I don't have any
> error, but the signal is always the same (no effect, if you prefer).
>
> I have tried to disable the kernel console output, but it is not
> working, either...

Support for the modem control lines has been added in v2.6.27-rc2. You will=
=20
need to declare the modem control lines in your device tree. See=20
Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt for more informati=
on.

Please note that hardware flow control is not supported by the CPM UART dri=
ver=20
yet.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Waterloo Office Park
Building M
Dreve Richelle, 161
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2081549.JTRpCZSdyA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm6Zw8ACgkQlyYWY4YEWhUIZACdFcRIBz4Uva5hjnNu7FBHZ6x1
rhkAn1L1mYUSzb3pFriVFg2nLqweE4yg
=bk/S
-----END PGP SIGNATURE-----

--nextPart2081549.JTRpCZSdyA--
