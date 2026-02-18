Return-Path: <linuxppc-dev+bounces-16927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDC8E9A047
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:08:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGGyn4zlrz2xlq;
	Thu, 19 Feb 2026 00:08:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771420081;
	cv=none; b=W4a5AswlGwP0edZI2cJOaWD58OHpcTxqFaDM65eZqPV7BYpzcgcRGp/xLW2CV0k6kWFAjhHoeZmyWeT0hRr+gSrrJK5i9XrVuvC1A68plpyS8A+4sCv+jdiRvsFGOcfkPKqKcBI/bccWxHKNyf50vxGSWaiBhJhqoynV784n6u6aJMuGJyN7JnKKys5S003aUK5910KUpIJzBUZrz8CYELo0hDJsmlUjV9HqCS8DFZmTl/1u9Pyjvlo1oqqkQWtOPgFGg+6irEM34XvkndqXsubXz+ql5zb5ii1qq/LUP2rzyWYKvrpoG9zukkB2KSD6A/MUZMPIGD6s5VBWPpg8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771420081; c=relaxed/relaxed;
	bh=MRGYwwW7dZPASMBAQbEnUUAmVM7Dk5+BeMxteCPdDpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgosjmt90kJKD6nd7D5zGkf3B/Wpseq/ftRnl6blEHymdUsd71gP5DPxuOd4ZP1Q0jdN3bECtVLfuAZnEhWSUCbMpcb0FeCRFE6VyB4d2wQ0k4FoJsFpzSVThiSKLuENz1s48Jw035ocnd5pfuzX5pdkxj+HGBG+6im9URpvSn+2HLA7+ABsSS7kmBvCR1pf/neQzaH3dA7bGMOiTocOtCKft48odG85cV+wXDZOsa12mDSoRhXFUoXbpO3zIG8jOy22MQvBnH+Og9+vNeDOsrZxvtABGg7m79y7xpGrP1rUfiIAYOJ5wFqW/10H1YdhNtj5eIZoCJ95emJFahpZWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGGyd2TC9z2x99
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2026 00:07:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MRGYwwW7dZPASMBAQbEnUUAmVM7Dk5+BeMxteCPdDpY=; b=jt3wPQRhLZbn4iPv8TKFakFnNd
	8Gnijfv23M8CBuaPT69BRUwG1x2G0CjlMJvSY6UYI/JS39Dzrg4EGSmimCAQhdRTFyTSJ6utoS57c
	LHiKYdiX5Rr3LReSI880z4nIeBHa/10dKYxt6MwSyf7jVkhN8XSoufBePpdcTeZT/RAbcoKx+UQB2
	CbsvvNEHV603uZVde4B6xz1tbSwntTNoW6utsGgcv/OE3sa4Ol+sF0BJeiQx6666E05koInrZO1yx
	P2jsec9FGpHU+MlYSFJx23LqWaoVns3jq1hEwOnc1+bCjy0g6s6zbjiqFC9r0bCpFRFSISfEbKfW+
	yD7yl16Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshH1-000000063U6-30XM;
	Wed, 18 Feb 2026 13:07:23 +0000
Date: Wed, 18 Feb 2026 13:07:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	vbabka@suse.cz, jannh@google.com, rppt@kernel.org, mhocko@suse.com,
	pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
	borntraeger@linux.ibm.com, frankja@linux.ibm.com,
	imbrenda@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: use vma_start_write_killable() in
 process_vma_walk_lock()
Message-ID: <aZW5i4cqU1qUy3aa@casper.infradead.org>
References: <20260217163250.2326001-1-surenb@google.com>
 <20260217163250.2326001-4-surenb@google.com>
 <20260217191530.13857Aae-hca@linux.ibm.com>
 <CAJuCfpGxsX6kZAzZJZo7aGNxEbeqOhTV8epF+sHXyqUFOP1few@mail.gmail.com>
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
In-Reply-To: <CAJuCfpGxsX6kZAzZJZo7aGNxEbeqOhTV8epF+sHXyqUFOP1few@mail.gmail.com>

On Tue, Feb 17, 2026 at 12:31:32PM -0800, Suren Baghdasaryan wrote:
> Hmm. My patchset is based on mm-new. I guess the code was modified in
> some other tree. Could you please provide a link to that patchset so I
> can track it? I'll probably remove this patch from my set until that
> one is merged.

mm-new is a bad place to be playing; better to base off mm-unstable.

