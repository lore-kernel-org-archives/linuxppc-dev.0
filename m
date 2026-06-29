Return-Path: <linuxppc-dev+bounces-23092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6D5C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:22:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpllF3yKRz2ySS;
	Mon, 29 Jun 2026 22:22:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782735721;
	cv=none; b=BWIjiLl1NZAn+A2lXNUi0iEqUORPMZNmMx/0lbDcqoTIiiWq5ZGtQzsopxFNZiNpEO6gHqPUYZlDeJ5U+yK9RkbGEpgmk3zKcRBcP/gEXAXwvgdUpqsX+udCl/rlO3Wslmf0qBt3j72knYHMEs88AfRuJ8rbrx9Tp6kWUDK13bJYRcdCo3S6D5ZhOA+xWOadOdjYf7vNshFM8GjXTRrflvTiBPRVlepcrFmVA0LAQzKpwvkoh09GHjyXx2FHMAe+Fh23hL5ZwYVOxdQL7EBl4nACu7vDbOaNbh/+gYlYQqoLGidEbvThuCXfFxsIIZis48eOzrg6ap7JBQLGEqBANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782735721; c=relaxed/relaxed;
	bh=dircqAEtLKhzXLNYPYvdhjyZBvBeGfOpZZwNNS747TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVuF2fdKOyhvuJ1DqRM1Xy//ifF0girS6Pm/+XsD2RVv5FlS1uzoTWKsD3JhZSBHvOZqK1uoTcVvvC32vUToUuPJu+RjqGmXDsNMdzsto+Sq1nmZGWmicAARs6lWLMwwU6A41RfX6asSktSN6dohKqhhXAnQyS6EVyCfA8Eo0ICkGSuEtQE0yP3EqVoxvOlVc1DiBbneQ573uJCP7eM+x7qmUxIjkH/fJXPOjO6xx1TBLXU75kPd5oVbncq1RztaHVLY1zurSw3yw+NbmdltUjFrU5XHS0Hh9NrVZ1iOtJC709/WuV+VcdJf3+c1pmOSIwJzcYHrcOa3NzkfpcdqQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpllD6Vkmz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 22:22:00 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5ACE68AFE; Mon, 29 Jun 2026 14:21:52 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:21:52 +0200
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
Message-ID: <20260629122152.GA21344@lst.de>
References: <20260518051804.462141-1-hch@lst.de> <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org> <20260519082432.GA14956@lst.de> <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com>
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
In-Reply-To: <7d8efc7c-65e3-49f8-9381-910de7affef2@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 26, 2026 at 05:52:18PM -0700, H. Peter Anvin wrote:
> On 2026-05-19 01:24, Christoph Hellwig wrote:
> > 
> > raid6: rework registration of optimized algorithms
> > 
> >  - avx2 instead of avx512 is probably the right thing for no
> >    benchmarking, but if it was intentional (it wasn't), that should
> >    be document.  So I'll just switch back to the previous version to
> >    keep the state of the art
> 
> It is unlikely to be the right thing *going forward*, though.
> 
> The very unfortunate performance inversion is likely model-specific. It is one
> of those things where you largely would have to have a list of quirks :(

Note that the default is still to benchmark the implementations.
This is just about the case where the user explicitly disabled that
benchmark-based selection.


