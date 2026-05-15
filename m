Return-Path: <linuxppc-dev+bounces-20968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739CBCD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 09:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH1qc6cNYz2xRs;
	Fri, 15 May 2026 19:19:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778836780;
	cv=none; b=jc40GKJp9bF+kWlSO5qCYQFKtdAoExGIIFNwlSsTo1hV8E7W23VjQGLE4B+V8kjo3pbh2ausQzR0yPeLyHSfOfPoeTz3O0VzR7jFa3749hTlTXO3O8Hy5Nvlwe90l5M44RKUYRMxP/JIr6p9Ht30/xfof54+VM/6jb0vGoLsLaC/TRDCQkEvbPZ83FYKfXnqaCEEzVw96ge2T3aSZRf9m+liZKHouAG2kBPFg7uxP/e3+sxRE1hpzT+QRkr080AyVxj++lK5n8MSzahyKzK5p13sagoNebbv0c2Ma6FqELwH+OVKbr+r2cG0JuLmBsYu223pwyz6rIK2NwZRiffXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778836780; c=relaxed/relaxed;
	bh=A3ggIcTT9QpNE6xAWUcm+Edx6+JDZ1X1JlzR3+EsdbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONQs14cg/6mEpFSLcNA1vRyGKbK5azfFEKuCPCu+aDw5qXqnbGhfT9dN24jZCgMmNFludMTcBokKXHygxzy0r5t7YnuKaQDqiYkgfH/AkSpiMU9RKQ0a+CiQawycfaUhfkHZNGpaiVW/7rAQ9oPj6HpFHGg4fsnQpXyZPl0Dqq4P3tuf2Z5Y1PBTi231N5RW0uOBClcCC5VtI6fzhk1g8gxxHs1oT8jWz6vj4iahPwqpmVsTtjk5J7ccbA1r2xDGLbDkF6PfldjlzCE24LWKJyx0mhwxEBbv4Bu7BiM7cfHM+W3aU95BBH4k/1gjSSSEsJhe+RzODtIUv9PUJPN4Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH1qb5qQFz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 19:19:38 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C6DB68BFE; Fri, 15 May 2026 06:37:58 +0200 (CEST)
Date: Fri, 15 May 2026 06:37:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kreijack@inwind.it, Goffredo Baroncelli <kreijack@libero.it>,
	Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260515043757.GB3855@lst.de>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz> <20260513054742.GA1018@lst.de> <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it> <0507CCEF-0548-442F-8703-1D006B5E068B@zytor.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <0507CCEF-0548-442F-8703-1D006B5E068B@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 14, 2026 at 12:57:53PM -0700, H. Peter Anvin wrote:
> That's what I'm saying – it should invoke the RAID-1 code under the
> cover (as with 3 disks, D = P = Q.)

Yes, if the btrfs maintainer cared for this setup that is what should
be done.

