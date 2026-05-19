Return-Path: <linuxppc-dev+bounces-21171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FAACD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 15:27:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKdpX047gz2ySD;
	Wed, 20 May 2026 01:27:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779204467;
	cv=none; b=jMkiArZ7WIlDWprAPd6wFt3SCyd199NNbp4YGJMlN5K0U8H2UORyIhTfFATi1SHibp/6zrJGoWGglRbdxcnkJ7kXQUSTJUUG2GmsYBHSMC9dmn0u4JKraFtSzXQONQWNFO7b9PHtrM9WYUxB/Rg8gZMnGu6Bu/dreKLCS/LyOhGmhv173eSqCzGQYQNqrAMYFtRSttSmqOT0lxBGD6lvMwjD2435F+0nGiXQ/5mPx9muqupagZfM9D9kg6OmOLakf2+amYms4uKnseOJsG50KUHeToSUqcWNjXUAR6wvXKRLOsrObye+36YSGqGdlw8H2UGQOexaRJabDpCq6S4a7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779204467; c=relaxed/relaxed;
	bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK0vaM4DlftjmXkHhg63+ukkBxOeWSCaBqlgrJTUU4pCl4LoyT0C2ExhX1XJf5nwU0T/O3IVg+HmWbcDozJ6nsWWMpo4f0AIrxKUBvmPf8vt0/u1zOZNmmvDv1ac1YndQWjz3sDGNArUrc64I8hECM2QiAdcDGZwqJ1qjPM2qUdma0xvHe934t4xLAFI5ltVK6XlxtBxqicQuTegZU93jP7TNrBWao6TNUMLMw3IQ21KMfOFO5wUuYnq2OugZo96WfpZPQxYqveAn1r7EC+SpwbLApf+aDgcUiFaQQ3rgTYoQZpb9SIR+6RG2DyH5lcGbsl1OePHeDaCAD4cbHWqfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gg9grjFC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gg9grjFC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKdpV07zxz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 01:27:45 +1000 (AEST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-910bb291688so461073585a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779204463; x=1779809263; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=gg9grjFCDgynt+kxRKeckyZqkFaaNbi9y6pxwdKeGaoEySjmBLZOuNIHsqXy4RrvW4
         qU6nTLCqFxqz59kFf1DkgVq1ha3dWGkwCZ/CpVMq0xxg6n/jtSihR6c0rWi0r9R2J3KU
         0Tfdf2gztSu4lF8i8rA83G217p9UFrmK52UtArkRTLanh4xedEeOi3fP99fi6H8eITzm
         4AsOjz3MX8j5pibQPswlbXmd41FcimpsH7rRn8oi3jWAtrzU63R5j5VOf8NFVkyIhFxa
         f83DHCNAVZ9WmY2TBqCPMMQJ6A2xkrFU1Hu0B4pq4rtHXmwH4T0t1WWFlzv02+qMIjhS
         liCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204463; x=1779809263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt+hX5KDw0Kh9RBmOyjzabH+WBL9dObDUAkuMZR7Klg=;
        b=f4DukzTKd4O4Wt+jE2VNbHZW1vdxDByEEHD9Z/CqNiHL8vaqGPhzvxnLNwPrFhpudJ
         JATt0GtQf7kaPYT67bzA5oF86OrAtA46ewcJhlSdD3/k6xGbdMSSLqa2BBXS0URf+bQ+
         r7XpBo76luXi6a5MK3SvNS/DNAqrIOFhfqGhRCKLlAygtlX+e7p0+4IKy99h4DUcdx+d
         zlPmAY2KUlcix32SrAi51ooSpXi0wjtNqMwZWqlfCv813l0gT7jq0o8WraPl2QHrAUKt
         xeeMkuX3V2/F0sqIpaPERWajkUGm2V8512sySysWhFoDrgU33eOKlhX98hziSRiQJElY
         7MBA==
X-Forwarded-Encrypted: i=1; AFNElJ+W1i0eyQrNMd6jlKb1ItYbg9JA8z7w2nRoiTsukb7BfLYYx+k6d2lo478Ow0KCBXBy4wluzJC0ZqHX128=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkxCStdVxabXm7ztj2/2ajsTmXlj7jYdyL4Y5Z6P7QYUCjHlPJ
	v7tCsX3aYi1rJ8A6/uf8SqRsPgXUnoAkkkekx/EbQ0wPqXbMxeypjxOhbhi0JJix180=
X-Gm-Gg: Acq92OGpqnXdYuW8de3g+m9s53L4FMD6TxcAYxL8GfLV67dzuQLj6Xchw1LtkkWSPll
	D9CnX4k9/3dGg2qGIRoxb1hzzeAaiwDtwBOZSYJGqw/saLKTB/rCfEkbJo5ddCXUZFpZGTH5Uce
	d/QqvnEq2LhonO0I59BOabMcetK0/RbbkkFuG873mDBx3sRDsqj8NEffHa2+KPh0eyxKhuIKH6e
	uIx/Rjuf+tqhul+arJkVQ74D8SNNpwLiyT0Zjr/DREozkk4CKQRpNvB+aWcrv7sBdc8Vi6ev6hF
	IpXzYRhY4S16Z3CYxLmPDC79oymhHgN91p0DL3EvjxNnx3LclxHt7V2D1TBqFw5/Oco05Y00Jfm
	8TIf1+BQEWsUvLke7uxBZ58JMIJZZsMGR04o1EcpPjBjH9/IkaxhxHMOHzlxhf0XQ9O1dv49mtJ
	qYpAsW1PWyCnHMmvVOv5AcHmERpo9xgufQ4HtNi9mI+gixsrBq5KCGHRgKKRRAXdJyRWkrHCYh7
	bQdOpDEwxf5h0XF
X-Received: by 2002:a05:620a:45a5:b0:912:671b:d098 with SMTP id af79cd13be357-912671bd4e8mr2727065785a.51.1779204462879;
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba943761sm1881906785a.11.2026.05.19.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:27:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPMM9-0000000FCKQ-2JCd;
	Tue, 19 May 2026 12:27:41 -0300
Date: Tue, 19 May 2026 12:27:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519152741.GM7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
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
In-Reply-To: <yq5abjebsaid.fsf@kernel.org>

On Tue, May 19, 2026 at 08:37:54PM +0530, Aneesh Kumar K.V wrote:

> if we get force_dma_unencrypted(dev) correct, we won't need the above.
> 
> for dma_direct_alloc and dma_direct_alloc_pages() we have
> 
> 	if (force_dma_unencrypted(dev))
> 		attrs |= DMA_ATTR_CC_SHARED;
> 
> 
> for dma_direct_map_phys(), if we have swiotlb bouncing forced,
> 
> swiotlb_tbl_map_single():
> 
> 	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
> 		require_decrypted = true;

IMHO I really do prefer the DMA_ATTR_CC_SHARED flows closer to the
thing that did the decryption. While the above is possibly sound it is
very obtuse to be guessing what kind of memory swiotlb decided to
return..

Can we pass a pointer to the attrs into the swiotlb stuff and it can
update it based on the kind of memory it has allocated?

Jason

