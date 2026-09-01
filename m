Return-Path: <linuxppc-dev+bounces-26406-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BEFC624D5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:06:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ9hZ5J9bz2xmh;
	Wed, 02 Sep 2026 02:06:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788278782;
	cv=none; b=PpqLyLj8G7OTQIEpnDj3mtMRXJqsRO8OvsJfTIlI+nwt4uEdlknYo9lAo6sY2kuHmxTD1KJZmMxj9jIt6ZyHyI6SmxtwBunZQv9ikvjOnuXThZu/nD5dPl+ZrhMn5nh/kvP3UsFFwm8h1vUeMZPZck7+gp4KBEzYCWSdPOTKhHEtgc39nJZgW0Sv0a+9hUH1dEx/2ZRzuA494jXj32V/oXEPvIo2OGoTd/T39ll4Qi0lt5v2go6fLJUXJMDb9d5H6kylNrvGEEXfjBnU1RgCTy6YCfO3L3Tki1mTFLBjXIaJOGvOGqqxYyGXRR9l4v5eZ9f3vKTxknEQHpJRk13Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788278782; c=relaxed/relaxed;
	bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrH7yKNaboc8AFVzRLtLBczELmvOTPKgMe9i+fJVfqGB3uAA4JhBna508Fl9NiEqzafGzx1KvGQSg+TlHF6EhlJaMRO6ldxFJtI0LYQzI+ZMtP7NwIMPstdctwj84GCgVyPrWJ3JWauFwhYLiuGvCXNzZNY9ZeZRHryv+LkKwjtFiYb8v+yCGC6faoBTymLkqj8i0zN3fcTRd+DIv/gctt/97LozprhMYO4XFyQrqChn5Ep6KT6ZXM5Gj2BAd2gPZlxSEq6CNgSEZS4Iqo0EauMLOMdehxHMP2QYqj2N3pA8N1oUnUCDSsKus3qlIW8Gjt4o23BK8GfYidiyEhdqyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=V9Jx6iP0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=V9Jx6iP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ9hY4Jc4z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 02:06:20 +1000 (AEST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-92ea24a2dbfso10714685a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788278778; x=1788883578; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=V9Jx6iP0lIyQJgv39CCANKJ8Wwm74ieeITgN2+FUxSO7MheX62qgFAEGxHZElwNYbI
         G2vGNvyE362ibpriHNTfkiAiF1kZ6+/MDCRkjMvs4Wo9QgSNpEhwpARb7UtiA3hasyVV
         JDVtoHn6KXw/FXPyB4Blia3CPn0ewjsVNzN3MniNBYWdMK9V4Mkw4UGKX50cLwFw8lXv
         NNwuUyCme+Vy6IRz4mf7rH7yKNRZxqYAAP6YXlrVijYEhG0Yy9JZIrEj44r+Xcbpcv0o
         ndFGq8xohFpyBYPrGXXbYoO0umTQrRGVWNI1/7ypKup6CjtPw9aeV/GpMpPYjIwx521G
         5hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278778; x=1788883578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=jP+9tnpUnFRU/dGy/IqE7mdKauiJcodQjytlTpwbYD7CuxL5B+29vJSHfr+YZpyLmE
         zLQv5/LxXzVtbOCYfoRsqeKT4DbiKwtU7zIirE5kaCPeyTgwVRC1lyVSjhXBAVevne/0
         xEuZ8RXj5LSoGyXdTAhrtke2w2mFQThkC+fVLV8FFiW73OM24kpAoUdpAlINqPJfIuT+
         Ls5hJ9qilPC1GlNZzNwbZe6j2/bVdrSfulYsJUyjdUjTI/sPJJLT3OC+LnChOJrHDsF9
         nHXDQ3ZT9d7dw97/Z6W91OHZXOMllvAzFyoHxHU+zHBAUFQRUs3HL4rI5ar9NGw11PPw
         iP4A==
X-Forwarded-Encrypted: i=1; AHgh+RoQ++dh4LNSGlWVx8LZeywOIEoVll777TMpze/b7QUmvZS+OB2IsuZU9cSqI6dirRwa65dPXUDfSVvTjz4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k3zyiVF4puZXShXpdBAaIRAyh62tNnfo0eLPpZM4NaIUAOqfdS
	jBc6TLH+dBs2hA9XXCWG19sPOb0sftvrJJjNcI3IxT/k/JFW+hdyJa8EaoQ3ZrOWem4=
X-Gm-Gg: AR+sD12yLswrFusLPsA2I/IChA+B+mykRIDh5EcNCgNxVAWvcntgB81XKPsGZmK3Vx/
	PVYK+G9aVnmWLoE/QsEFU4Sq8CnpSnUcW2je67qqTMslVc2Kq8ItnsNOzdvONp8eojpopS57OKA
	r65OGt4V/NgEFZN2Mj9RzFj7MAEA8HW/Y3rmLjVGua0WwlCZ/Up8dwSXRAXdvJXQS/bwkFq1D9a
	WKfbl5VFPLit8qmPZfufHD0k9y6H/Px0s9jNBBqTON4RC5F/ZnODwemXCycRJzaXklpvfEdu8Ii
	x3JjHvpAN9byX4VztTdiGyZPfWm9ougOmuoQXjxiV9+me3eV2ix9TLHTVEHfp0J9YVYl/ztKxUc
	J0I4kpbQwpmgti0d31JxToC2Qs7x51OYdk82mKJudJjJHqvx/nnk/EidAQgL6LUhEx+UMvMcbNj
	ButoJ7JCLzaqWkiOQmQ17J9m+vspt+QFHlSmd92xRmvW0rmZEWFwP1UyW8+klNFAC0YaTK3BAFj
	xYWHdSDt2Ul5aMXwk9LSGkTe4b5iFD+FCw49T35i4iVBA==
X-Received: by 2002:a05:620a:21d2:b0:936:ea0d:ffc3 with SMTP id af79cd13be357-939139002d3mr3178331885a.22.1788278777843;
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93922e5278fsm886283685a.14.2026.09.01.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1R04-0000000BtB8-1Fgr;
	Tue, 01 Sep 2026 13:06:16 -0300
Date: Tue, 1 Sep 2026 13:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Russell King <linux@armlinux.org.uk>,
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <20260901160616.GD56830@ziepe.ca>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
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
In-Reply-To: <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>

On Tue, Sep 01, 2026 at 11:54:47AM -0400, Liam R. Howlett wrote:
> On 26/09/01 04:28PM, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:41:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > >
> > > > > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > > > > increase some time spent in softirq but again is 512x that big of a deal?
> > > > >
> > > > > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > > > > either really, certainly not without it becoming extremely messy.
> > > >
> > > > The less costly version is to thread the page to be freed onto the
> > > > mmu_gather through a linked list in the struct page memory. This is
> > > > super cheap since it is just a singly linked list operation.
> > > >
> > > > Then when the mmu_gather is flushed it does a single call_rcu using
> > > > the rcu head of the struct page of the head of the list. The callback
> > > > clears the entire linked list of pages.
> 
> If you are going through the trouble of doing this on your side with a
> custom rcu callback, it might be better to pack the pointers in a way
> that does not need to pointer chase through a linked list.

Well, I have 8 bytes of memory in a struct page and can't allocate in
these paths, so IDK there is another option..

Jason

