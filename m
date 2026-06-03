Return-Path: <linuxppc-dev+bounces-21975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4F2CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 12:36:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVnHW3sm2z2y1Y;
	Wed, 03 Jun 2026 22:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780490167;
	cv=none; b=HJ+WtZ8pSIjvCcg3gBCfDIwK+HIGkeXoDproeLxo12prDHEbi833lOuZuxdsVX3eXkX1iK8GJzoMgCm0JJV7IF5gs+7b0m4mAoAvHzzG7fwSTsT1l8cwx6qiKUzgJhzLJdsWWzKrtHcuOwEitqw+m36wW81ndmgZFIP9GLHjBtovZD58eOLqoYcBys6PdIwMHyoe51mcslV4i+jeuzhcv6g47KVhYiSmTz72RXd2o2+oXg95h/UW/TnrTAG/s34CjU1s3hkLWg5gQGt3PJIzTo2sXU08dphOTVvQzbBC45EDJ60L8ixsPZwogvOr71VcAz4Sn+/w3gDSGFazVbNxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780490167; c=relaxed/relaxed;
	bh=/9sR5yqOCGgeVlEaAS9Soc3bRmMTmesBZYBPLglueNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQcH0ZpZ85N85vgZnurTrGh+Cpaey4LRX2qC69TAEWCYwkXI2x0FvxZI+VTH9qSYaolL9J6iQXM4SA4MHCzpJuUJW9aN80nvTFjto7yzc7S6x0IuD4+bcIaxQxPQdiEoIvvXtB7EDqBYTk7syMRQaJ3x15j1YaLdFBFLbSa7rLRq9m2zSSFHw7+6GEJWq0NDcjGTx8XPBdPZgWiFFmQGogDiffcygJGPqcdOlF7PC1uQeSDCp9HeytM62tgCu03v9JM3cPOUrQZB55eRPF/BI2BUdkEQEdyU+atmGIZn0bLvjjHK4/AtTb4xy/fePB5A8UQ2G87J1PxSHRi3GkYCqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mfH39SgR; dkim-atps=neutral; spf=pass (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mfH39SgR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVnHS1WzVz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 22:36:01 +1000 (AEST)
Message-ID: <79118b43-78d2-42da-b552-ba8b5859fdc7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780490141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9sR5yqOCGgeVlEaAS9Soc3bRmMTmesBZYBPLglueNQ=;
	b=mfH39SgRWtk3Q6TdmUau9qBKNIw1TnDmHXu8H0o13+pe/fgdf3g2HcIbMceCONX/LZGySx
	40rPnip78y3PfLSthqGi43RLqdSXW3D6qZOH8HFlJyqFeoL6mJwQne1WmYwMCiA+v20plk
	xiNVsRdSxIC8nWQpJX+NECvDOZAR7wk=
Date: Wed, 3 Jun 2026 13:35:28 +0100
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
Subject: Re: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to
 early init
To: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Muchun Song <songmuchun@bytedance.com>
References: <20260603120246.1572177-1-usama.arif@linux.dev>
 <f9dd874a-b637-4740-9a63-8da66de323ca@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <f9dd874a-b637-4740-9a63-8da66de323ca@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 03/06/2026 13:24, Muchun Song wrote:
> 
> 
> On 2026/6/3 20:02, Usama Arif wrote:
>> On Tue,  2 Jun 2026 18:10:35 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>>
>>> Bootmem HugeTLB pages currently defer HVO setup to
>>> hugetlb_vmemmap_init_late(), because the optimization needs zone
>>> information.
>>>
>>> Now that zone initialization is available earlier, the bootmem HVO setup
>>> can be done directly from hugetlb_vmemmap_init_early(). This lets
>>> gigantic HugeTLB pages apply HVO as soon as they are allocated.
>>>
>>> Bootmem gigantic pages that span multiple zones are now filtered out
>>> when they are allocated, so the remaining bootmem gigantic pages seen by
>>> later hugetlb initialization are already zone-valid. As a result,
>>> hugetlb_vmemmap_init_late() no longer needs to handle bootmem HVO setup.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---

Acked-by: Usama Arif <usama.arif@linux.dev>


