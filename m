Return-Path: <linuxppc-dev+bounces-26604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F8EC624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 09:07:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcSCT3YbHz2ygW;
	Sat, 05 Sep 2026 19:07:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788599253;
	cv=none; b=AhL2QXEwLeGdFDQt2aCYe6Z9S8rRFZJSAL61dfobPoqQnOwvRCTtNAL/g+tV1w4W1sYjboNoNj/u/R+SjFCRmswdc+uxV03O9u/xorRh53EvPSxydkvJpD8tzw/VlZk3lYKB2/ci9DMrPxZZ79hlUS1I9eWrsak9JzUSsVzQzvkvSOu6YQ3NTFX+CBe/c4kv9h1FJ9ha5cW77P4uU2398ttN+eAGHu0zuSRn12MLtl+yFi3RPcQB/5t1zGre27UhoHN0hVokxp38SuGXYgWg0JDjbip8vItRmWWSc3fC3RPB31ryrByxMnmOiIdsndTZ1LuxjAhhcWrfWIDvNGzT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788599253; c=relaxed/relaxed;
	bh=Lp8UCRU7U/gPdKVedCNM8hsF2owEixvJ2Zh3lB3p6qw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bjqnv48k0ljMNRpZ/xRW1yGOARn/CKDy/7K/JnxYDGmf/RVFiPa8KvNfHyZZ7OX054aHbi/FJbiFLiwYrlCCtocJH4waJKJ9718cIKPUdqtiDhlliPGTamT5Gvr7JexT/GznixQNZe5V5fY85YE+2w0BmUTP2fVeGZTxCigz+RgxqfkLPCsbxw3ptAvqDJ2M0LrwbFncJqUhGs3uepE1o6FLWoU178AIhdzyl5rPvNgvuEaTmntynJLR51ku9iXDf+fCu2hWCt9KlTuUTpMHCQtca+RmFTPvB+CwJoFZ3WySqqo/rAbMymRa2+7T1hWbWEbAQL3XszmW2WdQUyB/DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p3/LNQ9U; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::6; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p3/LNQ9U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::6; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 319 seconds by postgrey-1.37 at boromir; Sat, 05 Sep 2026 19:07:30 AEST
Received: from mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcSCQ267Qz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 19:07:29 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=OiKgIsORJwdwK7mxOyBT4OEx/ZyTZXJf9s4fMrv5tMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788599231; v=1; x=1789204031;
 b=p3/LNQ9UaexG+XkcBbbQ+LDPS03V+10DjnjPC0yC+VHNHLANMIsdrYRKh0M1wd5Aqrl9YJaM
 ym9UlMYGWzocZ7HP7x4mYLER9NtGuedUpmqYY62Xnc6in9HEVCkxeAeGm0DLcM/JWBYIqDjsIfu
 EOWSJkQ0Py/PxgZYJeuMTvwA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 27e0770342031b0e;
	Sat, 05 Sep 2026 09:00:27 +0000
X-Mizu-Trace-ID: 27e0770342031b0e
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 05/11] mm/sparse-vmemmap: set section order for device DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1143901c-5036-4b79-8135-21ce57075136@linux.dev>
Date: Sat, 5 Sep 2026 17:00:08 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AEC3FC2-2365-4EB5-A022-8AB0EC111073@linux.dev>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
 <20260831075342.57563-6-songmuchun@bytedance.com>
 <1143901c-5036-4b79-8135-21ce57075136@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 5, 2026, at 16:20, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> Hi Muchun,

Hi,

>=20
> On 8/31/26 3:53 PM, Muchun Song wrote:
>> Device DAX can use vmemmap optimization only when a full section is
>> populated with a compound-page geometry. Record that geometry in the
>> section order before populating the section, so later vmemmap =
accounting
>> and population decisions can use the section state directly.
>> Clear the section order when the section becomes empty again. Also =
reject
>> partial additions to a section that already has optimized vmemmap =
mappings,
>> because a section cannot safely mix optimized and ordinary vmemmap =
layouts.
>=20
> Perhaps we should explain why they cannot be safely mixed.

Yes, because compound_nr_pages() determines the number of struct pages =
to
initialize with section as the smallest granularity, they cannot be =
mixed.

>=20
>> Partial additions continue to use ordinary vmemmap population, so =
they do
>> not save vmemmap memory. Such additions are uncommon, and the lost =
saving
>> is negligible.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/mm_init.c        | 13 ++++---------
>>  mm/sparse-vmemmap.c | 16 ++++++++++++----
>>  2 files changed, 16 insertions(+), 13 deletions(-)
>=20
> Also, the issue sashiko reported looks like it was pre-existing, not
> introduced by this patch. So:
>=20
> Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks.

>=20
> Thanks,
> Qi
>=20


