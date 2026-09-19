Return-Path: <linuxppc-dev+bounces-27787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41B1C982D7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 14:08:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnBCj0pHHz2xYg;
	Sun, 20 Sep 2026 00:08:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::c6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789826881;
	cv=none; b=R9aXB3fF+NdMjNpQBYtA0zHJzhsv+NPfBPS98nEaLXOXFQJ07x0cqLlJviTOxgDuRf8XYh/RvPhQYS6TRUkH2wl+KA5V5C/GEVjaLgiqCWcQCJJkaW7THY46wI/72PmiOCOcKb0MmBk9x3zAtmI/Dj1m8fyDZDHamo/qKDn0cx6r7pc6GRhf8ltZWtFvNHs86wGWJTKyuGguRwVWNsDVDqt8vwYIyPbqZIV5O7za88V06lczBzRCgerGOilMU1N18c6nPkevIMZZ3ZAiWx8WpicX19D1JZ7QZUmE5QtJWNJX+g3qapcLPA9cwB+u/VnrYCQONs/C9/XoCAfuFZwXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789826881; c=relaxed/relaxed;
	bh=1RJtSmGkDzOhRF7zExD6eG4nMnJW5Es9Ic7XyY94Oj4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mwCsincrIbR9UaY/u/6witEyfDlJJJPaClsgfBVW8a1vbjxSUQ4CagiEYvgsI6J2gSREytTK9gBJlJqtbSnJPoR97O01+Pl9ull/zYJSxoYHKhix0YkhMlKEdgsl7K4HvDUfodIkhiKyoi1yl1c966h2gi4XcKxgoDjc/GMrWgg5la5JqY43ChNzbQRHofzl0EVupClCIm3HHQILTJBJVvieSrWq4ZeqSHlixdjj+WReP8TznIEpHUZEj6aEY9ESbBnB1xKD8Jk4wm9bl+fsOuAC/6bbLM86qApCL14kPb1Q7XOeiWN9JhMlB83OtRZObenXx37FagxFTwmW23MCBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mqt6FUuX; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::c6; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mqt6FUuX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::c6; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-198.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnBCg6kdgz2xST
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 00:07:58 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=1RJtSmGkDzOhRF7zExD6eG4nMnJW5Es9Ic7XyY94Oj4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789826860; v=1; x=1790431660;
 b=mqt6FUuXMFr5TEmLd/Q/Yc7UnGrkFFt7cnv558YaEsU6Vh8n7PyA8OR+ru3pS1o5JvD957Yk
 +b3PDUY6awRtFAZWYIo+vVXFm5eURkdXn6ow9TQg96V92kPVGoWdAUTtvB9B3qysIv8E+t14uye
 rg662j5uUpj680cmtR7g5Ql4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id b0b09ee52edac098;
	Sat, 19 Sep 2026 14:07:40 +0000
X-Mizu-Trace-ID: b0b09ee52edac098
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
Subject: Re: [PATCH 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <186ee2ba-daf3-4120-a3e3-101cac1ff5a1@linux.dev>
Date: Sat, 19 Sep 2026 22:07:19 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AA6C66B-0FD8-49F3-8447-959A3E438FC2@linux.dev>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-2-songmuchun@bytedance.com>
 <186ee2ba-daf3-4120-a3e3-101cac1ff5a1@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 19, 2026, at 22:01, Qi Zheng <qi.zheng@linux.dev> wrote:
> On 9/13/26 4:37 PM, Muchun Song wrote:
>> VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population =
in two
>> places: it keeps allocations on the normal path and takes a reference =
when
>> a backing page is supplied for reuse.
>> After Device DAX switched to the common per-zone shared tail page, =
both
>> conditions can be determined locally. DAX supplies ptpfn for every =
shared
>> tail mapping and requests an allocation only for compound head =
mappings,
>> whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() =
alone
>> selects the correct allocation path.
>> When ptpfn is supplied, the caller is reusing an existing backing =
page.
>> Once the slab allocator is available, take a reference for each =
reused
>=20
> Does the availability of slab mean the buddy allocator is already =
being
> used? Could there be a window where the buddy allocator is functional
> but slab hasn't become available yet?

Yes, because the slab allocator is based on buddy allocator. But I want =
to know
what's your concern here?=

