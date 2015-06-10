Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F16491A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 14:37:22 +1000 (AEST)
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 443A71402AB
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 14:37:16 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so28939671pdb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2015 21:37:13 -0700 (PDT)
Message-ID: <1433910976.3096.26.camel@axtens.net>
Subject: Re: [PATCH V8 03/10] powerpc, perf: Re organize BHRB processing
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Wed, 10 Jun 2015 14:36:16 +1000
In-Reply-To: <1433763511-5270-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-F3dSe2WKDK/roJllFKaJ"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-F3dSe2WKDK/roJllFKaJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> +void update_branch_entry(struct cpu_hw_events *cpuhw,
> +			int index, u64 from, u64 to, int pred)
> +{
> +	cpuhw->bhrb_entries[index].from =3D from;
> +	cpuhw->bhrb_entries[index].to =3D to;
> +	cpuhw->bhrb_entries[index].mispred =3D pred;
> +	cpuhw->bhrb_entries[index].predicted =3D ~pred;
> +}

I realise you're copying existing code, but:
 - could you please rename pred? If we assign .mispred to pred
and .predicted to ~pred, we should pick a different name for pred.
 - I'm really uncomfortable with the bitwise inverting a signed integer.
Can you explain what is going on here? Looking at
include/uapi/linux/perf_event.h, this seems to be a single bit flag:
shouldn't this then be a logical flip rather than a bitwise one?
(Furthermore, looking at that header, why is pred an int at all? Why not
a bool?)

> +
>  /* Processing BHRB entries */
>  static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>  {
> -	u64 val;
> -	u64 addr;
> +	u64 val, addr, tmp;
Please don't use 'tmp' here. As far as I can tell, you use this variable
to compute the 'to' address. The name should reflect that.

Regards,
Daniel

--=-F3dSe2WKDK/roJllFKaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVd77AAAoJEPC3R3P2I92FXYQQANQY9OJ2JXU62eMPqu27wW8W
jT4OgvKkni3de69Rcmbo+sOMRMIUp952r9wvk37SKt5Hl4pplb94QN7i2Vr8Q3xe
toegHIRQpg0fD2jl3m7QFspB8Imb7DguGnTCGevZdNlQKJMhHjFGDsE2mlU+CiC5
VXZnmKAKyLydNlpr5mi0Jfdw+hO4bCqDWYTiUmRG0Z06DaYnCMfJQcx1lU2KyMs6
ZiCrKoeQjFL36EqisokOCvg9RwtmfSDQAMTIr7wr9cIo0UYTqU6346ewCsi8puQB
syek7p71PJPdhTLVpZgnpNvuisvX2oxbFwnBdI1KveuBjmpRhX3VhFItMnwnD82+
pLPtHGhb0FJubpHxu+WVpGmbeWm30/tDaLUjLGXTR8QDV4zkYcnv3g2DemF6450i
Yg8wG7QJx7k4QGQQS9ZKxszpD1Rr9TUOYsEkCpOka2W2KZ7tk9gJSxWausaK412r
z6F4C8Us35jhf2BW8xo2yKiS5Fo0LSPdFOJ3DVkeuPKQfnQIPhv0FVJG/8oeCtXQ
sKIi+/k2+5V3EIFbHlA5taGcm3dYP08BCZXuXS2HGrLqrnhr5L60TWh1TqGneZbQ
jvsrcblgXCSCczswXwSMAw8SR80gfLp4CRJVHapVoKNRMa4ZRGdv22sRskT+92m8
BTR1dQW2ZWVIRdiPkMre
=3h0O
-----END PGP SIGNATURE-----

--=-F3dSe2WKDK/roJllFKaJ--
