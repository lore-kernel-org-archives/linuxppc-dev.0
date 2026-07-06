Return-Path: <linuxppc-dev+bounces-23665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82474C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 19:52:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvFPX1r80z3brB;
	Tue, 07 Jul 2026 05:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783367536;
	cv=none; b=lm7DHWAQJPI5rSltxZlveEvL2lEJA57XYfGHHoxJKjlKvQzrxiQT64fLoq5xEUww3r0wo89FPM4TODQWcE+7kkG6E9Ip4jdT1fSij9CTG+5N1+KCKdReoOsIpT7au1Zn4eZBqKuLZxX6RhlCqzro5v+jSKSNR87Bz90KLTxMK3mcxDwNMum8G5df1WsohPg987mdgrerlFgrYJKsz/QKLnQ+vpRRR0bMc9Nb8XEhAvl99QQJiYYam754BFm6T3cRG+1u16h/sezYrqzDh7WTqm9vbq5QRJox51h9Dd/OBnAjxtniYaT8RCc7ooJBA8+5sLC+fEf0u21mqH82MxnRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783367536; c=relaxed/relaxed;
	bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm3i2VazZddzoM2cJn+R3QgZkRj9kNLyHBpg9JSuL98wxqv8Ib8s7rvlroip4c8IoJ+OIm/xUrJFSGb4rpigkfI8iv2YJ3ZY6dF6hVk4RFPn88ECOkUmO7m+nR/XOJsiiJ+eXknHn74/K82uwINY9BP27GyVk/5rmZDMu3sWrRg+bJqLjAsX3fqZHl4JuBrsgA+3cQl/jPFtKZhO+1Cfd1jOINL3xQqVCL5ftEB/1NJo1zS++xpHY3jjq6F4re5cStqYceLiDFMMR6fAo51jtO/1K+uJhdJr4XpbVy3QwdgIDZRLouZPFfThBa53QOPAh2Dbw8zKia6fpYEQ3kWHgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fagZMPc/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fagZMPc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvFPT6dzkz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 05:52:12 +1000 (AEST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-92e6a434cabso173477385a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783367529; x=1783972329; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=fagZMPc/5NHMkWxNjxfYfSb5EZGofQgd+TC1q5/a565nQdWnwFvP03vlf/BwcAUopr
         Gd+O+oBd9fQlZfChlLKE3nPB9PN49dRm8yIwmsT+WZbeuqPYwnMNKXVF3MmEzkG4yDQF
         VsMcC2Wbro69wqWLQuzTjws1e8f4HhWYkw1ryjtyXTIzw4ZxdFLgB2yu/xcTPBTSwRcL
         ol1Njr61N5lNBR5rILzNiqTX3DiZWclA8qGUNk9TKtrCST37cipvGUKivGcddHkGXN4U
         DcTv4yRr2kUA1DvzaVsMXeDnt5fOG+hHAdo8hsstRUMIfzEGnH0KBVkEiF+6rF/MFWpD
         9kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367529; x=1783972329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKPpU41kPhzJrO0I4v1JFTcP1rq+uvMCyjdGLEJkQ9c=;
        b=US7L+VElAtvjxfVf3PGaIo/uZD4qJNddfmWtfGjfLfQA/A4YRrR4XU4FYitbt2N9Jk
         M/O13KdBkCxM+EkszYkHSREG1TvagaBAHLPo/5NXuW0t12SV6VdTZ3zsTb3DFt8KlnxE
         4+IbnwHfYjymXf4Tbc3EyRZnFJcJnhXK03cqHgZJaXMHdMU0KbFrla1AjqTH9jh9i/jH
         KIie04F2T5HycPjMGn8qvrZP2rHZ0rI9rJuLPbElx929elk6iH3K6kkj6R4s73JxEJwe
         M0Af7NHL+rGwsA3fvXgYozVhONlwWjwI8yu3IJ55Uch3A9vbB0hB2kLzejA41NU/WtmQ
         fZMg==
X-Forwarded-Encrypted: i=1; AHgh+RqZ3SVSMymooFksWLcu5VdC6HoJXDmLYw2SVYfBSVflN1RjJkqnfE6pobZxx00Om1CtQCYI29obwEMpqpk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUlQAx/AUYvWoO5aGvfzjOmx2G01fzDZCxafumqK2q+UEV5NhY
	RrGqkXV4fNWIBRcDVnTqT+6L4CoUuWV5eYgPhwvqUe+kkharunI/n1XMjj7IZTWFknE=
X-Gm-Gg: AfdE7cm3q5qe6iQrZGsg8uv39FXKgz6OVthpS7y6cpnkvJN/kQGCovjE/4GLNsHjmi2
	duLRA0/QKubyZgB+hfy/6e46RaUgmPFQao9lGkeTegy9l28DhKgMDOtWf3sHH9mkDN9SC430kvJ
	8G3EXaspVB1WQA76s1xu0H2RMYbzN3Wm46CTLsetnF2gAQHSyEPBwEdIippcb352yW7kzZnEaXW
	Szwzmp/MTvrDQHYXHovUy8FKNv7lrCfz6GPCDhclwjZYhavDmevfogpji5UgcyfvgJwzHllCf1b
	t7j54jszKkMBIEoe0wSFsSePJ8DMhYvcDa55HIDdQYzGLIRMIVbx6z0MaE2YGz6Np6tPbEiIRU3
	Oams2aP5eAtcJCzUWO6tZaoD0XWgDIWcB1YmFJEVXsl1apCcEc5y7Qgs07MHa
X-Received: by 2002:a05:620a:2911:b0:92e:70e9:6865 with SMTP id af79cd13be357-92ebb585521mr281465085a.59.1783367529434;
        Mon, 06 Jul 2026 12:52:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm972606685a.4.2026.07.06.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:52:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgpMO-00000000etJ-0DJM;
	Mon, 06 Jul 2026 16:52:08 -0300
Date: Mon, 6 Jul 2026 16:52:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260706195208.GD118978@ziepe.ca>
References: <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
 <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>
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
In-Reply-To: <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>

On Mon, Jul 06, 2026 at 01:45:33PM -0500, Tom Lendacky wrote:

> In that situation, with SME enabled on the host, the SWIOTLB must be
> mapped by the kernel without the encryption bit set and DMA addresses
> must be provided to devices without the encryption bit set. This is
> because if SWIOTLB is mapped encrypted, requiring the encryption bit be
> part of the DMA address, any device that cannot perform DMA at the
> address width where the encryption bit exists will fail to DMA properly.

Ideally there would be two SWIOTLBs and "decrypted" aka low address,
one is only used if the device requires it.

Alternatively we don't support this questionable security choice and
using swiotlb with an incapable device just fails. Use the iommu, or
don't force swiotlb.

Jason

