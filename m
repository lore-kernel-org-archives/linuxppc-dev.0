Return-Path: <linuxppc-dev+bounces-27900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29B8C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:13:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptC247V5z2yjw;
	Tue, 22 Sep 2026 18:13:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::d5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064798;
	cv=none; b=Mk8KAV4JnB4w4ppobg1Ytyz7x9yHQwhqSbxav2MLJz1JlExK/IHKudmdDEXFsF5xW/WAAkXxmgquvGaJMdWYp+NjN5MOUeoJAT/73yNtgi6WMf8rX4QUAQFlrTHO4dyGWinl9dD0eqIB+AV5PB4shMylHetcHWYrvHl/Rov868y5QDWuFh8iWSseZsO0ylwx0Q/2cLIgDCKJeduOZbEDqSei7Q7w18CcDFbEvDgcZsmxVEy6O8d/OL/a8TnKc1E+0JVdu7uXf/zf72fll/woa5YU0ebLzyFGLmDu1mu2hFkGVVMhXdo05HmYlmAjafqP/EmgiOh0QekP/EypQpc37g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064798; c=relaxed/relaxed;
	bh=zgNa3/libDCvbtZBwjfAcECc9roNZSpEdeb3sDJmKkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY48VaANDugng96EQX2VCJVBP2tiAkJ92SmzL4aSzMKU72zxSLU6J7TZfIGc7xBBj5y1bJy1AGT+0NM+4nVNrdHnGMJoJ6vjLS8xwtfuasLTjrekRsmxvJSJqM9C7iVOMBP8iNniED0fVC05GlFfad+CyG2bz74aikQF9BYSIlFPdxmeaOYrsTGMgumB3HgUbewcvJZT5KZpWn7iX3qSsWBKI+N/uoz1gngDujNTFuzdIo5lBqTLU28UPcyFUiD6wj4sBVT8Ai/9JDJH8PJd6GXTkJLR3y3aqxhyhYvTQ6CSInQIKkUCS9/XiYvAmbpe4Mbm4nb9URAsYusNEzASKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dHviHVJ9; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::d5; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dHviHVJ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::d5; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-213.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptC13Cr5z2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:13:16 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=u0QxjtjmQE5VvsgjRmYJRV+MOX2c7kGivVyl2p9yp0g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790064778; v=1; x=1790669578;
 b=dHviHVJ9ydbDTEnVN2wn+D+mLbnXtT6cg67RjAAyW/cXorCbCPX2xacHpXRwdJzckoSsdp8s
 2pfi+msGR70nlVMIGcHPhNG/1oTXS0SoW8U6gB4OEO/WeZMwcbqcCHCTJNrJYW0s8igSIbSZMi2
 fOG1V3Tq5n0QvejcsGVivV/U=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 048c39df30f9f240;
	Tue, 22 Sep 2026 08:12:58 +0000
X-Mizu-Trace-ID: 048c39df30f9f240
X-Migadu-Flow: FLOW_OUT
Message-ID: <96981a8b-0a93-4ed1-8d71-f01db02035d1@linux.dev>
Date: Tue, 22 Sep 2026 16:12:48 +0800
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
Subject: Re: [PATCH 4/6] mm/sparse-vmemmap: remove the unused ptpfn argument
To: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-5-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260913083734.86802-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/26 4:37 PM, Muchun Song wrote:
> vmemmap_pte_populate() no longer uses ptpfn as an input. Drop the
> argument to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/sparse-vmemmap.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


