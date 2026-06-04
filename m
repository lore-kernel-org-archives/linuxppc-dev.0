Return-Path: <linuxppc-dev+bounces-22043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C398CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 14:30:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWRmb1P5Qz2yRC;
	Fri, 05 Jun 2026 00:30:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780583407;
	cv=none; b=i9+h0h4eCTe8RIfvVYTXxUjlMQKYT1cg1cA1OB1WGXCRyknr74Ea9IgW6W9hQCNwfMBwa4+ttY4D9ph+Xc2d3MUUZinW7jG7tLwJ0cH/Q1l5BHUD6CYb+v+cykQyXdChQH6Jmc9FbJ98vWmu4i2TYra4OC6Xm0GMwM5dJrKyjGDqcKbrU7FcrRZ88vDTgOT8DdtERKMVQgJGy9UlQ7uLMIW2jBEngZBpGrshfKTdkhWdJrsqY7efnXvn1St7EyIaO/X37ijeOjPT1qRTwUt1FDdqBtrjWVN14R3AsWO179tc/SkrTVhsEeM0LqqCY11BP6uLPZav5IP40V0pv1aRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780583407; c=relaxed/relaxed;
	bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7tAtP3+JJ/dy0nrE4k2K9D3AKYKrNzc37LumXasF1Cg+2/CPL+wWz2MVydJwz0c7W1SjrmQYQXh/k5BQ/5Lh9N13/cP9ztwy+1P37WLYeFPeJLvHSCcj5GatyPjkjgPMpHMxfcB1qp6nz/tdT23sv/bTpSZZDpHm31FSn4sMHNf/MPHpojo6Jz4pbBhbzEG7lIjIB7uTTUqr7/Jln66SbwoAeJRn5PLUrVbxTXLGBT+vHS0NT+7gA66ONdWSraagG5ldBAP9Mc8aUNXN/ZkBNegAy0lgBzflTrYKci/zmSK2STawe6Pfvyl00gsDVtMgn/J2J29DBVkx98IJ6frRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nqccFV0Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nqccFV0Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWRmZ0q0Qz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:30:05 +1000 (AEST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-91550c6ea8eso123657585a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583403; x=1781188203; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=nqccFV0QqZHx1HAFru2J4096X3DwrljpFr+tjcgwlM9gBOvyVW4fpAbx98kskOVJyo
         bsBA/1I3FMJB6+wVvpggZQJBaiYWmGvLTgZTD3He/I0YRtIAmYguhCsrH6upHB2rMoIw
         PPEoJLK3iLvkDjnh55E+Yf/r7MQNcxXqlEjcvgSSEHHHRlw4+8oohJyupcZRJEFmeG3p
         ujYMo8gB6yNP0o474nR7uCP8pZ9qpDKbJUerkFjj//b53ihn3beIP6/9XhPqhuva+O/+
         H4Qu7aPyRqX1jDbjxzHB3sgyqOrFttkHXxw3oRGK3ZE5nYspq9OfzWfGy5HTm3Fb0p2A
         jE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583403; x=1781188203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leYnnf5Pg/xQRLvt6GMDQfv6g59yyMdkhV1lUPQrWAM=;
        b=pQMQZl5hMP+cc/BgYk+g4kQBKJI2Jb3FejBsZBHrOqJcDeorPjgvZh5RHExJdT5wC9
         YThpsQqTPY3+mN8h+ayB2Tn46KdoZYBWRFioSHODN8mrJcjrVc2vxM6xUcJQyODGSmBD
         apS80KrBEvML4zm0HlAOLHAOEDPOUhT5vS6DfenLwkOw1e6iI+9epi7ueVXpcRk9rH4d
         A5eqesGgZmMFBD8cRN/AW1SxYhN2SMQrWqnStyXasMQlD69egHY7kspFy82W4FSctHvk
         hVgEjchqExleoYuXnFesy+Kv5QPEXQNEHnulFAz4YNp5zwRfLH5lWOJxYkCXiU2aJIoQ
         yzLg==
X-Forwarded-Encrypted: i=1; AFNElJ9hnaEherA7mHBedI7px1Pif6wncNOZtqIP0av2l2zwninLRR2GC8CXJWE1b7r7/xSSSRnf2GzFwwGMyJQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnuAGVfuOSvVhs4Jo5kKPLK+E5sSkTHAOdr1fiGcL1/Bjb2kIz
	bm42yrvRjU9MkmWU5/Fnrz0xh58mYwAbNfEp3w25FAf2LZpoFzQ6+goupHgH2dOGVS0=
X-Gm-Gg: Acq92OERwrmyahu81Kv057x6QLQiYp+On8sdad7COr6lQNtuaRkBr99w7Tp97RTM7Z7
	I7JZMYCAPt7tz0fZP6/3Ob+DHbx639f+BmgIZDYVdiBEFuhyp9iWSZuqjVVGnCrHCN8gt4YVs6W
	QR2tH9ChiP1V9V8xmn78nP/tpGTGGlL9lTuszCwqFZBCYtGSiZOkL2wGzjmMsJD5LrGVUqamvcu
	hi/xFRXN9lx6EAE3l+OV/wNAD526CdCKervtNGMFQNFsFwsCJvLhnPdXAsVCewhFCQJNt7wFK8G
	uAoO/RMWbiIwXSvcmHyk7OL7BopoW5DspAVaDlR+nzN1otK28nK1rNmhucfnl/+8HGDdA57xiif
	nO2rs6mJFwQgocTt111reXv9gjdOXFfHen2shyxkKpE4Iifj+H2zEZ3pyLg1viwbK9vxRSaOMwP
	OgFb4GFNHrMsv1DAM+U8k5Ky63Cp+k7qKOPA8IF89DIB58V2iR4+kjZb94QYvlKKLhSk74WP2Gn
	W078+uZ9egonEai
X-Received: by 2002:a05:620a:2544:b0:915:3e46:c44a with SMTP id af79cd13be357-9158a80c3f3mr1387419585a.46.1780583403463;
        Thu, 04 Jun 2026 07:30:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm657350885a.11.2026.06.04.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:30:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV958-00000008IZw-1Hzl;
	Thu, 04 Jun 2026 11:30:02 -0300
Date: Thu, 4 Jun 2026 11:30:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260604143002.GA2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jun 04, 2026 at 02:05:35PM +0000, Michael Kelley wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
> > 
> > On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
> > 
> > > Except that in a normal VM, the "unencrypted" pool attribute does *not*
> > > describe the state of the memory itself.  In a normal VM, the memory is
> > > unencrypted, but the "unencrypted" pool attribute is false. That
> > > contradiction is the essence of my concern.
> > 
> > I would argue no..
> > 
> > When CC is enabled the default state of memory in a Linux environment
> > is "encrypted". You have to take a special action to "decrypt" it.
> > 
> > Thus the default state of memory in a non-CC environment is also
> > paradoxically "encrypted" too. 
> 
> The need to have such an unnatural premise is usually an indication
> of a conceptual problem with the overall model, or perhaps just a
> terminology problem. 

Oh yes I do think the AMD derived terminogy is aweful :(

> Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> Name the pool attribute "cc_shared" instead of "unencrypted". 

Yeah maybe. I sometimes imagine replacing the encrypted/decrypted
names with cc_shared too just to make it sane.

> "cc_shared" set to false in a normal VM doesn't lead to the non-sensical
> situation of claiming that a normal VM is encrypted.

It seems like a good idea to me

Jason

