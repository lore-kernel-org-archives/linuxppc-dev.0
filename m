Return-Path: <linuxppc-dev+bounces-21133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9DCD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 21:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK9VP4zzQz2xpn;
	Tue, 19 May 2026 07:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779138733;
	cv=none; b=lM/d2ztYIM9kcvBe0ZQF8MbY2iELayUcajhX+QjJBpd4+v0lwUlqiMZj5yELtszjelpjTd6a9r+aBndmVk5m5DEFBZLwU56hTgt5TQCq/nNQTxjoWcMnRHfqTj1EEzhYHKXoidoKHGuF8huZKSbPXKMHPSRauXRWLcSfuTiHECTrv8kZdc8F1I2j6xxXTMUWlRcwxwadEmpwseRhFuDaJ7SBOZdPzUqiVIiY4hHu0Wqgltd1X9+xAEOrLzdOYAQ/dFinxvYSk4tDSF8YnOOx31Z311tTc7eh+NfqgSc7GvswXDxsuq7rytUl7LOp2zy+sbpL6dgl0N6X5fY2pfKiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779138733; c=relaxed/relaxed;
	bh=k9EMRiVmcXp445Bzm1MuxQc3uKBg58qEu2HWzDpPm/8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WyQ2O0hT0FH7xbTmIUxFIzPFHxm5L5kns9rtSthiHn3ADXngghl1oSJuCGH10PYB6kC5JXZmKrWmPps+znY+VvgOVV3NLl7JZUMJL3a7xB5AgNY41LLJCwf2C5ECGu06EstCPA6VRznZED8Dz2zF1l+0ZlbZZBnUmx5ocoFcuVQ3fFGHFObUzgj6z+tbhXHIEXusqkzGFliUJavT+Aenm1z/vIzBZWkIMjM1WNDptBQEp5r0wb519Sd2UIx/qY0I6x6MO7Q+hu6+4ymomE1L9R0azTmNxbGSwSSxfLGCFCf5fbQ0Pi2IF4FB10ubF2FWPx2B4JCWqiuj0Sw0U3uVtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=dmdzNWjT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=dmdzNWjT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK9VN20Ygz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:12:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5705600CB;
	Mon, 18 May 2026 21:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC18C2BCB7;
	Mon, 18 May 2026 21:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779138727;
	bh=6CbWyBWe6ek+skQD7ezBR5R72rf11+dnwrag4D/122Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmdzNWjTjK3Cc3C2V+DkRdbwT+d12xy/ZdRJ5bQRPDa4Caa5RS6kZ9MZ1ALFQP/+U
	 kc1KEx+sN56byuYGjJ5PbU1JGucdCZy76CwlbeuJ+r1GAPZ0VTw7F7ixRcBQbkK4OE
	 ese4fN8XpUeBQ1LjLfsivknyFMJ0f8eUvHc2/mMw=
Date: Mon, 18 May 2026 14:12:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Dan Williams
 <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, Song Liu
 <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, Li Nan
 <linan122@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID6 P/Q library v3
Message-Id: <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org>
In-Reply-To: <20260518051804.462141-1-hch@lst.de>
References: <20260518051804.462141-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 07:17:43 +0200 Christoph Hellwig <hch@lst.de> wrote:

> this series cleans up the RAID6 P/Q library to match the recent updates
> to the RAID 5 XOR library and other CRC/crypto libraries.  This includes
> providing properly documented external interfaces, hiding the internals,
> using static_call instead of indirect calls and turning the user space
> test suite into an in-kernel kunit test which is also extended to
> improve coverage.

Cool, I'll add this to mm.git's mm-nonmm-unstable branch for some
linux-next testing.

AI review found quite a lot to talk about:
	https://sashiko.dev/#/patchset/20260518051804.462141-1-hch@lst.de

