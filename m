Return-Path: <haokexin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9TSz6JRrzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 12:33:07 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so690546pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:33:07 -0700 (PDT)
Date: Fri, 12 Aug 2016 10:32:55 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
Message-ID: <20160812023254.GI17275@pek-khao-d1>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <CAL_JsqKSQ2pUNEm+1_skkOM=gYihYBztcJusnZ=PCOvo+TkV6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
In-Reply-To: <CAL_JsqKSQ2pUNEm+1_skkOM=gYihYBztcJusnZ=PCOvo+TkV6A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2016 at 08:17:52AM -0500, Rob Herring wrote:
> On Thu, Aug 11, 2016 at 6:09 AM, Kevin Hao <haokexin@gmail.com> wrote:
> > With the commit 44a7185c2ae6 ("of/platform: Add common method to
> > populate default bus"), a default function is introduced to populate
> > the default bus and this function is invoked at the arch_initcall_sync
> > level. This will override the arch specific population of default bus
> > which run at a lower level than arch_initcall_sync. Since not all
> > powerpc specific buses are added to the of_default_bus_match_table[],
> > this causes some powerpc specific bus are not probed. Fix this by
> > using a more preceding initcall.
> >
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > Of course we can adjust the powerpc arch codes to use the
> > of_platform_default_populate_init(), but it has high risk to break
> > other boards given the complicated powerpc specific buses. So I would
> > like just to fix the broken boards in the current release, and cook
> > a patch to change to of_platform_default_populate_init() for linux-next.
>=20
> The patch that broke things was sitting in -next for some time and no
> one reported anything. Are all these boards broken?

At least in theory. :-)
The effect may be different due to what devices are missed. For me, the
Gianfar Ethernet on my mpc8315erdb board is malfunction due to the MIDIO bus
is not probed.

>=20
> I'm fine to just disable the default call for PPC instead if there's
> some chance this does not fix some boards.

I have tried to cover all the invocation of of_platform_bus_probe() via
machine_device_initcall(). Yes, I maybe missed some boards. But won't
we want to take this as a step to use the default populate function since
it does remove some reduplication codes?

> There could be some other
> initcall ordering dependencies.
>=20
> >
> > Only boot test on a mpc8315erdb board.
>=20
> Curious, what would it take to remove the of_platform_bus_probe and
> use the default here? We can add additional bus compatibles to match.

I thought about this. But the bus compatibles list seems a bit longer and
it may cause some side effects on some boards due to all these additional
buses. So that changes seem a bit aggressive to me. It does seem a feature
for linux-next. The following is the compatible buses list which are needed
to be added to the default match table if we want fix all the current broken
boards:
	{ .compatible =3D "fsl,ep8248e-bcsr", },
	{ .compatible =3D "fsl,pq2pro-localbus", },
	{ .compatible =3D "fsl,qe", },
	{ .compatible =3D "fsl,srio", },
	{ .compatible =3D "gianfar", },
	{ .compatible =3D "gpio-leds", },
	{ .compatible =3D "hawk-bridge", },
	{ .compatible =3D "ibm,ebc", },
	{ .compatible =3D "ibm,opb", },
	{ .compatible =3D "ibm,plb3", },
	{ .compatible =3D "ibm,plb4", },
	{ .compatible =3D "ibm,plb6", },
	{ .compatible =3D "nintendo,flipper", },
	{ .compatible =3D "nintendo,hollywood", },
	{ .compatible =3D "pasemi,localbus", },
	{ .compatible =3D "pasemi,sdc", },
	{ .compatible =3D "soc", },
	{ .compatible =3D "xlnx,compound", },
	{ .compatible =3D "xlnx,dcr-v29-1.00.a", },
	{ .compatible =3D "xlnx,opb-v20-1.10.c", },
	{ .compatible =3D "xlnx,plb-v34-1.01.a", },
	{ .compatible =3D "xlnx,plb-v34-1.02.a", },
	{ .compatible =3D "xlnx,plb-v46-1.00.a", },
	{ .compatible =3D "xlnx,plb-v46-1.02.a", },
	{ .name =3D "cpm", },
	{ .name =3D "localbus", },
	{ .name =3D "soc", },
	{ .type =3D "axon", },
	{ .type =3D "ebc", },
	{ .type =3D "opb", },
	{ .type =3D "plb4", },
	{ .type =3D "plb5", },
	{ .type =3D "qe", },
	{ .type =3D "soc", },
	{ .type =3D "spider", },

Of course I can choose to use the default function if all you guys think it=
 is
better. :-)

> The difference between of_platform_bus_probe and
> of_platform_bus_populate is the former will match root nodes with no
> compatible string. Most platforms should not need that behavior and it
> would be nice to know which ones.

I don't think this difference would cause any real side effect for these bo=
ards.

Thanks,
Kevin

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrTVWAAoJEJNY7TDerrFxmdUH/2Q7b4VkIRypfDK2F7dW2SoG
QWRr0Wtne1OhPpb56hW4DFXj27hRPiSMpkF/X8uuVaos0wDL3UBHr21Bbz9Jm0Bm
0K792LY4oB8S8TgWBmgoyvyg0aw6QZoXlNVJUkInMVfH2A8+7hsKN4/AC5DQnyLS
pJzKSTdpq9YeQ9COVaJ1nC+VF/xL+X8Tq7N38MudXacrUIc89DUegPysEFSQNhBD
mM6RxvCHezXFkAOvG1STmdxUboT992ar6yZ0zRRnIaeTGCqUG8vTxiYgPXktsuqv
RTVXbL/wmwLwnnzU0JZUdOK23EgYuUYNsVHR7EbFzCQJLucaIgMCzDfHyUIgyO8=
=KtVJ
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--
