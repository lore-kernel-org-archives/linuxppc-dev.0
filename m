Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4481A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 13:39:20 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EFDE1402B1
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 13:39:19 +1000 (AEST)
Received: by payr10 with SMTP id r10so45733220pay.1
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 20:39:18 -0700 (PDT)
Message-ID: <1433993900.31423.40.camel@axtens.net>
Subject: Re: [PATCH V8 08/10] powerpc, perf: Change POWER8 PMU configuration
 to work with SW filters
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 13:38:20 +1000
In-Reply-To: <5578293B.9060506@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-8-git-send-email-khandual@linux.vnet.ibm.com>
 <1433915365.3096.44.camel@axtens.net> <5578293B.9060506@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-hxwNbI5WaQPsaJFbrJBf"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-hxwNbI5WaQPsaJFbrJBf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2015-06-10 at 17:40 +0530, Anshuman Khandual wrote:
> On 06/10/2015 11:19 AM, Daniel Axtens wrote:
> > On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
> >> > The kernel now supports SW based branch filters for book3s systems w=
ith
> >> > some specific requirements while dealing with HW supported branch fi=
lters
> >> > in order to achieve overall OR semantics prevailing in perf branch s=
tack
> >> > sampling framework. This patch adapts the BHRB branch filter configu=
ration
> >> > to meet those protocols. POWER8 PMU can only handle one HW based bra=
nch
> >> > filter request at any point of time. For all other combinations PMU =
will
> >> > pass it on to the SW.
> >> >=20
> >> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> >> > ---
> >> >  arch/powerpc/perf/power8-pmu.c | 51 +++++++++++++++++++++++++++++++=
+++++------
> >> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >> >=20
> >> > diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/powe=
r8-pmu.c
> >> > index 5e17cb5..8fccf6c 100644
> >> > --- a/arch/powerpc/perf/power8-pmu.c
> >> > +++ b/arch/powerpc/perf/power8-pmu.c
> >> > @@ -656,6 +656,16 @@ static int power8_generic_events[] =3D {
> >> > =20
> > This is, I think, the third time you've modified this function in this
> > patch series. I appreciate the fact that you're trying to keep logical
> > changes separate, but it seems to me like this change might be able to
> > be combined with patch 4, and given a single commit message that clearl=
y
> > explains the complete scope of the changes.
>=20
> Here I have to disagree with you. The changes in this patch like PMU
> should not handle multiple filter requests as it does not support the
> OR semantic required in the protocol, the fact that we need to pass
> on the entire branch filtering responsibility to the SW comes into
> picture after we have enabled the SW branch filtering support in the
> previous patch. So these changes have to follow that up logically and
> sequentially in that order.
>=20
OK. I don't think I understand the patch set quite well enough to follow
your logic, but when you send out the next version I'll try to take a
closer look at how the series fits together as a whole.

--=20
Regards,
Daniel

--=-hxwNbI5WaQPsaJFbrJBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVeQKsAAoJEPC3R3P2I92Far8QAJ0y5u1e2MYWee35XudgJsK1
lSMIHFxVFhN5XiXMimPcLs1VT7MyEimiOoGxlHKwe62uWenOXDkasWGJGuEgQN2f
JBbsNdP51mObBxlFP0BeYO2IFwjZl+IuzK8UrE/XkAysOIEkMDFFZwh6XTORz7P6
mx8wilr01qkuCUrY1NjbJ+aJsGSsOOSJLthYSBym8mTdfu7k75ca71OGkROs4Aqm
Xo5EbPFKGFOVCizfAWGNQ0tb3+4A1xnZl52GAX7aWwLwopXr9wqgHsoldfmlHEgU
hYoRbAb0+UnSmAjzGODJadso8bODsGd5s7+D1LjxytYhsq/b4KQj0MlBW0eVEXQZ
T9obIteaF1WPozNAkajCKk5BEq8vabyiUiQlfBZ/D+UyKI/4Go4Om4YyhxJ8s0nK
p1nnGZLZskhyg5o4qU5Pzl63j9HydKsudjsuYtKwC1MInKAJ+KZRCzt+L5f0zb+f
HO542PvwicoW8I+ACu6F86mxSX+OU8VeOa+m2IlpnOXWbzXZgyCP6S9g2M6YpSCh
tCAVnDQn3mE/eUTOFT9SHC/Fvt6Y+b4c5NlLQ1YG8+VsrQ780vgCDS2qgliokuZb
qqJizJ43eEZEcr5vLSJwLDm1rRFrv7wlQWPJX1wL43a3Sr0ulfjYgtncnDdmm4Xz
urT0J9kYAi+RQ5CxCC8K
=zZrf
-----END PGP SIGNATURE-----

--=-hxwNbI5WaQPsaJFbrJBf--
