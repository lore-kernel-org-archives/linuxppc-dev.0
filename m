Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A80101A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:12:32 +1000 (AEST)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B1BC1402EE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 15:12:31 +1000 (AEST)
Received: by paceq1 with SMTP id eq1so42533871pac.3
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 22:12:29 -0700 (PDT)
Message-ID: <1435209074.4286.30.camel@axtens.net>
Subject: Re: [PATCH V9 05/13] powerpc, perf: Change name & type of 'pred' in
 power_pmu_bhrb_read
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Date: Thu, 25 Jun 2015 15:11:14 +1000
In-Reply-To: <1434370268-19056-6-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-6-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-IZPg9OoU+3cQgTtO02Bj"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-IZPg9OoU+3cQgTtO02Bj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 				cpuhw->bhrb_entries[u_index].to =3D addr;
> -				cpuhw->bhrb_entries[u_index].mispred =3D pred;
> -				cpuhw->bhrb_entries[u_index].predicted =3D ~pred;
> +				cpuhw->bhrb_entries[u_index].mispred =3D mispred;
> +				cpuhw->bhrb_entries[u_index].predicted =3D
> +								~mispred;
> =20

This is much better! However, these are still bitwise rather than
logical inversions. They will work, but would it be easier to understand
if you used "!mispred"?

--=20
Regards,
Daniel

--=-IZPg9OoU+3cQgTtO02Bj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVi41yAAoJEPC3R3P2I92F96EP/iaO5VfUiYBTpfNQqKld8YYs
7C6mAWbN1Ww1GyK63OTGhGocgRXm4Emfqf5iI+YpV1SIWFMjKlHmEqTZXMgwNPmx
SVn8Q1IcP1cJN0s8LuhKyElM/aKZGXpGMLC3VNki9ie+ew/WHQ9Aia8gvzKDzZkL
kw8GNnwcC0cQFinsxA6twDoo0MscagGtoneSumBaJBIi7QAQDIDeIAxljOJN/Wu3
E18UfE7f5oGljwI3K4l3PJn81QtkNdPdOUf1jxhPv+ife1vmThnMJLnnEU9Hlu7U
k7h2gHVpyzkPbm8cOQs+2qFB3pLBA4JOAvpI086W9VNt/LHVmna/ikvw6L/xQpCt
yc0+SmVqqfj0DiSE6jvHPw8Vx/GOkTqJS75w/t+aa+lBh4Dmzi92XX/BEfZpA6x2
1Q045vGCjz1lS9leYbVgeUXdMg5r2Sfv8l4+EFCQ/gtpm9RUiT40CIxHC2oXUk3P
pq47rckNcsFCC4GfPktkkdAR6gaJd0cosegkAQwtqiN8OcieeVjRl6mLlWQolwUu
LpIEQRjNZuI14xiLjMKOOMfExBy7k9MVliBugRxq6JJDA7sfpCaHxEYetb1QafOa
tsXVEQWxcRIKkdU6bbQYbaRfyxTdQ/oQpqbNv3/0zX3mDw56mapkBomelB7Bw9NF
HAEF5Fc1KM2PUcwYC9rO
=LIUT
-----END PGP SIGNATURE-----

--=-IZPg9OoU+3cQgTtO02Bj--
