Return-Path: <linuxppc-dev+bounces-11850-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67972CA1017
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Sep 2025 14:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cKXZY3Vsjz2yQH;
	Mon,  8 Sep 2025 00:31:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757255477;
	cv=none; b=i/6fwuNxth23jHV5FPFX8geN25zUkDUNywrb1+naeu1g07vckf6Vb3xtqS63rSYVqT0X+1JYZ9WduLMmc7zTwHg5LSmh/B3QFJ+x0KZeQ+oxLFmGdpj8cbG7s7+Yy9pFjaJsZ6e8mrbvtUfKZ+L4o+q1feLEfSE+ZLT97htJBJG+XBZEbPnazq8qIVN0+prWn512xlKY2GCwvKnV+Bpi0vTbPYc7TWRWgkizBtHejAsezqAOL0qrN3t1xrZCCebiL6lwL1nTELLEQHYlVbp34GawbMCk3YTmBjjs3TAswF6RXKI6BY36dseo0qG4Q3St35zukAmkBtug1Kz68i8LLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757255477; c=relaxed/relaxed;
	bh=G/EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8ZldlmV9nSRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N9RDn11IUWU3Ywn8JCxM0GDdCYQ2JXOrKzgElv1Mmb/eXX04V87V6UjJoAwGPoGgGxgPCszPWaA5F1wazi1iAi5SJo8gTpKN9cMq8KEUMDyn2SbCVccC1cay9ApzpplCjjkefe/pXWEhAXz6iScBn+JSUwutm4uG7v1jBJAAYRunv/XmjgxwDYNQFBaFcd9EIxF3awm+XqZ1pymv1xeUxDb5y/Qmj0uF1g0iH3Z7NxCYz6aYbE9mkCF2aVEy25Ohvew0wxGzYNBxeYNjXxjEJ/gOm2hQLgJmyXer+HMBCwS/Y/dTCrGKIumJQ40+RZKjjDQi7oAyeLN5Z4XVS4EIMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; dkim=pass (2048-bit key; unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm1 header.b=LxAEL1hA; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gkkyoHxl; dkim-atps=neutral; spf=pass (client-ip=103.168.172.154; helo=fhigh-a3-smtp.messagingengine.com; envelope-from=o-takashi@sakamocchi.jp; receiver=lists.ozlabs.org) smtp.mailfrom=sakamocchi.jp
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm1 header.b=LxAEL1hA;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gkkyoHxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sakamocchi.jp (client-ip=103.168.172.154; helo=fhigh-a3-smtp.messagingengine.com; envelope-from=o-takashi@sakamocchi.jp; receiver=lists.ozlabs.org)
X-Greylist: delayed 347 seconds by postgrey-1.37 at boromir; Mon, 08 Sep 2025 00:31:13 AEST
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKXZT39Pdz2yN2
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2025 00:31:13 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2941140003F;
	Sun,  7 Sep 2025 10:25:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 10:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1757255121; x=1757341521; bh=G/
	EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8ZldlmV9nSRU=; b=LxAEL1hA32JcJEnG98
	oeJWFJW96Ab1ZdHJgGFlspwkJEj8Aiavk+dntTuQR94KmnDxtmALl7CB+fX7pbmo
	zvwHV9izosIpgEyayMmq4HTHRSL2iK4fMKWHMvvD41vWIEJCTnEIIqxOvjqUMPdN
	FaaZNPb2cDEYVHxVXwipUcCnSOWtlHTWUV9b7UKVDN46YphS5bUyXSD3O2FSIvg3
	JUD1TcNnZpGiXsQ7MCTj1TVHQ3ohhj+xY79FbL/+BRd7wIICp8XkFAHyKTyD/8lm
	yl+rKrALxeGxgT5Cn2F0n3Vujw7PsQdn7K1EKLloRiZFtuJG1JI5PkcjOkt6ZukQ
	tPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757255121; x=1757341521; bh=G/EPaorfj+fFyTEHaVMF0Aq5nU/5YHn8Zld
	lmV9nSRU=; b=gkkyoHxlYwH2iEfC+POnjbirfwG9a7+WNBFdUULpIUfCF6QwBKD
	CXcsXkweDWwsQzN7Gd/GbXOk1SV+QIJUgWkOe1GLc0VVeUYBy346pR/YD304mG7z
	1ztsB7KcR9c74q1QJaQIjsplL9rOCD+fGXEZYd3b1CaBQnjtDDPbNZDWICkLf5pp
	E+qxogYXjT9un6LXfyJoljBVnMPFxj2E3BW22x2ShtmyGXx44gZthxk9ic+CJ+5v
	xe6lmL0VZ16DWgsUqgTs96f66G7saKooHJEnRz+Yld+xGqzw4yGMu+xPzsXFPe8w
	GNdDDSQNNRcQqEmj5hrowrarHbImiv5H7QA==
X-ME-Sender: <xms:zpW9aHBBt0nmuBo9smDJ2pyc66XAz51H2zLxPIL-bKuIIirEqr75FQ>
    <xme:zpW9aP5GM0Oa9oXSpXiYSqnaKLnHMrts9xFSY3EInc6RNC_Ob2dxgDJB8d83jBdim
    fy3XXGQESbNHiHsUNQ>
X-ME-Received: <xmr:zpW9aNLIKTgt7t1RechOqALMeiJc4jvDTVIeA0j8Y6R9TLQOMTuGJFNVHgmJLi83Qw1w6W0IAc1sMtpcdOdKwHPv5EDXH_yn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcu
    ufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqne
    cuggftrfgrthhtvghrnhepveehudehueekveelteevkeevkeeiudfgtdeivdehjeetffdt
    vdeukeekheeitdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjghhgsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdr
    tghomhdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhlihguvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdgu
    vgdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomh
    hmuheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:zpW9aESQOTluGcoqM_cunEP_CQ11Qvxrpy5aGTfr1MzqwvK2MTzWog>
    <xmx:zpW9aFHJqGCH6u0UWGJG3VtNOeC2T8wJ8cwxckTphVMd0qLeV964DA>
    <xmx:zpW9aNpr-peDJ1nPk1kSevLyeyufAy3XpVeJTpuplknDlKhO7wcF7A>
    <xmx:zpW9aLNxtTkNoAukVHmomnYFXm7ah-6QwcR2-dfdjXXF-bo6zSTB0A>
    <xmx:0ZW9aEVsvUTTHZprT5gFlKyXEiCBT6fpdOnxgCny8ixcqLiQ3QkTgVqI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 10:25:11 -0400 (EDT)
Date: Sun, 7 Sep 2025 23:25:09 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,	virtualization@lists.linux.dev,
 Will Deacon <will@kernel.org>,	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <20250907142509.GA507575@workstation.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,	virtualization@lists.linux.dev,
 Will Deacon <will@kernel.org>,	xen-devel@lists.xenproject.org
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
In-Reply-To: <20250905174324.GI616306@nvidia.com>

Hi,

I'm a present maintainer of Linux FireWire subsystem, and recent years
have been working to modernize the subsystem.

On Fri, Sep 05, 2025 at 14:43:24PM -0300, Jason Gunthorpe wrote:
> There is only one user I found of alloc_pages:
>
> drivers/firewire/ohci.c:                ctx->pages[i] = dma_alloc_pages(dev, PAGE_SIZE, &dma_addr,
>
> And it deliberately uses page->private:
>
>		set_page_private(ctx->pages[i], dma_addr);
>
> So it is correct to use the struct page API.

I've already realized it, and it is in my TODO list to use modern
alternative APIs to replace it (but not yet). If you know some
candidates for this purpose, it is really helpful to accomplish it.


Regards

Takashi Sakamoto

