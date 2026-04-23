Return-Path: <linuxppc-dev+bounces-20014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31855F589D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 13:14:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1c4S5SwCz2yGX;
	Thu, 23 Apr 2026 23:14:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776950056;
	cv=none; b=EQeqFm5ivULUlAIA0fEWdoSooaUIKeITci1JKjo7NKebpLJO2B47xS84jHM9Yb8QFZkvPs/JIseA73gS5S4mya+kZ/uoDRKv7s8Mm3xLlBsXMCNlPmtjNmNCk8GGxuAJGjedMCT7mK6Yd0h9JOtrawVbjb/KbR5eg/dyS1NXbC1X+nZUZ61Wc8gWitYhEb/XfyYLsvmMWayqlrzEYqDyncfMEMctZr0c55z1TGHS0SQ6Zkc36XUznJ57+zM2uezDO27QugCqaCGsYVE9himwRlPtrOgSmdy+YaVucKQO+nK/2sBEb7U4PEPTnSEyaqOIgG8RivL/rlghLHds0vr+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776950056; c=relaxed/relaxed;
	bh=E5zu17eWGJx0ZbQT3/4IhKgc7X0rd78xRrUuhl9JKjo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gbZZB47SDFICp+oTY/rM3xOb3xES5DZy9ALS/b1RvbLYSN7KW+nw/AW6l3wRC7tcr6rXt/iqQt6SylHXOLqV64i0oo0GRG0ZuGNhcLuXjZIQsvtGkjIekyoH60d7VicPtyJF+fAN37H6si4Qy6E8h66bQTYcGJVY5zAomlzJjzo0q03T1PTwq5mIiTPO38Lrdw1DPeSI6IaP8QilLC63OBJJEnGap3MKHOorS6uV7AnjCUGbmKGTV2TR9UoYfJmAeI4DVLD+L5CbDJEpiQczrUPnbZByogrgUKRygM9fcW6goDbE5y3RYkWyBuv2K93EbQjtmgSosYBQy02W3/wHDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S03Ap+5t; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S03Ap+5t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1c4M3h84z2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 23:14:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E4EB40395;
	Thu, 23 Apr 2026 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3830C2BCAF;
	Thu, 23 Apr 2026 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776950043;
	bh=vnWoAcvGkh3LMITKH32uZE+wtK1wshJpIlS68Lsz+nA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S03Ap+5tRCZsFG/zml8CtLTb9BLLVXvGEoZoAY1RDgMQdM7wvq1yuwkIVYkAy2l2r
	 ZlbkQb1/rkCirun+/str7aimc8Ii31c13+V/2Wa9O/D1OMLHNQBv4iOL3M2YQKTfNG
	 qLoS826+ne+kj4Lz5F+ChjQSVWBhYDlhrAyzBOJ8=
Date: Thu, 23 Apr 2026 06:14:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song
 <songmuchun@bytedance.com>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 v5 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
Message-Id: <20260423061402.71f0f37285e922f28853e5f8@linux-foundation.org>
In-Reply-To: <D642D89B-CC3C-46A0-B1D6-3DC2C4DDB874@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
	<20260423071911.1962859-5-songmuchun@bytedance.com>
	<1cbae635-a115-4270-bae2-64145d16f936@kernel.org>
	<1ADE7CE5-F02D-42B2-B7AC-FE0D6E86042D@linux.dev>
	<20260423053237.a44b68034673bb35a1e042cd@linux-foundation.org>
	<D642D89B-CC3C-46A0-B1D6-3DC2C4DDB874@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 20:43:02 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> > 
> > Ideally, split the series up into one series for 7.1-rcX+stable, another
> > series for 7.2.rc1.
> 
> Given that these issues have existed for a long time and the trigger
> frequency is very low, I suggest we take a more conservative timing.
> 
> We can prioritize getting the series into 7.2-rc1 first. Once they have
> 'baked' in the mainline for a while without issues, we can then proceed
> with the backport to -stable (7.1.x). This avoids rushing risky changes
> into stable branches.

Good plan. thanks.

