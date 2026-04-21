Return-Path: <linuxppc-dev+bounces-19865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C11F5A8DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 04:02:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g07x91HPJz2yfS;
	Tue, 21 Apr 2026 14:02:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ab"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776744173;
	cv=none; b=gRA/MCiy/zR6BW8Hc2PxfjdDe6OzGf0wkH5+K7g8LGh6yXYBQi6RzXXz3DAdNdPqqvQrbRBMopvhBS9vm9MSlpAW4RzMo9VFq7urE6BKhSQN5QFQM+Q6bXFGoIXfQ4nIjwoUstL+b87sWb3KQxQ9j8PfJ2OVLfpfBNbNrfcscufQp1O2oxM6W6V95j/aQGZVFv09XZc3vI5FLTvy8ToMhdveKKJBFRkE4XAhX3RduEve7MQxFCUvdqGEU92x4rkHCzkCUySGD3vE0Ohj3gcwD+Uus5rvcOhFsHNQSg4iXr0lSEiorqBrtCxt4kPcHl2amJ544iapbzEh3hvzEctxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776744173; c=relaxed/relaxed;
	bh=jMdJRNtKo7iaVl+CsUGo+lqElncIkwLhNwFqakkkUeM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ipqnj9SMb/TZCPHoxAHIxMWiF/bHDBJjMYseeiuDpBiR4+PkhWhftqNx/ugQZbAK16XsDwz0oT87ltQCWaUvuRWLs9T7rDAKVB4t8/BfR4XXqNsHXNzu9ps7dv5Utqi0AldhTKBfP8To8HOZumtPq0cURH5RIQOzr4SLNrj4ff192GdQU5XyNUqH4gMKM8LE1Ho1w0Txu9n4o3q2kKjJJoxUX+nsUJusA6o5/b9ASKrjw5hBEXr9HRZdExNcYH9X/3eerl7xrNa8MKhU3v+dVHcexAy5xETeoP/rAcdbsR3IsIAlWz329dmK7iXU9uQ/7KtZVnJ6FIbziEZrt09t5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P0xaSkgf; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ab; helo=out-171.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P0xaSkgf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ab; helo=out-171.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g07x45jCpz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 14:02:47 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776744143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMdJRNtKo7iaVl+CsUGo+lqElncIkwLhNwFqakkkUeM=;
	b=P0xaSkgffkY/VRF9fMqKDRh7+V+gLrQC2wIjEZ6WMNXTbB4slbAyJZcsfbYpBc8bue41Gs
	uC++PiG4GNvn5/ExS0vNS0mVz2zXeeQ1kIUJ7wtddJaMO0GIWpx0gQHOLUqaQ7IjZOyY0b
	cV6Lg9OsFyqR52slTe7DWhNESR/Rq/0=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3 2/4] mm/sparse-vmemmap: Pass @pgmap argument to memory
 deactivation paths
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aeb1N2T1rX6GHrXn@localhost.localdomain>
Date: Tue, 21 Apr 2026 12:01:42 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9C51B52-F9AD-4D35-9B00-7C21950ABB29@linux.dev>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-3-songmuchun@bytedance.com>
 <aeb1N2T1rX6GHrXn@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Apr 21, 2026, at 11:55, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Tue, Apr 21, 2026 at 10:20:42AM +0800, Muchun Song wrote:
>> Currently, the memory hot-remove call chain -- arch_remove_memory(),
>> __remove_pages(), sparse_remove_section() and section_deactivate() --
>> does not carry the struct dev_pagemap pointer. This prevents the =
lower
>> levels from knowing whether the section was originally populated with
>> vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).
>>=20
>> Without this information, we cannot call vmemmap_can_optimize() to
>> determine if the vmemmap pages were optimized. As a result, the =
vmemmap
>> page accounting during teardown will mistakenly assume a =
non-optimized
>> allocation, leading to incorrect memmap statistics.
>>=20
>> To lay the groundwork for fixing the vmemmap page accounting, we need
>> to pass the @pgmap pointer down to the deactivation location. Plumb =
the
>> @pgmap argument through the APIs of arch_remove_memory(), =
__remove_pages()
>> and sparse_remove_section(), mirroring the corresponding *_activate()
>> paths.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>=20
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
> The change looks good to me, but I was wondering whether we should =
pass a
> mhp struct instead to low-level functions like arch_remove_memory and
> __remove_pages and have __remove_pages then pass the right stuff down
> the road.
> That way it would mimic more what we do in hot-add path.

Passing the pgmap parameter is a temporary fix, as I have another
patchset coming up to remove pgmap entirely [1].

[1] =
https://lore.kernel.org/linux-mm/20260405125240.2558577-46-songmuchun@byte=
dance.com/

Thanks,
Muchun.

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs



