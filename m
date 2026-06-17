Return-Path: <linuxppc-dev+bounces-22742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C002CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggQp531Ylz2xLk;
	Thu, 18 Jun 2026 00:14:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781670224;
	cv=none; b=BNCShfZOEDT1liODRjiKeDv84GFSR+hktZ5VYGG6OTaFUG6rhr1we+G5g1ODEbeJtBL6ErZqm3x0ncsySQssu+Tn4HBeFUbMebb4xbdJx4fGseJUEMNgqcmYqzyyF6MdNJzcGcS2QBMpLBz1wF74cu0p95hg2y8IbgE4mGYtsNhFYEM3fqvQou1adB7M6PuxErdNzyJZKNecy8rtaGtpJVnAsoK8WVmfGN3zhexSSinZwf/BJRogI4CWSMWx4N7jXZie6Oa2a19myZ8dWeXsqiy6cS3vJe4kxqz6G4XPmZmR+eHi/8LSkh68aysghMxFasOLwWUwGqvmgiaZfELCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781670224; c=relaxed/relaxed;
	bh=pDWfBHCIgx7ksbfZa1ubRGAaRoFfFBx7ZNK9YSokzdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkWZDlfGuY8Ue6MjUk3n1M4OIWEa7EIhxYrBdLGiNBCX8KE+EgU5Ybf+6QD9E9Bcl9f2q4n2y6TjJ8qkbW990tDZyyFBzaZYxL62g1MegXvFa0XJeCKEUQgHNoCmWJYWZcdOYt8r89ZRyr8itl7FdqjX7uhc/GMBkBB9Eba/GEpVocpWorraMd1papN6ut013ff9WLqdFbir+m3p44YwHf7H8fqpxlc2H2MdUHBhO6rVqqu2zq+3HXpTF8uwLaVjS5DWqofjGvS+SOBv4rRk0RO5BV77VNFRGj0sDlhGUtWtj4vJsqmM9sNQYdfjcrT9vKnZsBXtziMrWk4C43RpvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCwy/3NL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ryncsn@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCwy/3NL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ryncsn@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg9hv5GZjz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 14:23:43 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-37c64d34032so247962a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 21:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781670221; x=1782275021; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDWfBHCIgx7ksbfZa1ubRGAaRoFfFBx7ZNK9YSokzdM=;
        b=LCwy/3NLObr1EyjMl0/mDPcKzdn8wg13S0Ren22rprms0A/xQGPfgkqPBINsJwrALO
         FfBDnbVhl7FITkeeOpb7bnFw6K3FouFlyXNyeSBz9Fv7MHyI89UIKUTgHFksf7YknzI7
         Rs3RUfoURFT3Am3kdKRk92dadkW9M7eZ8envnIlykkoyM+mMUHwUueS4BF09EKBWOokc
         TrX7+dKISYMp2NcUK5RcwF+4fW64Gs8yyxE5ilMfijKcleTUgSORwe9rSEYnfRB65r4O
         0e8YJhISZRMTP4FC+qJOktHY1Kmnb7kuEH1dUtYrbIpoJHVZo66ZfDlXCjt8d5Yetgr+
         HRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781670221; x=1782275021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDWfBHCIgx7ksbfZa1ubRGAaRoFfFBx7ZNK9YSokzdM=;
        b=RJY3nLPxWf4xoi4FNe+UyNA59NKeR5w9vM3sQvU7MwjN5tGhxSKcWFB5++aZj9YZFk
         pLBnn0bKq7IOXf5wMnNCMsvxY42ngbCy2MsyZrwfYte1AW3+gkFW9X6ddW2Ok0cWUyPD
         R5o3ACyzjqcmu4qpFfv9tApwJfhXDzagLcmYAPtlbHMfI/FDmPw5pY/Ra5axuhgME+1j
         9lbIen2K4n1+DPjykO8R919z/2ruV3lvfSAsHCC2BMl9P52neKW7+3savgcDRQlZ6CEu
         pG2GBaMLdmglO9SRRbNijrkur9mDDhPeW8SCND748VnC/akO1TKf2Z1mHAOFfPfr8bPH
         UiJw==
X-Forwarded-Encrypted: i=1; AFNElJ/Er4sSCTdRzfT6JPCCiNZ+/Q7+n6S2jRll0/z05ic0GDARhW7JnBbC5AoSelgs5LCZJAl7SQivcU/vesI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCG/BrMQ+43Qfvymz/k3Uf34zFtJR85o0uKVH2nXLbNQQvcpyU
	BFHJp40i/5bpBJWMy/W+En7FOxfxauEw9BPi5qpUJeB6HCAJps7dfnfA
