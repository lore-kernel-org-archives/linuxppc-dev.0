Return-Path: <linuxppc-dev+bounces-24783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C128C531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 14:14:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h693X5xXvz2yFg;
	Sat, 25 Jul 2026 00:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784902472;
	cv=none; b=RdJEGdEPaijFtKsXa1ULfXYieJWDATmkBxiRMqDfaGQsBGFpEhDfhLYqhvXQAMT8skrRHCqLNeYZ9yv6zke8hELAVG3kBDg+sMXqiIdtNQb0U65WWuOWChi52siBSLflb6CooP4aBtWhrjyfvIhb6cwIkHgqTlGg9lV8xhP9vjjIg1dsy3G1AQFYXRW3FV6oqGn40odf1pWLQHJfHwPiy9B7xR4OAiiIMD+i+yOOUQTF7VJ11NbzyHiU8fQV5CyvLrLJgMub9ju1BSnrq0ztJ2L28jZqmjo4W2cY3bwUdAmAWPhdx4NMg4uIA9taLpo/Cij+23pa61q2NT6vsnS1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784902472; c=relaxed/relaxed;
	bh=sqQq2Owm1obwOGEA9eotW/m1MLzuoJQfAmp5HBaVcd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGIg73rrzOjY5gKmsyaZwh0GUH1oZisXgKDW/9GtlFPy4GuS//K5+La8u6t74eo1UMs81afF1XShKZKrTZNiT/A9ARFioL6GOXREavkOdGModFQ4xnCf+gxlawtTS/IlQy+3KHxA15TwJZJJV27Vxsc+dVckCR4l+0Ig12iICYgOZyW5SU3qdKjRJtKtYgs+gkLfMwIDEVHYbGXwnWk7DJ+318rQqBz+YMvowjiyZxxrRc+rsx12F646IDbus17QdZYhLwAbrLRR0sN0VY6urYt6cEKg59IKo2NoJudzqIbpR3Nw1xZXnd+aBVazgCyMOK4xaRN/RDQ8VtB/qHiXlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=b3FaE/15; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=b3FaE/15;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h693Q2Stwz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 00:14:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sqQq2Owm1obwOGEA9eotW/m1MLzuoJQfAmp5HBaVcd8=; b=b3FaE/15gGHycdVRSEH7kk8gXg
	ziED/cLtyY3G9U83si7GAn5Ol84senjYN1m4jLjO0UtBZIPJDA8wUFOchOARYzauL2VUm0k7nZpzN
	K07SPvCGF24b8xDHwesu9/XXFOC/xHyVYN0uSucmDm+HCF3RUQvxf7WqMkuuVnzM1qoNRsMjxDcj9
	uhiGquYmGmqrNAnYWz2mPt+rVVhLzVIZYA3vpLT1TxNs0sooD2gummR7OMhrl7SLQIfux9q544RXB
	8pK5bJXka726CjSXoWptNMLW0fFoYyvvcYKrkavP6fm72xKjr3YlkbnKKrHXHEs0HDQz3K+4Q60X8
	AYR/0EFw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnGf7-00000003fU1-11AE;
	Fri, 24 Jul 2026 14:14:05 +0000
Date: Fri, 24 Jul 2026 15:14:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
Message-ID: <amNzLXuwflIZFKtI@casper.infradead.org>
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
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
In-Reply-To: <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>

On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
> 
> 
> On 24/07/2026 11:20, Pedro Falcato wrote:
> > ptep_get() does not need write access to the PTE.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  arch/parisc/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> hmm I think you might break build bisectibility if
> you separate out the patches, you should squash patch 3 and 4,
> with patch 1.

I don't see how this breaks bisectability.  Can you elaborate on what
you think would break?

