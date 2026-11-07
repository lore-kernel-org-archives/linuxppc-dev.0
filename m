Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB764606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KolnCTI7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMNCh4DDTz2xrC;
	Sun, 08 Nov 2026 04:22:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794072160;
	cv=none; b=LXF1p3LH+qWhtdCGgKKXTdMS46Q243TobZu73bAnIqJu5DW9MVqexp8QCkvjqn8/ayTsk3IkYIrqET7FNe/f24JQbCOh12KL+RoLc+ld95biPyVWCFNIQHn49xq+T+n3I/H2b/EQ2uMeSuXFxKQJxy7eQLNwQ2jH9O55urocgRhkv2En000jeDXHizWJlmN7EhkJCTeJ3RUSw28OdT6Q/66+dq/leovIC9vAnwJhDX+E9zDZd+2hrDun9bXlBB5u05EDphIHu+NCiBRWp810pDHMqPSwTtHHMQC34lrY3abY89aLCs1HjBg4TiI1J94vEFcl+x9CeqAvp0glwhJPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794072160; c=relaxed/relaxed;
	bh=XmI8rWYPQf/Yk3+VD2zo2YslLq5vKVW6l7UCq9+Iu4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI55PHjwT3jS/I0eVNfJ0DUOZGDD33g3EsmDbhCM3vvem5rtnWEIGpZ0YhRmZUIMFMU3QVjFFWFIzTOT+7lIS/QX3k5t7zBz7C0h7B/9UGM5zT/dkrd2wPNWF89sukkLPTAwucf2L8b1B6zg0paLj3zswrfcwMF07wI+6YeUAzqa1j5cwJ2ZcX9qGVdR6NFMvNykGoVeZbFSi13mm7wp6YKl24FLBs7hElwBtIhEs2naT2lEAj7/f1WfYk6zuBQekpoukSbIakJoZP60JohDrH3R08r7nxLLeUzvYstiZxNZ1sX7ZXy3BcUydl7kWodh9qvBF9JxBc/Bfgu3asWHMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KolnCTI7; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KolnCTI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMNCg4kKzz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 04:22:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F243B413EE;
	Sat,  7 Nov 2026 17:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBA21F0089F;
	Sat,  7 Nov 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794072156;
	bh=XmI8rWYPQf/Yk3+VD2zo2YslLq5vKVW6l7UCq9+Iu4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KolnCTI7SaK31zca7v7wy2Mycrmz3EJfGWSoHQT+xw4wMvA5veAkZQyAzR0RHLf53
	 7z0w2Y1hoaKGxi6XRZfkLKShmaUF9YXKLnTCvVHVorxctr/2riWCRhVYDHO6JUDsb+
	 /txQnwAPITgzg67QQgZLuuhvC4TDhau41rQl1Dtom+Utzu4v7VHiNwoZu0/cn0y8/P
	 PLwkFVCeoUea5WmCr0NKAudWsjpf99WGVzC3JmNDIMMiNqWVwtxCRaxhwoowmDT/Lj
	 FsIWGLvtajb3oBbBnZA/TWCD+SHD/vs+w/hy5dKGnepbpDYnrmj8WXDbUyZV3nfOeW
	 odC6ug+HnuAgA==
Date: Sat, 7 Nov 2026 18:22:28 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/5] powerpc/mm: make
 vmemmap_populate_compound_pages() static
Message-ID: <au9eVOrRrnRNLUZb@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-2-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107043122.25650-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:31:18PM +0800, Muchun Song wrote:
> vmemmap_populate_compound_pages() is no longer used outside
> radix_pgtable.c.
> 
> Make it static and drop the unused dev_pagemap argument from
> its only remaining caller to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