X-Gm-Gg: AfdE7cki9vCxvyEyPMPv0Bgm/QhPZzFepRuMf4fgAm4s55o852ho6pYkZU5JZ4OIO0Z
	BZDIXk14DOiL6MEZh9apLG/0w+GAJcjzmdvx9gMz1iLEBEPCa0IYbsm+Yx97j589BHGd0xx//SW
	uLRgRPoLJBOs+6ED/MqN+PU4BhRxUxwRY8FE44K28Rpq1caL8uCMqNrH16S7t7+MUhnftpEQaww
	GjB3qsTAwzKRSSVgxk8AZlJbsznUSa8JPWSN/DyyB9ebwZ/ZEzKUNayy9bot+DDSlMkW3cjARv3
	hVKttXJEsG1EdjmF/jgSgF0CcInwNGeuXwKyPDSfA33o+s3lCg7vdsA4J5KZcdSrVQifPCrrB4E
	goXy95y4fFXit21FThVGSSl3Y4xUZxMLUGuNx9nqC9bMWrr6IEZm/DckxzL9sctDQfvRg7/sHTj
	12KERgbLfs+y/ygiIVlQtYM7ZBbAjpwGbTVd6l5QvKSwxomrF2AeFYU1iQXt9Yrko1DxXa
X-Received: by 2002:a17:90b:3ecd:b0:36a:8254:8eb1 with SMTP id 98e67ed59e1d1-37ca6a6c890mr1013456a91.6.1781670221256;
        Tue, 16 Jun 2026 21:23:41 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ca1dab259sm689079a91.2.2026.06.16.21.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 21:23:40 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:23:34 +0800
From: Kairui Song <ryncsn@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
Message-ID: <ajIUVSWaQbFoez5Y@KASONG-MC4>
References: <cover.1781287297.git.ritesh.list@gmail.com>
 <1e8d7e4d0bb1377277ae8b6561d89fa0e048e7de.1781287297.git.ritesh.list@gmail.com>
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
In-Reply-To: <1e8d7e4d0bb1377277ae8b6561d89fa0e048e7de.1781287297.git.ritesh.list@gmail.com>

On Fri, Jun 12, 2026 at 11:39:15PM +0800, Ritesh Harjani (IBM) wrote:
> On PowerPC Book3S64, MMU is selected at runtime, so macros like
> PMD_SHIFT are effectively runtime variables in the Book3S64 code. THP
> swap code uses these macros to size some of its array data structures
> based on PMD_ORDER e.g. SWAPFILE_CLUSTER macro is used for this very
> purpose.
> Hence this patch initializes SWAPFILE_CLUSTER at runtime and also
> modifies swap_table and swap_memcg_table which were earlier using this
> macro for defining the number of table entries.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  mm/swap.h       |  5 +++--
>  mm/swap_table.h |  6 ++----
>  mm/swapfile.c   | 27 ++++++++++++++++++++++-----
>  3 files changed, 27 insertions(+), 11 deletions(-)

Hi Ritesh,

Thanks for the patch.

> 
> diff --git a/mm/swap.h b/mm/swap.h
> index 77d2d14eda42..956879a69ddd 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -26,11 +26,12 @@ extern int page_cluster;
>  #define SWAP_TABLE_HAS_ZEROFLAG		((BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - \
>  					  SWAP_CACHE_PFN_BITS) > SWAP_COUNT_MIN_BITS)
> 
> +extern unsigned int swap_slots_in_cluster __read_mostly;

Maybe __ro_after_init is better for this kind of use case?

> +#define SWAPFILE_CLUSTER	swap_slots_in_cluster
> +
>  #ifdef CONFIG_THP_SWAP
> -#define SWAPFILE_CLUSTER	HPAGE_PMD_NR

So on Book3S64, HPAGE_PMD_NR is also a variable right? Then we don't really
need to change the SWAPFILE_CLUSTER defination here? We just need to adjust
the users of this macro so the build will pass?

Or maybe use another macro instead of HPAGE_PMD_NR here, whichever is
more arch friendly.

That way if that is a build time constant, all users are folded to
just one mask/shift which is super efficient especially for inline helpers,
and there are a lot of them. Only special archs live with the dynamic
load overhead.

