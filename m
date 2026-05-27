Return-Path: <linuxppc-dev+bounces-21550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B73CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 02:57:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQDnf3Fsvz2yTH;
	Wed, 27 May 2026 12:57:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779850678;
	cv=none; b=B1VyI2HmZurkWIeeeDDKiUSWS/tpA0O/rQ6J8gFN18QlNQAxs9tEpoqHLl4HujcigwBgdY/ANRomHaJR+hKyDgA40R9NarPMOzvSqrZr/G9vqHB5Z91uUn6RmDgALZFx0PQ1zXJsNJX8tC6aszDQdy1MMzBVUFTGfif5U6TwbNWXwrUfa8HyalOeG5PXZJ4IASCIsI6RrQO2LBF2gqpU5UhGDbg1cTe1lOi/ZN/3RFUSYdQZMsw9nkuNZuSEac/qW+67+p9fVODENjmoscbRWnByVUsEcc5XgOTCFBWFqcE6Ln6QccHNFr4/UlVRhTAclnQU+Ba/p1X6BbpUfuM5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779850678; c=relaxed/relaxed;
	bh=OevDCY97IHfMWjohNiIYTqTRYr/bbPEe4iODaGzCseQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rre3fMZMmwT7Jq0+h/wWk5kgBRLgmlX//1GJ2k1WCd5IW5VXO8P3FahEtQ39GqBDcJbKj94UGKtapImPvulJ+A0+aC4DBD0O2WaeRhJP8JQ9HpYrGjBt9yWza7BDRmZvsS+Sl/5O7Akm96eiXMQrflD9xV4KGX4x6p+hXCqhtWW16xKkFNQqPG98ML/Gqx8WAH0sIveyQDsMaVmnEboMiQUZQKVIYdsxpfC24Skx2t2VF05dJOlEY6z8+DnBT7JF4fsKWjQvCzhDw2iuLrnJKnQMvi6ZmXuQu2SEhvVlrbCDm64ffNfVWC5OT12WsI5S7z3T6zBSdu8mxwlFTvoDmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jRHumPzy; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jRHumPzy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=yintirui@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 43298 seconds by postgrey-1.37 at boromir; Wed, 27 May 2026 12:57:55 AEST
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQDnb4S6tz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 12:57:53 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OevDCY97IHfMWjohNiIYTqTRYr/bbPEe4iODaGzCseQ=;
	b=jRHumPzyfWCCF+pN7RD25xUqbdZBtJrU/LkkjWSghE/SDZVDQJHA1uf8sTeQQJb+pPrrVIriv
	BHuldCsnAcyzX2PDcp0+sXpNTRAcEZ1GyfXFQmgDwVeRSRjpiwTtY+Ft4brF9v9wA+TktkA6SrK
	uso67IalMfYGi4RTYZwkOak=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gQDcX1Rg0z1cyQ9;
	Wed, 27 May 2026 10:50:04 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 70A6E40565;
	Wed, 27 May 2026 10:57:48 +0800 (CST)
Received: from [10.174.179.248] (10.174.179.248) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 10:57:45 +0800
Message-ID: <9dbcf423-108b-40cd-80af-6b93f113599d@huawei.com>
Date: Wed, 27 May 2026 10:57:45 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable RFC v4 0/7] mm: add huge pfnmap support for
 remap_pfn_range()
To: Lorenzo Stoakes <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@kernel.org>, Juergen Gross
	<jgross@suse.com>, Jonathan Cameron <jic23@kernel.org>, Will Deacon
	<will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Peter Xu
	<peterx@redhat.com>, Luiz Capitulino <luizcap@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, "Liam R . Howlett"
	<liam@infradead.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
	<vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Rohan McLure <rmclure@linux.ibm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alistair Popple <apopple@nvidia.com>, Andrew
 Donnellan <andrew+kernel@donnellan.id.au>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Coiby Xu <coxu@redhat.com>, Dan Williams
	<djbw@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Conor Dooley <conor.dooley@microchip.com>, Rik
 van Riel <riel@surriel.com>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pm@vger.kernel.org>
References: <20260526145003.88445-1-yintirui@huawei.com>
 <ahW7rut_WP17KADW@lucifer>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <ahW7rut_WP17KADW@lucifer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.248]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)


On 5/26/2026 11:33 PM, Lorenzo Stoakes wrote:
> Allow me to be mildly pedantic (sorry :)
>
> One thing I'd like to highlight here is that remap_pfn_range() is, in the long
> run, deprecated.
>
> mmap_prepare callbacks will indicate a PFN remap mmap_action, which will do the
> heavy lifting (see [0]).

Thanks, I missed that mmap_action_remap() may also reach the same common 
PFN remap
path.

> So perhaps worth referring to 'PFN remapping' or something?
>
> (Since we already have mmap_prepare() in use, it's also kinda inaccurate to
> say remap_pfn_range() :)

Agreed, describing this as remap_pfn_range()support is indeed 
inaccurate. I'll reword it.

>
> [0]: https://www.kernel.org/doc/html/next/filesystems/mmap_prepare.html
>
> Sorry, this is pretty nitpicky :)
Not at all, this is really helpful.
>
> Cheers, Lorenzo
>
-- 
Yin Tirui


