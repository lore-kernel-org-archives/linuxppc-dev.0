Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D4C46CD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Dec 2023 14:35:48 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jR60heL5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SxVGB6CJnz3cdV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Dec 2023 01:35:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jR60heL5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SxVFJ063gz3cP3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2023 01:34:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 726CFCE21B0;
	Fri, 22 Dec 2023 14:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DD5C433C8;
	Fri, 22 Dec 2023 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703255693;
	bh=wD+DMULNfcm5v8XBB1zPgHfSQmHjnNJXjMQ/L2uZCUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jR60heL5YoJ84gLmfHknmBiULDdGVsMMFgLQPfZCYpy78qODZ1J1sj/eVo4tR/f8z
	 DwF5RCDyZbO6L6vA/PV94WL9baUoKHKWqNn9tDDmndx9HosFKmLvGdiYyIn6raooh0
	 6euKwvSP+2R+sicagkmQNX20Ga751Z8xj1Xl2OK7lP4lu7JezvrfqYI69yJcX5yh4V
	 QYCThon4gk1S3HT31/NBvXkQZPkoCKAiXrSXikKI2n53dH9WXlvcjBjUk7jr4hzRJ4
	 eP3lk91zvAlNy7Cbj2nmvs/mXx9QDbUSNrvQ4k8wq4r26626NRHUZljsLU+dUiRY+N
	 Vz9xmjFVSUFUg==
Date: Fri, 22 Dec 2023 19:59:25 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/bpf: ensure module addresses are supported
Message-ID: <qi7rglfbf5bzkbsvuzpfrjwglobltam2ejvvf2hmdau2jd6qqf@af2q5pxoiywz>
References: <20231220165622.246723-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165622.246723-1-hbathini@linux.ibm.com>
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
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 20, 2023 at 10:26:21PM +0530, Hari Bathini wrote:
> Currently, bpf jit code on powerpc assumes all the bpf functions and
> helpers to be kernel text. This is false for kfunc case, as function
> addresses are mostly module addresses in that case. Ensure module
> addresses are supported to enable kfunc support.
> 
> This effectively reverts commit feb6307289d8 ("powerpc64/bpf: Optimize
> instruction sequence used for function calls") and commit 43d636f8b4fd
> ("powerpc64/bpf elfv1: Do not load TOC before calling functions") that
> assumed only kernel text for bpf functions/helpers.
> 
> Also, commit b10cb163c4b3 ("powerpc64/bpf elfv2: Setup kernel TOC in
> r2 on entry") that paved the way for the commits mentioned above is
> reverted.

Instead of that, can we detect kfunc and use separate set of 
instructions just for those?

Unless unavoidable, I would prefer to retain the existing optimal
sequence using TOC for calls to bpf kernel helpers, since those are a 
lot more common than kfunc.

- Naveen

