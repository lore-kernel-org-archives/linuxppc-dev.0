Return-Path: <linuxppc-dev+bounces-24206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6EDC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:22:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzz332HlRz2y7W;
	Tue, 14 Jul 2026 22:22:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784031759;
	cv=none; b=HUHmV/VBOYbtzEo9XtDjIoW2RgqfCAhY19PIIHXGmRLEbVaoIiz2CVHqJNQirLS1APj/RZsPMmRU8KbWtSCpqL4843Ran3EsLD4WMxt3hhE0ENYuoWNqz2PuPUQHc9zWq5MQw5o2FUGzKyG/ocSaeErYWknHwKBCZ/tNqrfrCcoUpdw1ZJFA81b0nbzpqH69MY5xAyaDeajS/J/E71Geq6U6Ay7XjqXG5qfN6nb5mJqrGwevkzWiZXpKKyHJrdAdfL+iswmnh7O3/kmQPVf9PIWwlasAZze+r4dNx7HWSh1S28WulW05AmtBXqTHqeBKXQXxrNKnbzGhj2xwtG01gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784031759; c=relaxed/relaxed;
	bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFn1iklf9uR1pBwdUwJGAl/9FJNx/IoH+sgtiTUmTvYn/JBM8dw8DeYmo3yERWMXCYYMtB1GRv4+IbdV3Ol8dBwuPhW5gqiH8cG5zbkq1OVZeBe3HRL/vKgabSfp8fjS6O+m6GopVf8hqE4KnJlIhPuJZbpVaGQuQmLyO2j5gmpqh013InrW8TGTpcWG1RxmddDmAR+ijGxLkRQ7eqGRRMzXX/UEnEgZkhjFAIuJ5f+iHYFZ5rdphsWNxCdVbOSWUyXQ8gNwcFtOmU9024thFotlJUy8yOylp4reFLtQHhxr1iyDwXnupKBfJQiAc2giIWClelgPAtnJkyJ0QmI+qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=O8XQ+es4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=O8XQ+es4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzz316VbNz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:22:36 +1000 (AEST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-92e855da580so328953685a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031754; x=1784636554; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=O8XQ+es4mYmPV/OwWdiVu+or+avA/NB1JVRphXwR+31izXCZEb3Z4G0vrjRq7aXDSh
         6tLB2EPOaTEC5mhlL7KOzFPEO62UnJTT9Fw7wwq7246jYforJPNcGRpIEL9SW3CknV2+
         Qq7BWOBdbvBlOTEE3s2GhSB61M5nPJfgtBUM47w70BtGBi94lG5W9lKHpCtlHg/wFied
         xdG83uJ20Pq6KJPU4e0X7Bj5VJmuNLeWSVVnacj6Dal2VJKmjAOEo40zQ0S6X16Vvwzv
         z2aDJCr/M1jvj1nz5Pkb6GbIWeup/6zZ8DDKDvNOn1TTCvSPfDLOHnI3JNhj9bQTP6Cv
         uHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031754; x=1784636554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=sppBdYsD6qDm5rstci6aHn0+LsljnY0149L6VV9rcZi/A+9lZFwwqTDUQ6gwOBnjhJ
         9J8MAnnajKybXE4SpyTxYyD2+aXSqD1CwzdnEiMex5sWdwLF2cA0SePTdPh1DFEg9Toy
         /Qahu6g6wMAig5q5wipxEWu5MLHACWIvmKAF0RV0IM3X7K+Llzxgq7MRqY5/xhw6TcRg
         pyOX+LBL0x3hnzJxP+/h5+C9mL6bNpJG5DoG1G8k3dRhBvnhJy1/Fk8a4jItF7v5Mj/B
         ZqlHCxPw6zYpjQAZaqW70KRcyaBUNkxrq8a5OkT4KIT985SmmbeAIPEzAILmIhfs2+8G
         CbIg==
X-Forwarded-Encrypted: i=1; AHgh+RqYTRM0w8S6IRbEuNOwkOimqpzwj/OYC1jDca8/mTCB1s4PvCIc27XLXtr+E6woGlYCfqzoj9txUtbU1F4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywhs4i+8F3dDDWNhw+i5XZIMCDTfemzATFO8GTSfrVNj40rlJXh
	rJzW916z2kg/FgRLvKtQBKf98S2dWLQ7tIu3/GNoKaUCk1xGoT4rh5ozdct7cikKnO8=
X-Gm-Gg: AfdE7cn55YoEb5VeZd+AU/KgqFrMRrbH8C1KdC3Go8ndeuPUCpFFz1unNoqqjgjCIfb
	PTRGqYR9A8H/Xh4V2EcaRXlDRazOvAIJyXEKupbALptUgU0QwyWZzWWNX672k+y9YAXT6EZglI8
	eCTuQ5zngp/RKYyhYChON/zeRWKKnJQxt0q/tuiVs5omDovH1k3x6IXxWH8JD4zrAQ+IWboDw3q
	1svRhYTz/UKq6Arjy2evEctbMqzwRFvQqpOCQGmJg58wBVV+SBb4YXObi+dtzxhPWsCJVXCig4g
	xjQlVwyvR+lIBFWYhQKJD9gZbHerlCfylLm9N1uFApTRnOumrIHyh61GL1qgoylyTSv0ojUjUz2
	+NY8QhMidWSmK0nlq/3OVdbHqJiPG7eUVPCd6PJoSHqT+695AXWh8HW6BtmRw
X-Received: by 2002:a05:620a:7085:b0:92e:6bbf:966e with SMTP id af79cd13be357-92ef2cb202cmr1211484585a.45.1784031754284;
        Tue, 14 Jul 2026 05:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm164927486d6.42.2026.07.14.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjc9g-0000000FRaG-0ohM;
	Tue, 14 Jul 2026 09:22:32 -0300
Date: Tue, 14 Jul 2026 09:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260714122232.GE3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
 <20260713175433.GI3133966@ziepe.ca>
 <yq5azezumef6.fsf@kernel.org>
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
In-Reply-To: <yq5azezumef6.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:05:25AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  	 */
> >>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> >>  				   1 << order);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		leak_pages = true;
> >>  		goto remove_mapping;
> >> +	}
> >
> > Truely these _set_memory_decrypted() things are an insane API. So a if
> > it fails to decrypt it can be in any messy state?
> >
> 
> Yes, we could possibly try to encrypt the page again and, if that
> succeeds, avoid leaking it. We might want to do that tree-wide in a
> separate patch.

IMHO it is a horrid API if failure leaves thing in an indeterminate
state. For something like this I don't see why the arch FW implementation
would be unable to restore things back to as they were on failure.

But whatever, everything about set_memory_xx is really bad it could
use a cleaning

Jason

