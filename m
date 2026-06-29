Return-Path: <linuxppc-dev+bounces-23094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77019C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpmLT0yQsz2yT0;
	Mon, 29 Jun 2026 22:49:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782737345;
	cv=none; b=ZH3a+Cv2i0PUfq0nH6057i44FXadk7G8adN8rdWa60isWBaYb7gzcDnWxVD/sTt9yHXgOmZDKoPjKt3rb8GeZu9DeXuQei/cUSC/yYjqI4FeYjtfMELqJy+60qoRsTlGWoHu+6LK+uGsx024LrcROlkLuWFM09HdJnnSYi4QqST4wgWLbo1J32lrnNTV52rmiXmvtEkyMxbPgSzMbmPWT05F++jit0Y0IDAiQpOzbOaZOMeOGRSXu+r6kpZvle7ID/SXvynk5xZg25CsRbtGKOLftq+vRGeKCH7+izJYtCjd7C8zbWh4S7Yr2VjRAiksaFYdcQDvH7UkAnKCw4bEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782737345; c=relaxed/relaxed;
	bh=ZnCdA3RZ8rzOBYeB70O433uBRb2J0cxlC2SD87W2TX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWc+Ql8PwLWrdUeh5GRI4u68YcuxJEUYYKwLHgJhQJaszNA7wY6ritnjpCVLF/+q+twdcFftp/07WIfePiS/5dXr0bhBZaqN6Gb69Osxl9V6meqt8VkJKhjfjJQmPy0ax46SI19gClexk7CC9YrvMmlcPBE5aSbjrdYYP5Ya4NJ+KFrfkTXGR3oycA+kzecp+E2Ks7iBGwM7OpMwLDnPKbU72/4WOyS+chMQ3lxOEKk0gp2awN4gk6Uo3GsiLcTO1rVT0/c2eBXfQimydV9h6CBWmIbW5xlGVqDRP6cG4/hiSdgLvmxOn4h3WcXvjEvNTyiIvV/tKCn3j+nxbgtTZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmLS34S4z2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:49:04 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8495D68B05; Mon, 29 Jun 2026 14:48:57 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:48:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "H. Peter Anvin" <hpa@zytor.com>
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
Subject: Re: cleanup the RAID6 P/Q library v3
Message-ID: <20260629124856.GA23695@lst.de>
References: <20260518051804.462141-1-hch@lst.de> <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org> <20260519082432.GA14956@lst.de> <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com> <20260629122152.GA21344@lst.de> <8684FEC2-AD56-4BDA-874F-1D3D7170F880@zytor.com>
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
In-Reply-To: <8684FEC2-AD56-4BDA-874F-1D3D7170F880@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 29, 2026 at 05:34:41AM -0700, H. Peter Anvin wrote:
> The real issue though is that the benchmarking isn't really helpful, either. 
> 
> It has to do with power across the whole chip, so it perversely enough depends on what *else* is going on...

Yes.  And preferences might matter if this is just a file server or
something running a real workload as well.  But I don't really have a
good answer to that.

