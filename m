Return-Path: <linuxppc-dev+bounces-20969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26A9CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 09:24:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH1xL2xnHz2xRs;
	Fri, 15 May 2026 19:24:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778837078;
	cv=none; b=EzNGxvlfnzKq9J3fPFoktiXkuGcC+hvKUY30ajabtMx+6nmaSmPDVsOXvcUj/auMHVcGIfBg//RSuImkf5u/4VdpJoWfsXHmyPPxaPnRPMO+gZBy6+fachdYWIAI2CmdVI75EscgQivWWBsZbW2hZtJI1yYZuMpHzQQVpaka+lW1QI6Jxv8i3tmoKwnvAvDD/Rh6qYKuO8dwFTObZglusUWU7z8rVeYWY8p/KutiK9gME9QITE/F8yw3lBlPGFLHKbtolDQd5hp4cBYFEYnqknS0lefboPWYDyqBnCsPVUAHfGEgn0CeviCHL0y1HoBUDrxpmT7FlMjaZXuxUhIAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778837078; c=relaxed/relaxed;
	bh=/R8ozgf+55DzMr8+wU9geLZu52m9aFdrT2CH63clcjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgvCVsh3SUEFIIAouH+qQQg+Dd0rGRceex+FbfTdzJt1AS2f4cg8Pl9JqaEFbzu1s/UMZBfp4PyX5YfewzgMfQITerWhGDc5L7fis6dmejNqZfhjE4rg+rgZdh5B0NrpCItS2D9JUa4AkpKOXdWN/kCFJqe+aC6V2Jj32FddB4jghqQCDPA9R7hQKTwZASsvu2SPqt7L2D+F7CriQmaKAnzuWDVbS2hesKOeGRqdZ53N2Vey5HWyH7InOUtSerpQWAk6Jwshbkrjj9ls0bcgAdM4iVbQ4Mi8JWeTYz2eFzeknbPSFpzzYoDyvf+A5VkGFV+3+PIePC39TcdKzc56UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH1xK4bC4z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 19:24:36 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B35A6732A; Fri, 15 May 2026 06:37:06 +0200 (CEST)
Date: Fri, 15 May 2026 06:37:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: kreijack@inwind.it
Cc: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
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
Message-ID: <20260515043705.GA3855@lst.de>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de> <20260512114231.GG2558453@suse.cz> <20260513054742.GA1018@lst.de> <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
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
In-Reply-To: <0a8d1ff4-f5a2-49e9-aa45-d25dbe4ded40@libero.it>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 14, 2026 at 09:51:59PM +0200, Goffredo Baroncelli wrote:
> I think that the David concern is : "what happens for an already
> existing btrfs raid6 3 disks filesystem when the user upgrade the kernel ?"
> (I am thinking when a new BG needs to be allocated)...

Then it will cleanly fail to mount instead of constantly corrupting data
and memory with every write, yes.  Which clearly suggest that such
file systems don't exist in the wild.

But if btrfs wants to keep supporting this I'll just add a _unsafe
version without the check in the core library.

