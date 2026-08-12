Return-Path: <linuxppc-dev+bounces-25782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6308C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:43:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKwnQ6G8Sz302l;
	Thu, 13 Aug 2026 03:43:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786556586;
	cv=none; b=mCnq49nJxChc4+e41fXhJ9Ainzu8mFdDZezzuP9QAa8lkLbBV0aEuEXcFmp+oGZ+rYriSUKZwFeKMWC9LVaHzJTdn5iVt/6csZqsDJhJxzHnxBnZw3xyLh3fFAnjf+kFfxs0GJNEE4a+IwFrNY52Qo784UVkIG03R3xyCbrn7ZcXuYF4Ltme5ZjAJyE2j0GBpTjq7ICjdWnC8N9g5Um7s7QW2Vd1kVeo7lbIk3pnfPbBNC4C8BPf4NJSG8VH+8yqDnYspu9fNKgch8N6koZhCrQO0llLIJ7+A1k/LCroqS1z7Ge/t8XjhsylKlUkiU5jlX6328t1Sn5fYu6CgksKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786556586; c=relaxed/relaxed;
	bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnybkHky/HUe+1cRon0NzxYfJJ78jSkDNo1a8hpxay6DT+40CYHnrzM6McGoB+yLuhgTxzs1tiTW5410rWRDLXWx+49Hk19uPi9Ym16GouH4ukfMw4x2AOLFL4SO2wzqxgXl4I1nXV7atYPmXpi2yrLGwV1Bi5o0j584tBlgDbQ6YmQfE8NE/9TIeo9uNzAjzNuqJ14j5iIKVA4VQoJ11gvp/U/y0/IZyaGtF7S53Ijr7P060YReaAtz+St6OFMLv4XqkEYpZ1urNv1amyv666KfothRXdgt5K5D/dreXBhPaoyOBORVA1od9TWbP+42bhCjTffZccGFoLJEfOF23g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=blT+udg9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=blT+udg9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKwnN3bMjz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 03:43:03 +1000 (AEST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-51c16ac21acso8369981cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786556580; x=1787161380; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=blT+udg9dtGB0udEqeNa9/G9yqDdy5awHZjD5vwHrrosHTyn10QR9FnnU1DrVkb4eU
         wCeelpkdjLGrc04XUQ1f7keIhNOu+6ASElKChu2LmhiXGDB8yTbWzHduZ4PaOpwNceLL
         yPlFfal6f/dFV/vlRYQCM/1kf2cclVj9mAv1xaDhkqr879jjZjDp4uMoVzub/mQf2H5Q
         scNBh8TJItBE1ZnOeuyU3b4MSHWpoZ6XoYD1r4Foehb70ZWi8M9Qb37zhrzT3Vq4cPyJ
         QN3z3Qt4e0b6vbtoi6u2N0MLcAivMYQQ2fIPEW5/9PuoItPrYObaLjBD6RCc60de2XOg
         l+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556580; x=1787161380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=j538Aax25JmFbAzGDPrGb9QcsorcKp0YmlwD/IyUPO/CYywuQgn11pGRvEC2NbxrqG
         TZ3guhWNeBd7S0nOjsqOwc2p0FCW2YJnPWjrCjvHWeLklznWgB9042bER1+EpJABZdXO
         Ti4/VqYlmQVb3m459EuO1FQil0vePrWW1hNBc7WjXst8xMo1+sIPR/EJ2TjnQKWlXDEJ
         p17NeCDAWiGBnYy7f91XAvWQHHDppVsruURCjyHQdBeey/XWqXXY+iUGyt/A2rQCHI5P
         isuRN+nXiy1LdQFecb2ZF9U5BC/Wqw0rHwDCVUUx18MjKsmKDxNzsB9HQYZtZcVtBTT7
         2Gpw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9/rAycc/p206WqldHI95gbCr0UxDRn3+P/XYya7tQ4cCZsnEbZQX/xER25OgXBK0Sl4hUKOx+j0urAzA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqLGV/4O80fbB1el1H37+3yx74yGUFXro72wuFLcL95yPW6tRX
	wjKxDW5ojpbNV0+ikOkw7JqX+2ze+J8FeNE335foBwSkM17I6ZtOn+55uTzRunwxBE8=
X-Gm-Gg: AR+sD109h3nGxrQvubOrphZy5S2WL0RYb3hgQS9T7j6jMMTnl05PDliJKlsmrpWgDD+
	a9JOzHPcjIdf26BPCV/uQMeVHqzdTewCxCIg7kL2EmTpGlGOwaHnvn1xkkUEs5A34Pbd0wvyYOR
	7sqCDqBP5EbRZ3Mf4/l9PYb7NfKMZuaW1WuAoMrW7VYbzuRL0pvN3ue26QjUjwPj2uqNMsKvukp
	ALNCebitG5jCHzY88Qspx6NynXM4xBhb7jBedRniJiXL8icGD4mwakbYMzgQ0wBRmybU/UFussF
	WmxsKAf+pZ77Sg/bepOVJvfUAKsy5HHpMGyTfWmXcCupksUsRj/3JYIHQsJaGZ67VgTpZKPv2k4
	12tomZXndGsma4J46vjty1jZGggHy1uOufd/zVI3LsALPmLPWJxa4CjktZR+zAExXkzDFh/qWpS
	X6RBv1ePW/JccXhqfzUFzy2eCpdwbJx3LU7oEQvQ==
X-Received: by 2002:a05:622a:145:b0:528:38b1:b54c with SMTP id d75a77b69052e-52d646a004amr57067221cf.2.1786556579927;
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61d91199sm22262711cf.14.2026.08.12.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuCyg-00000003IL0-2V6p;
	Wed, 12 Aug 2026 14:42:58 -0300
Date: Wed, 12 Aug 2026 14:42:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <20260812174258.GF662699@ziepe.ca>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
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
In-Reply-To: <anysnQFVTO_RAYxp@arm.com>

On Wed, Aug 12, 2026 at 06:25:49PM +0100, Catalin Marinas wrote:
> > > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> > > option in realms?
> 
> It's still not clear to me why we went for CC_ATTR_MEM_ENCRYPT instead
> of CC_ATTR_GUEST_MEM_ENCRYPT.

Yeah, this tune should be only for CC guests that have the
shared/private issue.

The AMD SME issue with the address width on bare metal is an entirely
different problem that would need a different kind of tuning.

Jason

