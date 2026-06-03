Return-Path: <linuxppc-dev+bounces-21932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEF8CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVX745tVlz2yRF;
	Wed, 03 Jun 2026 12:42:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780454576;
	cv=none; b=m/drngEkqWZJ0qWjy5h8w5kV/nur5IQ6Qfrqzw3uKnq3v57N7Md5eJFhU7Uk+9unAaTUsATsDs4qqNIKm6PTkhXJ/pGTFNrfToMNThkLfLJEY3o7T3SeaTNte7AmGppICBsl+FDjUIDGAkTgw4kCfmPeUzIs58y2afa6CHrvW1+j0qyuf5Z5BXjgADcZLY1dwSaeh0kVYC4Q/xjMkF+gG6vr9D1bFzDOGeWitFCsLcMZStrKecXUaaq8qlSZ0qOoy+V0knv2Rui6PHEsVGjnBuXtAZp1X4+fa0e5Zegfl5X8oTkee7fXpWsdrzTMyjryyqrZhINUziK0GhWyKYljGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780454576; c=relaxed/relaxed;
	bh=uFt3H9eVB4pknImQVyVI+Z5RNzHUL5L6kJW7ohYLnNU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=loowqLh4XRrpzyFY9ykO9BXwW8QxXhEcJ/hQbCApYmV40lwqvG41Yh2aLk6LzRh7uGYbpXlfrgSoggqg15TrD7YQURgjcpz2/b/CDvhvdfaYe5aHcKwB9YQ09nR5etgCO3TACfUDhdQ8Zh/d3OnpvpPsCTJZtnzitN9iz76c4EdS9SgN27ZHFMpzjnWiNdKSo0j4XuJzDvGdjj1BRx2dnj0neFD4L4YX/x4a7+IcZlx+LltXxgTm1rCEcCqxPL5nsJIuqWYeH0H/zK7TLVEL4nrETPNy3GXfo/JRu+sOjWxVjdGfQHVWVcGdjovXifYfeD/kTg6piZOkU8RuSvzE/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TOdvl/0I; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b7; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TOdvl/0I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b7; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 52822 seconds by postgrey-1.37 at boromir; Wed, 03 Jun 2026 12:42:55 AEST
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVX734zwvz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 12:42:55 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780454555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFt3H9eVB4pknImQVyVI+Z5RNzHUL5L6kJW7ohYLnNU=;
	b=TOdvl/0IAihcEOBFeMilBYZiC2N2x4xQF/YenP5BCzSIZivaTf+rJmxh3QgmTsygF3QYy5
	6SIhrlIS5fkw4I7fdll+nDCefDuUeBS/cx4xVVbgeCYPAy9MkYxzVNh/R9Xdzok2RWfoJz
	qtTmVPZGmnAA2ahV5lFuLlLpdRcSoOc=
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
Subject: Re: [PATCH v3 18/19] mm/hugetlb: Remove unused bootmem cma field
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <178041489401.457517.7510742037477989122.b4-review@b4>
Date: Wed, 3 Jun 2026 10:41:44 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <101DD3F6-934E-4BFA-9FE7-361BBBD2080F@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-19-songmuchun@bytedance.com>
 <178041489401.457517.7510742037477989122.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 2, 2026, at 23:41, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Tue, 02 Jun 2026 18:10:38 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>> struct huge_bootmem_page no longer needs to keep the CMA pointer. The
>> bootmem path only needs to remember whether a huge page came from =
CMA,
>> which is already encoded in the flags field.
>>=20
>> Set HUGE_BOOTMEM_CMA when the page is allocated and drop the unused =
cma
>> field together with the redundant assignments.
>=20
> It looks like the commit does more refactoring, please mention it in =
the
> changelog.

Will do.

Thanks.=

