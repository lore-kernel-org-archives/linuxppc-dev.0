Return-Path: <linuxppc-dev+bounces-22061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2972CCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 18:24:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWXyw3v5zz2yRC;
	Fri, 05 Jun 2026 04:24:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780597464;
	cv=none; b=Wv+JBodSyan4Eo/XBUmuX5Jt9iXh4YetKZVIvJjhlpeMiDdV2n1t0UWagQEgGbeiCOJRmVSX5eF7jxIHH2m8Yvp2uZjMn3Lv+H86Gvv2hcARU67Q9TOTjvIE1TAJlVPSi7pN5hKfE/pdeQrkWzC4ctg6euSX9Sl7GtiVSY7SqI9R3zVZApiytugJRbg/GYZ3mL/7fNkYBaTq++eu5LkXpGsAMMx1boCNHfTYC3HnmF3DCr2nhp8yMwyAaa3EALJ+svx3LiTaaZgoVvTxiYTgFnk6lgiaxDkVKih08S18ubHgrUE72fBli+YYGxgkdTuEXy/su99sXOL7+wmlMDybfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780597464; c=relaxed/relaxed;
	bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8FL6T6rGMUMkWXF3eLmtZCUuL/cozwOTpKzsk2CJo7ldoE5Ynsghb6mkN0RG8WYnmfdNanLk8m/ENPbDgjm53lbiruj0UrOGMjqd5CcX5H3LIuOZOix6+WHzfc7bF4C8aDNTo258RYL/Gi4HR5OKymYXLwz5bl/2LE8KOnYTAsDnzSizKydll4ZbZx37cHwIRs2XvTnY5yosuNB1ANQ0FsTXNVrdRJg3CvTbMHwr3aLrg8VQiqi/SGVWPjvG8yaen2+BktmAZaI4mXb2H6mjW0uAiG6KaZkaZ5acfRiz3My8TnAugbK+yN+rO/1GtwLuh4S/rMCnYl7YR1UBa2JaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=J3n2fyP0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=J3n2fyP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWXyv2trHz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 04:24:23 +1000 (AEST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-51778077b28so11330471cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597461; x=1781202261; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=J3n2fyP0ojIk3OgKT3qD1WWhMhGrpcfNn2DNCoWtE8Oec3Fy4dxCYX2BJKlkg+ebvN
         kaRGNEF2gHCR6tzelmpoiITKGx2wVeGGPD9yXCJti5srsvq3/PDsvA2kw+EtR8ydsKOA
         sHqe1rSlVlUjrN5w5AB5sOfQu71UVEGvABIYPrd2147rrYOa0iE616U4nldokiaYZw3Y
         6r+UuqVGCVakCNYVPzm2FemmfoPs0/59N9rCHys/9GqqiJ4t6D7/5AosuR6zOw20NDIO
         pC95iDQHGgp4PerfdkzhGQXHM+jmfZKWP7920yt04wFvjiA5Mp7nsxYRPacCRZa393Kk
         8EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597461; x=1781202261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=XSEi2moACLCK3ZcuGEctIrMcHxXcLxiXNx1o5sWZ1xj4AJDvmdkYchpVWqSpeiMFnZ
         iVJ/V6ffI6nybIxhkwDIL87NiODiU2256ETzXSeGTID6C/d5kyMhx2tf1ZBLZ9tLj5XL
         WJ1bwOidPmRGnv0bvnw6yGBreW602xyaGNimrf3EOZ+DcVWbwuv+MGkJgVPCxSIemPA1
         +i6w558pDISwn6imGt4Y9PgCS5JF6UYtHqICcJPTAzjfoOValAFW4KIzwkqjSR7XDAO2
         jMSh65h+e2mALfQ2XjhHpS62IePAUrWnCvwd4dUdXfKYSJQL+I0u2njgq8A9DKfYThvM
         A2rw==
X-Forwarded-Encrypted: i=1; AFNElJ/aOHfLOdw0yXlX4rok34bS5oL8RF03ngHKJ6c7SInE6/hdJXEXbZbA81rCh/PyE5XcHJ64zUBDi9v4o10=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDfnzZzHKGL3MFIp8cS4bfcKly+QC8ir0uR6/2NK6qf0uBZs5g
	85vatmNrXsMK3f7aOzVtoIa/Sg6k8m45M1oq29PrbmRT6sFd14Tf+7PuQQzM1vPa888=
X-Gm-Gg: Acq92OGhpZBAeQ4IXsFDy5wVbi86iAkCk81Rba3Crm0c0zk1BtjgpGLwrfEFXWaMwyE
	uRN5W/Z9cd+KAoUFUgzs7THjXTyaX/UVBjTj3Tghpe3Gzd/5vHLSNbUlZfeny3qdo8V0I3csvll
	CPupCwf5Erm6W1JK1Xk4+LAX6+baaGa+L0zEHnMVuzeOB4qr4/YIhv9/DUYfUdS3g7z0xZu/BL+
	+OICoxh1IiHtzkDulZlk81OU0SsKjluMghfbor8/AiA2GBBvQ6tUe+Ln/z9en6S76xX09YhYsD1
	yER3KbEsw+bzPPVAbht0kMyAxhFi+H8Ue8sq4HLq2s0mgHCjMWmWIM+/n3udrOpA5WDwxgt+NO5
	u7GBAxxtaT7S46VMTk/dr74HTkZ1zTiRlfC4XfU+C1JHKbmcA1dWBRmrYWtyCMJtTVdHhY14xcH
	EoDXa23MqnKBWrK5wkC8/xQI8TzPgySWovMsI5ZOcGg9bY5L10FkLsdVBtii2vg7gJV7o1IS4Hu
	w8GRnlDZRuNXVTc
X-Received: by 2002:ac8:598a:0:b0:517:7277:9362 with SMTP id d75a77b69052e-51778751a59mr126094041cf.48.1780597460764;
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dd2e53sm57509021cf.24.2026.06.04.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCjr-00000008f4K-2dN0;
	Thu, 04 Jun 2026 15:24:19 -0300
Date: Thu, 4 Jun 2026 15:24:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
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
Message-ID: <20260604182419.GC2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5apl26qrof.fsf@kernel.org>
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
In-Reply-To: <yq5apl26qrof.fsf@kernel.org>

On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
> I already sent a v6 in the hope of getting this merged for the next
> merge window. Should I send a v7, or would you prefer that I do the
> rename on top of v6?

I think it is too late for such a major change, but this should be
imaginged to be for rc2ish next cycle. You also have to spell out how
the pkvm patch will get sequenced as well, it would be best to push
that it gets picked up right away.

Jason

