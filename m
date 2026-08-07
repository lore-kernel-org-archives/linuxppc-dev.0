Return-Path: <linuxppc-dev+bounces-25587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE334C5ACAB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:58:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGm2K2rQ8z3c58;
	Fri, 07 Aug 2026 23:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786111097;
	cv=none; b=CIC5ITSEOQ2tAmcrh2z94aAfgt6/kjvZLf7yB4DKcohAVFQioZLWnV26KWyHJXrzN2QEi/4I20xDEJFoqbpaY0YYBCsPnLfQ4JI4CjiL/pAYToarex7Iz7ThfeavLMvAxNpVRe8vIS7zK4emv0gipsty3ywywOwy6zt5/5q59RKdmdMVpgP1WDtS5vYpRqy1m+oTuoGlLDIbFc7XxP+37cWmzzK9YA0VLUjiE82Z6/D+Psa5II8VKkzVMiL2bBqkKrICVzDSF6iPId3bYCCOz3p8KGOedyY0nFLoohU6KGWMftU4Ix5qkAF6/M5ZGujv2+iOJz4PTlIVp/Zu4ZfMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786111097; c=relaxed/relaxed;
	bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StZrbF3KHZFaxjykwugeFFkrrQF4Ms0IwTO4zkDgKGDkwmZeMVF7d2W+L6pjhek3TOzgfg1E2sZtFl0jv12PltK7BBqQEge/XytfljDOiEe7BB+EBhL1ugSd1zy8Scf8BK0hax/xtLOkLSeMA/6wybyY+jZ0bIV2GcdS7eJKJoobXS2K92hr0F5cxxnw8uiHypXqSMncg1/NKswxkaIK6xDvzBA8BE6OFd4CP83BR7IP6hvk8HoGigohHgr8j86kXq5R2AB0yWzhJ3b37QxITzd+RkW4ayVPbwTSWR4NdUp/LAip2J7ihccNgmIivKdwM9sgGU9YDDg+xFA3clMvNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gmJKhVlR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gmJKhVlR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGm2H6LLCz3c4l
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 23:58:15 +1000 (AEST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-92e54f8c051so180853285a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786111092; x=1786715892; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=gmJKhVlRhZz/yI8Yxoq+Q8Gv5ih7T1Gbx7eEy0q7TaCuPG2IqFPoBDm0njaxsVGdTe
         u6ViakXj6o6Qsaz5LqGBFsdl0p8H9hflKspYiP+5MXepxHstQHtFeoV/zSa0NZdpITih
         rNSGaxKpr8Vy14FadlgJZ6jSurX2ckGxafgNGvQKo9q1wAb3OX6qKuoOngIPW063qB35
         rqtb98ufkwpdx4zoa+v13HhD5dudPX+ZcCX0wpmcGHCAZ5DzWWGRlt63eplg3bq25bCs
         QsjENglmZhhEsqpRUVosIx2pp8kwfKj6AysenmZVVkM/DwgrBiuBw7FsCHuUI7Lge7Rz
         XzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111092; x=1786715892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=E5eh0V8y8sysaJQpmmR1K24d42PGwNzon5+hvcodbebPlInGmN1Gpo6ZIPgsyMAkHK
         bvvrQgd6cZn6hgXtLEFH8HNYbzgJs7BC7DSSPLOOv7ontLpO0r17pbsklpnwfpWSqc6k
         ECjRuc3DssMW0YfZh/1rW9W1K35ah+KzYkaGyLzsNQj4owq1bAhGzvPDq3BTv7BaUvUJ
         HS66mbVeE3Td7oO4p/ruNRefSeHcYI4UDlWJGMW3Qe5scLp4prtVX0ypUlZMZJmJkzOu
         QoOC2HJV1XqFarKhflV4CUo8Kw34ZxaZ9Z4E+RuofQDsiVdMks7yRY3OK7z9CLG5odbm
         0VxA==
X-Forwarded-Encrypted: i=1; AHgh+Rpw7alKk3WFJwg64zLSMQUdQ8mrOKqFqV5ofmbc9YesqbqVXDRrH9faQcMZbo5N9z59f2HmUy4NPP7BOmM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxrYX4khpqNiOsb1pmblm1uJfogeJz3QN+kGxWMykkVQKW0Ilnh
	zB+aXWN3jTdFna5gAV/+nQ9Xo8Y5z+1sAyMOjulk5d7sqPiHEHIz6VSOljIYlZuZKD0=
X-Gm-Gg: AR+sD120M97ByfUXjFS1nvZ1x0yjmpV880Z4Eey6EJJy6NFCw3d0QiWp4P+lwyHA6+R
	7ijs4Oj5DSMSx5nPeXt7xkl3WGcPpEGoWdMOwr94gKM7c5umlBmAqRouQk8Y4ujigY625K2s9+c
	dwXz02ez2k6tZZv7YJVcfjCIENi92GzmbKXqla6o023I8/yJa5NxEaZtjM2uAML3gguBPhhajmd
	K62+qWlHqqCfdMtAy1dmNfBrvGPkfX9Au6FLI2UJXH8Dp+mjbrDtq3IUfnCtksdyIp688LTMRDK
	yT+hT2lsWI8IEPYN1CpkyJ4yOqmftHjv/TAExL2TBfzvPUjJDDA+gmroKLSOhDbN1u3fVeUqKvp
	8jeIsQErF1Pnlhshv6myPQZ8D7Sl+ooRzmUEQJy+a3b6OsZsKvjf02ljDL/HSE413Wi+mqupqfc
	4vxQQeuWP8uRWy7cGsQHfAAMyuxANz/XM2tMbifA==
X-Received: by 2002:a05:620a:2725:b0:916:14f5:8866 with SMTP id af79cd13be357-936490191c4mr2577886985a.16.1786111092001;
        Fri, 07 Aug 2026 06:58:12 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e2971d0sm152121785a.43.2026.08.07.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:58:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsL5O-000000012Hc-2aob;
	Fri, 07 Aug 2026 10:58:10 -0300
Date: Fri, 7 Aug 2026 10:58:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807135810.GA200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
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
In-Reply-To: <anXbJ2O4DWgPxCeg@willie-the-truck>

On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:

> > I was under the impression that there is a possibility of using swiotlb
> > instead of restricted-dma-pool with pKVM.
> 
> Yes, that patch enables swiotlb as a possibility for protected guests
> but with your patch we avoid shrinking the swiotlb buffer even when
> restricted dma pools are being used and that's a waste of memory.

I also thought we switched pkvm to use CC-like swiotlb as part of the
alignment in this rework? Mostafa ?

> > If that is not the case, then we could change:
> > 
> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > 
> > to
> > 
> > !is_realm_world() &&
> 
> Perhaps, or you could just pass the swiotlb= option if the defaults don't
> work for you. Can you give more details about the slots exhaustion you're
> seeing under CCA?

We see badness with swiotlb too, it basically doesn't work out of the
box if you have to use it 100% for real devices. It easily runs out
of memory.

Auto tuning to higher levels makes sense to me, but I'd rather the
core code handled adjusting its size to the estimated need, not arch
code.

Jason

