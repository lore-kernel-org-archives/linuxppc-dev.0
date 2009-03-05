Return-Path: <michael@ellerman.id.au>
Subject: Re: [Powerpc] Next March 5 build failure: platform/pseries/msi.o
From: Michael Ellerman <michael@ellerman.id.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <49AFB92B.8060606@in.ibm.com>
References: <20090305195008.f4fd4ce0.sfr@canb.auug.org.au>
	<49AFB92B.8060606@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-vlWXm5wA4oHuC21yWibM"
Date: Fri, 06 Mar 2009 01:06:54 +1100
Message-Id: <1236262014.8325.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vlWXm5wA4oHuC21yWibM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-03-05 at 17:06 +0530, Sachin P. Sant wrote:
> Next March 5th randconfig build fails with
>=20
> arch/powerpc/platforms/pseries/msi.c: In function find_pe_dn:
> arch/powerpc/platforms/pseries/msi.c:210: error: implicit declaration of =
function find_device_pe
>=20
> CONFIG_EEH is not set in the config.
>=20
> Attached here is the .config.

Dang it, that's my fault. Thanks for catching it Sachin.

I assumed pseries always enabled EEH, but I see now you can disable it
if you have EMBEDDED set (which your config does).

It's a bit yucky making the MSI code depend on EEH, but the only other
option would be to pull half the EEH code out - so I guess that's what
I'll do.

Does this patch fix it?

cheers


diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platform=
s/pse
index ddc2a30..dbb5109 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -25,6 +25,11 @@ config EEH
        depends on PPC_PSERIES && PCI
        default y if !EMBEDDED
=20
+config PSERIES_MSI
+       bool
+       depends on PCI_MSI && EEH
+       default y
+
 config SCANLOG
        tristate "Scanlog dump interface"
        depends on RTAS_PROC && PPC_PSERIES
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platfor=
ms/ps
index dfe574a..0ce691d 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SCANLOG) +=3D scanlog.o
 obj-$(CONFIG_EEH)      +=3D eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh=
_sysfs.
 obj-$(CONFIG_KEXEC)    +=3D kexec.o
 obj-$(CONFIG_PCI)      +=3D pci.o pci_dlpar.o
-obj-$(CONFIG_PCI_MSI)  +=3D msi.o
+obj-$(CONFIG_PSERIES_MSI)      +=3D msi.o
=20
 obj-$(CONFIG_HOTPLUG_CPU)      +=3D hotplug-cpu.o
 obj-$(CONFIG_MEMORY_HOTPLUG)   +=3D hotplug-memory.o


--=-vlWXm5wA4oHuC21yWibM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmv3H4ACgkQdSjSd0sB4dI6bgCfcCFbZ3kTHhNxcf7K1t01Uvew
MfsAn3Mrc+b4fqzTI8OU9pevaS7R8tYZ
=c7er
-----END PGP SIGNATURE-----

--=-vlWXm5wA4oHuC21yWibM--
