Return-Path: <linuxppc-dev+bounces-26395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49A9C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 14:24:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ7Qr5Y3Zz2xmh;
	Wed, 02 Sep 2026 00:24:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788272660;
	cv=none; b=aQIKn1AvqvoqRDXdccFyI6qyhpQ79MtpIwyWn+CN9WZnRWGJwaQHkqVihBKQWEoMMRDfAj668HlUZQG6plKIKH2TLr7kI9Xf+8/X+B9FsPKV+lm/St5j3BE2X6mhwZgd1wm+lbq7sJH9zcEpMcr26ylBKE/Jngg/ujw+q2/gWDZMHZcGAcF6ZdpfRDwfoyrcf391TETCFCl8itbdGFAQreQXlEB2YsZXa9eW4LlJYl9MSYwAfGmCCrDvcSjDV0Yvt4EL+E63e3OWppjuix+67wF0CvpGzi1NgngIN8JflBfReHKBm1bmQOlrquU8JzKJBB5EU9/mFGmhmvBpwq1Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788272660; c=relaxed/relaxed;
	bh=AMNw5MzyW2DJkQCetuS4jMUrMgDtCzVkmjImJH3QcQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb6j8N8iJ8k/tpuHgKQjNv/QCwKf6m7ZpSmH6LV4hNnZ8fnG2TKaG5UoRyARG9Ab2teUK5DswdCABAiAGtr6U5QHalzWowBuJlSGHhaNCO31k7yPLymo1uaryBlIo06rFXNAE25EHyYzPiqhNhbCzQVooMPUOVy7ATkt3KumqUBB0emEsbmNykF9cZHVqlzEZcLZJaMUMuXl4ICfQqU+RLLiuaQlq2JyA+0bzps5R179QccpEWgYMLlFM5BT5gNiuHRuPtdQwFkd8GAxewrAjUzqy45ujNlSJWYjbnKLbeE9Hmm72f1rrKPWUCrNCbAcwYBWx5D8vLyKQVckTrnyUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cH48povO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cH48povO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ7Ql4qJHz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 00:24:14 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-9371bcf1f8fso347672585a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788272651; x=1788877451; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMNw5MzyW2DJkQCetuS4jMUrMgDtCzVkmjImJH3QcQw=;
        b=cH48povOMVNHodty9+w4MEEdrxTKAn+cBAffk5/rIjNZxw3i1qz1jw+tAis7DAfTDJ
         VZeCLe0oN8IWz4XLguy2ZpNGi2CR/SYPSsygvtuMu5fg0EkYBTb6KrFOCciAEOW5S+kw
         2SvDTxRlL+PTyZlJyTa/Ch5j2pQl9N5O0X8J1yLfsjORjTqK6ZgHbNgEmWg8U8e6C08X
         tdn1XVBD2RAdF+HXu01hE6XRP60ZUTTXanjxVjyXkI7M9oTsgw3bA81xBkFpDP2HZJDX
         9sCS4QUAFBrRTYq8nWmSBZOWVvRdaqBX/t1Y2gvxvlaKpJaiga9whKKrVVvW37ls2/kQ
         sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272651; x=1788877451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMNw5MzyW2DJkQCetuS4jMUrMgDtCzVkmjImJH3QcQw=;
        b=mcPF374EY2knYdbSjM4Nb6pkTvn+N8gKJt1O3sfzzUnghGYFBrJj1ym+gRpV1KyD+a
         yjT7E1wxGI1T4WvhE/Zz/2PEIxV8cPKFM2hd/RHjc17zQczRkInNLz6cjlH8qCi+O/Ra
         eHC+rXrMAa6QxZslJP61MiC5+Lz+yW6kDM2hxMXUmp4M5j2lNeadg88Z01qdi5mlYvyJ
         z15FFr6crNDKTNXzrKG4srt0wP1kxYSBCQgIWqnd6b1NTeMdX2BbryLDTP8CXmsOcngx
         +WysBvv0g4izIJjjLUzoO6BW/+btmsWCjcRwTG56dBEHkQqwaRHpHQXiP9toP+cgkwOR
         R8rw==
X-Forwarded-Encrypted: i=1; AHgh+RqbCqvHQ6htCg8aisjLRGni4I3Jm368M7eN8RGwbW58XIipBVNW6EYTUYuhD3lgy7ufGCFOzG4za8K8Yaw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kXg7CzeRzMbdf8TAqMXbz/Q9AZ8ULEUm05rn2UJPWeYtUiTqsk
	uobbTb5MN/RxPk1L3+Z2rS44W/DF+RTK4lDI5dtwT8iG2MKYfqsw0pLUGiV4ORR1ES0=
X-Gm-Gg: AR+sD10/iOGf0g9+m4Q89iS/bKN02IcDSmOiMxTgPvypnybktgZXESUryQtS7gjfABd
	Re/u2T5GKcOkK4RF3gLiMOUgp7WLKJiECxxlmi06Xas4tHg9r59cOYRNYrvpuJ7yksibKj0CHYm
	xIMyMRj6PxI/i9nOlETSl3EDo0bEwdkemSyP+mXsEom+lF68z2Uj+foypEhV8iBQ+jIkeItVkd/
	m1u8v4WImJI/Z+UB4wA9Nt4+x2C9oLmR9qskMPOHyglATHuUbl+raWqy+4Uny6ExJtmJkQfwIBH
	lLmHirhVMSZKErfYbqx4bjHF5lPjyqAsABo1tPT8KlDHb5OVsXKW00TLNEM0CtSK6nip4uXQQrH
	KXAOJmkhrUeyS9xrjbnWqpLCBs+ocA8XjFPHLfXDhMcHCQPPYMz+6gflIGClOcy/M1mTErDci9M
	qVtzLYyvZYckZLSj0Z0d95Bu/pAZIM9E+fnsClwMMxiR4DXK94EirpBVB9EmD9sYIe9v6tTNt/I
	6P/2mNQZ/LmEF/wqKQWIMqN6YdL/C5blAlE2Kn8krKfeg==
X-Received: by 2002:a05:620a:29d4:b0:934:ab73:ac53 with SMTP id af79cd13be357-939134fe550mr3924451085a.0.1788272649971;
        Tue, 01 Sep 2026 07:24:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917012b65sm1040535485a.2.2026.09.01.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:24:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1PPE-0000000BgeE-10ID;
	Tue, 01 Sep 2026 11:24:08 -0300
Date: Tue, 1 Sep 2026 11:24:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Message-ID: <20260901142408.GA56830@ziepe.ca>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
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
In-Reply-To: <apbcoMTVlL42G5tg@gremlin>

On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:

> It won't be costly at the time of the calls obviously as its deferred. Maybe
> increase some time spent in softirq but again is 512x that big of a deal?
> 
> I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> either really, certainly not without it becoming extremely messy.

The less costly version is to thread the page to be freed onto the
mmu_gather through a linked list in the struct page memory. This is
super cheap since it is just a singly linked list operation.

Then when the mmu_gather is flushed it does a single call_rcu using
the rcu head of the struct page of the head of the list. The callback
clears the entire linked list of pages.

Since you have to tlb flush anyhow, it makes sense to always use the
mmu_gather. For example the design I ended up with for iommupt
accumulates all the invalidations and all the free-able memory into a
gather then invalidates and frees.

This allows maximizing the tlbi efficiency too. You can't do call_srcu
until you flush the tlb and if you call once per table then you are
also tlb flushing once per table too.

So if the kernel really does want to clear out 512 leaf tables the
optimal implementation is one range tlbi for 512 entries followed by
one call_rcu to free the memory. Hence the gather..

Jason

