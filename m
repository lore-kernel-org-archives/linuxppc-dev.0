Return-Path: <linuxppc-dev+bounces-18474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F8F1093172
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:21:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcSXW0LYgz2xm5;
	Fri, 20 Mar 2026 14:21:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773976906;
	cv=none; b=BXATlvxN0M/NWQJsXAY5s0i5eOjtONViWm+geagLKpYM9ASxW3bdP3ujys10ESOdEovug47xUZa1vmhUo1PSpp/nnEV664LnsSnyfp481KdmxO1JMxtMZESc9SZnRVzMVPQRPb5FTNvUthaqIKDOwY0lLGRpoggzEFmXcDXvYWV46cG05De/go51KPuxQXNmvU5jNyHKT6e2NoUPbmj+e/fPJtb+2qcNf2weAiMJZdMAHIZPwVj4MzEXTbv9XzH7d3ARTNzunMcUuchguQxDCt4GZu6rwA0XBuQSZLUNeME4vkMwe21ciqMNuWtDv0C1SYbXKGi9taazwpr2ii4Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773976906; c=relaxed/relaxed;
	bh=euot9GX9Psoi1WN6TxY1zgk1VpiBJA8QKwf2sKbBPeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfLbGoMrgZn3ubvJrA0qczNx8CMvlioQEtBhITuW9lKiReupDGPLUHiulIHKfhtt8j5yBgW8XBWGiZ12hxHTgK+C7cGJAyuyJ8jMY7VBoOljl5O8KWvl0xjxFXTfPlzpewedOgIbX/InX39UOQIZHmSrFqZYLleTXk006sB56/H53Ip4SdtYeXcwiHXv5GXsUrym+zv/Yzw4MzsqwHeR1IoLTO1O+GDXXKRhgBKqxywadKmcZ6HxI1xKPUzfpL4lj+z0671SjYczXe/CFjn8RTHL75Wugk2P00YZ8IogXQYdbIGs55Ms1cahp0vOKkQXbs8kiPBEtmA9ERlR8ch8ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QD7Wrq2n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QD7Wrq2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcSXT6T4Yz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:21:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976901; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=euot9GX9Psoi1WN6TxY1zgk1VpiBJA8QKwf2sKbBPeo=;
	b=QD7Wrq2n4KvvhaEHOm/wyrmbTjwRxYrS7dUAS/mKW7u0C/o7AS5DjB/Rr+bRIEmzdHGyZdvO4kZnpjWlfafo+EYiSUnM7HHm5nvDTGYW407E0qB84ZD8xlm6QIez4DhSUJLZAIvZL4zH6yY7ykTgV3bnj37dkOaq6FfZIG1kz6Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K7P-S_1773976899;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K7P-S_1773976899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:21:40 +0800
Message-ID: <ab7ea070-47c8-447a-8e9e-ac471063cf8d@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:21:39 +0800
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
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/26 11:18 AM, Andrew Morton wrote:
> On Thu, 19 Mar 2026 11:23:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> This is a cleanup patchset to change all young flag check functions to
>> return bool, as discussed with David in the previous thread[1]. Since
>> callers only care about whether the young flag was set, returning bool
>> makes the intention clearer. No functional changes intended.
> 
> One observation from Sashiko.  Minorish, worth addressing:
> 	https://sashiko.dev/#/patchset/cover.1773890510.git.baolin.wang%40linux.alibaba.com

Yes, good catch. Will fix in next version. Thanks.

