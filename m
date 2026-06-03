Return-Path: <linuxppc-dev+bounces-21928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2E2CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 00:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVTkY6k7rz2xc2;
	Wed, 03 Jun 2026 10:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780448101;
	cv=none; b=H0i1HYQiC0cc2S5zTCL1dVRmKLawcxAnvPD9rYlMR2EBtk6EPf2LXagNkASXfGmsiorIwpGR5vZsHMynWqWsYt6QLeioNeGCJxrQHVRKCtMFtbpycgVX2R1bNy7SC1uWWaqt8KgOw3xFNhlXEenRCEwI7HHW2s1H7FWbmYEg5WUgDM4ncMWtUzjxhdBzblHAWTw4fkMupO0WQHvkXzURVrfxix7IdYyoFUx/Iz5XeA8Iol9VL50lL0p+oVJwOIkeIusfGwtQGWepXVvMwlcb1pdDgB45M+NKZn//W6w6wXrzv5JSvFHIbb7+Aet5ZJH17Vvr3lvwTPk/8mU26RO5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780448101; c=relaxed/relaxed;
	bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaeshBiUUBxO3RrRB2lmzmQW223QAbxIklkns7wvJE19uiUoakQLrLVJZGjWpm5jvs39WvEGa/UkJkBIHoM9+64URVs5Ect3FEeEDpvu4bLmgCyNj5VdtN+h21HwD6d3fEok6FA4G8sg99O5nEMzHo2hKNrs/MogZicTwgLlDVfPUGGukzJZ2zhp6uK+4iKqjsEvF4G14jJD4gZWV0gN41OS6ez/kVfVqZ5fsljWFZM8zDJtZobTidVTag2y9UtVyQAEVHRA2JJKJ1aQn/5MRTYmueA7dAebWcqb6vcMoaIc2ZpxQvIXJPTmtCIqPD7KTAagRb2dn35ukdN/dhlrmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fHfWQ1BL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fHfWQ1BL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVTkX4YY9z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 10:54:59 +1000 (AEST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-91588056619so54486285a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448097; x=1781052897; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=fHfWQ1BLip6qw+h9QOvwyFZLoU2hzLKs1PYaeRvxQWRYk5VjOlddKMxm4Crqx40my0
         qiYml0LIhAukyLddyuEE3i6KF5EguyTAxbI8OBE3pRzBxB6GnI9bv5NWv0WucVB3Bj7l
         OCGkuS4c1VTlIgn6gNFRncvQoW+Gw5qGJQ88tdg6q3jhksad8gF2lA9H1QvjBi4Sp1r4
         /4spquoiJMIq/Y+kjJRdwReFh1b9crj/5eWLwragNRhoVSuVHZnI3g3Q9JJ4SuSVdZy0
         H6mG1coqyUFO23uaBDGi/7xTI1GqkQ5bTUCmzOIyze46s4uVq9Cw8/Oj65LClXr/0ryu
         tRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448097; x=1781052897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=XKB6v8WpjJY8MmL74pHn9wh0HDF5aJI4pPxKS+q9QoUwnGf6dKKaVMHSnqkbBQhVhW
         VJGS/8x8WYr2/MMgmhP95hCKD3gAxQ1i+BAKjfU+OKtAVsq5zgwJNACXX0OgKDc8XaU6
         fzIYP/sFvPdlyLnTVXPDHi1AbRgEjcbsDHd7Hc5QZ9nkfgC3nyXY53tD9v/OfWbwhUgk
         /Cbuf9Yn2BoELVCd2nTrXP/xqahoVhFycNCHSHFbG+gYfuupoOyn/IRRmSeAsJhcz2Rk
         wLVa9VJI50OVj4C8rPfbW1G8H+xLmmqpK7VE1S4nnx1cZfqZs7DQQ1CncRwVSAOMq0FZ
         Z5yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a/oOddwN3LjFIY6h35smcQgw4MS/otbjNuYIXidynVBcDBpK0MAUTIqdr4u6UFfFs5WKIx8iyyDO9Ukw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YykqeCD2tbJ7G7A3dmckd67t4MibJ0o8c+fJgwuS69yYXHSKcH7
	qOTJon3JZ6Jpk3TNkcEXR341I/GmPGBKzbKQC/Qodcsz4Qjt8ZUac7z0PCtecrfZMi8=
X-Gm-Gg: Acq92OEBD5qf78J6QnHU+q/IbobCu6lui+8LZGWrqHMB94QjOm96G8zVB+u3yyTQbYq
	R3HS86VdR8YOhJ+JFajZESyhAoUA8nMP+/ehMar9NB8mEz/WLCQwYDHygjJvPBOPKwNpEYRc1xc
	uU1QTv77CNKIpGLD0G+OpPfaG5UxFGhQLLk7BrQaEXQ2Tro0zgBJnt6rRGNd1+OKIJEV+Pobi5w
	Q6Y19UVHQFTKc5ymCSPTredqhp9txyq37rtpsqJSFU48XtPmrxqXYpqAGQTF/XFCG2r4A9hNiNd
	LfEgL9PvRc61fUodt4otKvu7JEqZi+7Xp5ZzDmZTSizN8wKlho/pKvoA7JgEaRhyu9yrg1ntCL3
	MbJQlxo1H1YoMViSdbXEhKdu+TLlCsA+beDShMu3kagCD3UJCAbe3+6GhcDylq2lHy5tp4aRbwR
	Adh2vZR0kfG6BHyfrN930BQyBoRNcAFQ9Z4uUiBOJw4r88kR2yIfOFj0RGbzUiq/e9Y50ZOVQir
	Y6Nmm1QTJRiTQj3
X-Received: by 2002:a05:620a:4409:b0:8d1:a75e:2f8c with SMTP id af79cd13be357-9158a86b6acmr242337785a.53.1780448096650;
        Tue, 02 Jun 2026 17:54:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm100630585a.16.2026.06.02.17.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:54:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZsk-00000004x1y-3mPP;
	Tue, 02 Jun 2026 21:54:54 -0300
Date: Tue, 2 Jun 2026 21:54:54 -0300
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
Message-ID: <20260603005454.GM2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:

> Except that in a normal VM, the "unencrypted" pool attribute does *not*
> describe the state of the memory itself.  In a normal VM, the memory is
> unencrypted, but the "unencrypted" pool attribute is false. That
> contradiction is the essence of my concern.

I would argue no..

When CC is enabled the default state of memory in a Linux environment
is "encrypted". You have to take a special action to "decrypt" it.
 
Thus the default state of memory in a non-CC environment is also
paradoxically "encrypted" too. "decryption" is impossible.

Therefore the "unencrypted" state is a special state that only memory
inside a CC VM can have. A normal VM can never have "unencrypted"
memory at all, so having it be false in the pool is accurate as far as
the APIs go.

un-encrypted = true means "the memory in this pool was transformed with
set_memory_decrypted()" - which is impossible on a normal VM.

Jason

