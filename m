Return-Path: <linuxppc-dev+bounces-20011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A006F589A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 12:32:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1b8Y2rsfz2yGX;
	Thu, 23 Apr 2026 22:32:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776947565;
	cv=none; b=LuFxgufxCZum5q3tPUAVHylRW0F5KC12ePowV9b1SYdPhw1mVbOmkGcDuzxONkQTp5ectgfZNIzJIxL8Vcx0rpJUeUwzwmud/+REh5fGJCPk6hfilKx9pTrzDtsHoGh39dsoEFunamnLk9Iew2zSK99AjPSpgg6k6ai/0gq3K7/dJT2PBIdxMPD6R8+h0X0dHqEeE4/7m/Tsz4rZ7d2p6S9mvzMeKfw4Ui3pLzWumJCCp1O9h6FrPcpZHles8BCQ19f6xwgYeAmFGNHuSvlRWzU7po4bryFyWAJMPwuIhuokpwH1C/jw8ZBqg36yiXMVhff+JtJB8qiBTY/YlUPwew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776947565; c=relaxed/relaxed;
	bh=0Sm1+HBnujx7eaCDOZfyNeyN8WHlWDXXHQPnbPCVZFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Due//mmig3JFpfGnchbwG2twA5Fm100k0uxUWwg7Y7B5d3nDUZB5kIQeCiKcuQTZlNVT5PPcsyysMZoofKo5j6C6maQhwDvKEjSofWFWxQYZXA6MmNVxqqvsW3YfjSSRefUwa5sXzy6L5NxCKuzFvlfp7w2xMhFQ+fdml92OE4BxcDUv8NE3SKkWYcyODXXvC371/xIUURjzVhlPdh3rEjaOJK/RZ3+Bc3R4f0e6PO/CyzlwVkLkB9m3ioV4leWVb476IDLYpWr0EAuztS9jmSHvv+a7ZNXKOV7t2RNnRE8Gd8VMJhTiqIvPTIXWnQjAgMUn9ajLrFPTaG+ZPyqJQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=1tmWKztb; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=1tmWKztb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1b8S6clhz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:32:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD58860123;
	Thu, 23 Apr 2026 12:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F9C2BCAF;
	Thu, 23 Apr 2026 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776947558;
	bh=mLO1y63KeITgQnUtuuXUB7kwisFayIJWJCkn+Pp4dzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1tmWKztbTYs2a2lnZ2W3wKk0ddFcrR5tPBvRW6LZjbenwsnC6sxbXDaVDkLHtFIK2
	 Q2FcV7i7E/VourF3CDjnZlCSvecYn6y/hnNfmlw1JVnSBIE+iCAcKf6mXAWx9SbzO5
	 DaBWiDwSdF6pPLaoxg5Hkf04poOAtzQymmkk++/I=
Date: Thu, 23 Apr 2026 05:32:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song
 <songmuchun@bytedance.com>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 v5 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
Message-Id: <20260423053237.a44b68034673bb35a1e042cd@linux-foundation.org>
In-Reply-To: <1ADE7CE5-F02D-42B2-B7AC-FE0D6E86042D@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
	<20260423071911.1962859-5-songmuchun@bytedance.com>
	<1cbae635-a115-4270-bae2-64145d16f936@kernel.org>
	<1ADE7CE5-F02D-42B2-B7AC-FE0D6E86042D@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 20:04:21 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> Ah, looks like I need to update the patch to fix this.

OK.  Please have a think about which patches we should backport into
-stable.  Possibly all 6!  And the timing of this backport.

Ideally, split the series up into one series for 7.1-rcX+stable, another
series for 7.2.rc1.

