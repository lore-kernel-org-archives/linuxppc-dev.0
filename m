Return-Path: <linuxppc-dev+bounces-20295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3693DCCFA13
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:05:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5MbG42J6z2ySf;
	Thu, 30 Apr 2026 02:05:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777478730;
	cv=none; b=TShAL94XEYeKGGRwVxKgrCXMiLU0Y57fzt0dvE5pKkCbdQQalTeqDR4WMH9wt/7PgggXQoLQf8GYxnciDf823xFCaT8VanO38dtEmEVZcmw9wXFr+PyBVOHAFx7PmfzB9PzYXxFEOj1rOh/t9hoYKNmiaDSDxR80TD7c6P0npFFiHe0MZXoFJn5t8/PtiLynHSuiAajIcYk6ATjUzPv1rnhPDhABu/IDDuMN3AWsjIkZp5L0OMOm/+wVGbR8fk7m0/1UHyVnq8Bq4BZol+VaoTQaZ0GruuI0kdTc2StBEi7EelL82tj7lL/g0LUB3WE9McHYXpwsLz3bei3HDRFO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777478730; c=relaxed/relaxed;
	bh=EBEyBa7Rph51aBo1JjddMSs3BFPbJQoH8pdrtEkDmzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae3ENzFbR0aLIUgj+8Yo+A1nHbpctEB2MVKG8Tf6tidbOm3Ulddyr0vjs4wECb7hFQ1LYSGZzp9C69PYe8KH4DTF5ahUapYuYeAOvcOBXV3BdJRKoDI1YEYhrMEMDDQt4jilH4y6i3UWmVWoYJVtxCwxujAgz9DK3R9IZaYs1bB3pJn5TQxuHXxgxTMUW1BaI35CZwkAOCuD0QAQ76fz4eOjaJADLuR0lwkvaPwTaYjuq4gkFVMdJPBQaoBGXOaXYLthCL1Ro8R6mg7F9ineKj0w7LFlNsKyr5gwmf7QWAt8ZQ2ta9rlkyG/dEQ4wMM3AWyFW37+h9etVvV2tF95hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IeSI53bM; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IeSI53bM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5MbB61MRz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 02:05:24 +1000 (AEST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g5MZy5D4Bz9tn4;
	Wed, 29 Apr 2026 18:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777478714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBEyBa7Rph51aBo1JjddMSs3BFPbJQoH8pdrtEkDmzw=;
	b=IeSI53bMf7UWhWLp7hjI0kjSd6OaZw6ahRuuKpMgPpv03+eWRi+QA8mjNcvrbjOk7S+ADa
	1Lu+Vvm4BPI5U7ztma0W6sFzDWTpN7bVRp+AwGFEZIStrHToKJlnLB8EFwFjBdmAzuQu48
	OHlHKoKsWPvo15s1VL50JQmaBrbhoRvO6jkOTSr6XP4DBFwowa3P1IWLSsTiRC1Q8eqtWj
	Fi2QKLMNlF3b+Pq/q0dTVmBMaoFmZQ7P66rYrzeIUn7o9L7LvHnuOFb6GZOC4rfnqTBjCd
	OjwWTd+JilnYRyjBAr3b/lg/0Q8NeCSF8U/CrOKv8WgQirJC5lItsICyI14OEA==
Message-ID: <69f83cbd-8883-4ead-b570-4520379b86e4@mailbox.org>
Date: Wed, 29 Apr 2026 18:05:06 +0200
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
Subject: Re: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 Kees Cook <kees@kernel.org>, David Howells <dhowells@redhat.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
 <d8cbbe3b-7eb0-43c4-ada7-0730f7c05f69@cs-soprasteria.com>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <d8cbbe3b-7eb0-43c4-ada7-0730f7c05f69@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c64d262b5b61b60f041
X-MBO-RS-META: bxhznyrzqwkwj7pbb5n84a5p5sm6zsxr

> This happens in alloc_pages_bulk_noprof(), due to
> 
> 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> 	if (!pcp)
> 		goto failed;
> 
> Because:
> 
> #ifdef CONFIG_SMP
> [...]
> /*
>    * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails
> and thus
>    * is not compatible with our locking scheme. However we do not need
> pcp for
>    * scalability in the first place, so just make all the trylocks fail
> and take
>    * the slow path unconditionally.
>    */
> #else
> #define pcp_spin_trylock(ptr)		\
> 		NULL
> 
> 
> So apparently it is expected that alloc_pages_bulk() returns 1 on non-SMP.
> 
> Christophe

I got SMP set as my G4 DP got 2 x 7450 cpus.

I can attach full kernel .config when I return on Saturday.

Regards,
Erhard

