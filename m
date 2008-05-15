Return-Path: <joerg@alea.gnuu.de>
Received: from uucp.gnuu.de (banki.eumelnet.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id 7A1EFDDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 09:05:40 +1000 (EST)
Date: Fri, 16 May 2008 00:05:14 +0200
From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
To: linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: linux-next: iBook G4, keyboard is locked after wakeup
Message-ID: <20080515220514.GA2475@alea.gnuu.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've an iBook G4 and tried the linux-next tree 20080515. When the
computer awakes I see a black screen with the cursor blinking in the left
upper corner. I can change the console with Alt+F1 =E2=80=A6, but I can inp=
ut
anything else. The system is locked. I've ran git bisect and it reported
acff8d4223ddfb35f3950dce3709b1c515e96c08 as the first bad commit.

commit acff8d4223ddfb35f3950dce3709b1c515e96c08
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Tue May 13 11:09:44 2008 +1000

    ide: use __generic_unplug_device() in ide_do_drive_cmd()
   =20
    Call __elv_add_request() with 'plug' =3D=3D 1 (so the device will be
    plugged) and then use __generic_unplug_device() instead of calling
    ide_do_request() directly.
   =20
    This is a preparation for converting IDE to use blk_execute_rq().
   =20
    Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
    Cc: Borislav Petkov <petkovbb@gmail.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 5aed79e..a4083e4 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1606,8 +1606,8 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct requ=
est *rq, ide_action_t actio
        spin_lock_irqsave(&ide_lock, flags);
        if (action =3D=3D ide_preempt)
                hwgroup->rq =3D NULL;
-       __elv_add_request(drive->queue, rq, where, 0);
-       ide_do_request(hwgroup, IDE_NO_IRQ);
+       __elv_add_request(drive->queue, rq, where, 1);
+       __generic_unplug_device(drive->queue);
        spin_unlock_irqrestore(&ide_lock, flags);
=20
        err =3D 0;

% cat /proc/cpuinfo
processor	: 0
cpu		: 7455, altivec supported
clock		: 606.000000MHz
revision	: 0.3 (pvr 8001 0303)
bogomips	: 36.73
timebase	: 18432000
platform	: PowerMac
model		: PowerBook6,3
machine		: PowerBook6,3
motherboard	: PowerBook6,3 MacRISC3 Power Macintosh
detected as	: 287 (iBook G4)
pmac flags	: 0000001b
L2 cache	: 256K unified
pmac-generation	: NewWorld

What else information do you need?

Bye, J=C3=B6rg.
--=20
Real programmers don't comment their code.  It was hard to write,
it should be hard to understand.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILLOawe0mZwH1VIARAkGrAJ4hxLe8+MwFoY+U1seTKErOmXyyawCZAXmx
sL62gtQh9Lfi5QSniTAMAJo=
=SGER
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
