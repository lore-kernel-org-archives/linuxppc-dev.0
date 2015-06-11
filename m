Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA4801A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 13:33:21 +1000 (AEST)
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EED7F1402AD
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 13:33:20 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so49336316pdj.3
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 20:33:19 -0700 (PDT)
Message-ID: <1433993542.31423.37.camel@axtens.net>
Subject: Re: [PATCH V8 03/10] powerpc, perf: Re organize BHRB processing
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 13:32:22 +1000
In-Reply-To: <557828ED.9090803@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-3-git-send-email-khandual@linux.vnet.ibm.com>
 <1433910976.3096.26.camel@axtens.net> <557828ED.9090803@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-azhgnOZ9KJPUI8NDzVG3"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-azhgnOZ9KJPUI8NDzVG3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> +
> >>  /* Processing BHRB entries */
> >>  static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
> >>  {
> >> -	u64 val;
> >> -	u64 addr;
> >> +	u64 val, addr, tmp;
> > Please don't use 'tmp' here. As far as I can tell, you use this variabl=
e
> > to compute the 'to' address. The name should reflect that.
>=20
> Agreed but then it will be a new preparatory patch at the beginning
> of this patch series.
>=20
I don't think I understand what you're saying here. Why do you need a
new patch? As I understand it, you've introduced 'tmp' in this patch;
couldn't you just rename it to, for example, to_addr, instead of tmp in
this patch?
--=20
Regards,
Daniel

--=-azhgnOZ9KJPUI8NDzVG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVeQFGAAoJEPC3R3P2I92FwcgQANZIfugPaNMfzljdtJhil+2S
bEcza7Ybm1sgO3k4Yp8ktqloqYvuwaivDPzeDEM6Rs62dUs4NgkKbPWbOKrGBCsh
AABqZjqHmHi6Ff8EMqx+IV1JgFr+dvkeTmppKAKNeGPMXrHYdCWmmmsRqsRtVTHS
j+6hKU7oNmLz9t29SLV6C+/AeJUD2vPRJylPzFNDRs8aI5dm14HtftsX6Hi3SmmS
HgTKFNFVeEcuY5RZ13m/dkSRpp7URWD5Rm7dPxIL+uyxmkhl8UFio0CAYXhdUjm4
ungD0sE43T9R+oRUkFx1gctcN3m6vezXVHpBHzUYrP8Y8m2zhR58ySWHmLhilZ6+
i3i7F8mn2Gf72+4OZHS56ZZkbk8hdfM6qN909A6xGVnW4liMftDcSX6o78tDCqT8
YgnCPPN6Uf4nZFSTWoJa1zz0VdEqm7YcwyrA7g+TK7kViYwbwtyptg+35QYNT3Po
vL0F/u4avu/3k8QbXqpefcCkoCxqOS2+JBexIa/ddvNgYIMS/hBUUVD/hWWFRRp4
nCYmoI/wMGMORSVYATETcNW7afjOMYmrrThX5o7avmhNz8+bEzYD4Aa5x/YfVDHR
yKdXZ/mRt/SujEHmIDjrxxxwIcpz/9pA4auTXDZb3ZBSflytzYiGSM+DtCSZv8bS
m9oXUpuBGcFBAvjBtjbH
=VVYz
-----END PGP SIGNATURE-----

--=-azhgnOZ9KJPUI8NDzVG3--
