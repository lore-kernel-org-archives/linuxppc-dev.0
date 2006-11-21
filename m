Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 4D10967E0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 20:25:09 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id EC11C22DDE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 10:25:00 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: LocalPlus or XLB-Arbiter Problems, DMA, MPC5200, DENX' 2.4.25
MIME-Version: 1.0
Message-ID: <200611211025.00412.roman.fietze@telemotive.de>
Date: Tue, 21 Nov 2006 10:24:59 +0100
Content-Type: multipart/signed; boundary="nextPart1710000.KaMr4RxsML";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1710000.KaMr4RxsML
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

We've got the following problem:

MPC5200CBV400 L25R Rev 2

Using the DENX 2.4.25 with FEC and ATA DMA, BAPI 2.2, Prios are set to
=46EC 6/5 and ATA 4/3 (RX/TX). This causes the FEC task to interrupt the
ATA task (default).

We try to load both tasks by transferring data from the ATA disk to
the Ethernet, e.g. by using FTP.

At the same time we write to some peripheral on the LocalPlus from
within a cyclic timer tasklet.


=46rom time to time writing to the external peripheral fails, there is a
bus cycle, but we write some wrong data. This only happens if we have
=46EC+ATA active at the same time.

Increasing the ATA priorities above the FEC priorities gives us FEC
errors, but the external peripheral works.


I'm sure others have similar problems. Did any of you change the
priority setting of these tasks to be able to run her/his hardware? Is
this related to the XLB pipelining problem as described in the errata
and previous mails in this list? Does anybody know if this problem is
fixed in newer revisions of the chip? Could be disabling pipelining
and waiting for TIP to go away help as well?


Thanks for any help.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart1710000.KaMr4RxsML
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFYsXsp5XY/BK//MIRAmw2AJ9UrQLf8TEbifJpgOCVnN0c9eYAsgCeP/OB
+1q3unobxdNdkYlf0KjGG7k=
=8UNZ
-----END PGP SIGNATURE-----

--nextPart1710000.KaMr4RxsML--
