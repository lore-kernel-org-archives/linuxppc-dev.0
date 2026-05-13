Return-Path: <linuxppc-dev+bounces-20827-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75793CD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 05:59:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFjTc0F84z2xpp;
	Wed, 13 May 2026 15:59:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778651971;
	cv=none; b=BN607WNWKmvenqH7z+3cDXBq+9KHcPT1Kob/7q1IJlyaHewSk6+a4Qbph1OsqwFlsrr0Zld77sLkqnPrxBGlgF5QydRrcOnaax0RW0P98CLmYcnlOwRiNrcDjjl+dQNRn7HBl8lsBiXZhVytkeVzXrjHy/bzMP/jY76Rt9J3bLsj94tblJ+e+4G4/VpLKsZkjThzULHFrcniuYqF5UL7HI/4SAwpJTQDhrB02qL9DeLgjthtkN2FAAxA71H42EagcNduE1EQBzUWhZ+nMMmDc0CuI+nGaRmp/cJAaa514iENswv841+uE0W5GwCKOjm8HfuCmdoQ1eLJWk8Q4q5kXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778651971; c=relaxed/relaxed;
	bh=+doqOq5qahrITQTt42Vk0H3M5xERwzM2ccixxL3hjQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOS6JVVz8zOQTSnyqRhwm6LFSRol7ydZexc+Y+7fRQNqJb98pGf5+Dg7u+umDOXC5e7oK6auFnerbXyVZnPUcYrPnvIE3QvwANhaWIjZwklpXkCh+eVxY3ufpff9+KaswBy/RaaNXFu+EZPcjJnYkfn8HgN/Kn5hBnvaGk3kEh/SfeYFxxFImNYQh6IocPAFjYDK2WR/WZoK1yf6CwVjKUGO2d9qbkSl3FGEyqNGrYbeJxP+bePzPBk8RoBWVrEDBd8M9qnvIHrHa3eaDPbYh85JcOPhYfbF9qVx47/XVuI6GaVvaUMAxb8nqCmubQw26HIhwSor6ksiJeE4bLDh5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 699 seconds by postgrey-1.37 at boromir; Wed, 13 May 2026 15:59:29 AEST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFjTY5Mgxz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 15:59:29 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B404568B05; Wed, 13 May 2026 07:47:42 +0200 (CEST)
Date: Wed, 13 May 2026 07:47:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260513054742.GA1018@lst.de>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512114231.GG2558453@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 12, 2026 at 01:42:31PM +0200, David Sterba wrote:
> On Tue, May 12, 2026 at 07:20:41AM +0200, Christoph Hellwig wrote:
> > While the RAID6 algorithm could in theory support 3 devices by just
> > copying the data disk to the two parity disks, this version is not only
> > useless because it is a suboptimal version of 3-way mirroring, but also
> > broken with various crashes and incorrect parity generation in various
> > architecture-optimized implementations.  Disallow it similar to mdraid
> > which requires at least 4 devices for RAID 6.
> > 
> > Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch should have been sent separately as it has user visible
> impact and can potentially break some setups.

It _is_ sent out separate.

> The degenerate modes of
> raid0, 5, or 6 are explicit as a possible middle step when converting
> profiles.  We can use a fallback implementation for this case if the
> accelerated implementations cannot do it.

This is not about a degenerated mode.  For a degenerated RAID 6, parity
generation uses the RAID 5 XOR routines as the second parity will be
missing.  This is about generating two parities for a single data disk,
which must be explicitly selected.

