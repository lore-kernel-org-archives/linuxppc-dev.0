Return-Path: <linuxppc-dev+bounces-21373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD79CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 08:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMK0J1tmsz2xSN;
	Fri, 22 May 2026 18:57:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779440224;
	cv=none; b=Pizg62wNLp67kMYBPcihtVohrnWmGT0l3u13/AyGAcme2n9LYFpV7DG2wlo14XX22uNJvXScNuTGk4dV/QlkpbEEt+Ez0QcVbx/amu9dN3PCJuza5TO4SgduRQkohl5Yg9WDaUg0uN5igUOmnE4XGj+aY/qfd3uI/+MNlALQzU81JtcGk55HyIUdzF96YdMeCtTq0g0522qxMyWBU4ui2cuatgYfIWpI/AeuLGtBDULqr1wKfDm4A2nbGXLJBvRNLRcCQDTHORwoeVwguxMZpnPrNCXYJTUX7oehFGtSeezDsrgJCDkmju49bzw0iflp3sdy0Y8CGPSfI9IYAqWuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779440224; c=relaxed/relaxed;
	bh=wl++rc7qAneafJ55JR13bw6NqLW3bgI2BMfioSnBIUI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=c5jHL+UKo1w7G53QrPvIlGLPDMh9m7bD+lhlHvTcTgSlD6x8yryBr4ekTXWlnDKjzpbTmXaKwfE8/bbcIRCX+SwXsW7KjCvJRUTk9LGkpNY4ZYHvrT32/3q4QyH2YhWJNWoTsIIQ/J/DSX9g7HHpwN2WSIe6UBopwdzxKhW1BUGM1NDzpyi7uQ7ieYf0yMEK0YMIjAhOSYtXjRDJjeeqVWNMETmOY/+mjDgtNPfCvK0jeXDltpbM9wfNN01TaDna1tNAB0RwQbdfqYqhaMRDihV/j6Vrn69BGsbbn9Jw9ITKKh01Nod0AO6CY1tY2+6+TIsooED5CmodYNcUlxUgmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xzw3XKT2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xzw3XKT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMK0H2WKqz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 18:57:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C87760172;
	Fri, 22 May 2026 08:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE841F000E9;
	Fri, 22 May 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779440217;
	bh=wl++rc7qAneafJ55JR13bw6NqLW3bgI2BMfioSnBIUI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Xzw3XKT290Py6aKFLaCyb+YtmMQyWpaVPO9XgJ7bE6GJUgCTks8F0DUme/d70g/dQ
	 XbUduXE/Rw6sG4Pfc+uNAphK/p6relnp5bpiAzopwpIBkwF25RtkgZZFv3Pz5XIEUo
	 tf8XXrop3wkF8Z33nSOF90NCRnW/sFvO0DU5oQ7VQlA4/iGMVL4IJ4d4mbYiUzEXyZ
	 1HxRcuXKUspUhJPO610s2I/i1CD4HYwGhbQv8sjoieEKEw7K+R82p2GiughBmbA8VH
	 D842kFI70s6DcKhblCH5ynn7yAaSP2Mg1RYugYq7KT0O0oTtcWihMPaKsTUMNaiqds
	 pOqA3fOtBt3nA==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 13/69] mm/hugetlb: Refactor early boot gigantic
 hugepage allocation
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
 Ackerley Tng <ackerleytng@google.com>, 
 Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com, 
 joao.m.martins@oracle.com, linux-mm@kvack.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513130542.35604-14-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-14-songmuchun@bytedance.com>
Date: Fri, 22 May 2026 11:56:36 +0300
Message-Id: <177944019668.3663073.6529634450029926963.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 13 May 2026 21:04:41 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 558fafb82b8a..ff8c5ec831bb 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -104,17 +104,14 @@ void __init pseries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_p
>  	}
>  }
>  
> -static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
> +static __init void *pseries_alloc_bootmem_huge_page(struct hstate *hstate)
>  {
>  	struct huge_bootmem_page *m;

This can be void *m and powerpc code does not need to know about struct
huge_bootmem_page at all and its declaration can be moved out of
include/linux

Other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


