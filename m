Return-Path: <linuxppc-dev+bounces-26768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A83EC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:35:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfHLf3D5Mz2xqp;
	Tue, 08 Sep 2026 18:35:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::9a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788856506;
	cv=none; b=maVIE+Bgki+5HI0+EC+2sZMZpysuHkNhMbAT/EqQS7UjDY7R27o0pjBwisni8/T/YhrTlEXDAffD9pwxpnQmvMqe2iUgCXg6Hixj/DvKyTbBR2yXNMew3Ms69MTJszYSBpe/Fz3E6EZk8Ym3+8DkcPWf/ZKRa7Mwk/Ml8PksqoX/6w/VmvwF6MNCZDyFYSU/C0dC1C56enEHuIYbznRhloBv0YPMbzpKj/kV0/q2lMSpOtpkaw31w5dbIuoiwsm1QZZWUFMvfgFpburTccKOCZ3ndys8bDRycwA5gDRV9ADjATPsDL/xakS3M6loPDcNjtCNztNxcpz1sUk7owOuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788856506; c=relaxed/relaxed;
	bh=aN2ORbphLllnmDHaHvQtAfLkAW1wgx0CLNBFoa9NNVg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F/sZxbgqkDeMg9Hyz/Q1BSF0szm2iAYO57qMKrCQOz/BR/pAoNkUwxSNdINctb3VKpwFvNy2elX8UNwuELrYlDfGt/eMkHr1XIfVuVgDkiynMpUPCWVX8HZwUQb44Pe9MspqnWxiWkwhbymRymlNDhOXo1n5b2Q6AaHjonOWGU/nDWvjNzl+QQ51kJmS9vaB0JWpVAHxvunkeUMMigUalCb/0iVkjzDJdtHK2wze3+SzkSaXlmW82uPFeAli3MAP/z3XmZJiVtMip33iFut2rAkSpRKHhKPuepCxGIOmv76oY7NdPWv0a552zhphSIzPT5aae8AT9m8ndIBmnCOYtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WaIV5EqJ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::9a; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WaIV5EqJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::9a; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-154.mta1.migadu.com [IPv6:2001:41d0:203:375::9a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfHLb0sWqz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:34:59 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=muqKO/Q4TVxj/cNMo0pajKXnu4hE0n3bdHEU8buxoq8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788856481; v=1; x=1789461281;
 b=WaIV5EqJnRx2MXsspd/aeq6ewHOKtevy6YI5y0RSqGgiEYxQtOOd7G8se5A+i2OffWaAQ+rI
 GPVzzsSbfcj9r6GPdaXu4ObJvoNwpPEgDIvo3ACaDEL9/teG+XF0OklW4Ev2w+DKReeHPFo1dHY
 dFEUXkxx7dUZJdWGEp4ctFbI=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id ef271c2c22e4d45d;
	Tue, 08 Sep 2026 08:34:31 +0000
X-Mizu-Trace-ID: ef271c2c22e4d45d
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
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
Subject: Re: [PATCH v2 06/11] mm/sparse-vmemmap: switch device DAX to shared
 tail vmemmap pages
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1fc41803-a0b3-48ca-84a6-caf965fb11f9@linux.dev>
Date: Tue, 8 Sep 2026 16:34:09 +0800
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
Message-Id: <B05E15FC-62A2-4F8D-8624-F3DD16056DF6@linux.dev>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-7-songmuchun@bytedance.com>
 <1fc41803-a0b3-48ca-84a6-caf965fb11f9@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 8, 2026, at 15:46, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
>=20
>=20
> On 9/8/26 11:03 AM, Muchun Song wrote:
>> HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap =
pages.
>> Device DAX has not been switched to that mechanism yet.
>> Switch device DAX to vmemmap_shared_tail_page() as well. This aligns =
DAX
>> with HugeTLB by using the common per-zone shared tail vmemmap page.
>> The optimization is enabled only for DEV-DAX through =
pgmap->vmemmap_shift,
>> which is assigned when a DEV-DAX device is initialized. Unlike =
FS-DAX,
>> DEV-DAX does not modify tail struct pages, so sharing them is safe.
>=20
> Got it =E2=80=94 adding this description makes things significantly =
clearer.

Aha, also makes Sashiko happy. This time, it is no longer confused
with FS-DAX.

>=20
>> Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
>> initialize its entries with PG_reserved for device zones. Also skip
>> poisoning vmemmap-optimizable sections while their struct pages may =
be
>> shared.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v2:
>> - Explain why sharing tail vmemmap pages is safe for DEV-DAX
>>   (suggested by Qi Zheng)
>> ---
>>  include/linux/mmzone.h | 10 +++++++++
>>  mm/memory_hotplug.c    |  5 +++--
>>  mm/sparse-vmemmap.c    | 47 =
++++++++++++++----------------------------
>>  3 files changed, 28 insertions(+), 34 deletions(-)
>=20
> Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks.

>=20
> Thanks,
> Qi



