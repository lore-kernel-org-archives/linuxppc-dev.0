Return-Path: <linuxppc-dev+bounces-25357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF488C5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:13:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrWj6qHLz2y1Y;
	Tue, 04 Aug 2026 21:13:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842017;
	cv=none; b=jggbuENZ4nM2KKkoWKdM7D/LwwS2cZaCjgqOUrsY0uJccG0jsx4NOiisqV7oVORIexu5HUiuPT46CZd9Kqh39VgxLS1c4qUPN9+KHSy+FG/m+klSeFYDUmg+p4W9AD7kwixmY8S9ksQMeAbW/KJihM4V2bSr2ZLGM5tmSH5O5fy6aWqpWClssb3dO/v17qBzukOPkthvq6/Yp8vXmWpHb0LWkcwqybzFBpD86bcqFew5y0dw1CHRXeVhmal3Yq/DyiIcAWbhANSUXzoFQtUtY//Ol4o5IzSMkE8M65e7Qr3Ns6L4OfYKtr5W8fACl4skhZVOfqfVuLXfrJ6bnzFE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842017; c=relaxed/relaxed;
	bh=8cqD4Td6cmzUoT3kOqg3vmAusK+bPeDWcDnl9ayoHm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boDTZH7ZobZzW5FS72Oh4619K3cXYkgF/7toIMCxJBOOe0wmG6bQ/sKzEiMJgOK2C0aN0nFYgVEUOqhfeI5GlbzWoQCJcEFmlzYFzWAsQrGZGb4uBn5o4170KUKo3Ec4CwB4b9hPIlq/i3rf8u+GHAmLFKq3/a8IUVSTnQ9UAA1J1b+3/MnnSUX4ft0boQXhNY53R5Y+Lpr7fBGG4S1n3NhQjU1On9AzcraYBwi1HnpCFrRSdPimcmMG3t9R9AoXsUdjRw9v4+EuKQhbHM0SiAX8hRA2oyYCdBuQI2EBSVGvUN0CcjS0yqq7gBhe1O0rRocwx4kh1JA21zRSz0gUEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3bqKum+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3bqKum+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrWj2fTTz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:13:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6C1D41FB5;
	Tue,  4 Aug 2026 11:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE311F000E9;
	Tue,  4 Aug 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842014;
	bh=8cqD4Td6cmzUoT3kOqg3vmAusK+bPeDWcDnl9ayoHm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V3bqKum+zDMz1wDVK7/W7/Cpna1axIZ8waZJbfhnPeWsV+7SrDqLU8PWSJUbb+3he
	 M4Ja/j3rIk+CPOSW1G/w+YnERDAPmXk+3AzaT1Sz5HuG9ZnCWZDSLd/bqdFHK5D06a
	 TsufOI4BVEZ5xRT2DqCq4kvbr+jQRDVOYtzymVbxhGAK5wvEuNEJ5/0Nz5YX2pMOHT
	 goPV5EbvfQBEpDb2ziiFBVoHsjypWl7xqNlDJ+SsYzL7n3M7DBvJP+LxEDAdh4CuOV
	 XpjxHXJY+Wb/A1v3WDrBJxb6mVTS1u6Ems+3MMJol5M0Iioj3XhSxbtErG49jJSQwY
	 wJA5izhsuzVzQ==
Date: Tue, 4 Aug 2026 12:13:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
Message-ID: <anHI4B-lMu6AJJfA@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
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
In-Reply-To: <20260803164400.531199-4-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
> There is no need for write access to the PTE.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

With below addressed LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> index e2ea8ba9f8ca..f2bab31040c7 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>
>  #ifdef CONFIG_PPC_16K_PAGES
>  #define ptep_get ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	pte_basic_t val = READ_ONCE(ptep->pte);
>  	pte_t pte = {val, val, val, val};

Worth making these const too (that {val, val, val, val} horrifies me btw :)?

> --
> 2.55.0
>

--
Cheers, Lorenzo

