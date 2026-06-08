Return-Path: <linuxppc-dev+bounces-22186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7500CCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 10:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYpnb69PWz2yS4;
	Mon, 08 Jun 2026 20:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780916051;
	cv=none; b=a5CZNxYwZxiQGec9WiWgKKaaeZPYB19zUP5itBOM3Eg7jDFTZYns3OaG375NZFs24g9AdMtHPR+7FqSyvPDOLLSifwwKOHipcAPG90aCPkX7gNh/qlF7HzQ6xXSXG6uDu+xIGr/Q79rI0Awaqej4KsYi1R1Ov6bY23431/BnOeL0wPat7qKHZ9lYPf7Dzcpv++RqCCsbG8iNUMpdSszuVVE3MDspXB0BZYJ9xet7elbZEi5GppZk57wFnJ6GcrYlE2iVofKg92BtX7+S8Kkn7fpT3gSHik+ewxkV2PiX9u8rd6nCJk9TX9yEVU804vp8tYnRfwW/GOHY8h8pzxuBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780916051; c=relaxed/relaxed;
	bh=plNYBzzaUu+CjxUfVgmwKMU0d70IRGPw0rK3BmwuPjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=amiaTKjQuDO+JOZJ4YDxRgOgpghNbN8prxcPiPpGd5l8EHsr6ET0keEaKwCB4IAN53IQICUkktWZJ/5fhtl+QSiJJ+01iGenb9DaVzUMKdzEXDg71yoZUZTV4EMkIbrGJ0pN0wRXU1b36xc1HSsBLUHxTMicFayiLtDdEI2NSHU4fKixOZsk0B03P2dn/kOjNUpdrysEh+WWgTLFJa2isT9nohZ9qRS3+qAbvncdV43/Xp1x1O0f0Em16/ESNjCLqllprM35COJe2DdOQ0Wtj/gw0Xvf3uxC/Qu7UE13y5mIR0HVeuaKRiVKtGv5mqpGDEB9lILqTkjP6MnxUhe/Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=JoCZ/WKI; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=JoCZ/WKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 547 seconds by postgrey-1.37 at boromir; Mon, 08 Jun 2026 20:54:08 AEST
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYpnX66yhz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 20:54:07 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780915488;
	bh=plNYBzzaUu+CjxUfVgmwKMU0d70IRGPw0rK3BmwuPjc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JoCZ/WKIAI4ynKcKsLsemvNM9WajLCXA73D5zw2xoD7lCL3z54ZkMrkLh/JyPdEyE
	 /kqCaIilwuycoqSIz0z02aXZrhcLMotd35EHMU7drq2vG8mZar/SYgy1xT2vcdWCN6
	 uGoRfxIdzyZOSLqUCzO80yrI3lBIVEMsvs8BDl3o=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608104448eucas1p1685dd3246a9e2b35613d32758481919c~3FTNnAVOb0713807138eucas1p1-;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608104446eusmtip22e466d5ec2468bd35b4ff28e72e16298~3FTMH8FJe2930429304eusmtip2T;
	Mon,  8 Jun 2026 10:44:46 +0000 (GMT)
Message-ID: <4d30ec2d-72e4-4d5d-98aa-d2519ed6737e@samsung.com>
Date: Mon, 8 Jun 2026 12:44:45 +0200
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Will
	Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa
	Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260604182419.GC2487554@ziepe.ca>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260608104448eucas1p1685dd3246a9e2b35613d32758481919c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
X-EPHeader: CA
X-CMS-RootMailID: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
	<20260522042815.370873-6-aneesh.kumar@kernel.org>
	<SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5afr35sciu.fsf@kernel.org>
	<SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20260603005454.GM2487554@ziepe.ca>
	<SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5apl26qrof.fsf@kernel.org>
	<CGME20260604182425eucas1p172fc82b218cbed92f71a093549902d3a@eucas1p1.samsung.com>
	<20260604182419.GC2487554@ziepe.ca>

On 04.06.2026 20:24, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
>> I already sent a v6 in the hope of getting this merged for the next
>> merge window. Should I send a v7, or would you prefer that I do the
>> rename on top of v6?
> I think it is too late for such a major change, but this should be
> imaginged to be for rc2ish next cycle. You also have to spell out how
> the pkvm patch will get sequenced as well, it would be best to push
> that it gets picked up right away.


I would like to give this a bit of time in linux-next so it is a bit too
late for v7.2, but before merging it I would also like to have this code
reviewed by someone with confidential computing knowledge.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


