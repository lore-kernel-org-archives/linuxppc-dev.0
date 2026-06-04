Return-Path: <linuxppc-dev+bounces-22045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98055CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 14:57:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWSNg0myGz2yT0;
	Fri, 05 Jun 2026 00:57:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585075;
	cv=none; b=WjaQR6hbw4C0Pi1xvlw1Vyj1bvR91ieKBcNqlvTLXqaUOiYUuFc4IvbLJ4dS/FyvZvPQBXRthFL7uiMvx5qKo/+y0dHyRYdQtNt0enlkOlA51rnuldEU7Rjb40pPmwnKjLMaYiKovT1AsKdlBREqOZK9iLvgADuM3tY2bkQcPH39OyLp9VcCkz9J/EGUEX/nKLqgas/mRJEHxbZlfqfwbLIpZZQAaXC4DoAsD1gZ2RQQVyPOZSgfGw/Q+c9FOiebkjg7spBgV7udJvtCpFx13S4lOshG72HUAx37ZoIWSfnEWZChuH0nPg4Lyra22xgVQuqjSJjPY2fuv2ByMQ0Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585075; c=relaxed/relaxed;
	bh=hYpE8ScA3WgBcN3vhg/AglZszMwb5uF85NWSIx0kbMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+WYa2L6cBftdKzFemw3d+LShRB+F1jh7X9RKs6tgL7hi/ESVc4dezjedvJP4THyWepaQ0djdtndayuDMKuIXQuZ5I3wFVX1yqMR+VX5DvG0jd3dbwNP4VhKp+FSpZpI0AeHIiV/VERoHnStEyGgll+22kxSfMQuBPtuSpQR9TkmgzXbieOrPw2qMi0l8iOH65GEp/ZyvvuVrhqMp/zX0TQcGv0s6RO1TX8dB31c7fRhVuKb5t4Rz2uDRB4yyELdGedsnjNs5IXY9TfH47oPIGB4gWS9R6RG9J7zYiQCmBq4vgQ8/Iq6OkYpG8Sspwj9eY2ljxNopJoI+2KqNHDWTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPWVmrL8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPWVmrL8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSNf0vbMz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:57:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B929B43CC3;
	Thu,  4 Jun 2026 14:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FCF1F00898;
	Thu,  4 Jun 2026 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585071;
	bh=hYpE8ScA3WgBcN3vhg/AglZszMwb5uF85NWSIx0kbMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kPWVmrL8guiyc8M71azpVpri2D/uzclh6JoLyKNzyoo4OxN4agAWchTRxJjWIqJ2q
	 UtcCBus1mVx0a/I8DtboPOq/GBjzm61oZmXhDyCjcmifakXbxSMF72Q9Vr5TzFoFkh
	 Q8TOXNTKOqDXevhNGLhbxVb/6qqknzC5ebPnVeNlk37O5tQ+YjJ50srz4rcVPiOTCZ
	 zoUWZTgYQ9VSABiBHxcdG4TxBCB9zKt/fo3E0ZZLIZoVDRDTTcOdIoi6vJKJ2Dg7L3
	 j32qrNj5EkbQiih4TEEVu90fxL2Lx7UWE3w8deLFZ3bhMFmkT/hb4euyZAfcM9jKg8
	 bkPIf1Pnb7Z4A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Kelley <mhklinux@outlook.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
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
	"x86@kernel.org" <x86@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 04 Jun 2026 20:27:36 +0530
Message-ID: <yq5apl26qrof.fsf@kernel.org>
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

Michael Kelley <mhklinux@outlook.com> writes:

> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
>> 
>> On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
>> 
>> > Except that in a normal VM, the "unencrypted" pool attribute does *not*
>> > describe the state of the memory itself.  In a normal VM, the memory is
>> > unencrypted, but the "unencrypted" pool attribute is false. That
>> > contradiction is the essence of my concern.
>> 
>> I would argue no..
>> 
>> When CC is enabled the default state of memory in a Linux environment
>> is "encrypted". You have to take a special action to "decrypt" it.
>> 
>> Thus the default state of memory in a non-CC environment is also
>> paradoxically "encrypted" too. 
>
> The need to have such an unnatural premise is usually an indication
> of a conceptual problem with the overall model, or perhaps just a
> terminology problem. 
>
> Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> Name the pool attribute "cc_shared" instead of "unencrypted". Having
> "cc_shared" set to false in a normal VM doesn't lead to the non-sensical
> situation of claiming that a normal VM is encrypted. The boolean
> "unencrypted" parameter that has been added to various calls also
> becomes "cc_shared".  If "CC_SHARED" is a suitable name for the DMA
> attribute, it ought to be suitable as the pool attribute. And everything
> matches as well.
>

That is better. It would also simplify:

	if (mem->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
		return NULL;

to
	if (mem->cc_shared != !!(attrs & DMA_ATTR_CC_SHARED))
		return NULL;


I already sent a v6 in the hope of getting this merged for the next
merge window. Should I send a v7, or would you prefer that I do the
rename on top of v6?

-aneesh

