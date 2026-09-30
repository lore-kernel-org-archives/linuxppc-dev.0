Return-Path: <linuxppc-dev+bounces-28558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A9ACA5FAC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 13:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvx3942nsz2y2J;
	Wed, 30 Sep 2026 23:39:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.134
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790775541;
	cv=none; b=TH0hX6NXeysc+4D9FFVmgDk/sfTrLMko2E/jRHrLbNIkJGoy2EN77udhE1pHVBDSi3X3jD5vhYDLpch6qk/Y9moWCIDD1W3e9m5EnKbhQeBM40xRw8iWhFQoL0ERMWCQffzL10hIrColDLtAKmBWrKrxRUfYHkkuy2LpjcKPUVkcHl5FoF5rGFQ4IdYX+GcwaVQk4NGmphPoIaKXZfwkYrkRYC3dRsWERwcs0bQBweRxaiRO3rEtX3P/aa6zqoyjd8/jboGVFNhrslyIk90i57Yvb5xae6yt6Mom4mzaVoWgP31GOyeAO9JvhbxNFsmyT7vKmXsyhjkxjzqFQXeJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790775541; c=relaxed/relaxed;
	bh=P00NcZdXkR2XuhFtH4v6JbA7ANad/OjoIJXR7zjLsGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrSLiYWQfmvxexpdk+OS8HxS5wlu2LCCAwiStR+nFhjiBXiKYJEXiRpaABHLotx3OibPI4kH7/uXRx5CT6KLrkKthmOIhuzN10qdBGVo/CZrzD+fXgcVntY6FbTK2tUIhthadMOUNFSa8lfCpWPy113ifLbsBHikBUEpVr7nKreeQI4kr1jqjwqBCmbw2wuMShSCUczo6+J/1DviMs5EBzJvsJJb9gqQsgKFIwmdk6c834R3urNBCrfe68fUFxUBC3s5f1frTZJv5TXwuV3IpZ+CIvpJI6qjtBgx/3T/83hkcXTeVykiERx5WlugAgDUubm3jf26gOO999mbKAUgBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xEyPHhsk; dkim-atps=neutral; spf=pass (client-ip=95.215.58.134; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xEyPHhsk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.134; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvx36121Bz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 23:38:57 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=lcQuluWqoElHRHUpdffs+zz1mzqDGPOpnACMggFGdo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790775518; v=1; x=1791380318;
 b=xEyPHhskqY+zKro0V3No4XYRdbC4c0j8qfiMjyxWmC7/KEcRAjzXGl17mTOIQ4Xk+L0xmwx6
 NCA52a4KCQ6dVj19nYnWKubqmVZ6MyBphh+XDZqinMF2AQy3maHBEMSW7fOIOSGGVEGRM70IHPn
 7lFd30bUgDrVUC8fO9w2Acio=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 441b9db43c699605;
	Wed, 30 Sep 2026 13:38:37 +0000
X-Mizu-Trace-ID: 441b9db43c699605
X-Migadu-Flow: FLOW_OUT
Message-ID: <aa39ec65-a2c2-4396-b20e-4e4e7447df26@linux.dev>
Date: Wed, 30 Sep 2026 21:38:27 +0800
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
Subject: Re: [PATCH v3 2/6] mm/sparse-vmemmap: support device DAX in common
 vmemmap path
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, maddy@linux.ibm.com,
 rppt@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 qi.zheng@linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260929053231.66085-3-songmuchun@bytedance.com>
 <20260930085329.17337-1-lance.yang@linux.dev>
 <62E3517E-517D-4C23-A04A-F5BEB0A84C60@linux.dev>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <62E3517E-517D-4C23-A04A-F5BEB0A84C60@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/30 19:11, Muchun Song wrote:
[...]
> 
> Your proposed fix looks correct to me. I would slightly prefer keeping the
> rollback close to the failure:
> 
>             err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
>                                      params->pgmap);
>             if (err) {
>                     __remove_pages(start_pfn, pfn - start_pfn, altmap,
>                                    params->pgmap);
>                     break;
>             }
> 

Cool. Will shamelessly steal this approach :D

> If the first section fails, this simply calls __remove_pages() with an
> empty range, which is a harmless no-op.
> 
> Would you mind sending this as a separate bug fix? I will ACK it.

Certainly! Lance

