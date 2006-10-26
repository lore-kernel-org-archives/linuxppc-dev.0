Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 518AD68034
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 06:17:18 +1000 (EST)
Date: Fri, 27 Oct 2006 00:17:02 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: fix up the bd_info address
Message-ID: <20061027001702.4da5f5b0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_Kvr5TjIIc.74/JmEndYL3Tb";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_Kvr5TjIIc.74/JmEndYL3Tb
Content-Type: multipart/mixed; boundary=MP_jyvtnxkQr.yzM87bq2P_sc5

--MP_jyvtnxkQr.yzM87bq2P_sc5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The patch is attached. It is applied after Matt's bootm stuff. I was going =
to send it through u-boot list when
all the things around FDT will arrive there. It used to fix the problem boo=
ting the bd_t kernel on FDT u-boot.

Just as reference for now.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

--MP_jyvtnxkQr.yzM87bq2P_sc5
Content-Type: text/x-patch; name=fix_bd_info_address.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=fix_bd_info_address.patch

Patch fixes the address of the board info passed to kernel when OF tree is =
disabled.

---

 common/cmd_bootm.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/cmd_bootm.c b/common/cmd_bootm.c
index f1c0eb4..eb59817 100644
--- a/common/cmd_bootm.c
+++ b/common/cmd_bootm.c
@@ -836,8 +836,12 @@ #endif
 	(*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
=20
 #else
-	ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
-	/* ft_dump_blob(of_flat_tree); */
+	if (getenv("disable_of") !=3D NULL)
+		of_flat_tree =3D kbd;
+	else {
+		ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
+		/* ft_dump_blob(of_flat_tree); */
+	}
=20
 #if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
 	unlock_ram_in_cache();

--MP_jyvtnxkQr.yzM87bq2P_sc5--

--Sig_Kvr5TjIIc.74/JmEndYL3Tb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQRe/uOg9JvQhSEsRAknfAKCdOFmzJtMNkHqeCBw6MgygDDq73ACdEh/4
AggtcHCxy2QX+jlkKBCESYw=
=mvEl
-----END PGP SIGNATURE-----

--Sig_Kvr5TjIIc.74/JmEndYL3Tb--
