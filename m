Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mykMNeh5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJqZ6PBZz2xmV;
	Thu, 12 Nov 2026 23:00:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794484826;
	cv=none; b=EMSVXF4FbS4wSJVCp1hkuJJEj+NP084KaPiR2LNrAIpNgIKU2AKFJrQwdSUiB3OkTiuxI/Oh2HINX+byCWM2kOSMvhWlr59TUBnJF4d1LOlVXhkcjrYgzlxghh/oF8PuIW4k96e6UbfSHZruS3M/LFoZ7IaVILwW3XjvWoqk7yFsfc0pCgD7MU7kHXlEtWJgxu/qdfSHnqdpD1HNPQP+D4u9f0vcsCqhWQPhuFE6D2aA5CVhKPMk+bM914csX5tVb5mfYXqxEAIRlP9hehpfw/+yeWiN1AwRXko8jccMU8Kprr+kLpytKHcAzeo+wLYoE225Yra3SYWmNPUgl4iKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794484826; c=relaxed/relaxed;
	bh=wTN3UxTT/XXw7NH/F07ZSE1+SznsV7bVJZdXlw3Sm0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Azk9ewKZLC6zezZ3HkRG6y7tSJEjdrRGmzTvIiDFIUKLgqkIDsU0Ya6Hl5o8UZzgMFaeaHqRquc6m87xu07AFUOR/1T968TtDbDjJotig+U8GUsedzNRXmXK8HR6YkognkWRh2lKW9o8IUyrVx5lpBEJE64R1UvKMGa7jLLMbV4x1iZreXR/nr22TmLCdnxT51dEYJMg9i43MQleatBzKW2PVt0qZmxqgyT9kyfsOBuC7PMTdeXjLsQXNRFx2M70UdrReOuBXUmAqMV5oDM0cRYWPAXKVdi2w98L5mffz38UYAH/yzNoAynLdvLW1uh65DsEyfOjI275bCgyNSN2+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mykMNeh5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mykMNeh5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJqZ09pdz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:00:25 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E06B163950;
	Thu, 12 Nov 2026 12:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869391F00A05;
	Thu, 12 Nov 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484823;
	bh=wTN3UxTT/XXw7NH/F07ZSE1+SznsV7bVJZdXlw3Sm0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mykMNeh5BtXxUerEKT1YuKhyGYJ7QWD8IG5KpF4NuP4taMISSoglro4vnkkgm5jw7
	 WQS/4vwRcKImTEfxhMYZ5wbg4cf0zsqSfNSCuEwHpTxLLpdEiTkzuh28KNZeLAVJNg
	 ZfCkbQmePV1CQjWwx2EMjuLDIhpJighraQGEfBeHC2UHTK/MwHz7f2oBCj4SrVNuE8
	 h5IIE+hXfIdS625oF8CuXci5blOoZ0531mmkrv2ibJ2+zxzA7PXsQSYWh5mHmJWrB0
	 v/bWt32FVQ52/8TNJggbPdO6bVuM9pAUdH6G57AlDfNOf/PKeeT3jQZcm5rv//GblC
	 jWyGILzZ6HoIw==
Date: Thu, 12 Nov 2026 14:00:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nishanth Menon <nm@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 5/6] arch/*: increase lowmem size to avoid highmem use
Message-ID: <avWqSw2YrUmfAX62@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-6-arnd@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-6-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:27PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most of the common 32-bit architectures (x86, arm, powerpc) all use the
> default virtual memory layout that was already in place for i386 systems
> in the 1990s, using exactly 3GiB of user TASK_SIZE, with the upper 1GiB
> of addresses split between (at most 896MiB) lowmem and vmalloc.

...

> Based on the above observations and the discussion at the kernel summit,
> change the defaults to the most appropriate values: use 1GiB of lowmem on
> non-highmem configurations, and either 2GiB or 1.75GiB of lowmem on highmem
> builds, depending on what is available on the architecture.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm/Kconfig                            |  5 ++++-
>  arch/arm/configs/aspeed_g5_defconfig        |  1 -
>  arch/arm/configs/u8500_defconfig            |  1 -
>  arch/arm/configs/vt8500_v6_v7_defconfig     |  2 --
>  arch/arm/mach-omap2/Kconfig                 |  1 -
>  arch/microblaze/Kconfig                     |  9 ++++++---
>  arch/microblaze/configs/mmu_defconfig       |  1 -
>  arch/powerpc/Kconfig                        | 14 +++++++++-----
>  arch/powerpc/configs/44x/akebono_defconfig  |  1 -
>  arch/powerpc/configs/85xx/ksi8560_defconfig |  1 -
>  arch/powerpc/configs/85xx/stx_gp3_defconfig |  1 -
>  arch/x86/Kconfig                            |  4 +++-
>  12 files changed, 22 insertions(+), 19 deletions(-)

-- 
Sincerely yours,
Mike.

