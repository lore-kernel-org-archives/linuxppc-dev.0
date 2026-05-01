Return-Path: <linuxppc-dev+bounces-20368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBD8CD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 15:52:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6bCF2k5Kz2xGC;
	Sat, 02 May 2026 01:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777650745;
	cv=none; b=O64PV2X1+aLr+PfvecLhcpH+coV0lO3bIb0Nzu49qnX4Y/P4WmLjehAErbjxuYegAx9DMVhIjHw17shDXP0PVXLah+pZ+yWyVaIY7XWM4NwLJRhA8JwFWvG7QouEJ3x53VdCNeTAHmviGVJNLrl17fFicyB8n/AyRdkocgE9eX0WC9EsbjV1ZuL/0BWIqbGKuQ+LkUl6m7o+ZswCYzDKM9UjVUxAvYwsXEwfWvQhwkc95HAdlF3e9qB6lsZUKWkPxbshJWxCZDKgLZtek65p7Xiyp5dJBhLn3aJifpkZLmJd0wH+pCwVrGud0wCPuQ4HqWcxRwUHcLFH0c8yziVUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777650745; c=relaxed/relaxed;
	bh=SiF4i7SeB+vqQpOzTdzc7LyjPQDII4G9BWeiAEqxhGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcyWjZQyhQcsGmjB6Rzb8Q2141NzopFAYf1btvwqtXuLCc8bhdTIbSCu0bUjHsxyf+ktKHAZpJ1PeF8PVLBLXvhKokCyU4aZsDkmXkCdT6BhSiwjeSQrKmIqj0y40IBQWfjlzkNcsizoeMvTB7PjfKJeiGWyjgXXWu1sjkAsOj8AWRDFoyD0w+kp7ks6+N9VAH7cC3whrIZxbpKskmyrXpHqucRVt7Ah7GABZzXf7an7kxBAIEMvbx4vgSM82gSD+gvN42ICaNTaZ6q3b9D8ocEsy8fI+bHZCVQR+Nqs1N/EmdbZ6Fb9S3WkbRlQDK7oagdb/fY4EdtVBpDoD+ru2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVDd9j10; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVDd9j10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6bCD1nrRz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 01:52:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DF83600AE;
	Fri,  1 May 2026 15:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D9C2BCB4;
	Fri,  1 May 2026 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650741;
	bh=CmRbcbTi+OjVPZtnCXwufH2SPkRkS5oJkc2YfZ1djM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVDd9j10pzEBSdRC4+QeFj4BgrGtGegXqADT53FcQUjMhslsOR/0b8M/SeBRUjbiL
	 U2fYt86IaWaPqn4mV1onqa61I1SUk7HLNDW/omvLoBf0BH4n82Nt8SShUszHOEgWX+
	 Yg2s+/jyz3VDnqKEVso8YuKRhMIWmw5AZKuu313vA5DlmyJ/Rx3fmNczFEGG/bRD5C
	 eqUXB71O0/nCiiPJ8qZcNkawkQKohpdSSJ4uA0FZNvaLfCO6RUdrocyE/W1A7fSAIz
	 Hbt9kjA297YFDx/3kqUo5yAmQtYP02v7yShDf43ds+6qzWhvd82x48N7/jTN1fhgjc
	 65/sBiyDMsG6w==
Date: Fri, 1 May 2026 16:52:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTKsSj0i-ZkRZN5@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afNM-gIqxpyJ6ro7@casper.infradead.org>

On Thu, Apr 30, 2026 at 01:37:14PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > (1) If we need to wait for I/O completion, we still drop the per-VMA lock, as
> > current page fault handling already does. Holding it for too long may introduce
> > various priority inversion issues on mobile devices. After I/O completes, we
> > retry the page fault with the per-VMA lock, rather than falling back to
> > mmap_lock.
>
> You're going to have to do better than that.  You know I hate the
> additional complexity you're adding.  You need to explain why my idea of
> ripping out all the complexity now that we have per-VMA locks doesn't
> work.

After a brief eyeball I share Matthew's assessment, I really don't like this
series, it's piling on complexity for what seem like niche cases.

We already have enough weirdness in fault code honestly.

Let's maybe discuss at LSF if you're attending?

I will try to have a more thorough look through when I get a chance.

Thanks, Lorenzo

