Return-Path: <linuxppc-dev+bounces-18120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CD5105A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 13:46:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWpnY6xvZz3cFN;
	Fri, 13 Mar 2026 00:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773323217;
	cv=none; b=nx+p6Zxi9HgTWTkzARGp6z9JFqa4mtD6upkJmzj+jxIXkyesRhLGnjtBKrseK/gA/AiVpeS0yWxiiS+3TQwLnzpuVhIftS7A6MzYDI+Zl1+V6Fg176dJT5y9rteGok1vLhxX2ybd0DyBIKReNP89cwpdj+ytbytkSQhu8627u3HwKz7aMpPhue+EGhDPl77LOui99X4vq/GxftpBBCocDjwX808wnG0Qchx15uREr2nT1Ll/O5Y43kvebcPU+i5lo73KLxtq65APZwdQTihJT971cJsM+LC2jYO4k/4B0yjQ8hL91qgySUHFkj5qKdljmh3/Vn45qXGu1MIRsY7/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773323217; c=relaxed/relaxed;
	bh=l8xdTzfmFI9blWnX69yppRL0CTG4tWAVHoV5RzxnJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFKXQ3PEOMveLnItODyQ4NOvdqOLL1JwauLW30CB1p4P0wCD0MhSa+gFJFcHJfpTnCJGnY6fQIyp4SCgufIiInWcIa0d7NIObhmrM2DNMLhp5n6YbBMFbIiq8raST7I9tsgC65pMqvk8B/3TFauYB8Qw1X4/KYu1WwFVK6pyk4y8YbAixRjbi/XL4+lq+L5AHI//IsRk9nplaIqPDQn3t3RVvfVfGnKpK+fjeOjqsyRAD7i9BK8G7JH97KduL4y3kfFMHfHWbvwoG1PzvuUZ32RJkSqpJ1x/+o7qpVEknM5OnOrJvuuFEXoc6x1Rj2VsbxaXlMHer3XkgOF6y3cNhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=aNowo7eU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=9irl=bm=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=aNowo7eU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=9irl=bm=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWpnV5czxz3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 00:46:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0023060145;
	Thu, 12 Mar 2026 13:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0435C4CEF7;
	Thu, 12 Mar 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aNowo7eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1773323205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8xdTzfmFI9blWnX69yppRL0CTG4tWAVHoV5RzxnJ4M=;
	b=aNowo7eUwaDEsiVlTqmEAkItMBfiAqnQpwNdW5+Iir3vEvTnk82QibP2d05ImlF0a165mh
	nmvWlvpeFzo1/3YJJgy9A68B3kA75iz0ORvDTg44s5evgsV+Q5arPoARsc9Mpj0kc03vTo
	y0krEtMS6grTzTv7HePJJwYz8b+7S/w=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d18605ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 13:46:44 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:46:39 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] random: factor out a __limit_random_u32_below
 helper
Message-ID: <abLDvwa7c3OXm_e2@zx2c4.com>
References: <20260311070416.972667-1-hch@lst.de>
 <20260311070416.972667-27-hch@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311070416.972667-27-hch@lst.de>

On Wed, Mar 11, 2026 at 08:03:58AM +0100, Christoph Hellwig wrote:
> Factor out the guts of __get_random_u32_below into a new helper,
> so that callers with their own prng state can reuse this code.

What Eric said. random.c is not "some library code" meant to be pulled
apart like this. If you think there are some good general purpose
arithmetic functions, by all means develop shared infrastructure in the
right place. But I think for this super simple/trivial _below function,
you can probably just place it additionally where you're using it,
without needing to touch random.c.

