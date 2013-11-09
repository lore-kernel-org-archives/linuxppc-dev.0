Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D0DE2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Nov 2013 17:44:00 +1100 (EST)
Received: by mail-pd0-f173.google.com with SMTP id r10so3061051pdi.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Nov 2013 22:43:57 -0800 (PST)
Date: Sat, 9 Nov 2013 14:43:36 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which
 has doorbell support
Message-ID: <20131109064336.GB27936@pek-khao-d1.corp.ad.wrs.com>
References: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
 <1383845691.23598.125.camel@snotra.buserror.net>
 <20131108015446.GA31761@pek-khao-d1.corp.ad.wrs.com>
 <1383945372.23598.211.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
In-Reply-To: <1383945372.23598.211.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 03:16:12PM -0600, Scott Wood wrote:
> OK...  Why are you splitting out smp_85xx_basic_setup()?

In the current implementation of smp_85xx_setup_cpu(), we only invoke
the function mpic_setup_this_cpu() when the smp_85xx_ops.probe is set=20
to smp_mpic_probe(). So if we set smp_85xx_ops.probe to NULL when doorbell
is available, we must make sure that the mpic_setup_this_cpu() is also invo=
ked
when there does have a mpic. The smp_85xx_basic_setup() is for the board wh=
ich
has no mpic.

  static void smp_85xx_setup_cpu(int cpu_nr)
  {
  	if (smp_85xx_ops.probe =3D=3D smp_mpic_probe)
  		mpic_setup_this_cpu();
 =20
  	if (cpu_has_feature(CPU_FTR_DBELL))
  		doorbell_setup_this_cpu();
  }

>  Where do you
> call it other than from smp_85xx_setup_cpu()?

We would set the .setup_cpu() to smp_85xx_basic_setup() if it is a
non-mpic board. The following is quoted form the patch:
   	np =3D of_find_node_by_type(NULL, "open-pic");
   	if (np) {
   		smp_85xx_ops.probe =3D smp_mpic_probe;
  +		smp_85xx_ops.setup_cpu =3D smp_85xx_setup_cpu;
   		smp_85xx_ops.message_pass =3D smp_mpic_message_pass;
  -	}
  +	} else
  +		smp_85xx_ops.setup_cpu =3D smp_85xx_basic_setup;

>  Couldn't you have just
> removed the conditional without splitting up the function?

This will break the non-mpic board.

>  The change
> log says it's "to check if we need to invoke mpic_setup_this_cpu()"
> which doesn't make sense since we always want to call
> mpic_setup_this_cpu() if we have an MPIC.

If we have a mpic, we will call mpic_setup_this_cpu(). But if not,
we would set the .setup_cpu to smp_85xx_basic_setup() to avoid
the invoking of mpic_setup_this_cpu().

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSfdmYAAoJEJNY7TDerrFx1yAIAKcDrUeATZOnEwLoI5e3dEo8
GZqxHsbjaAcLvcu3Ip+Ixphusin5JMrLpFzjTlMloHDnejaj3xQnCBhCQoQpHA++
D28LZUe5eSWiOWaYqT4iSxdoXpLrrVp4a9Nl/TrFNXWp+gFRK5va+8lrsP4zWxai
bcamNrnK1IBIiH9clw+jDb7nMUJJ6Q9GlzZiqCv6Lp1V5SsCu+qtqYMs0txihcH4
M684w1oLeZpiuTREwtBvcxWO799CoZ73X/1wG/zu8Z+8GEtTVNQgoR5W0bvbNIx2
5h6iDQkiJyFMn1HFm94dILSDdk8bRimwGgpHg457m708bALp7oBZHmXZGCK/CTE=
=Hlaj
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
