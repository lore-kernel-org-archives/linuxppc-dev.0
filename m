Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4554DA9C.9040102@am.sony.com>
References: <4554DA9C.9040102@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ccaV2JRH9G4b7T/eyUYl"
Date: Tue, 14 Nov 2006 14:44:40 +1100
Message-Id: <1163475880.8048.78.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ccaV2JRH9G4b7T/eyUYl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-10 at 12:01 -0800, Geoff Levand wrote:
> This adds a platform specific spu management abstraction and the corespon=
ding
> routines to support the IBM Cell Blade.  It also removes the hypervisor o=
nly
> resources that were included in struct spu.
>=20
> Three new platform specific routines are introduced, spu_enumerate_spus()=
,
> spu_create_spu() and spu_destroy_spu().  The underlining design uses a ne=
w
> type, struct spu_management_ops, to hold function pointers that the platf=
orm
> setup code is expected to initialize to instances appropriate to that pla=
tform.
>=20
> For the IBM Cell Blade support, I put the hypervisor only resources that =
were
> in struct spu into a platform specific data structure struct spu_pdata.
>=20
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
> ---
>=20
> Michael,
>=20
> Unfortunately, for your xmon spu support, your DUMP_FIELD is setup in suc=
h a
> way that it is not easy to change to use from inside spu_priv1_mmio.c, so=
 I
> left of_dump_pdata_fields() empty.  We'll need to work on something usabl=
e
> there, or make some other way to abstract those platform specific spu
> variables.

OK, back to the task at hand :)  For the moment I'd rather see you leave
out dump_data_fields(), as neither HV or baremetal implementations do
anything. Just put the offending xmon code inside an #ifdef
CONFIG_PPC_CELL_NATIVE. eg:

Index: cell/arch/powerpc/xmon/xmon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell.orig/arch/powerpc/xmon/xmon.c  2006-11-14 14:43:11.000000000 +1100
+++ cell/arch/powerpc/xmon/xmon.c       2006-11-14 14:42:35.000000000 +1100
@@ -2807,12 +2807,11 @@ static void dump_spu_fields(struct spu *
                        in_be32(&spu->problem->spu_status_R));
        DUMP_VALUE("0x%x", problem->spu_npc_RW,
                        in_be32(&spu->problem->spu_npc_RW));
+#ifdef CONFIG_PPC_CELL_NATIVE
        DUMP_FIELD(spu, "0x%p", priv1);
-
-       if (spu->priv1) {
-               DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
-                               in_be64(&spu->priv1->mfc_sr1_RW));
-       }
+       DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
+                       in_be64(&spu->priv1->mfc_sr1_RW));
+#endif
=20
        DUMP_FIELD(spu, "0x%p", priv2);
 }


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ccaV2JRH9G4b7T/eyUYl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWTuodSjSd0sB4dIRAhaPAKCOay+lmdhonXOsemktQNgUzlWqDQCfXYj9
lA4u8ytDZynbBhZSQ4sPACQ=
=A+zU
-----END PGP SIGNATURE-----

--=-ccaV2JRH9G4b7T/eyUYl--
