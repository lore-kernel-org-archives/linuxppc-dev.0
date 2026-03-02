Return-Path: <linuxppc-dev+bounces-17512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E869E9B369
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:09:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPbmf2ZnGz2xc8;
	Mon, 02 Mar 2026 22:09:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772449778;
	cv=none; b=QNrOoaoj7t+bvUXIuDCqGjGQLvyA6lu9vRUuNb7nuJJOt7uz0YL55t3IlWZQ9WHjTWXz/PeKzWFeKO7L/eRlFh1Y4F0o9NmPbmP4DNoYhXhbnNThKp0hXZojbcd6QGb3+SoKXI338vZGGA/0oelukdO5Hg/KpnzrteZk/nCtHOPJyVeNREhajMadTfWz8bD5boLkPLFeTubUnwOnF+SW8x/izHgUZTWuzErZp4exleaq6Whp21VTz1HoQodg/ni40AavkdA5qDaeaAUXhn8/M1tujVz6s9kDCgtDA5Qr51u75avb+kdBTACmgI9dS7EHWZIQGsaeDcCqtFiZ/+cdig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772449778; c=relaxed/relaxed;
	bh=ALgtyZvM7U+ADKVcCq+vWsLwr98RElyoZqbUR3DonCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCkfluu/xj4rjjcZv/rtI/jxDc1N7/gENmrC/3chORwxg1GwM2W4WFcS/TQzUjl6f6FhiUfPX8Z4hAwrsaRUuHXgiYfqiH2m8JIAaw4EwEj2seOUyu1yK42IVpTJGtuWxK9Mt96Vhj3XIRgmxF+MWB2uhIHJagN6iDv8+GOmr5LkThd9VfXieJ4UTzuuFn5IDU6k4embZhQChgK8/iS5I7IGGmYGcWaNLMJeZMBGKAEOImAkMK4ZbgGQKuOLQRAVa6XXnYODHoEE/BbETfyrg0Ks/qVGMlu3A9zYwicFSX7llJcwdJqZvXZWYalUgKVN8iNGRmGid8jZrIyvu3j1Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eHpzqh4T; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b5; helo=out-181.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eHpzqh4T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b5; helo=out-181.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPbmX4rhBz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 22:09:30 +1100 (AEDT)
Message-ID: <d8771807-c85b-48f6-b5a3-a7f167cc9494@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772449740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALgtyZvM7U+ADKVcCq+vWsLwr98RElyoZqbUR3DonCk=;
	b=eHpzqh4TQFq6GsbuPnCpe5jSVHJ3YXMxlPIIhBK0jXo03V3jnRz3qkm5dHB/xKaM1ACva+
	2Y8OdZXsjeij5zDj3tbrLBIE+QRNrcPXZM4UgCJcT9WztqxJP4KNtYkPpB8oLLxlIXXWk+
	kq5Y65mqoE25P4/NF5WJQn/9mPcWqZU=
Date: Mon, 2 Mar 2026 11:08:52 +0000
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
Subject: Re: [RFC v2 00/21] mm: thp: lazy PTE page table allocation at PMD
 split
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com>
 <1d3a4e8e-9ea0-42e7-b8e7-d92fb27f80f4@linux.dev>
 <CAA1CXcCygvA9uUJjB-+2J00srnHbiNGwbvcbqpRer8Vy8QBxWg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcCygvA9uUJjB-+2J00srnHbiNGwbvcbqpRer8Vy8QBxWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


>> Thanks for the build and looking into reviewing this. All comments
>> and questions are welcome! I had only tested on x86, and I had a look
>> at the link you shared so its great to know that powerPC and s390 are fine.
> 
> Good news: as you noted all the builds succeeded, and the sanity tests
> dont show any signs of an immediate issue across the architectures.
> I'll proceed to debug kernels, and then performance testing. I will
> try to start reviewing the actual code changes in depth next week :)

Thank you!!

