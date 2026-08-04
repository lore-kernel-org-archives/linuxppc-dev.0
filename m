Return-Path: <linuxppc-dev+bounces-25358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78C6C5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrYS6cX0z2y1Y;
	Tue, 04 Aug 2026 21:15:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842108;
	cv=none; b=g8HVhcHRej7aN8jCvWEq/kJ/42fEzDkq1ztyHxoRHTWnVGYAsOTqFfc1hz+SlELAF5ay+KALrI26ZMENKX5gFeQwEEtYiw+wxazjzxYLLz8/x5kMO7uiVuIRjmDG6lq0kXIMUAVmIuPrPE8nFlTV04y3guk/zd6sWyDlj41gORYGknZ2/2OKxcWTrtzVMyPA6ZlYbM5293cJ/goLDzu/bw5WpNlhOpkwdfQseCf00hTy6ae5hpV4bK8/cNjk2PhWt0AVDgqIqQek9d06BErhO7ExeeAEBp86/5a0+3KWTmOA5PJazaYGi2L00tfvxATDjVkFwQ3WxdJ6pc1eUDTnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842108; c=relaxed/relaxed;
	bh=NlvQqMPX1ZBZq6vczB6DK1Q1sg9iUABmibDLc459ooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omtRwcJXbbDl/iHS0IVAB99OA4EQ7PfNwZn9I+gfKZc0Iqx7qqDix9XnwZIpp1buy/NT0A6qZTmFvSMvPZ/h5FMuCHPaWaDIFjgot3HxbpE6seryww7AQdzPzx0XViHo9fPWJwtXB14bGf93CYjtlSm12h6ZBA3ajc5NVGporriK5m+rbbFuvYshZLKZ7NFzar6wmR1yNihhF4fbDUpo9WDuHy1msu5/VNMe/ZlIlpRN8w4QidsdUQb8ReX595ATj3xOT3/SqZNOdjlnwz5ykhchsYf6aCQAt1r6vBRQVAJSFY/n1Q2B3xuyToE8nX4pRIZObJEVrz8UQON0mY2FGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnHoS2uq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnHoS2uq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrYS2dCsz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:15:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25FFD60A59;
	Tue,  4 Aug 2026 11:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D21F000E9;
	Tue,  4 Aug 2026 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842105;
	bh=NlvQqMPX1ZBZq6vczB6DK1Q1sg9iUABmibDLc459ooE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnHoS2uq+Wpn11Z4etXu+hxwCLOTiTcnmGh7C2+5V3PHkGFMDITE9z6uYgjCeYU/L
	 fC2NEuRAvvmECwZZAk2YEwJi/IwoCe8YsK5WKKXZVKTQd4iez0HYq95u5/tbxm135G
	 BW+tRjPZmgs+NDRQXQS+Z1PArA8qMZ3MY68n34Q2d8TV/awui74P0GXMnIVCuorty7
	 wc+LZ/aDpCuNW+K8lOzK6vW28Jlb7Q6F04ycjuf6wruLgZ+JZ8nOR4jzNd1mJrn889
	 QN98PED33opeHD+Qj9pfIsMlzShSZ8hTwHnXReg/xD7GXlIty0nulMgyNHSoKB2eaN
	 uL1Z8zxWAFNqw==
Date: Tue, 4 Aug 2026 12:14:43 +0100
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
Subject: Re: [PATCH v2 4/6] mm/s390: constify ptep_get() argument
Message-ID: <anHJh7rPomeJgVHc@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-5-pfalcato@suse.de>
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
In-Reply-To: <20260803164400.531199-5-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:58PM +0100, Pedro Falcato wrote:
> It's a simple READ_ONCE() dereference, therefore it can be const.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Even I can't be pedantic about this one... :) so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/s390/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index e882663a58e7..ec331ec92943 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -986,7 +986,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  }
>
>  #define ptep_get ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
>  }
> --
> 2.55.0
>

--
Cheers, Lorenzo

