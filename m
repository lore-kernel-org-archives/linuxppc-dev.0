Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFF606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=U7k7USFh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNc8V3Xw0z2xSR;
	Tue, 10 Nov 2026 04:24:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794245050;
	cv=none; b=fnI3IsFs2VljtFt5E7kviHyPOdGwbymfKzIpYoN77+OG9qktS5zQ+RTONHbEhLclm3n0jIe04mwkcI2FEhKThtvk4YFmp12cMlg5IjwkirgNGe817zeLrx3EdGJeLWN6G4zTTSoBpy04OVdk6qGYykYi7AGGc3AO9LSUz7TKqZuH5I2gJmlZB2T7pvNuEqat9pxgMGUMrtyGET3s1wlK9NbGfTTF9pYDM+YZOoD7zz/wekownE/GHO/Lk2w8ErahRDQRGAkuZDCVPwO9Kq6jwsLKlpVNctEgw8TEvW0q2E7oNbA0IY5wZ6NzhifnAXXkE9GnlfUmGl2ply/TO4mswA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794245050; c=relaxed/relaxed;
	bh=eun4fonrA8YxuiXzX4G4XMpkIlQF/XMM49UglMMMiXw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JQos0qA05qX/uyoA+ABreyQjoQqkUvEKQZJ9ba18CzTJn4svMN9q4As/JZlrWeNz158IJltY+9oElrRL7eOlqulN5b5NOh3uPEonbrv+ha9dpS2QeYIzKfzMkQROnZHTrOhJ7ndf6FqSiXM9R7lUQYCrsBgh3OzHsePzEwbB9iATwvGcj66J6IYuCXg1uuOZ8wLC2/QoUsp81w0nd0z0UJLvqCF/n5n9M28aqMQctrX5h0L9GggIAm+KIy97C2hVRrI/r5JuCa1YsorVd2+4Do6VAItoMKgJV7HEwR3wWuyKKWr66qmqUzvgld8AFu9P491S2ToO5NKqyIUiDUeoJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=U7k7USFh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=U7k7USFh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNc8T0XJZz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:24:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6707941607;
	Mon,  9 Nov 2026 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924481F008A1;
	Mon,  9 Nov 2026 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794245045;
	bh=eun4fonrA8YxuiXzX4G4XMpkIlQF/XMM49UglMMMiXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U7k7USFh8CiH8yapE7FTZPIc3n7a1VfVrrw/hRpz7ZfmAvrqap3KqDfRs+5dgXjUg
	 7b5GVFc0envv1FiTeaCTmMTZ66R7rrrr0X/aHT3OQaPAdaAd9AdSGv+gj/dkjcPbkm
	 IviqjTERNDo2xLRDzAyJciW777BbRh6rtjEPsZg0=
Date: Mon, 9 Nov 2026 09:24:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Wen Jiang <jiangwenxiaomi@gmail.com>, catalin.marinas@arm.com,
 will@kernel.org, urezki@gmail.com, linux-mm@kvack.org, baohua@kernel.org,
 dev.jain@arm.com, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 david@kernel.org, rppt@kernel.org, xueyuan.chen21@gmail.com,
 chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ajd@linux.ibm.com, jiangwen6@xiaomi.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and
 vmap with contiguous memory
Message-Id: <20261109092404.5441d8bf9c4494ed008162fa@linux-foundation.org>
In-Reply-To: <20261109140206.GY9176@e132581.arm.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
	<20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
	<CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
	<20261109140206.GY9176@e132581.arm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 14:02:06 +0000 Leo Yan <leo.yan@arm.com> wrote:

> On Mon, Nov 09, 2026 at 07:07:23PM +0800, Wen Jiang wrote:
> 
> [...]
> 
> > > Do we have sufficient ARM review?
> > >
> > 
> > Thanks for picking this up.
> > 
> > On ARM review: Dev reviewed the earlier revision in detail and
> > his suggestions are folded in. Leo Yan tested the large vmap() path
> > on TRBE/SPE. We'd welcome more ARM review from Ryan, Catalin
> > and others.
> 
> I confirmed that my Tested-by tag remains valid on the latest version.
> The improvement is consistent with L2D TLB refill reduced from
> ~16000+ to ~500+ across multiple runs.

Thanks.  I added your t-b to every patch in the mm.git copy of this
series.


AI review found a couple of little things:

: In [07/10], vmap_pages_range_noflush_walk() uses an int nr
: index, now shared by the high-order mapping path. The previous
: high-order path used unsigned int i, nr. Beyond INT_MAX base
: pages the new index overflows and pages[*nr] can go out of
: bounds. On x86-64/4K that means an allocation above 8 TiB,
: within the vmalloc VA window but requiring a very large machine.
: Please carry unsigned long or size_t through the direct walker.

The vmap(8TB) limit is already well known, not sure that we plan to do
anything about it(?).  But the patchset seems to drop that limit to 4TB
for higher-order pages, which can't be a good thing.

: In [09/10], nr_contig < 2 can be dropped: the loop guarantees
: at least one page, and vm_shift(..., PAGE_SIZE) returns zero
: for a single page. I withdraw my earlier NULL-page objection;
: I could not establish a legitimate producer of that input.



