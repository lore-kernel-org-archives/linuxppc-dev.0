Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2BE0DDDF79
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 10:18:36 +1000 (EST)
Date: Wed, 10 Oct 2007 10:18:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: don't enable cpu hotplug on mpic-based pseries
Message-Id: <20071010101826.186f1f24.sfr@canb.auug.org.au>
In-Reply-To: <20071010000815.GB7875@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
	<20071010000815.GB7875@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__10_Oct_2007_10_18_26_+1000_wInLiMp5dDA90KdZ"
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, tgall.foo@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__10_Oct_2007_10_18_26_+1000_wInLiMp5dDA90KdZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

On Tue, 9 Oct 2007 19:08:15 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> Don't allow cpu hotplug on systems lacking XICS interrupt controller,
> since current platform code is hardcoded for it.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index 9711eb0..e29b890 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -252,6 +252,19 @@ static struct notifier_block pseries_smp_nb =3D {
> =20
>  static int __init pseries_cpu_hotplug_init(void)
>  {
> +	struct device_node *np;
> +	const char *typep;
> +
> +	for (np =3D NULL; (np =3D of_find_node_by_name(np,
> +						   "interrupt-controller"));) {
> +		typep =3D of_get_property(np, "compatible", NULL);
> +		if (strstr(typep, "open-pic")) {
> +			printk(KERN_INFO "CPU Hotplug not supported on "
> +				"systems using MPIC\n");

You need an of_node_put(np) here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__10_Oct_2007_10_18_26_+1000_wInLiMp5dDA90KdZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDBpWTgG2atn1QN8RAuKPAJ9QWVu4JBfurc0fWfwcFj1fFr5J+ACeMrr4
oShUFBVn4/m4NEkuU6hw+BY=
=DxMO
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Oct_2007_10_18_26_+1000_wInLiMp5dDA90KdZ--
