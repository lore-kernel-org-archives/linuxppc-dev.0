Return-Path: <linuxppc-dev+bounces-20060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE9FFE5201
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:20:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g289n5Y3Qz2yTQ;
	Fri, 24 Apr 2026 20:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026045;
	cv=none; b=eF+00553HQ+K/Fuj0FNSTb0S74mtrwKVkefDls0J8Myb4+v6k87ZpPN0p0gi5OkzyIn1RZzCLqty/xnGj98fuHuTB6bTZtxaJwZZu7iR/Etitnh7L/5YDKN3UQOykKN3mnzFaAPUIXtQ9IERjJiZARwdEZ09XIt32FfACa2XAJg3I3QqpBq/BUCHf18zUAzDI/qfaw751iiARmJaejMN+hN2e3vt0DDZwB9VXx+Uzk3mpcuojNCEL1VKigIwjtF2ksUyWrgngmld+drZRpa0VvfaRfuGien+45U4om8iB7bplgW52VTNmfMXxxNkOSYcebBRV1tDloMPuQ5vjv6CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026045; c=relaxed/relaxed;
	bh=v7HsCofWu1Fj4KM5mfTpvHEQ8XWMsqEKDLZEW1mgiAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g6RJkO+48ceCSitWNlDXTZIzw8K9AQVWUUiDTgfYDZccpwvKIVrzNYev4z2PxVx1+d/WCSwoxDX1qDW2l8ZlQ9gfeP6uEipelXupIUgskPLw2SsHZGCcrivgDHSgQMTnhAAJGydIczPAicc4yxh4+5UkaicEnV9FgXOc/AvjgErEKJ554RJWa+OqhDycAaAc8IITET0EC+0YCyIwOhCdlEE14ZenG5xY1c47MAxU9jjGj2GTUHUwPrVDg6jWX0RAxSXNQRkD2j32qeMESM5ksctfAz8kythlfFdWXzEXYyO74lh8TbitmPH0jMPqW4uGeHcrN8U68HUB1q7M7/ULRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KBJaGO89; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KBJaGO89;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g289m5lJTz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:20:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 366686001A;
	Fri, 24 Apr 2026 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADBC19425;
	Fri, 24 Apr 2026 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777026040;
	bh=0RadErNyVmV3gi8KLyDo2YKUadazcNECWm6ket0mhpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBJaGO89V8KafZomOFN7DV16OlCVvzwC7VKvSQQilKTbrOJuibl2b3+ADa2f1ziq4
	 RmfX6P7YFFkox0Lnq6RqR/GLRf087p374Y7C+2E8ZHRH3MoEzmu10z+fTHqYsBl9xK
	 4834ULDinadjU00M0zGkABFZBA64qCd2z1++Z5YM=
Date: Fri, 24 Apr 2026 03:20:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] mm/memory_hotplug: Factor out altmap freeing
 checks
Message-Id: <20260424032039.a43516455eb1ef7c7fd7867e@linux-foundation.org>
In-Reply-To: <6dd8e62b-97e3-4261-92c7-ba3a02ae6397@kernel.org>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
	<20260424025547.3806072-8-songmuchun@bytedance.com>
	<6dd8e62b-97e3-4261-92c7-ba3a02ae6397@kernel.org>
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

On Fri, 24 Apr 2026 09:34:43 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 4/24/26 04:55, Muchun Song wrote:
> > Use a small helper to centralize altmap freeing after verifying that all
> > vmemmap pages were released. This keeps the check consistent between the
> > normal teardown path and the memory hotplug error paths.
> > 
> > Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> 
> Thanks!
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Andrew usually prefers sending non-fixes separately,

Patches which are destined for the current -rc cycle (and possibly
-stable) (aka "hotfixes") take a different route into mainline from
regular next-merge-window material.  They go into different branches
and they have different timing.

If a patchset has a mixture of hotfixes (upstream next week) and
regular patches (upstream mid June) then I have to pull the series
apart, stage some things into one branch and other things in another
branch, rework the cover letter etc etc.  Problems with this are:

- what goes upstream doesn't map well onto what was presented on the
  mailing list.

- the hotfixes (upstream next week) may have dependencies on the
  regular patches (upstream mid June).  This is backwards.

Much depends on the urgency of the hotfixes.

In this case, iirc, the determination is "not very urgent at all".  So
the series is OK as-is - it's all "upstream mid June".

This is still a bit suboptimal because when the -stable maintainers get
onto backporting the cc:stable patches (after mid June), they may
encounter merge/build/runtime issues due to the absence of the
non-hotfix patches from this series.

So generally, it is best for authors to have a think about these
timing/priority issues and to present the patches in a suitable fashion
- hotfixes/-stable patches in one series then non-hotfixes in a second,
later series.  This way their presentation matches what goes upstream
and we reduce the possibility of problems when the -stable maintainers
get onto backporting.



