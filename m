Return-Path: <linuxppc-dev+bounces-21376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF948CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMKDW33Zmz2xSN;
	Fri, 22 May 2026 19:07:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779440859;
	cv=none; b=gSNjYOac76lNmmqIWczV44yurMYePx9RC+A8bYQgTUNGLk3UOm4Qlti8bqYk8E5v4gPHYqrgphzhevFgg9LSkdgxJ/MGZXyzjQQB27JU//Tv7Jne2gMKPOtjrYMKOyWuBpIntGQcJGahNDP9U1uC23lT5uHx8aV7ooNa4dC4HuNg678i7q2vlGyJP6BKDSV+3RWuWAKPllzazkMEq2rpmQ9iVzrBWcNzNn94d1FG45WpduCt4U4sVFjIfnaGi2/1HXuARD9tud0oele40yJ0BUVNlWUps18Ik25dVHiPGr9ci0iOFVxp4NoWccwu+7sAff9QtBuuk8Om4oTew2i+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779440859; c=relaxed/relaxed;
	bh=5nUM04+Oakpa9Cj4TWrMW9fEn3Kk+NVFqR1pcLe6/gg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zi5RJp7fYlUHsC5MnJevKghHMF10A9f/4mzKjJ3QzPWGneVFxhIaKnX4x3xUPvvNmMTdpfyTE+ROVtwu7Wkzm+NjVG3lY5ALRvKKw/6EaLjJaJd5UmuWs3U80EV2diuFRaBs+MKp2W6nXwYOMrNWI5KtQI6iC1SR/sT5E+91wjPWFeWygN4OJ6OKJCqW3Ae7HqKJ8MEfd7D9UU2/LJ5c9ixsghmX+pgpMdaTDqkIjib1s/OjpV13yDfdh47+HJv0TwctWrhATioB/Ww633EKxOK1Dz58gRHadrbyqrbQQEQf0LrE3TT+ItQV9jtwV1gHs+dVdnPc1tLhHEY63rXdfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kVMY/Otz; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kVMY/Otz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMKDV5Pc5z2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:07:37 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779440837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nUM04+Oakpa9Cj4TWrMW9fEn3Kk+NVFqR1pcLe6/gg=;
	b=kVMY/OtzdFq6iqxzCMMwayWxsSWMY+CExELm4bPfWtHv+NUhZ7ovfrKPHfkEWe6tD9xP0W
	ouUAkCmWjJ7g8pcptkLRtK535VvcrcUzKHC7wTqTQB34PQjQqnqc5GwHZi5c0QCKRmS67B
	47wgP7fANk1PZvbaoaWBdmZdVMDaGiU=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 19/69] mm/mm_init: Make __init_page_from_nid() static
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <177944019670.3663073.4082076266566320906.b4-review@b4>
Date: Fri, 22 May 2026 17:06:28 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ackerley Tng <ackerleytng@google.com>,
 Frank van der Linden <fvdl@google.com>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8583ED6-4455-4085-BB0F-D9D903491C9A@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-20-songmuchun@bytedance.com>
 <177944019670.3663073.4082076266566320906.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On May 22, 2026, at 16:56, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Wed, 13 May 2026 21:04:47 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>> __init_page_from_nid() no longer has external users and is only used
>> locally in mm/mm_init.c under CONFIG_DEFERRED_STRUCT_PAGE_INIT.
>>=20
>> Make it static and keep it inside that block.
>=20
> Can we just fold it into its sole caller init_deferred_page() please?

Yes. I can do that next version.

Thanks
Muchun

>=20
> --=20
> Sincerely yours,
> Mike.
>=20


