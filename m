Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 180FBDDF86
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 03:15:19 +1100 (EST)
Date: Tue, 4 Mar 2008 17:15:18 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] (testers ?) Fix sleep on some powerbooks
Message-ID: <20080304161518.GA4523@localhost>
References: <20080303062831.6BD8EDDED8@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
In-Reply-To: <20080303062831.6BD8EDDED8@ozlabs.org>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, debian-powerpc@lists.debian.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--p8PhoBjPxaQXD0vg
Content-Type: multipart/mixed; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben, Gaudenz - Hi All

On Mon, Mar 03 2008, at 17:27 +1100, Benjamin Herrenschmidt wrote:
> The PMU backlight code would kick in during sleep/resume even on
> machines that use a different backlight method. This appears to
> break sleep on my PowerBook, though I can't test that patch at
> the moment as the machine died while I was bisecting.
>=20
> So if anybody around has one of those latest revision PowerPC
> PowerBooks, the one just before they went to Intel,=20

yes, I think so:

$ cat /proc/cpuinfo=20
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1666.666000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 33.15
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh=20
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld


> and have a
> problem with suspend/resume, please test this and let me know
> if it helps.

It helps. Thanks a lot .. :) ...=20

After installing the kernel with your patch, and booting to it, I
successfully ran the machine into sleep mode, several times: On a
console, after booting, and with no-one logged in. On a
KDE-Login-screen, with root logged in on a console. And just a few
minutes ago in a fully working KDE/KDM X environment.

Pressing the power button on this machine put the system to sleep, and
it resumed when pressing the same button again ...=20

I uploaded this fresh kernel .deb, patched with your code, up to
rapidshare:=20
http://rapidshare.com/files/96992135/linux-image-2.6.25-rc3-g7704a8b-with-b=
en.s-pmu-patch_2008.02.29_powerpc.deb.html

md5sum for the file above is 7a7613e0c52e179acf7caacaa3890901

Please note - my favorite part - this kernel does not have an initrd
image included .. :)

I attach my /etc/modules file, just in case ...

For those not familiar to rapidshare procedures: Just choose something
like "Free" on the page above, wait a few secs, then chose an
appropriate server near you, and type in the code you see in the image.

I don't have my own web space for binaries like this, so sorry if this
is a little annoying ...

For those not subscribed to linuxppc-dev@ozlabs.org:
Here's Ben's original email, with the patch:
http://patchwork.ozlabs.org/linuxppc/patch?order=3Dstate&id=3D17107

Thanks again for your work, Ben  .... :)

Last, but certainly not least: Thanks Gaudenz, for pointing me to
"git bisect", for your response as a whole to the Debian powerpc list
=2E.. :)=20

My public key can be found with the 'keyserver' URL in the signature ..

Best Regards

>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
>  drivers/macintosh/via-pmu-backlight.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> --- linux-work.orig/drivers/macintosh/via-pmu-backlight.c	2008-03-03 17:2=
4:44.000000000 +1100
> +++ linux-work/drivers/macintosh/via-pmu-backlight.c	2008-03-03 17:25:12.=
000000000 +1100
> @@ -17,7 +17,7 @@
> =20
>  [ ... ]


--=20
Wolfgang=20

http://heelsbroke.blogspot.com/
http://keyserver.mine.nu/pks/lookup?search=3D0xE3037113&fingerprint=3Don

--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Description: /etc/modules
Content-Disposition: attachment; filename=modules

# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

apm_emu
ide-cd
#ide-disk
#ide-generic
sbp2
i2c-powermac
#snd-powermac

#snd-aoa:
#soundbus
#i2sbus
#snd-aoa
#snd-aoa-fabric-layout
#snd-aoa-codec-onyx
# End snd-aoa

cpufreq_performance
cpufreq_powersave
cpufreq_ondemand
sr_mod
therm_adt746x limit_adjust=-3

--FEz7ebHBGB6b2e8X--

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iQEVAwUBR811lvS/Z5pGFzlGAQomnggAkjnzVbcld3l8RjC75s802gnmEU8YAM1l
n4Nxbxna6eTC7cJJHdJWHqKWvLGd5ml5P4QW0cyzXJp94JlX+qphbiAff8Su5O+2
QGBp90jBdKVWaqvpP73ePo+mrTTeTAyvFeCnEgUktswmGY2oY9alUlyY5YfeqSXV
ZrYj8BEH8mW+4cKYq5GpqHyeXrgHrp2CbhfZWlUenOoWXdVy+ELoC6gCJ0T8Uy3G
PVVmx6tT3dEL5XBD+O3byc53+2Td42JVDYQPVKVNCBvQHeBoIBwmvCXQIML/cPKN
aCAMYH9J69p95eKh+dt15zSC10Gvxbl2pZ4M6B3D7G3ZGs8IStfLAQ==
=GZSq
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
