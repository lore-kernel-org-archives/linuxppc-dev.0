Return-Path: <linuxppc-dev+bounces-19869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34727F327AA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 06:55:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Cmb4d3zz2ySW;
	Tue, 21 Apr 2026 16:55:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776754543;
	cv=none; b=HdDRIFD+oP60DtmHZqrjLrEvVjUaS/ae0BKF2B6H7oM1Zii0+boRFAlszVabYotfknTpooO4DYeBMeLuKfkYETw82Gogu9qUll1Q4doawblL8FBH02KEYVQQ3lmfZ2fw6X3Ei5xxA9xslwRRqS+rlILnXryvVSG9YVION16Ehy+Y74RUWJTj+JJjYItIH8C26AywOt+I/dyXY5YcBLgi8Wdnxiqh1R7oWUHqyxeBU4TrERlPZWHwpVBdluJi6ALb4d5uYhjS/9ZeXPD6Ivvmp1VYFK6aItg62jQWa3+X9zCqefVFKsFmZSErjvS0C38nh9twiE9up8Lm/o7GKws/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776754543; c=relaxed/relaxed;
	bh=NxUMcETQuixlF3rMQVkit9JIIkPJRX+G/qfMeu7OkdM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SvSPMXFBLvF0rev0hfI+FfiE6yEcA/xmwInQgrrzVvLcGnsRsEEkame+h2ICtmqSmKRCRe2jnuXl7ru29NwFWwUN0mSIUusPloy2tgIyuaESH25uaiU55CHTL+NBmxac/mvKYcROAkSKOWLCfa5SvMjwxDEe/G0dl2vMv/OhQyz1T4NnS46RZoejeZuG5YJ+LiyKd8n+NP2LPFyvX/iSGTII5e6ahObwQn2wh09WkHGED3qRm0e3QFM91dpBDvRsfibww+elwPDPN2mpBvAgjf3Z33eYnwBdEmTOC+NxYjzjOZ6gnfaYoj3XBeZfpbp7BcjQAN/GkRmAoLwSJqqrRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pk7L4Wn0; dkim-atps=neutral; spf=pass (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pk7L4Wn0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0CmW5t7Vz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:55:39 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776754518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxUMcETQuixlF3rMQVkit9JIIkPJRX+G/qfMeu7OkdM=;
	b=pk7L4Wn0WxtolMrucH5sGuAJaeIzkBSFPNvgmYguRp0KXfsGDOalpq6EmsLz1HMn16rkdY
	l0JFXPxWXTYv9tEqYaXY7XCrs0hWc13c9n6czix2oXutSiup0LJg5lsBelcDL3AKWYgmYK
	+n+6x5MrhJgRcfdkMcXYW1/1Aw1QdpI=
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
Subject: Re: [PATCH v3 4/4] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aeb50jwoCBvgEnec@localhost.localdomain>
Date: Tue, 21 Apr 2026 14:54:35 +0800
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
Message-Id: <9343F329-BCD4-4D64-94CB-A94F0E9E4400@linux.dev>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-5-songmuchun@bytedance.com>
 <aeb50jwoCBvgEnec@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Apr 21, 2026, at 12:15, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Tue, Apr 21, 2026 at 10:20:44AM +0800, Muchun Song wrote:
>> The memmap_init_zone_device() function only initializes the =
migratetype
>> of the first pageblock of a compound page. If the compound page size
>> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
>> subsequent pageblocks in the compound page remain uninitialized.
>>=20
>> Move the migratetype initialization out of __init_zone_device_page()
>> and into a separate pageblock_migratetype_init_range() function. This
>> iterates over the entire PFN range of the memory, ensuring that all
>> pageblocks are correctly initialized.
>>=20
>> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for =
compound pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>=20
> Would not the call to __init_zone_device_page() from
> memmap_init_compound() take care of the subsequent pageblocks?
>=20

No, it won't handle them automatically, as the page count from
compound_nr_pages doesn't cover the following pageblocks.

Thanks.
Muchun

>=20
> --=20
> Oscar Salvador
> SUSE Labs



