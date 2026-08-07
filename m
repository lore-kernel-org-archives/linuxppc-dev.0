Return-Path: <linuxppc-dev+bounces-25608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF19CC2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 16:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGqnm6bpZz3c7K;
	Sat, 08 Aug 2026 02:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786121260;
	cv=none; b=LFbwtBF8NC54wTTBANDUAqQ6/P8q91QQY8FXJc5ncMS4Hh/D5Wo8t4T6BMwGdT/G8ZiMhk9xBkFNvtH8FE4o2k+AxbVhEBGkEAgSMTByhQmfHuOXyAgHrIkcVxmtoJVZ472t0E3eiMUQONqPc4pvxCQfhEcpOzgF4OZhm1Qw7cQJpVk47nl8fENFpkDdbogpHbyiqpCv1gRVej+DqyReFppuOk7KZjsz3zQ0vLklo+UNDxgUaZ46du03tYaIUCcmzrUbuOC7Mkd7UPGQHw/SdDnm/ujFLIPyIZcu7PG8T9aZr1lkAxAJFXc3j0dPn6/uN/upGYooVsA1/wzy11TAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786121260; c=relaxed/relaxed;
	bh=+gWaXZ9+2O+1F3TFyj+8MDOiIFSD+n/ei0pL8L1uFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzW/pd5nyRAoDMPt31SjaVaXoCW+Y2/RwfnJkW6ty7EvBkLPliy1vtL3gjapgrHaDBHIto9NQT8b2vzgFn42D/TH8tGC8B73riKalD+j94v8Bos7vB+9zNShNzJfDCC35OWtuZwNsh2b52g6DlGdWJLrhFYVm6444hlluYE1kk4MZ8M3MeJPYx9IrML1Whj2bQT5njwp7FTLYA0dpt1MDLgDpiNO7YnaG6dRpCIXhKWyXBSFojrMKc05teWu8nEa4OlXbLItnWYQwPXdIZEe0UUAQwmH8FQNq+ER8SHq1+WVAuQgxhEt1wxG2VvK14hA17V/QTXHyjMAi+ZcpqrWuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LATZf8IK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LATZf8IK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGqnl6Xjgz3c78
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 02:47:39 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-92edb12cdf2so237112385a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786121256; x=1786726056; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gWaXZ9+2O+1F3TFyj+8MDOiIFSD+n/ei0pL8L1uFmE=;
        b=LATZf8IK+aFtaPNYM2s+m6xQf/8V2tNR57OEwvC0sXwFt8aHFUe5NJjo7W0FbqmV9E
         xFSQ8TX24TGXCgM71TQLSB7KfhcFWt9IbHtwBGq+AC8tITCm/5dlneoNedv/wKIWIqce
         1DGSGFIYnV1AjS+NRehgG7VHaRR5mUd4CfjzsPn3VHxkwhsD+5wPlNXvDr4SyhK3MvxO
         03Gf1CRIxBcnaFVs06RMaWxyAIq9Cui1oZB45ddJlwLr+qjfntBtPbutN45aCij1zHKe
         e0bjDAEarVif0zsal76ZSyiCanq83dL626hYz0GI/+NSLXzAMCGv2qwl/FD0bCw393Bh
         OilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121256; x=1786726056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gWaXZ9+2O+1F3TFyj+8MDOiIFSD+n/ei0pL8L1uFmE=;
        b=YNvjEqnjrBd0ZacN6V8fjnky11OysISjsYdXOzrN8RoFG0BfC1KQ05SF+dXHY2tNme
         zXQ8YBubjwe6gyeJBfm/FEz88kVJQPoO+jWV+6dtD+FEUD4XQBI+di6IvfUkmWg6EuKA
         Zdr8lAVynI8dw7bR5BnEC7g4eZDJyC0HlzOOFSZwqXQ0mxw8wmKfVgAraUjDI8gIEvfV
         g3Ly3sS8Xv5XxzTgAOc3MoS7nn2k24R5MW4+h940+X8AEhSdztC1iY74vyJn3okmBnYY
         5YvEXs/57MxmbCJYpmWc8tROrdyzadeVI2qt/yrLNa3gZAJf7g9w71ge7huOOHKOsFKZ
         hrFA==
X-Forwarded-Encrypted: i=1; AHgh+RooapUEpeAnpV6qzzauWOfd+JgniXdWbX1XwPWX6UxiRkob0o1tM0LAQ/E+OksfxvlLYvWU1Mv8V5xAB74=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyReshtnCOON7P2MaNEbtTI3r2YBwjcJ5/U4xuJjPUxDS10iPj9
	aVXFdIDi6dFtbkW4nEdmaR6xe4Wd2V17inrjwFSJtqYi0tmSL8YWNKsp+PfWtkcAuIU=
X-Gm-Gg: AR+sD10fhgG80UB9sxn0X97J1tO+ReysqJ9MIXHmuM9et1y8n8ScKuNmbCDfTkQxr7y
	e4B62f4W5ajgj6gEUrYvFzQXcRPnIBac7ZgZIu12eNkbl1Tj+ganhtLS/i/urSUINcIS1yLFM+e
	83BwcJjeHBa4d1QfxwWIOgMJtZAZG2zRnWxbhIha6R4iJTa9q3+sx0Zd6+tzj2370W79I8SGwXM
	o+yUdBQOi7hEHF5+gYAMMMp3DVTRvgDY/fpO8PmI0yHB9HTGX6Qw9wiFaC5xIGP09vsQILtHHKc
	Y7cG8O/N7J9mF9MjViJMts1JenpdB941/K5jRvcTIJO0ot7sINlLHzLbCHZJyW9eDAqrwdQilSQ
	+vfTb27YPnMWKvRFQuy0c+dgI8cTYsa9d+3P5nQ+xKtkjM/gIdoTWUoR1CXeXNRpaqAJrEKGamE
	bs0cuLwqkq4DlTmArLeVdOISz8LcCydFbR4lRoZcIzWiU+rZiu
X-Received: by 2002:a05:620a:2849:b0:930:f2c8:d9ea with SMTP id af79cd13be357-93671f33f9fmr432093385a.41.1786121255653;
        Fri, 07 Aug 2026 09:47:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03ed23sm187954085a.7.2026.08.07.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:47:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsNjK-000000014w0-1mQB;
	Fri, 07 Aug 2026 13:47:34 -0300
Date: Fri, 7 Aug 2026 13:47:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
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
Message-ID: <20260807164734.GE200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
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
In-Reply-To: <anX7F7dnKOtAOIIe@google.com>

On Fri, Aug 07, 2026 at 03:34:47PM +0000, Mostafa Saleh wrote:
> On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> > 
> > > > I was under the impression that there is a possibility of using swiotlb
> > > > instead of restricted-dma-pool with pKVM.
> > > 
> > > Yes, that patch enables swiotlb as a possibility for protected guests
> > > but with your patch we avoid shrinking the swiotlb buffer even when
> > > restricted dma pools are being used and that's a waste of memory.
> > 
> > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > alignment in this rework? Mostafa ?
> 
> Yes, now protected VMs can use the SWIOTLB for bouncing. However for
> Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.

Oh? Why?

> However, I do not think we should over engineer this in the code,
> swiotlb can be set from the cmdline and now through Kconfig also.

That's fine for android, but real users buying a cloud VM and sticking
a distro on it shouldn't be expected to have to mess with cmdline just
go get a halfway working system

Jason

