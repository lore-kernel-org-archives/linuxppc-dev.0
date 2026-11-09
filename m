Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C5606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nLXVC7XI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNWv93WPNz2xjv;
	Tue, 10 Nov 2026 01:12:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794233541;
	cv=none; b=WNnlZLfxfIxx3Yfd7rkULTAD7sic3EzxXZ4xBlgb93JlQPmNeiUaYSkY1i6JwSdK+PkirKWxa/yym4EXDntacaVI3fMamnj09zYU5ZxfYJUmCzvVt7/dXzp/0ePv5VlX9eesCAGsvOBu5ehRspAmYUmt406yDswj7UtWtYXynjDiR12Mj7eFi4uyVWonIVEXqOloZbJ2CANemJSjsBIInqqNXfGujmsSaPcQWGZlrPv7UX/NdqXRF+j/QzuPLokqzUCgnp4a9lzHvrQ3rZUU46I5JNuC9JQorgAQOpGDNxHGNbcQzOukuH2qlb5FtpO4guMpSBWOghfyqSDURJEZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794233541; c=relaxed/relaxed;
	bh=31ISwiUcoP1nwNnlM+AcNE1UFEe5nZziDgYbUSqlYK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqV8N0FPOQ6VOQDq/t9FonHNrMRbhHo7e0vesaHikbX9kWwGJbmQSEWrcSGpq/Sb6pOL+SMXyCyiUV7bLcKeNF3J08ZeSI/0jKzF3bEy/AUnqYvkOkHjw4W+kZ7uAQ21un5qZq5JMIzI2QY7mgCJEjUWsavyuxbMJh76arhw1Ykb7qDnNT1x04x3qZaSnwJi5vO66MfHzNFznM7IH1PaCe8hvxEx4M9qL7JsB5b1PtSNsK/W+ld7NKjYcI32jU4qD8UkFd+HNdZKKTeRJu0i3IOc+IN82+yuRpjB8TLkj6mnXjg2tm/qxN4/H5QttTl4+dXOu51U0s+GIZOCk8lE/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nLXVC7XI; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=leo.yan@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nLXVC7XI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=leo.yan@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNWv63RQgz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 01:12:16 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5CE614BF;
	Mon,  9 Nov 2026 06:02:05 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76CC03F632;
	Mon,  9 Nov 2026 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794232928; bh=w9un5PJmooT1yfWMFaaQzUU8OhNkwnbnmZBSdQGnUt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLXVC7XIwT6vpEuK2LRZP1svw0GEjcPNFGmmqHhRpwzotbRQo+5ycs4hK07CKHxQL
	 6R9eRRQ1NlCugddQ2GCkXXcY1pHLJ/yiSdtqva4IrDvKeIIfCjaGoFInwNeNaK6nuU
	 b8g826oaOEWo8Lcm+sywiM3CD/XY1xmWpeLwIdz0=
Date: Mon, 9 Nov 2026 14:02:06 +0000
From: Leo Yan <leo.yan@arm.com>
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
	will@kernel.org, urezki@gmail.com, linux-mm@kvack.org,
	baohua@kernel.org, dev.jain@arm.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org, rppt@kernel.org,
	xueyuan.chen21@gmail.com, chleroy@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, ajd@linux.ibm.com,
	jiangwen6@xiaomi.com, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
Message-ID: <20261109140206.GY9176@e132581.arm.com>
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
 <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
 <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
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
In-Reply-To: <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 07:07:23PM +0800, Wen Jiang wrote:

[...]

> > Do we have sufficient ARM review?
> >
> 
> Thanks for picking this up.
> 
> On ARM review: Dev reviewed the earlier revision in detail and
> his suggestions are folded in. Leo Yan tested the large vmap() path
> on TRBE/SPE. We'd welcome more ARM review from Ryan, Catalin
> and others.

I confirmed that my Tested-by tag remains valid on the latest version.
The improvement is consistent with L2D TLB refill reduced from
~16000+ to ~500+ across multiple runs.

Thanks,
Leo

