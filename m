Return-Path: <linuxppc-dev+bounces-28425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52742CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:52:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv0520zgHz30P3;
	Tue, 29 Sep 2026 10:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790643142;
	cv=none; b=egHRgBWPIlJGKx+evYeOBcM2JYjk6F9Rg2ryRY/5Y6zAJ3VxPl3YO1KxTSIsKcJ32KyFVP2QMg/VswMs4FfOpxV9VxoAqOZT3tLWR4Vxs2L8NZDNTBq1fIFEXSCUZR73hLC2bed/WV51HFUAJevUjf27c7d2r60TcZQ0jqs7YEBT+2v6BWS26RTXATcPf89UJVsH6+OYF8Z1w7lYQBODCfUJUPAWoya3x+wBlNVcXWbw/s7kEc6yQ2Rs7QcqX/mgOqaDTolyFyacdCrMH54d7fkC/hgcIVcRgqoZM0xqYzGg5n0E+0qdzu+BpznH8eaxp1BAt1SSjao2Fc/XPCQ02g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790643142; c=relaxed/relaxed;
	bh=dxfGKXsjt22oMjT3e9zqK9vh34ayPH6ktSFXgULNLw4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=imKh5srGHGfxDp3IOJAIvxlmuatgGDtARQlHMWCXH4UHbeqyoZ/2a8XrUFW4hEsf165zSQW8IzqZIdvx1hqUqFNMvhGv67saNe55IwKJNj+TdgOox/5r5bcPmcb/EVc3yZ+ySpiziPQs3fmXZDJbAu6Ev95YXczt4f1O9zDwkSi+Sj+KNnIFiKBIoGH0Y3c/sxjCOYk89Nx674M3mV5hWFU/6Oc3l6/JV2ocZn2JlW0ON67U1cv4LlixtDvPy4QqihYxidGetXyL5JPlUfe36SEYy7D969l2rjmAwIN8RGS7EO5+tX36F2JvbsAPlLaaaXw1I7skxVu8KluoEY0P4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MTeuINsu; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::2c; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MTeuINsu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::2c; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-44.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv04z1HZ9z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 10:52:17 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=dxfGKXsjt22oMjT3e9zqK9vh34ayPH6ktSFXgULNLw4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790643113; v=1; x=1791247913;
 b=MTeuINsuF52A64HtkeS9XsiohdQs8roZkjQliWVTYzVthb9Z5/zgWrW2H02RF2MQiP6CwmDb
 7oGCZtKa9j0Y/8OVOZf/VaUmOqCA1IJ89H2hG4qZrO/hSOjHYIPpxocgcWkGr1jSXfM4G9ivC/9
 3zdEOrDEFUADlB7B/mOKXIBg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id d9a95586af9c48c9;
	Tue, 29 Sep 2026 00:51:53 +0000
X-Mizu-Trace-ID: d9a95586af9c48c9
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e36e8b24-81fc-45c7-8eb9-8b363e3d89be@kernel.org>
Date: Tue, 29 Sep 2026 08:51:37 +0800
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D999F950-DB51-477A-BECD-B68E8F414F81@linux.dev>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
 <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org>
 <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev>
 <se2tjmpk.ritesh.list@gmail.com>
 <e36e8b24-81fc-45c7-8eb9-8b363e3d89be@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 03:03, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/28/26 19:43, Ritesh Harjani (IBM) wrote:
>> Muchun Song <muchun.song@linux.dev> writes:
>>=20
>>>=20
>>> If you're planning to review this series, I'd suggest waiting for my =
rebased
>>> version.
>>>=20
>>=20
>> Hello Muchun,
>>=20
>> Thanks for taking care of powerpc side of the changes. Is it possible =
to
>> share your git/github tree somewhere? Sorry, but it's hard to follow
>> which series is based on which and the overall multi-series is based =
on
>> which upstream tree. If you could share your updated tree somewhere -
>> that would make my life simpler.
>=20
> Yes, that usually helps. And next time better clearly spell out the =
current list
> of series, where they currently are (mm-new, mm-unstable, on list etc) =
and the
> dependencies.
>=20
> I was a bit confused :)

My bad. I will specify the exact branch dependency in a future version.
Thanks for your suggestion.

Muchun,
Thanks.

>=20
> --=20
> Cheers,
>=20
> David



