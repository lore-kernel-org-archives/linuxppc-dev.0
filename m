Return-Path: <linuxppc-dev+bounces-29175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A3CA6004
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 10:34:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j20Tw1sDXz2y1W;
	Sat, 10 Oct 2026 21:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::a6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791628484;
	cv=none; b=GRCO/8SJsoSrAxPsErCA2VMMh56t2UjjNGRMsQWLn4aJF1B3RKsV4SY/AHpZNMBG7NHq6PN3/kGloWqOIvDH4Au2tutWeSOaAPOqwf3Phl+9mNtd5Mgq5qoIhajOxPLSqBzzPBJx7Zm37Jwfm/YVeOZueptwEAyasYrHRaJ3r/yJFaHHq9iWwjQDYRuhQecQYH3CpvBZb4f7ykoMZVodvn3ZBRAS9UgawaSBT1BLw1OsmymoJ8QkkBeVt+gp2O+AjMYgu0kewBS5LvqaVC2UsLYPNP7AKhin4x7Vusf3H0Lb8JtKxk9pO34ICXmoIdYsUkxe44WBFecalLlUhmvH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791628484; c=relaxed/relaxed;
	bh=g2VyDxK77mq7FOSsOuc0VjLLB5/X+CTe8SCo2xbPUpo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eea7rvkynKEwOqP1MTaw06rn3c5RIF8cizc9193EmsR14skfNm/EkYeoTbHyNWf6z0mzZsJfAVAeDlZecwF2vHYTPu41WCxjAPNeXc+Yqrsh3p9pq3DsNwi9IJ2KGOtdltvD5crDnRU0dHvZ5KRQUOvNL68zYcnOu66vQzQ1YFUswAVe57jSCCZCVNjqdTqcnS8DmUS3hGbUu4jxzNvnSg5qfWZyTA+l1n7A86AwuTWWz07yRGLHGM9cXoAUtAsXae8pgQRDJOKbmurQlLBqeBvabWEG/UEOF0Btzif319pPFXzSKXPA2pwg2iSfe47ywHpTj0XM09puRdrPfLvqbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o7v6ZlxE; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::a6; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o7v6ZlxE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::a6; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-166.mta1.migadu.com [IPv6:2001:41d0:203:375::a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j20Tq68X5z2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 21:34:37 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=g2VyDxK77mq7FOSsOuc0VjLLB5/X+CTe8SCo2xbPUpo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791628454; v=1; x=1792233254;
 b=o7v6ZlxEAY/w3T0uAInbokQuLcImEW3tq4ieDxhluOmHWMHdYELr/fwxx8FY6ovKgcaAPvIR
 sgstR7BOlg1LcwRisOLKHZ3kZtaNkiKDvz/NSS6mpN/mOefcvCMaQLWpESuYIHQvXXBpHV2t1qN
 q8IXJ7HYo6HeXnL1zi+H6nSU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 44cd96bd31e91f15;
	Sat, 10 Oct 2026 10:34:14 +0000
X-Mizu-Trace-ID: 44cd96bd31e91f15
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v4 6/6] mm/mm_init: add zone mismatch warning during page
 init
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <asoMN5F-3qvaW5w0@kernel.org>
Date: Sat, 10 Oct 2026 18:33:59 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Lance Yang <lance.yang@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E20DFEA-72C0-4417-92E3-66A077904AE5@linux.dev>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
 <20261010075755.83339-7-songmuchun@bytedance.com>
 <434B0573-BF18-4413-9BDF-C5873CC13206@linux.dev>
 <asoMN5F-3qvaW5w0@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 17:58, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Sat, Oct 10, 2026 at 05:32:59PM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Oct 10, 2026, at 15:57, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>>=20
>>> For vmemmap-optimized sections, tail struct pages may be backed by
>>> shared vmemmap pages. Those shared pages must carry the same page =
zone
>>> ID as the struct pages initialized for the section.
>>>=20
>>> Warn in __init_single_page() if the shared tail page has a different
>>> page_zone_id(), which would indicate inconsistent initialization.
>>=20
>> Please ignore Sashiko's report [1], both are false positive. It =
didn't
>> realize that shared vmemmap pages are initialized early before =
__init_single_page().
>=20
> I didn't realize it too when I read this first :)
>=20
> How about a short comment above vmemmap_optimization_verify_zone()?

Good point. A short comment there would be helpful.

Thanks,
Muchun

>=20
>> [1] =
https://sashiko.dev/#/patchset/20261010075755.83339-1-songmuchun%40bytedan=
ce.com?part=3D6
>>=20
>> Thanks.
>=20
> --=20
> Sincerely yours,
> Mike.



