Return-Path: <linuxppc-dev+bounces-21486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B91BCD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:19:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPN0z2LGyz2xnK;
	Tue, 26 May 2026 03:19:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779729587;
	cv=none; b=PaDjpJIyg3mIIfRBQnwvJbP6d56qd7hP6vmw8o8iGLfDwRmEcwv9g2fJoOUbXkt5BFsVeVZ5dBWf1yvIzFqL5xQEgD8XI0hYtIFvlfjrBEouP7ut2CmFioxaNmvgLZOM3EVG3HHRml8ynztl/AfcFqwqUEqIxYPqIpZ3EfCNz+yWKA9QhXJouCUxFlWRb5ZeRmRrWUc/H9l6/CF0dYuPvCZQI/2jtR8kU5GphBR9DzrWf3Fdmb2CNEYElk7zgPhhOWAfKn06JotQkSN5edY4L/DwRmIaR8fvHwOpli13+SkaMl2Xs79JG/fBR41PsRssgbRHskrfaAeXfdhyc/JK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779729587; c=relaxed/relaxed;
	bh=wu0JytchWi892cy9Rbe8Jo63tHJaQJzkGdnUYJHGi5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkHC/uMppmWzDI4UgfYf6tco8FH9YtH0L2vTpop8PunGTLObXfpPLq81rPChi/R0oRQQrSZk7D/K0+xSpXDF9sEGJSawUDbPYYxWe1oNNZFDS4rXbNq1uWUn8+X59zHwf+5aiyw4ytmwTLZaRvxfYOjCBXcs1AKVcgcKQRdk7BgFnvsixruLO2UpmogLpJXXvpUIXFMkazib2BEgYfmxFgVFKO79rkAG8rMkEjCSa3yrmWc69/IPR8vjkxaW/oRTwzMxFuyFhP+QK65/xPN5VlFPsxfGtTUv64tqwhXHoWbD/pn9XWOUlhxMVaBaFiPkouRd2pYd1aQ5LFOFj8Q/PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvQBosqH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvQBosqH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPN0y4gnKz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:19:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1225B440F8;
	Mon, 25 May 2026 17:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21B31F000E9;
	Mon, 25 May 2026 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779729583;
	bh=wu0JytchWi892cy9Rbe8Jo63tHJaQJzkGdnUYJHGi5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dvQBosqHNOOqzeyxIGbT+uY3fnEI2sBSVY+Fw1Z+kdR0F4bUiCfscUkDYq/sZhe9V
	 nVZsqXRIXK2/WnH/OaWD6ulApKmgoiFEITCjt1BP3xR6rjdRzHF3fljRYtYLEEOvJw
	 RtLOazVjgIFAu9DE95fN7v9WEophxyqhbSelwTraQ8uG8WZyQtw8XWxfDys40L10W+
	 dqVAw00+UNPrRVC82gJUh6pYAGSiZOj+NvPmNDNlAprtsmpWJdk2MKj9wyAzA79ZYi
	 XRyUssQNB9GRKHAsMtOXMISDpslXxRp/vdLqcPqYh8mA6t5imwPj19jO0nlBzbK2mw
	 kXYUk+Ovr6dQg==
Date: Mon, 25 May 2026 19:19:33 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/69] mm/hugetlb_cma: Validate hugetlb CMA range by
 zone at reserve time
Message-ID: <ahSEpapIOBUFjAhs@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-13-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-13-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:40PM +0800, Muchun Song wrote:
> Hugetlb CMA allocation currently has to cope with CMA areas that span
> multiple zones.
> 
> Validate the reserved CMA range up front in hugetlb_cma_reserve() so
> later hugetlb CMA allocations can assume a zone-consistent area.
> 
> Also drop the pfn_valid() check from cma_validate_zones(). mem_section
> is not fully initialized at this point, so the check can trigger false
> warnings. Keep the sanity check in cma_activate_area() instead.
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

