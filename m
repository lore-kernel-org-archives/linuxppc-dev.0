Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DE606A323
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYS9V1pB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRJG8638hz2xrC;
	Sat, 14 Nov 2026 13:38:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794623904;
	cv=none; b=S6c2dr25vfkv2RZF7teAqnrq35LsK+L7OLZkMtS+8SIJECRhjLFLM3Mv/9GGsEFLdXpQxME1eHpOfi4oeeefE9ki4NVWkEYGsmM+hWW6E4AS6lh3tzzKYIHoUw/4Syn7BZHnPaXZ0smGRvvw9qfmK2WTLVb94O+xBdw4+GYCHeYLvdnB0uuSCriA/yjuB1IXHKmD91nDWArUyM2X++XPfBlfTohCQPSy/aP0eHbOI5+BM4wv5l3Hg2xwE35RL2iutD+rijyvQVFOrSsGa+qXCkFRmybp/48glWMoaph6QtxUWjC758wO7QVt6ITp0GrSUUtCDbervGRAsqIK+FMmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794623904; c=relaxed/relaxed;
	bh=Fr+/kMFmCLsGicg9T6i0NCPKmoj+tnWS7HQ+lz/d99c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EyHVaTC07SaPQdgPvK6QHPqGQn8DA1z0TJAqqo6IOPbi+Dy3ulBE6d4MfMfYYDxy2W0iQupfjjOKywZ95ehpASvcog7dwGKm8sJUnHB2T33e1Yv8y9/oVH6VTPe1DGxSpqk7ZGDK+ntKoIrkVKxWsKOD5fFiITPjNDBgGOR21QRnFFu26tFDCgqFNinWab7c30gID39ZKKvJcgVkDw7Hmn1kj4gvtiHXQ2EhuJ14ixANa9B84RMgKKZl16kvxT3iri60vX6jos+fvm13ymeMzm9oBflHeSlJoo/BHuuW3e9TalV+nQqyye4E7Mk3WVCH/5Wysu1/9DaU9dBxGx7Xgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYS9V1pB; dkim-atps=neutral; spf=pass (client-ip=95.215.58.31; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYS9V1pB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.31; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRJG52gfbz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 13:38:19 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=LhWKw0hIjCAzkLgAvL9lXHI28yxzDvFvC+TmaniYtwk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794623879; v=1; x=1795228679;
 b=lYS9V1pBgRBdEL86Jb0hDCWN+xlxZHDRoQM5lC/+u9DSSJLBi5tsKmfTT4GGn4kfenE0Pu/o
 avTDRINzxymWiJnK0a8CdG6rdPiVhy1/pHBnFo02P23dEaI8WchVhHH7zyY/pbTrhAS6OPJnZi6
 Ag35eZsQ0eJFQLFXOFnHQnUM=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 9baa0a0f2146f049;
	Sat, 14 Nov 2026 02:37:59 +0000
X-Mizu-Trace-ID: 9baa0a0f2146f049
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages
 with PMDs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261030115326.1005755-1-songmuchun@bytedance.com>
Date: Sat, 14 Nov 2026 10:37:38 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Pavithra <pavrampu@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEAC0390-4347-401E-BB52-9D9BA3E93FDE@linux.dev>
References: <20261030115326.1005755-1-songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On Oct 30, 2026, at 19:53, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> PowerPC radix vmemmap population can reuse an existing PMD mapping for
> a device DAX range marked HVO-enabled. The reused mapping is ordinary:
> its tail struct pages are not remapped to the shared tail page.
>=20
> Leaving the section marked HVO-enabled makes memmap_init_zone_device()
> treat the range as optimized and skip initializing real tail struct =
pages
> that remain in use. This first triggers a zone mismatch warning, then
> faults while initializing the pageblock flags:
>=20
>  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>  Call Trace:
>    memmap_init_zone_device+0x164/0x430
>    memremap_pages+0x43c/0x93c
>    devm_memremap_pages+0x3c/0xa4
>    dev_dax_probe+0x264/0x3d0
>    dax_bus_probe+0x140/0x1c8
>=20
>  BUG: Kernel NULL pointer dereference on read at 0x00001400
>    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>    memmap_init_zone_device+0x358/0x430
>=20
> Without these diagnostics, the uninitialized metadata remains latent =
until
> userspace accesses the device DAX range and triggers a later panic.
>=20
> Mark the section non-HVO when reusing a PMD mapping so its state =
matches
> the actual vmemmap layout and core ZONE_DEVICE code initializes all =
real
> struct pages.
>=20
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so this patch cannot be applied directly to some older
> kernels. Older kernels instead need to pass the vmemmap bounds to a
> range-aware vmemmap_can_optimize() and reject optimization on PowerPC =
if
> a PMD leaf overlaps the range. This reuses the existing mapping =
normally
> and makes core ZONE_DEVICE code initialize all real tail entries.
>=20
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
> Cc: <stable@vger.kernel.org> # see patch description, needs a =
different fix for <=3D 7.3
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: =
https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070=
429.git.ritesh.list@gmail.com
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

Hi Andrew,

Could you pick up this?

Thanks,
Muchun



