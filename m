Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D3D41A0144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 21:56:58 +1000 (AEST)
Received: by pacdd16 with SMTP id dd16so137398893pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 04:56:55 -0700 (PDT)
Date: Mon, 31 Aug 2015 19:56:37 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Geoff Levand <geoff@infradead.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Question] Is little endian supported on all the platforms?
Message-ID: <20150831115637.GC1071@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
 <1441019966.31779.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
In-Reply-To: <1441019966.31779.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 09:19:26PM +1000, Michael Ellerman wrote:
> On Mon, 2015-08-31 at 15:53 +0800, Boqun Feng wrote:
> > On Mon, Aug 31, 2015 at 04:52:38PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2015-08-31 at 14:44 +0800, Boqun Feng wrote:
> > > > Hi all,
> > > >=20
> > > > I hit a strange build error on v4.2, when I try to build a LE kernel
> > > > with a slightly modification of the ppc64_defconfig. What I did is =
just
> > > > make ppc64_defconfig and make menuconfig to set CPU_LITTLE_ENDIAN=
=3Dy, and
> > > > then build the kernel.
> > > >=20
> > > > I did a little research myself, and found out the error is because =
of
> > > > trying to build a LE kernel with CONFIG_PPC_PS3=3Dy. So a simple wa=
y to
> > > > reproduce is:
> > >=20
> > > First, LE isn't supported on PS/3 :-) It's only supported on POWER8
> > > machines (and *some* P7 machines and only when running as KVM guest).
> >=20
> > Got it, thank you ;-)
> >=20
> > So should we modify Kconfigs of all the platform to reflect this?
>=20
> Yes. Maybe something like this?
>=20
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
> index c140e94..c359f72 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -415,9 +415,13 @@ config VDSO32
>           big endian. That is because the only little endian configuratio=
n we
>           support is ppc64le which is 64-bit only.
> =20
> +config CHOOSE_ENDIAN
> +       bool
> +
>  choice
>         prompt "Endianness selection"
>         default CPU_BIG_ENDIAN
> +       depends on CHOOSE_ENDIAN
>         help
>           This option selects whether a big endian or little endian kerne=
l will
>           be built.
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platfo=
rms/powernv/Kconfig
> index 604190c..32d5661 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -18,6 +18,7 @@ config PPC_POWERNV
>         select CPU_FREQ_GOV_ONDEMAND
>         select CPU_FREQ_GOV_CONSERVATIVE
>         select PPC_DOORBELL
> +       select CHOOSE_ENDIAN

IIUC, we can actually set PPC_POWERNV=3Dy and PPC_PS3=3Dy at the same time,
right?

So this can't prevent PPC_PS3 && CPU_LITTLE_ENDIAN from being true.

>         default y
> =20
>  config OPAL_PRD
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 54c87d5..182f485 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -21,6 +21,7 @@ config PPC_PSERIES
>         select HOTPLUG_CPU if SMP
>         select ARCH_RANDOM
>         select PPC_DOORBELL
> +       select CHOOSE_ENDIAN
>         default y
> =20
>  config PPC_SPLPAR
>=20
>=20
>=20
> > > But the specific problem you are having looks like a differnet issue
> > > with the PS3 boot wrapper.
> > >=20
> >=20
> > But could the reason of this be that the building process of the PS3
> > boot wrapper assumes the kernel is BE?
>=20
> It looks more like we're getting confused between 32-bit and 64-bit, from=
 your
> log:
>=20
>     ld: powerpc:common64 architecture of input file `arch/powerpc/boot/ps=
3-head.o' is incompatible with powerpc:common output
>=20
> Which says it has a .o which is 64-bit but it's trying to produce 32-bit =
output.
>=20
> That's probably related to the PPC64_BOOT_WRAPPER stuff.

Probably, and just FYI, I build a 64bit BE kernel, the dtbImage.ps3 is
ELF 32-bit MSB executable.

Regards,
Boqun


--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV5EDuAAoJEEl56MO1B/q4yoEIALP6aLsEg4ee7ng+Be8eC6hn
oyaS9n5KgDgC5/RjWdNx8XiRurSvKSFhJS+UzScIjiaYLxPmy8Zho70etg5anf/W
VopGIIuc/iqS0ngGCxFaJSMhmEsDJ9/reWcxWTMfy0OApXiXV/JTZ3LFXyxDqT+8
svhhRmDL0tfv6idDz1R5hQVWs7N1oOErxldX52UptaLJ6cyd2aBxTxIuLQuD77Gq
3Lv0fWaAslHSKEv7DiKLvlaWe/GSrlPaFUsI3VQ0xAt+ROQ8YXW4SUi+LyvQ+trA
cWMXVzaX7dxyM4unhVwWFKdMV27B/acX7Z1p3mLVsphF5L8qh/8WpIDyZGqdrvk=
=opIw
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
