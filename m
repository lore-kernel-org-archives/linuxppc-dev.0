Return-Path: <linuxppc-dev+bounces-25617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD9C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 18:01:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGsQX1q0Vz3c7d;
	Sat, 08 Aug 2026 04:01:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786125668;
	cv=none; b=TLjE84llah2ZhYeWzY1/te5cShaXp2khZTuOJUGLWS+GQrZ1epw7IfvBDx8uU1Xj0zgnE+2afCw6Dsla3R3DAs1jaMoiSxH9cblR+lyoPr3T/pfOo4KTRZNhm6ckp/dqLTV2NC2g/YB5wdyTCD2v6OHvWmxZ3PHWspNI0v5qvy6Myh+CuNdh3nE7ZtPTBlqDR1NItLMzWL+7lxw0QTQDwcWg396vm/0D/BNq7axgii57HcXsR+FHSmr1U/RifBtcM7Vdr4N/dcTZbtF5f/VBhC4RoilTKKznYVlIhhhjaZa+B8Pz9n6PaXbXxn0guF//hPPJI4O2Jj4AQZueYVX/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786125668; c=relaxed/relaxed;
	bh=9M1k5SlL5Su3vC0BTK1X+EZdBDJQy7Ds7MO/9dG8qvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NV00ZDMoHq6a/jgcJeRi+rqY6Hep3Ny1W4jtPFnXt0/6+wt8Zn0L3BWEU+PsBavHCwxtogsbWloI2AcO5/No0u6/pVL+RuOdZUYCESrBDZJIs2glwN6bkHE4iASReFgkFkcK/pasQv/nzHoQDjKrCcUG4Hih1o24oZ6gjRfjyaxkjxqD4IEvkKrn1be4C2eSeeM6usrNlWPyn9HaWFB5KaKlMlHnHxdihmq0xlz48aKwnYwaJKozLodJee7qT6xKlqKy+JOw5jSOfwdmg2+LprvDN8A2aN3I6DIEcIdCWtZXRrbFRbjGzoOtWVEk9ZFNGpP4XCZw1ZTDfxzV4uePIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2KP1Buw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2KP1Buw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGsQW4jzCz3c7S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 04:01:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C272E600B0;
	Fri,  7 Aug 2026 18:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6464F1F000E9;
	Fri,  7 Aug 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125665;
	bh=9M1k5SlL5Su3vC0BTK1X+EZdBDJQy7Ds7MO/9dG8qvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k2KP1BuwvBL3uUlPBpKv0J0Pm0yBgEOZ6G/A5UhKjJIS+jWDTjRG4EioD3Dp2//SZ
	 pY8YHcUZOqaotakwE11W09YnuJjVFeJKAhYBTL2nKs0RsCS4wzvHV18t+XmOetroYJ
	 gnqCdm82zmjLjAURA7aPUN49jhWtqEh6LSkkoML93+Nzloet5QKfiQ4StPRY1bvESW
	 ActGHYqTISBAKwDmrPW11A0MSURZGvzkWn3qPoAauu57PTvP6AWMOndXhEZvcW97ck
	 mtG/lpXbVMiA04jqQx6iI0gySsIUw2bwnMvuXuIl3zkajdZDJUAtWIfo59dTnZF+vf
	 hUaHTEP+kpSMg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected guests
In-Reply-To: <20260807135810.GA200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
Date: Fri, 07 Aug 2026 23:30:51 +0530
Message-ID: <yq5awlu1yfn0.fsf@kernel.org>
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
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
>
>> > I was under the impression that there is a possibility of using swiotlb
>> > instead of restricted-dma-pool with pKVM.
>> 
>> Yes, that patch enables swiotlb as a possibility for protected guests
>> but with your patch we avoid shrinking the swiotlb buffer even when
>> restricted dma pools are being used and that's a waste of memory.
>
> I also thought we switched pkvm to use CC-like swiotlb as part of the
> alignment in this rework? Mostafa ?
>
>> > If that is not the case, then we could change:
>> > 
>> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> > 
>> > to
>> > 
>> > !is_realm_world() &&
>> 
>> Perhaps, or you could just pass the swiotlb= option if the defaults don't
>> work for you. Can you give more details about the slots exhaustion you're
>> seeing under CCA?
>
> We see badness with swiotlb too, it basically doesn't work out of the
> box if you have to use it 100% for real devices. It easily runs out
> of memory.
>
> Auto tuning to higher levels makes sense to me, but I'd rather the
> core code handled adjusting its size to the estimated need, not arch
> code.

Agreed

-aneesh

