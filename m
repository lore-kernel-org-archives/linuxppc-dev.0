Return-Path: <linuxppc-dev+bounces-23412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18872C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 15:19:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grgXw3Nhgz2yYY;
	Fri, 03 Jul 2026 01:19:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783005584;
	cv=none; b=czod0aYjdAb6Km2EC2B8FfSNGKW3lkSOzzvykWno6P5hHn3GUb/QU84RYuvefhy8ujmttFiQ3FR1LwB9Eu0oNRm2f8yG/eLjRvp2XAi/iXDt0V7hRMJ1a3cvquiupgbX+5SUmk0kEChVCw3WfxHgjdm0QS17PxjvfLcbRjhThUp2z/vNGm4giyVdQC0/CBQ5ryONU4NuMoGunc9ddSynMfzAfFZjZDdgRC/lT7anHzZ/uSlcqaLtR3QuNSl1kDDQcxiC8ds5Af7JhbaYNWOSneFvT99eU/cM4lJW3Xo/iVni4U6Rxot3pr5Vf1jtkD1k53aQWNsrcIGCXgLcYoJspg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783005584; c=relaxed/relaxed;
	bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLY04s463vQEB/2K4pO8YII4tZmzrxgp8f9YzoNB618xe3NJxsAO/wU7scm9rlxNJKLmCFStVWZzgQjpyWsSDBweQOsFHp4VH13a5HYD6c33qRjW5WTvVTFMThWfd9kwUzrS4fVaQrDDK9gXo6Z80HePptsHlEeR6FdQ/NswkgxDXEGr7+U9ke7p5Fo1MxyQRcQcacXZyjlTGy+5UhX8ODdg9unSliBZYBeWWgTwxkyhjzYTLqt+KxSuRoQaZP/u98w51khHkniY6JLMfn75L6DTqmEU7GBFyOpHKc0SzTaQ2a8atpgDsy6qih6HkRNR3J25NHQcBPjNspFjWIY2bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pr0lsy4/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pr0lsy4/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grgXt41Wtz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:19:41 +1000 (AEST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8f29ec73064so11895486d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783005579; x=1783610379; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=Pr0lsy4/URTgFU2YiHApVRjHucUlw9vL4KSMG5g9kJwd88DhJFjwGOubOKSIbFm3es
         jShslPC+/oNLLHDCHIss4X4LlmWrZjUC7Z2f22g9QL0rJk06KsuDdmRzKYzos5CB7vbA
         5IYqUq5KIvEtH+t19asmB10bmwlcCp+70Qprp233RWsVeJV5ytCWcOTXiFLBfOSvbnf9
         gJZ2xnThIGGXPNdltxDX2VY5amBsVnhW1twQzJPQYxWDQqfXShYFdlplRQ9hVlX4Pb0A
         FzSU5E79Ar+UHyRF6fZN671G1xnGV/OfHnBrzbrbDar1mvqEClgA5OnDF0YtLEGPwHPF
         0gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005579; x=1783610379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=una0b7iSQE3/1X7UfiBFNzSBZGQVECZybRvoQUF1H+I=;
        b=OmtHHNaCJD7PdTT82BF8P51s+juQXMA6/hqvQEQikXukRad5/Xk78uLth4mNKxxUlI
         d1EepUVZRRIerEJOopK/ZcibWZJpba2aA3Ww9c07HnX++vGQSkAmwFjm7jzLKxpg9cdC
         VKpwEydyF+Sl+2XEVBNUlsFnbohbKs7EaxUVqK8tb2fTybOy+XaA6T0h0ZQ22T86sjVF
         OTcyUdfV7tyyB1no/Jfc+3AtbFB1Rxa0IGBjWbVC3EhdMwo9H8ODeL3GgRt5N3jyiy7z
         I3umQmK17ajxsctIy2lvXyKdOhgEWNSprT2XlcT/miSqZMZq/+qV6FA9s+5w5nTCrPhC
         yVsA==
X-Forwarded-Encrypted: i=1; AHgh+Roe6gX0a8764AHzrcdSdnRNfCVdCF3bz9dKgg3dNcT+LIKioDS5/hXYh3phJLV5Mw0UjA8sn5shLoPG52I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4MK8yaa1yT9Ty6fbgC1m+zk7qBoW+p5ncCbqOOlv/jvBNYI8a
	CVQHd93Zj7Xlj7hU22XJ6IEZ/8wwW52bx5tfYwwknRvzlagu0XEB+xw/s01zkVDu7n0=
X-Gm-Gg: AfdE7ckbqSUBDoapWWql2OQkOcgkX2R0/8Ki5QIDDit594MkTEmSuuq139oN5HFiah1
	hUOlEMb9tjMVTTm3DDnQBViNSFMluoJLBsDH63ByjwUuq1wCJbHkEH7c3r5wflSOI14DBAOryeJ
	ju+sUxpIoCvlfkgIsYLpXqSKTzN/4ldhV9NKTFilj+SUzdvFzATw1CF7JRoXPzpuCXSzb7NLjm6
	JBCuYM9Zr9pmvbvvJStgUhQbLlxsX2Ny1qfLiEewmhlm6l+AD3BseclQgDAaY4jQuC0lQLFWNMD
	dHZUZnjKc6BNGCURgJgJilP/cMI9slUEUaJ7UXZeQ+gqscKSxY8tbDwcnWv647DkhP+nRzQuuDH
	gjLPPjbSx6YmoU625lelsq5hosVWR5B7F4/DEpOhxdojQX5JQ66/4apzdbnCkz0q/L3VB4JAxg7
	EAL8yTSB8DZfiOaklsztkHU3WtTXsXa8EsWQ+YFTLmvScWEWqzpX5eCTOtemo+K7FdqDQ=
X-Received: by 2002:a05:6214:4208:b0:8de:16a7:fbe3 with SMTP id 6a1803df08f44-8f3c863d139mr68985636d6.31.1783005578597;
        Thu, 02 Jul 2026 08:19:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm27985376d6.34.2026.07.02.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:19:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfJCR-00000005wsj-2X8o;
	Thu, 02 Jul 2026 12:19:35 -0300
Date: Thu, 2 Jul 2026 12:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
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
Message-ID: <20260702151935.GR7525@ziepe.ca>
References: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <yq5abjcro17x.fsf@kernel.org>
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
In-Reply-To: <yq5abjcro17x.fsf@kernel.org>

On Wed, Jul 01, 2026 at 08:39:06AM +0530, Aneesh Kumar K.V wrote:

> This is the only code path where we need to special-case host memory
> encryption. For this reason, I have avoided renaming
> io_tlb_mem::cc_shared to io_tlb_mem::unencrypted. I can send a v7 with
> the above and we can review the changes based on that?

I'm OK with this

Jason

