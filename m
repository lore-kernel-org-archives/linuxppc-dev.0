Return-Path: <linuxppc-dev+bounces-28381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E42CA5FA4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htZZp6fy9z30WJ;
	Mon, 28 Sep 2026 18:43:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790584994;
	cv=none; b=JIbA17xQkFwQs3+lKTJ+JAr5uQ6p8BR82YBPdQ5EIohUuP4EJMlHnaAsjD1PPlchxFm0lpPhMySGGd8CdkmENsh/iauv2CvhHYcZQq49eTHY4s0qk0GMRux+4wQNdW+xjDdRuQPEQLOMB1JmH5cHLjsuvlzxJtHtCFI24mknnJ21zr2UrkIS97zxnVck+tnZdI77a1JOTNafqF0AWn1D9DQ7DWeUjbwNrlNkG3XA60kixHvVrqQNCrsb5sG94RtAvxIUXky/0yGjAoMswHYwrkxokjFysAcaUCjIBqYJ2GJS777XeKvCdyQn+8cx37WEi3m+PqLsEKTTf+9QgqkNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790584994; c=relaxed/relaxed;
	bh=E76/YfWbHqZZH9AFPe/RZhLmVNncPaFjzlO3MR/eBew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8x2NUCmR3PIFuPmxA57D2o4O1WcNexbUxQicqROKD4ua9nhOX+/sYDBCiPhDrkR2CqhcJzRCWB43BVnK93NMqiWnKWzfUaXQpq6oMvQE2aAwVSAq+1Vrpr6RpsgCJKidUm8I/6E3s2iUwMBUzdJ3EJGRkXPFpowwBxXY20uUMHnlJIDMHbgB3opVDHOSpp+Qhy5OY+rgW+tdHuIwfImu68sujs+3ETqwUT50LqdhyK9xl0ULHAFdUsw0CZcN+fxh8jN4UK5jBTMtudrhszyAMuQkN9UtfQkh11GEZ53w80iw3HA7SvZuzeKUNQlf9jdXz/rgbuOCvT5kIrl1DJqRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT2w6zGl; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT2w6zGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZZp0mWGz30WF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:43:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 59EC760AB7;
	Mon, 28 Sep 2026 08:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CDB1F00893;
	Mon, 28 Sep 2026 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584991;
	bh=E76/YfWbHqZZH9AFPe/RZhLmVNncPaFjzlO3MR/eBew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MT2w6zGlGUb23+uuNLyCwCEpY5WWukQVFYDPyhv3KmOe059p/K53PHsfZuM3HPs+6
	 MdEfsHyzTVtXVzK6/pPvFsPCZaRxIEr+SOsWmS2rWh8S87FVhSIBm7tC3zpEDL7UHS
	 oYC0WXMuRZlp/PHXjImBGChHWyX85GAfj6j3yoOqg0X17g3CYoxw5acwM5devozjKF
	 yYjKC3YM9WdRerSnW3nZsLS6j3YF2gBnHV/JCyN1cWKqzHKVwljm0BF+gI6Vi37XNH
	 7tc2+xSwfBvTtOUynyXFI1il1589u5YA8LhnC2Yh599ZiovBN67AdemETzsVsJhCc3
	 xN2V6+Y5cAGpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] powerpc: add support for Kexec HandOver (KHO)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sourabh Jain" <sourabhjain@linux.ibm.com>
Cc: "Hari Bathini" <hbathini@linux.ibm.com>, kexec@lists.infradead.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Michael Ellerman" <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, "Alexander
 Graf" <graf@amazon.com>, linuxppc-dev@lists.ozlabs.org, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Mahesh Salgaonkar" <mahesh@linux.ibm.com>, "Shivang
 Upadhyay" <shivangu@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Aditya Gupta" <adityag@linux.ibm.com>, "Mike
 Rapoport" <rppt@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1MgR1JP?=
 =?utf-8?b?VVAp?= <chleroy@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Nicholas
 Piggin" <npiggin@gmail.com>
In-Reply-To: <20260928083226.107807-3-sourabhjain@linux.ibm.com>
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-3-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:43:09 +0000
Message-Id: <20260928084310.10CDB1F00893@smtp.kernel.org>
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
- [High] boot: late KHO initialization allows memblock to clobber preserved=
 memory
--

commit 2f581dec390379323e7a0b4e4badb03487eea55f
Author: Sourabh Jain <sourabhjain@linux.ibm.com>

powerpc: add support for Kexec HandOver (KHO)

Add architecture bits to enable CONFIG_KEXEC_HANDOVER on powerpc. This
patch checks for KHO information in the device tree before unflattening it,
allowing a kernel booted via KHO kexec to recover the FDT and scratch regio=
n.
It also moves early_init_dt_check_kho() to be called from setup_arch().

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 4afaba19b5867..53c2f1897bfe1 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -923,6 +923,8 @@ void __init setup_arch(char **cmdline_p)
>  	/* Set a half-reasonable default so udelay does something sensible */
>  	loops_per_jiffy =3D 500000000 / HZ;
> =20
> +	early_init_dt_check_kho();
> +
>  	/* Unflatten the device-tree passed by prom_init or kexec */
>  	unflatten_device_tree();

[Severity: High]
Does calling early_init_dt_check_kho() in setup_arch() happen too late to
protect against early memblock allocations clobbering preserved KHO memory?

The Kexec HandOver (KHO) mechanism uses a scratch memory region to strictly
confine early boot memory allocations in the successor kernel. This prevents
them from overwriting memory pages preserved by the previous kernel, and is
enforced when kho_populate() invokes memblock_set_kho_scratch_only().

However, setup_arch() is invoked from start_kernel() long after early_setup=
()
completes. During early_setup(), substantial dynamic memblock allocations o=
ccur
before KHO scratch memory confinement is enforced.

For example, move_device_tree() allocates memory for the FDT:

arch/powerpc/kernel/prom.c:move_device_tree() {
	...
	p =3D memblock_alloc_raw(size, PAGE_SIZE);
	...
}

This is called via early_init_devtree() from early_setup():

arch/powerpc/kernel/setup_64.c:early_setup() {
	...
	early_init_devtree(__va(dt_ptr));

	allocate_paca_ptrs();
	allocate_paca(boot_cpuid);
	...=20
	early_init_mmu();
	...
}

Because KHO scratch-only mode has not yet been enforced during these early
allocations, could they use standard memblock policies and overwrite preser=
ved
KHO memory state, corrupting the handover?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928083226.1078=
07-1-sourabhjain@linux.ibm.com?part=3D2

