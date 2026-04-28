Return-Path: <linuxppc-dev+bounces-20213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC88FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:17:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4WwR1tFbz2ySf;
	Tue, 28 Apr 2026 17:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777360647;
	cv=none; b=ftcCX2Ca+5RzMCSCz3t/sg53TWcq5yQXalUEMblczfsMvIAWHMqXlnClEqHdMzayPcqIJVus8D+RhgHcHQIrRrBwPG/wgKXh23yRn7O3zCu+hmXutTm4njmCdFve+ZKc30CChYLL5u/14reQSVT1aEK5jduZ3qe7VG8rPvf+w0U2ifMq0E/kGuZSky0Vg9Hgb2YR0u3+xP/XvEfWC6o4EmYaqErjWcmg1LsK6ivhhu0dkR/FmmRpIC+JBNinkmJQjFNa5a3RCHfWneJEq5ts9k2UOfnM/F6IxJWweksj4BwZCZ39Y42ZSB69LifZlob7J2ezBmN1UIvTc22JZu6hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777360647; c=relaxed/relaxed;
	bh=/lEyLbwsGkq5jeQO3S1l+bt4PBn3n38L01KVUzmf0Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWgUGvn880mYwUSx0g7aJUHZYAL+XK67PkzacDDq2VrkyKzHMrLpSjJxM42bZg5Jqz6T3g3CAOJQkgegW/zJqDubWZFTcVXKtXlWqL/byUuP+qAGcqQHYavlxQU0vTsKJHEZz1dyTJLdPXPSExl93gpvxn965+qJk7vCBIfds6rvChrSBELocvLUzRM95RvcUS+HI6zma1DVHfM+pQ5BXL8qW4rQJSUifVLr7X5/dFZY0YJeQIkDVZ0ntM/wimdQzlz1xw3dmZoZ3qrRQnWrYzHaBM6i6AMK5RHMDhKCTKpkTXdzoJpgI89c8OyhZMDGLTVlhRrB1hS6y+EUYj5qwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s/Sw97Dt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s/Sw97Dt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4WwQ4dHzz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:17:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C188A40BE2;
	Tue, 28 Apr 2026 07:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB853C2BCAF;
	Tue, 28 Apr 2026 07:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360644;
	bh=x9qJIinO1nbogO7nsvx80qmxge1hX/VRXXcguBHeeBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/Sw97DttDLFUyysya55VdNHbAtjN6EvA/HnLuN9KLgoGNh+23d7x61vhdm0euIMp
	 UtSXK5R3sBkVa52RpDSncu4CcnwlAvWaOAvF4ysfEkiAbr3ZrhqAEkOPxktj8km0iT
	 EVbPcP/JxmKJmM1AqwyePCkw5W7yE7sy/FPMphWhHLoxQYXxn5t/dNAQ7hvsV6lLBo
	 sTYTon165DhK9vFnkcBR+vWM1y8XR/qkviuBmKThOZKLPE80Lkbsjqp/9riIlyql5c
	 VLQEk+0sbjAcGXGxvoXV8t7QokdfpoCQ5120+J4235p/yyVccZLhosagV6hsaT/sTC
	 VV4jjZfM/mCAQ==
Date: Tue, 28 Apr 2026 09:17:16 +0200
From: Mike Rapoport <rppt@kernel.org>
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/49] mm: make set_pageblock_order() static
Message-ID: <afBe_CQ0RtmT3xhK@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-13-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-13-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:03PM +0800, Muchun Song wrote:
> Since set_pageblock_order() is only used in mm/mm_init.c now, make it
> static and remove its declaration from mm/internal.h.
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

The removal of set_pageblock_order() from sparse.c should be moved here as
well :)
With that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/internal.h | 1 -
>  mm/mm_init.c  | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.

