Return-Path: <linuxppc-dev+bounces-21899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1ABCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:02:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV8bP6pCYz2xmV;
	Tue, 02 Jun 2026 22:02:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780401761;
	cv=none; b=TamfKv3mEI3OJFhwcmOcywYDElERrRurqT/OrpakcsOUd4B2VlHWmsaNALiU2adteuwzptiFy62n2KDBstimDvdM6G4kdPS06W+02uOP5A6evqzeAoT3Ir0Mb+0puqGan6GETTdKjgThTECQmYJPdivtyc0sB+OmEZKFIioh8g2g/Q5ag1uUrFjwNvNO0LykZdfe9LYvgQU+uTywcw85FXFd4AJefC9BjI3JN0KzDR6dypUzovLO2YhszYUHbqpK2RDDLfYRpSPcl1VLo3/C2lOXwxiQZkYeiTV/Gf22bn24FFf48hT64/XtyWocY4Xi6gs0xEPVJGPc/AG056V3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780401761; c=relaxed/relaxed;
	bh=+72QC/29sQzn8Uu3Y8YY2M0V2ygqHpEiwFZA5N0acRE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Cs8NAUCOahCO5gsxiM8fztvs4JN/GryUDfIYKeJrylijlpSayTk3kQ19SBMqZv8t75kp5hS8zvAP48VGY2vHo/a0cw1trNg5lCTCjp1tF6zhdVFqmzZ3zM9VtfjOiDJjNAC245EySutPynYDdiuxvlH2+VMbnvXVjTdgXH1Y1P+80Q2F0WjbdFMsz4M7AWMSeM6vaiphYdBbQjWYhDw/lqGcPBQQzuHgI8p6uSXzMo++aESqtuJPqxjC9A9ckZ6fOSD9B8YORCaJRlOPk+yb/Si2m3ql28W7+1ME/5IZpHxVHaDU1A5yA8oHIEBNCJqUgRhy3oJYUm3VjO4zRv8n4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z5LxNo/F; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z5LxNo/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV8bK41xWz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 22:02:37 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780401731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+72QC/29sQzn8Uu3Y8YY2M0V2ygqHpEiwFZA5N0acRE=;
	b=Z5LxNo/FMI/JNJb/TqGZvbAG+U2opcWuC2sWGUblnS6pU3elGn3CL95KUFbPiFS5cVhvjV
	CX+ErMO6Eug6SV/lU5nicCMOFsKiI46gdjqRHyzsh8e6yt3EiHAy5KF9W76dCuWzqmFpHE
	P3OutiC++LR7VRSLhM3SYQ2kkyLPcJQ=
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
Subject: Re: [PATCH v3 00/19] mm: Refactor bootmem gigantic hugepage
 allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ah6xzZBh8IysNXpI@localhost.localdomain>
Date: Tue, 2 Jun 2026 20:01:17 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F527488F-E147-490D-81C5-01FCB8523820@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <ah6xzZBh8IysNXpI@localhost.localdomain>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 2, 2026, at 18:34, Oscar Salvador (SUSE) <osalvador@kernel.org> =
wrote:
>=20
> On Tue, Jun 02, 2026 at 06:10:20PM +0800, Muchun Song wrote:
>> This series is split out from the earlier larger series "mm: =
Generalize
>> HVO for HugeTLB and device DAX" [1]. It collects the first 19 patches =
of
>> that series as a standalone set of fixes and preparatory cleanups =
around
>> bootmem HugeTLB handling, sparse initialization ordering, and related
>> vmemmap setup.

Hi Oscar,

>=20
> Thanks Munchun, this split out really helps easing the review.
> I think not so many patches from this series scaped review, but I =
shall
> get back ot it later this week.

Sounds good! Thanks for taking the time to review. Looking forward to =
your
feedback later this week.

Best,
Muchun

>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


