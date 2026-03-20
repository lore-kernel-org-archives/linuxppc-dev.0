Return-Path: <linuxppc-dev+bounces-18470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324FE109316E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcSDF4Zwwz2xm5;
	Fri, 20 Mar 2026 14:07:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773976061;
	cv=none; b=PdapfiI0hJ9akeyBRks/dGf1eQGQBb7WKcaUFCPwhnoMU9DVJfYi37o9RzAC2Kcjo1e7Quqx95tXcbcG+lfyZeOEBwzTxIj6N94C/AfIOA0Jfns2/ijEnNziUB1kEJcBRQvDVJ7M71l6WAQcq2ZU4uP/g/p6GTbaeC2aR6mDMBQtZUvDK2o8Ej0lOiyj6kaozCONSwUDGciKlhX2YgFHbUatFzLHjBcZjuXIJlCXQuM8hagtk6YmM1b7QVNMGfYpofWVEG88BKk5tkDmnWtclDtNxQNZOTp8/tgkrp7rbNKtg4bqO8htqiLTct59eR5+uU6NPH7qbDMkk2F8ritLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773976061; c=relaxed/relaxed;
	bh=+pDqs44dkcjEkb8OYJpU6L+/Zb+sncdVx4zheks3ZXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovq6Zy/08dN4kWbuv76FJODdYc08IGBUv4v6N7J4IeLpFmppwFATn0T4we4ckGCDrA0NO1S8PCFiubaasIlFZTH1xm+OTTuo44xW4QsHS7HfS8BQHtsSUHv/g5yqb1LOeoqzt8GjA8VtszA8qA1jVqRwHvADK+9isENjvF3khGQkRw+biAXvqbbeoio2aJ1OndWUnx+6XPD/8I3a2aMWdwsugotWn7ew+X39r3jjSBfEO50cHuNU3MhT9/lJPyHzdc9RjvB1gDJs/6JvZX6ykaJOGma8POgSNlKjKukWLNEhSEuUm5VGVQ4ql6yXJ6ygACpMb14q1E85FGw322TPnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dYdHcERt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dYdHcERt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcSDC4zFNz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:07:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976054; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+pDqs44dkcjEkb8OYJpU6L+/Zb+sncdVx4zheks3ZXc=;
	b=dYdHcERtYFyNDTA3+ZaSb0zhkINX++RF9JvBq39XHaTNKskbmntrB+vn38Plh0CJQ8M4rRNKMZ8wdWyajdB5G+jU77GwrnxHIAMTd7kNfr8ufDsZvm+VguuMIqoNLfEFry+kJX3yvWIW2gm66Tb8R7NKdA0PXdrRnjwoEZqzxl0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K9XTI_1773976052;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K9XTI_1773976052 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:07:33 +0800
Message-ID: <2ff1b860-ff76-48e6-98c5-28e517afd3f8@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:07:32 +0800
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
Subject: Re: [PATCH 3/6] mm: change to return bool for
 pmdp_test_and_clear_young()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
 <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/26 7:31 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:02AM +0800, Baolin Wang wrote:
>> Callers use pmdp_test_and_clear_young() to clear the young flag and check
>> whether it was set for this PMD entry. Change the return type to bool to
>> make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Some nits similar to before, otherwise LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks. And all comments acked.

