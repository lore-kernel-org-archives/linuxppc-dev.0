Return-Path: <linuxppc-dev+bounces-28483-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373C7CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvDKy3kVZz30V6;
	Tue, 29 Sep 2026 20:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790676262;
	cv=none; b=MvmrkpeazD1B2btvfLkFRvFLgQGi/7UljxlCAiUxt2uinPq0iOASHlAfaZ9MECWz4rHSo9bG5/4hYdGxaSgVfeL0BmgYmqMyaIXZJ7DyX7xEWH1DGGNGhY/Ktv83xY6cVP5nImCcAGZk2KwNrntSDK4L3pqO8HzODb3KOjLpNr2bWL/eMRNBqXtern5CCma6dyOB6EE/P373DLZKHatgPkTpMBnvy3InwaO3oHsH1H4DqKTY6ZXP8pdT8kp4Mi7MtwKQP9zOjP/TeUxwdHWWKGf+gNikIlCSgCLJhDfopukIobNGIBEmQjFqQmPTr0/MjgogohtztVom1bPjeGR5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790676262; c=relaxed/relaxed;
	bh=4nbqrJ878FZWi0rZ57VBSYZymeJkYo6GGL1ScKrDJ8E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bmnhqA8QlqVW4rjKyhJecpxU+Z6vCtbOjRbdWynzBuVM0cbSOAB/ALts3RkhFNVH7OtRw1gBSLko7SRR96X1b2Ug4+CBSmuA4aMJPZZj+Rf8Zv8ecOto9I9eA+V2qBv/JBO8LDmSzYmV9EWtYeH4TfxZdXOkU+ZbTxfRJXQRWZE0bD8io1GmYobhK4JIpbuXkg+qGt4F9UG613KSIMrkua+0iEE2dpQ7lJjRITQwEbHx49FM6mm8GJZBGSPyHCM0Ttu7Y52Xm+3VdEHA+lebhpSy5DThnWCMTQPcal7ZxS1McnSFRzmUOa+vmqrz2fycgq5J1ibGa/kJgnF30U/a1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xV2UfU0t; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::2e; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xV2UfU0t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::2e; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvDKv3F6Hz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 20:04:17 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=4nbqrJ878FZWi0rZ57VBSYZymeJkYo6GGL1ScKrDJ8E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790676234; v=1; x=1791281034;
 b=xV2UfU0tuDjs+vAM8lHyWi44dQsA17pn5uztKuFBNlIe6GwRd2PYsqtyA2scJz1Wj0qol/xS
 fKpCR7C1jmJ0APctIQOMpjalPubX6UCh/TA/Lraz91AVO/LOzU2BBNPDGNjjfJz18B63MgEH4kn
 de+vftwvanmq04h+NbE07hdQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 00c772cd190c1b5f;
	Tue, 29 Sep 2026 10:03:44 +0000
X-Mizu-Trace-ID: 00c772cd190c1b5f
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
Subject: Re: [PATCH v5 08/12] mm/sparse-vmemmap: move vmemmap optimization
 helpers to a public header
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0481F7BE-F912-4E83-80F1-6E7990B447C1@linux.dev>
Date: Tue, 29 Sep 2026 18:03:20 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lance Yang <lance.yang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9720986C-2DE2-4968-9CA6-7823B1F978C5@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-9-songmuchun@bytedance.com>
 <a31cc06a-c22f-41c2-851e-4827869e9df1@kernel.org>
 <0481F7BE-F912-4E83-80F1-6E7990B447C1@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 16:44, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On Sep 29, 2026, at 15:39, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>>=20
>> On 9/27/26 04:54, Muchun Song wrote:
>>> The vmemmap optimization helpers currently live in mm/sparse.h,
>>> which is an internal MM header. That works for MM code, but
>>> prevents powerpc from using the same interfaces without including a
>>> private header.
>>>=20
>>> Move the declarations and inline helpers to vmemmap-optimization.h.
>>> This is a preparatory change for powerpc, which has its own vmemmap
>>> optimization implementation and needs to use the common vmemmap
>>> optimization interfaces from architecture code.
>>=20
>> Which raises the question why powerpc was special and will remain =
special. Wha's
>> the big problem here that powerpc must do special things?
>=20
> Good question. I also don't think PowerPC needs special handling,
> but when HVO logic was introduced for PowerPC, it handled HVO on
> its own. =46rom my preliminary analysis, the reason it didn't reuse
> the generic logic initially may be related to the fact that
> PowerPC's section size is 16M. With a 64k base page, a single page
> can cover the vmemmap range of multiple sections, and the current
> generic logic doesn't cover this case.

I looked at the code in my local branch for removing the PowerPC
vmemmap optimization handling, and I found another issue that needs
to be addressed.

Since PowerPC vmemmap optimization is restricted to Radix, this only
needs to cover the Radix page-table implementation.

The generic vmemmap path currently allocates intermediate page-table
pages with vmemmap_alloc_block_zero(). This bypasses the normal
page-table constructors.

PowerPC Radix uses early_alloc_pgtable() before slab is available. For
runtime population, it uses pud_alloc(), pmd_alloc(), and
pte_alloc_kernel(). These helpers initialize the page-table metadata
and fragment reference counts expected by pud_free(), pmd_free(), and
pte_free_kernel() during hot-remove.

To address this, I plan to update the generic path so that it uses
the normal page-table helpers once slab is available, while retaining
memblock-backed allocations during early boot. Once allocation and
teardown are correctly paired, PowerPC Radix should be able to call
vmemmap_populate_hugepages() directly and remove its duplicate HVO
page-table walk.

Thanks,
Muchun

>=20
> However, completely removing PowerPC's special handling is already
> in my follow-up plan. We need to wait for the current series to enter
> the mainline, and then we can proceed gradually.
>=20
>>=20
>> Change itself looks good.
>>=20
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>=20
> Thanks for your review.
>=20
> Muchun,
> Thanks
>=20
>>=20
>> --=20
>> Cheers,
>>=20
>> David



