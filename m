Return-Path: <linuxppc-dev+bounces-25666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD8DC5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 10:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJW3w6y5qz300V;
	Mon, 10 Aug 2026 20:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786357244;
	cv=none; b=KbH3kr2hIplxR9fKHoAjS1Kj3BeeprE454mwY5KkKSsd+DsT5sAJCVY7HN0S1L2SjBbjkwbTNs3wvWztbm7UoAFmkL2MNSr+Y+di5PySX8LpGXtICqsSj3yrL0ZkJlCGqCVvKZo7UWNZvjGni4iCrQWuabuyIdOchg3roWRqoxBRZLyU+LveyHsE+4finJJPZ6awtu7JIcP6dk+SEpKkckfMhdF4+UeI6dQZJpkEBsUnPG3RU/LM6lj8i4efmbdh/z/lLWP7BXbCdOwg9FZX6SXrh31w2lupkR7df9uW5aBKiz7MmPSGmJq/PPMq/bN9S6M/aThUHEHcw5GZ9griDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786357244; c=relaxed/relaxed;
	bh=KO6eVlrCoGv7LRa95h7FC3E/wXet0JaIn2ciTJXwruE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev9VcPo0QyDEc2w76ie01QbE2yGFC6jN7fRNcJAHg9bjIhPdlDStiAGAtrTY8VOyRxXFpDxgitVupK0aEF2/D6GiMqjLkjVDHW7rTmivoLIjIkWIsTfh47JeDeXu+xvK8yWLJBb9KetPORBVFF+K8eX9sS1vPz5y8G+AmVrfTThngOPkhZ4f9fZnrJdHiMBiOVBMuAdfioJu+yXo1Eh/ndY4ZLZyNclzhgh7/VMpt2KxO+ZAzGnlOhGPWvIGKTS9olQ8OD6MNCEVZrt7VRf+F2cZJSwqz+HQsV3fyf+9VIfz2lF75gaw16r9yCi2dD1H1fWNtL9PVY0LRLgsBBVIEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOj+T9lc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOj+T9lc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJW3v11J6z300M
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 20:20:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B0F9A600AB;
	Mon, 10 Aug 2026 10:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169771F000E9;
	Mon, 10 Aug 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357235;
	bh=KO6eVlrCoGv7LRa95h7FC3E/wXet0JaIn2ciTJXwruE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SOj+T9lcP3BfqhGI1ByG0Cv3PFMgqUXv8bHIyEGQ0Crx7WPJvpMXrDR6cnXA8haDH
	 cYjQmWETdYROJsgxJuY0xAnMz+qcsum4zhRddj5OuQmXFYimXS65x+nSJ/ri3Pl+I1
	 NNbWKQWfp+9tZN7Pqfs4BBq401HgnEBNwmndyyrcCDyiTbSvJXGLmyQauDbrl/5q/E
	 wSkKYR4xrnk2AmyDzRpVJfB47dSs8n1OBShCZjXa2N+CTMRHmZEtOsPiqUVTW8WnRr
	 dQPmOerSaod1zGxwRrnOVvRSAkC99DwkhJUjDCZDMb4jRWp+BTOJwOS++QcQwsQ0GI
	 RC8+hOhcdNwJA==
Date: Mon, 10 Aug 2026 11:20:26 +0100
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anml6lLRERm1Iv-_@willie-the-truck>
References: <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
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
In-Reply-To: <yq5av79iiard.fsf@kernel.org>

On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> 
> > On 07.08.2026 20:20, Jason Gunthorpe wrote:
> >> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> >>> But the whole thing is best effort anyway, the kernel picks
> >>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> >>> how many devices or how much DMA they do.
> >>> SWIOTLB memory is wasted if unused so we should be careful around
> >>> that as it would be the other way around and users would have to
> >>> decrease it manually.
> >> Yeah, it is why the arch code shouldn't really be sizing it directly,
> >> it should be done in common code and, yes, we are probably going to
> >> have to do something alot smarter to have the common code better
> >> auto-tune this for the CC case..
> >
> > What about the $subject patch? I assume that it is still needed to
> >
> > restore the behavior that was altered by the "[PATCH v8 00/23]
> >
> > dma-mapping: Track shared DMA state through direct, pool and swiotlb
> >
> > paths?" patchset?
> >
> 
> I would request that we pick this patch to fix the regression described
> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.

I really don't think we need it. CCA hardware isn't exactly widespread
and the KVM host side patches don't appear close to being merged.

We have time to fix this properly, rather than papering over it in the
arch code.

Please consider this a NAK from the arm64 side on this patch.

Will

