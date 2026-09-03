Return-Path: <linuxppc-dev+bounces-26459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E59C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 06:36:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb8yS2LKZz2y2X;
	Thu, 03 Sep 2026 16:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::57"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788417408;
	cv=none; b=h+QEi/MKFmbfJX2ABIYYhUFyfS0jjA00pChKS22j1dz663ftU4WL7MzP2LkNt1Ewwinwj9EJacwZxP1J1s4g1NucfFIh9m6r9TIUXQsd/KsCMBAQoPliIlvT8Tbv09Ybw+w/Bj4DIBPnKMs1U5IHv402R2VRQVdXIhCrTaILEur+fscY14PgBjTN687hJ45ZmwxqjqA851gkiF81ENUAPV0Zqd2FP9SSiM+oJNdZ3OiCcc7hG6jPpgHOA6gUxEg8efFYEcmdQwY45qRPcw3XUJ7w9F+eND3xhimoHmsk3J+p0b3I8hv91r2MjlNk9czYViJh0QU6PztyzP+nED3rSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788417408; c=relaxed/relaxed;
	bh=/AOQl8uMLb7yaSSuMA/y+PSrYIOL2fdOT9lQ+lxwGTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnxxmR/u2MPNCfKfoHw859fJdG2MEmJjwVSQ0Bomc/D8ZHMbtzH1DWDg+AzJ/2Di4IKtKX0LQVLprfOy1dz3nSlpKms3OJ1Q86beb+yBhpuAx7QpemkzcCkfLamRC01WD8T+D//pK1Rj7SjosGXP6IXSeeOhi+DorFM9SIxMrXdnihJL4SSjiuXPTIghjUBX/P5OMezsE0iQm5LBBYbfx9goEZfvYmc1u5aZlgBI0b80RtB2XGqDJU50HrmdiGeaXG85GDlno1S04zXJKr1bXHC4nAZ6yWJZrZWt8Fo3N+scr46oKbYoYRXpm7LGEZaZAurCRAValZKgL52oHAi5Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BDPYwWUG; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::57; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BDPYwWUG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::57; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-87.mta0.migadu.com [IPv6:2001:41d0:1004:224b::57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hb8yM1wh6z2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 16:36:35 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/7zVF87+vSIaxGdnTGi6zl+USr7Ew+xcjHfJdu2PHXQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788417371; v=1; x=1789022171;
 b=BDPYwWUG2Z6bRep3T0VLBuuKDahOxIhearwYCB9Uw1og7GYuVlylNKYFuk9DYYcpN79wzQxv
 Jzj5HFC8/TpHPwL4N387Usg237Go+wsjMcy9922gksnD2685r3sFTvRolNcm0p8lyA42w1yhfCR
 2I4StrsLfzGRP/Q1GsSuYBDA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8473698cd31aeb55;
	Thu, 03 Sep 2026 06:36:11 +0000
X-Mizu-Trace-ID: 8473698cd31aeb55
X-Migadu-Flow: FLOW_OUT
Message-ID: <3775da0f-4068-4fc4-97a7-135eb975ec65@linux.dev>
Date: Thu, 3 Sep 2026 14:36:01 +0800
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
Subject: Re: [PATCH 04/11] mm/sparse-vmemmap: prepare DAX vmemmap population
 for section orders
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
 <20260831075342.57563-5-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/26 3:53 PM, Muchun Song wrote:
> Device DAX still uses vmemmap_populate_compound_pages() to populate its
> compound-page vmemmap mappings. That helper allocates the head and first
> tail vmemmap pages explicitly, then reuses the first tail page for the
> remaining tail page mappings.
> 
> Device DAX is being moved to the section-based vmemmap optimization
> infrastructure, but it cannot switch to the generic section-based
> population path yet. Once a later patch records the DAX compound-page
> geometry in the section order, DAX head and first-tail PFNs can look
> optimizable to the generic helpers as well.
> 
> Add a DAX-specific population flag for this transition. It keeps DAX
> head/first-tail allocations on the normal vmemmap allocation path, while
> preserving the existing page reference for reused DAX tail mappings.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/sparse-vmemmap.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


