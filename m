Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B111D1A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 15:43:20 +1000 (AEST)
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BBB831402DE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 15:43:18 +1000 (AEST)
Received: by pdcu2 with SMTP id u2so45917110pdc.3
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 22:43:16 -0700 (PDT)
Message-ID: <1435210920.4286.38.camel@axtens.net>
Subject: Re: [PATCH V9 02/13] powerpc, perf: Change type of the bhrb_users
 variable
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Date: Thu, 25 Jun 2015 15:42:00 +1000
In-Reply-To: <1434370268-19056-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Gvwx9E4OTyn0YwyLc7+h"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Gvwx9E4OTyn0YwyLc7+h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -	int				bhrb_users;
> +	unsigned int			bhrb_users;

OK, so this is a good start.

A quick git grep for bhrb_users reveals this:
perf/core-book3s.c:     WARN_ON_ONCE(cpuhw->bhrb_users < 0);

That occurs in power_pmu_bhrb_disable, immediately following a decrement
of bhrb_users. Now that the test can never be true, this patch should
change the function to check if bhrb_users is 0 before decrementing.

>  	void				*bhrb_context;
>  	struct	perf_branch_stack	bhrb_stack;
>  	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];

--=20
Regards,
Daniel

--=-Gvwx9E4OTyn0YwyLc7+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVi5SoAAoJEPC3R3P2I92FGI8QALc2bNuFLOJDEPe6jVDLJFsb
scnI51hWOgnlSQFANqgnJEAFs60Rl8yUaPVHe2JyLoDG2v9pvwVasAgWd99tMiWp
ghd30H2ozAZSjyJQE/zxuMFAqsr2OiTMNPGO5B4hlRy6u72YJc5vCrcgHokPvvDm
p4/owuqDH1KV5DeA6rlkuKYs2mwF1vfW3cCl6YafqDBbaaSZs6/FT/TCQjZxiJ2k
1JQlnx76OF+2CvCaoN2qyc7bnK9tR5sPnmYIvYzs7vb4gfmhsK/bLtImTBNhVSFi
A7htAz+C6rn1UY7G5T3hIPi+IY1hpmMym+BJeWY1d8aTDk45nRQexm8b2FFidhEX
SH98s2eDqOGHFNnhNfLM3j0X+OH1X3lXRY+CqRVQnnG2cXuQzWKjzRmGKdhNmmgj
05hqki7rr7UFP2QCmYLak2s3g1rTp6rUTqzT3Fr15rd4xJ1C/caRHS4S3xEOBmAi
FeB2v4tzI80w6NnAgoLikLQufM2xlrDdiPCTQHeV5Vp6zBqilHDMMSsYVCCSOffp
0vEn1w6LF9YJbKCdtxmjcpK4c/Y/h8bovUKxCmxmlizwUsVKbml9SC9bi73eRu78
VTtzrVxkzNH6xpRrvdOezx0sHm9ywdemV4arsvrRVsUOZkgh2SHU3u28Lz4BK4yq
vvFMCbxl4HYIZWB26Wfv
=Qmn2
-----END PGP SIGNATURE-----

--=-Gvwx9E4OTyn0YwyLc7+h--
