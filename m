Return-Path: <linuxppc-dev+bounces-21623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A0DCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 08:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR0dY3X1bz2xLm;
	Thu, 28 May 2026 18:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779958417;
	cv=none; b=YKE5+bJ7kb/djDKTKmxGQNweELjQiGCczcE1VyYccsoVskcWZYpwwVduo6H7uS67UTGTN+IOf2yhD6kp1hPOy8upY1EXoZSGNNPEsSu3nFkmo/XZp4vzGfU85totg8Z70hR5+5th6vvXA6pom3SngWmEkjc2KqfKHyO8cml0IPKyOs1S5o2VX+/JKFMGY9zR930flZRPryRgTDBzTOiE0HBA73/kz+VGX/2PJolZLbLcwGq4Uu6wyUnHKg+C0RD1AMI2m88sZDE5zftqSdyjCDEhwKFEWAOhoH24CNInbbOcWghsGKv2u/tzn0ZbZbaXxgcwxh8OpSh3sh+lkIz3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779958417; c=relaxed/relaxed;
	bh=Nu+2uJB0bWOahJZM395trqlBX9jrloGHIPyChDFiT4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5DCSSiO85DGAi4xxb45QN1zTxvZDzGyjxZgyNDwR2kv5xnKL3s0+cms7n86mXyF9+mPJRd4smGD7cxWWEFO9+R5xgGX21o94PRVeVKWGPihhpYiXkXPbjbiSmC4/uupGt+aSDImMvNijPdHJ9dqOgxF63PBsdaOc5ZY5jIMfw+xhnIhSnh1Lozj1or6Ur5/6o3dvnnNEEtSpe2wDlTW4h8X4rD7sswbM8UhZU4CdnprbTMudk/sTqCzN/ZM28mWhwhcS8q3giCl52XST0XMX8VzfWwOe1u10dM2HkwZllghqGG+Y7tIFNC18HF5HW83wiFDg1PCg7+hS+tG4CRMjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+39a899e115b5adf89e7c+8313+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+39a899e115b5adf89e7c+8313+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR0dQ28ptz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 18:53:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nu+2uJB0bWOahJZM395trqlBX9jrloGHIPyChDFiT4g=; b=WMt+kwP4HyNu4MxGTFi9A9bWL8
	I2vaJGQoRhwDX6g/0qB7yDnua1YQSzPQrViv3x1dOgw/6NIGCo7mJd5eVL0Z+kChl+oL7hNbxm4+q
	QKA+dCZ9jIJ9xP5nt5FvZkhvJH9HWs3Jr+bDnkv0cHQbPzHvs2nDIJK0lueoPxhJip9HsUmtceZJc
	O8Dew8VdViDsT/VjNjWBFVK5IcdIaj7eQwmihQsAd9IU9B4aWaMTdW+Tj7fcuXOZvbyUoWCz7H7rN
	zDBZczW/tM2JZZ4bpnCzeYHzJ21k5778f+4lirKrTNNFKjGkU+vtA+FH4ZWN1nwTpkVLBQply4LiT
	YlfcTbfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWUQ-00000005RNi-04pb;
	Thu, 28 May 2026 08:53:18 +0000
Date: Thu, 28 May 2026 01:53:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <ahgCfazNTdk7Em-K@infradead.org>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260527181549.GBahc01Xflm2yo5OqI@fat_crate.local>
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
In-Reply-To: <20260527181549.GBahc01Xflm2yo5OqI@fat_crate.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 27, 2026 at 11:15:49AM -0700, Borislav Petkov wrote:
> On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > > Setting memory decrypted is a dangerous operations and should only
> > > be available to core code.  We should have various allocators for
> > > decrypted code, but not export the functionality to random code.
> > 
> > At the very least an EXPORT_SYMBOL_NS.
> > 
> > Looks like there are about 3 modules using it already..
> 
> Looks like more to me...
> 
> In any case, we exported them back then for some framebuffer things:
> 
> 95cf9264d5f3 ("x86, drm, fbdev: Do not specify encrypted memory for video mappings")

Which is exactly one of these things that should not happen - mapping
random I/O memory without the proper helpers..


