Return-Path: <linuxppc-dev+bounces-28380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85076C9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:42:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htZYL6k5Mz30WF;
	Mon, 28 Sep 2026 18:41:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790584918;
	cv=none; b=G9AK6Xs/9PepI780ZjQAll0FCNjU/gx9WkkAWIUJocDZka82M+rHL9TLtOEEERX97bUctskwLU9o5MQ5kdnkHeMxS+DNh0lZhA89l+08u1pS1UYhPJGDdmz9gQ33O+VwifyqIuGVPqOCoM6uY/nNKSG/hg5+spDOhknMjq/ZEWYHcgdUucnRxugpb3MlwfL9wHNpQtZH0EaMUmhaidqHdGkLuczXZgqW8ozp0oZi3lzQqOgTA6XnQ7AAPVVGv6YGTOlFt+vpW8QxgWYi4dc/fv+SSgUl9BT5HbbZfgQGUzlCfquLLfLlQYxV8/ucCN8uOGN7yoeIygvpMRavHpBgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790584918; c=relaxed/relaxed;
	bh=TdNzTDhEchXUCyf1n2C/rpdeXch7Ae3LIrA75qOk4gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+x8bC3zDVhT4zHPiag9yEbHi4RgWtz1NeZGD+FAKMtmAx66Sza9HejRjcp4S83RcGoddQ85Czl1prRGzTredhFsFTcPkIVfebEGIu/vmem42P224ufiHwHXfgswLd44tBONV3yfO0wJneKohIcmcbivORebt6vcv2WK5vj5gDAQYwVN3piKNy7PEQLzUMw318Iohq2Mb18PUb7dvE+LGx7akznSJPori3DCkTbEohFxc73Pdju5CalfJjMdjozY+iSH58OXWu1Hcjn2SzLfry5QG9VZVWA07at7dCpFaFMF5zBfea3P2ABJF/zeFhNB4yT3iBxY8jd+JGqgjMA63A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD8hEsHe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD8hEsHe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZYK5VCSz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:41:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 069D260052;
	Mon, 28 Sep 2026 08:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52D21F000FF;
	Mon, 28 Sep 2026 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584913;
	bh=TdNzTDhEchXUCyf1n2C/rpdeXch7Ae3LIrA75qOk4gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PD8hEsHegiJzwCoePhw1+13WgFrtcq5hV7DTTk9e9nX3Q4vTo9/bAAqtyfPzV33VA
	 UvFDDccr/S4U2abGu8aTXiyCYGLlo13zWYfcYy/ejx2oy769fRe1PrVDyliVYT9UOt
	 d8tLB6Q/U34borY1Xq3wUDCcDFbihcCGYan8Qmg0olnueWp8k11Q7DEYl6ZwoN1aiG
	 oSS/UCTtpOjOgQM86e8R3yQuUyY3LmKwW36neXL9zEbJ9QR9W77mSlPjPrMEtd8oGH
	 wZbMTRv9ATeMpjc9W1QR+bD1H6DPnrBEY2l8YvzjNhAvZXfCdMwAB+vdpMD7xQp7j9
	 tW8irqCisFMJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sourabh Jain" <sourabhjain@linux.ibm.com>
Cc: "Aditya Gupta" <adityag@linux.ibm.com>, "Baoquan He" <baoquan.he@linux.dev>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1MgR1JPVVAp?= <chleroy@kernel.org>, "Mahesh
 Salgaonkar" <mahesh@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Hari
 Bathini" <hbathini@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>, linux-kernel@vger.kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, linuxppc-dev@lists.ozlabs.org, "Andrew
 Morton" <akpm@linux-foundation.org>, "Alexander Graf" <graf@amazon.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shivang Upadhyay" <shivangu@linux.ibm.com>, "Nicholas
 Piggin" <npiggin@gmail.com>, =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
In-Reply-To: <20260928083226.107807-2-sourabhjain@linux.ibm.com>
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-2-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:41:52 +0000
Message-Id: <20260928084152.B52D21F000FF@smtp.kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kho: bypassed scratch alignment check during resume causes memory =
corruption
--

commit cbd7cb7f008e704b389d8dfe3306e1e83e49e8a8
Author: Sourabh Jain <sourabhjain@linux.ibm.com>

kho: check scratch vs CMA alignment at runtime

KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
which was previously enforced with a static_assert(). This commit replaces
the static_assert() with a runtime check in kho_reserve_scratch() to allow
KHO on configurations where the minimum alignment is not a constant.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 7c4d86daf86d5..dc76dd6b74da7 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>  	if (!kho_enable)
>  		return;
> =20
> +	/*
> +	 * This is the minimal alignment required by deferred struct page init.
> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, whic=
h looks
> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> +	 * If KHO scratch is not aligned to that value, buddy can access uninit=
ialized
> +	 * struct pages, which can cause a crash.
> +	 */
> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {
> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
> +		kho_enable =3D false;
> +		return;
> +	}
> +

[Severity: High]
Does this new runtime check get bypassed during a KHO resume?

During a KHO resume, kho_memory_init() skips kho_reserve_scratch():

kernel/liveupdate/kexec_handover.c:kho_memory_init() {
	if (kho_in.scratch_phys)
		kho_mem_retrieve();
	else
		kho_reserve_scratch();
}

If a predecessor kernel passes a scratch region with a smaller alignment,
and the successor kernel has a larger pageblock_order, bypassing this check
means kho_init() will iterate over the provided scratch memory using the
successor kernel's larger pageblock_nr_pages:

kernel/liveupdate/kexec_handover.c:kho_init() {
		for (pfn =3D base_pfn; pfn < base_pfn + count;
		     pfn +=3D pageblock_nr_pages)
			init_cma_reserved_pageblock(pfn_to_page(pfn));
}

Can this lead to init_cma_reserved_pageblock() overwriting state for pages
outside the actual scratch region bounds, or cause a crash in the buddy
allocator if __free_pages() is called on an unaligned PFN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928083226.1078=
07-1-sourabhjain@linux.ibm.com?part=3D1

