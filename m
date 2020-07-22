Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 08:29:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE24D20714
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 08:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IRUmpXyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE24D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBTCQ5p2kzDq9G
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 18:29:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBT981Gf0zDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 18:27:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.a=rsa-sha256 header.s=201602 header.b=IRUmpXyL; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBT975QpBz9sSn; Wed, 22 Jul 2020 18:27:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595406443;
 bh=5oBiL0zY8LaOsvPSs61/dmYNQNxr4DLYffd2QJrYkdY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IRUmpXyLPrLpGuEquB9LP/N6XzynPVWNVJpk8rC9pjK6LmOlNEZmJePiH30Fo8lSK
 ZQs97rhk0+kG5U/kDHw20xz8XXG4O/+4Su6iBGt+J5sLmp759s8ABWylUQOrHmOHVK
 Pr2lyL8yRb4BfEXPzc+3XHbevxbvfy+gBczz3CVI=
Date: Wed, 22 Jul 2020 17:51:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] powerpc/mm/radix: Memory unplug fixes
Message-ID: <20200722075153.GB5513@umbus.fritz.box>
References: <20200709131925.922266-1-aneesh.kumar@linux.ibm.com>
 <87r1tb1rw2.fsf@linux.ibm.com> <87tuy1sksv.fsf@mpe.ellerman.id.au>
 <20200721032959.GN7902@in.ibm.com>
 <87ft9lrr55.fsf@mpe.ellerman.id.au>
 <20200722060506.GO7902@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20200722060506.GO7902@in.ibm.com>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:35:06AM +0530, Bharata B Rao wrote:
> On Tue, Jul 21, 2020 at 10:25:58PM +1000, Michael Ellerman wrote:
> > Bharata B Rao <bharata@linux.ibm.com> writes:
> > > On Tue, Jul 21, 2020 at 11:45:20AM +1000, Michael Ellerman wrote:
> > >> Nathan Lynch <nathanl@linux.ibm.com> writes:
> > >> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> > >> >> This is the next version of the fixes for memory unplug on radix.
> > >> >> The issues and the fix are described in the actual patches.
> > >> >
> > >> > I guess this isn't actually causing problems at runtime right now,=
 but I
> > >> > notice calls to resize_hpt_for_hotplug() from arch_add_memory() and
> > >> > arch_remove_memory(), which ought to be mmu-agnostic:
> > >> >
> > >> > int __ref arch_add_memory(int nid, u64 start, u64 size,
> > >> > 			  struct mhp_params *params)
> > >> > {
> > >> > 	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > >> > 	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> > >> > 	int rc;
> > >> >
> > >> > 	resize_hpt_for_hotplug(memblock_phys_mem_size());
> > >> >
> > >> > 	start =3D (unsigned long)__va(start);
> > >> > 	rc =3D create_section_mapping(start, start + size, nid,
> > >> > 				    params->pgprot);
> > >> > ...
> > >>=20
> > >> Hmm well spotted.
> > >>=20
> > >> That does return early if the ops are not setup:
> > >>=20
> > >> int resize_hpt_for_hotplug(unsigned long new_mem_size)
> > >> {
> > >> 	unsigned target_hpt_shift;
> > >>=20
> > >> 	if (!mmu_hash_ops.resize_hpt)
> > >> 		return 0;
> > >>=20
> > >>=20
> > >> And:
> > >>=20
> > >> void __init hpte_init_pseries(void)
> > >> {
> > >> 	...
> > >> 	if (firmware_has_feature(FW_FEATURE_HPT_RESIZE))
> > >> 		mmu_hash_ops.resize_hpt =3D pseries_lpar_resize_hpt;
> > >>=20
> > >> And that comes in via ibm,hypertas-functions:
> > >>=20
> > >> 	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
> > >>=20
> > >>=20
> > >> But firmware is not necessarily going to add/remove that call based =
on
> > >> whether we're using hash/radix.
> > >
> > > Correct but hpte_init_pseries() will not be called for radix guests.
> >=20
> > Yeah, duh. You'd think the function name would have been a sufficient
> > clue for me :)
> >=20
> > >> So I think a follow-up patch is needed to make this more robust.
> > >>=20
> > >> Aneesh/Bharata what platform did you test this series on? I'm curious
> > >> how this didn't break.
> > >
> > > I have tested memory hotplug/unplug for radix guest on zz platform and
> > > sanity-tested this for hash guest on P8.
> > >
> > > As noted above, mmu_hash_ops.resize_hpt will not be set for radix
> > > guest and hence we won't see any breakage.
> >=20
> > OK.
> >=20
> > That's probably fine as it is then. Or maybe just a comment in
> > resize_hpt_for_hotplug() pointing out that resize_hpt will be NULL if
> > we're using radix.
>=20
> Or we could move these calls to hpt-only routines like below?
>=20
> David - Do you remember if there was any particular reason to have
> these two hpt-resize calls within powerpc-generic memory hotplug code?

I don't remember, sorry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8X8BYACgkQbDjKyiDZ
s5JhQxAAmPVnY5hHgvzJE10d8K54XvWiy8uCAFjaKWUb8/dPphgQEBepjWP10ckx
q1EVNdnRjKrgVgX+duFt9jHbm5SFX6G2RFcSYnrb0t6hPr8v0pOj7v8VUw1QcqSw
cYgyCq0xFbatw0y39luYMrSpWzuLsXVAT33yi2/jcbwdEA5thvaWovrkpkfU16m/
7MIYYlyeJaUm7enro5f7o9qfsRYTJ6rUY9RNgHAgvYVo3OB2yuwz9E7wc1DPHcD9
etuy78Kz3t6xO7/9bDYFu1LzJpIB+LS7wVxmAjCLpfABQlnrVoC2iOiIrx40DYX5
A2t9TOhEqXQQxvpvc94xYcVu5GU83Jpcl2FbXRTiAd53MqSpMwIQK+66UsEPdWCD
TELkBEfzIyYGaPJzP3atlJymOeaAX8gfpHi8kPRPyAfIwSIFbA1PWVJ4/sKVrZNG
rLFpJJI5da5G/TTh9ssqOlPoyWMm8yFep9KR8hM4AjAs6G6dtWqih8/UpcMdxXut
7PXRgNd9BEwBmYq+/E/hVzKYFMqYO9OHSvqJxqtc6GCnW2vDYkZds/j0vzbM38sd
eFCVz+UPf+Eqf0gTYCCbzxAlWzwxPM1+knwoj2W2ypwExBK3W+DZ/s+/395VCZY7
MW4zkaKJf5sHB7BqtVxNUwImu/RETSlHteg70hbw4GGVG/LESpw=
=4dvk
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
