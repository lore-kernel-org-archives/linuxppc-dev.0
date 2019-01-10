Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2ABC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 22:56:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFFD206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 22:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ppf/PBuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFFD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bLvs6vXhzDqyl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 09:56:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bLsw3sJbzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 09:54:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Ppf/PBuU"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43bLsw0wCHz9sCs; Fri, 11 Jan 2019 09:54:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1547160884;
 bh=LitWFpvdKXNjMwZx0YTbEvvuJx/7dVVFpRuZO0vLFk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ppf/PBuUjkRWx6hYiEH7S7Ki9EO5l9PfNgW7iHtaF1DnzV9sad8MfxtImGLzuaSnb
 XvCSZdqL795ujNGsb232wLnt+trJyhcUoC0Uq2382BmDSJAQr2o+nvTTvYmmyoj65x
 T2r0+Zzd4fONoEwytSQvxXyw73yKrnoSbojVgck0=
Date: Thu, 10 Jan 2019 15:11:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH V6 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of
 CMA region
Message-ID: <20190110041109.GG6682@umbus.fritz.box>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
 <20190108115620.6ec22e7d60b86d5f609d5a87@linux-foundation.org>
 <875zuyjk96.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <875zuyjk96.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 02:11:25PM +0530, Aneesh Kumar K.V wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
>=20
> > On Tue,  8 Jan 2019 10:21:06 +0530 "Aneesh Kumar K.V" <aneesh.kumar@lin=
ux.ibm.com> wrote:
> >
> >> ppc64 use CMA area for the allocation of guest page table (hash page t=
able). We won't
> >> be able to start guest if we fail to allocate hash page table. We have=
 observed
> >> hash table allocation failure because we failed to migrate pages out o=
f CMA region
> >> because they were pinned. This happen when we are using VFIO. VFIO on =
ppc64 pins
> >> the entire guest RAM. If the guest RAM pages get allocated out of CMA =
region, we
> >> won't be able to migrate those pages. The pages are also pinned for th=
e lifetime of the
> >> guest.
> >>=20
> >> Currently we support migration of non-compound pages. With THP and wit=
h the addition of
> >>  hugetlb migration we can end up allocating compound pages from CMA re=
gion. This
> >> patch series add support for migrating compound pages. The first path =
adds the helper
> >> get_user_pages_cma_migrate() which pin the page making sure we migrate=
 them out of
> >> CMA region before incrementing the reference count.=20
> >
> > Does this code do anything for architectures other than powerpc?  If
> > not, should we be adding the ifdefs to avoid burdening other
> > architectures with unused code?
>=20
> Any architecture enabling CMA may need this. I will move most of this bel=
ow
> CONFIG_CMA.

In theory it could affect any architecture using CMA.  I suspect it's
much less likely to bite in practice on architectures other than ppc.
IIUC the main use of CMA there is to allocate things like framebuffers
or other large contiguous blocks used for hardware devices.  That's
usually going to happen rarely and during boot up.  What makes ppc
different is that we need a substantial CMA allocation every time we
start a (POWER8) guest for the HPT.  It's the fact that running guests
on a system both means we need the CMA unfragment and (with vfio added
in) can cause CMA fragmentation which makes this particularly
problematic.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw2xdsACgkQbDjKyiDZ
s5J9sBAA5lc1/Su5Mk8Js41SPXyYqpqL564xEbq/qnGSLpg3S6KalgBl3t2cwN/0
mcd68QCi6vsD659ZwKtvraQDMA5Mk5mCMXaJo59WnN5eaio+gjQ6e5Ii8AjZjO/N
peQhvsmk1TAy5GIC+h+s8o3g8r2gr5N/XxYnLBSz5DZhGtLH1Kpge1e6Gpk0dhlM
CM59ss0KWfO912VtHicpWwsOt2ac2Nfk9HKBlPtboefLKjAf8lc/Yggaz7NWrm/Q
Of5QXd94PaoH41Fy/t89LMOt4NuqTywx6/H0fcVCrYOxtHi9AMZ4o0xnEe+d1NqE
1LWVs6UTDgtSNkwygki7d3p3nY5vdLOsR84iioKZN5Ssvlv99pEDyBu55fhNvEO6
l4Q5cJigSk2Wxonn26Ktf50Ye3UV1JDFzvv4JQx19EfzvOI8aZREQWAJPvS0/s6n
vb2NZg6MG8jLy7havZxqxGpTZEqWLt4u3ksDbAeOL2qNpYzrELIeNb+rKJOnF/BN
wFWZ22vtrlXxJFDyTlOWTKLtX95PhYeviuZAqTqc8nTRbpe963rDpztxGOOclBG1
nipPp01RnwPG2XaqTdYnANWVFG0EHjdO+qQ8Ea9J5QCOswHjP02kbdPjPG5fb2zC
/gdOd9+Co4t0tZjCreB96Bn/1GAzaj0TCyADV4hWEwlhUoKnBSI=
=f8fd
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
