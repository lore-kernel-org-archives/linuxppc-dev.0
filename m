Return-Path: <linuxppc-dev+bounces-25814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC3C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:14:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLKRk3FC8z2yfN;
	Thu, 13 Aug 2026 19:14:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786612450;
	cv=none; b=RitrhEcQ5LLwiiLFf1aEx9UklpjGe/wmc0Fyt+HPNIpMiUllffx24xiAs21lR7AYGVmNa+uifKUpLODYiB+AIUo+9CLuoWydYaNhowaIDwdvVonDsJbxKtNi/x96s6dqkUJcEFoRfmXEkoQKnZO/IgiEGELouWMtk4oDnpzwm6/eHDMq4eaNa3gK6TY+fBzWPEwRN/DRxMy7mD6dodS1n0bJUrJBHxdHGgWa9whi+5UddqyoW2GQ6zPeHbBOhz0pdRAieILdq8hTaskiDInhxaW1BeTrYcKwSOgNeDCj0LjOzPQM/bRINrizcJQrp4WT+8t/nsau+Qguessc4u72tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786612450; c=relaxed/relaxed;
	bh=zhJmZaJPWu2tGQu9cD5mC0NR8f5AZSYCs6/SZ99TC3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kedEHHVdT72FLlIMQcqAEZB+GGIAQz3lE/RG/NVoxeR1XTQnsb+LNOLLx18LlnMKBkgkBff+SXM0YfaOqUW/St2KUaDs/JviHuG7uUzoEX9Ucp241rnxXRE+J1wxN+uKBH2bMsKWvDXYMlTzUnkpEjG5ioOaVajF4IjqokswHEAumW5ERPW/UHTYEv7knsbN1imfleU0PcOq+IbDbwsZD0Y9wa5FAb+/oKu5G5GncsZtk4AMp9pTnr9Sj18pyFqrzE4n2rhfjq8Vlj+3MW0eT0s0o3NisSV3JQYmRv7S4di5Xump2Q7Xkv/zuI0CKsT6zuhjUeySuuEjrffrYLZ6JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb9o2WF4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb9o2WF4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLKRj4FQyz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:14:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 77427600AF;
	Thu, 13 Aug 2026 09:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673031F00A3A;
	Thu, 13 Aug 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612447;
	bh=zhJmZaJPWu2tGQu9cD5mC0NR8f5AZSYCs6/SZ99TC3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Jb9o2WF4mJul7AfKWjZXxrn422eNlwV0OpD+YUFGaeWd6bV48nwOVrU7hqdRUi+C+
	 MMx4opwElstv+v12Jm6nH90+reZr0lst/MhRIUedGK2xlbjCtlG9nXCuqjcbRYusO8
	 X1lS+eSvLFUyqG9RQZpJPU1Dn9c9K3lMzwNnYQ/HvtF3Gfeh48zxH+XBa6Fb5Yyvvh
	 hFmFH9g0W6IrqIJjg8vT3CnEkPq+B4NO/K7RPYK//Xj76c4UIu2t6NY3pE/WZCVSVx
	 oHcTVrUCMzfVvoO0ByHsO9gTDpn6yo+uhhMAdcX6QxDcfH1IvdyynOvdpX89zJO1SY
	 LEmdUB6XPzQKw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <an2EoONjyp570tvB@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com> <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com> <yq5aecg2io0u.fsf@kernel.org>
 <an2EoONjyp570tvB@arm.com>
Date: Thu, 13 Aug 2026 14:43:53 +0530
Message-ID: <yq5abjb6idri.fsf@kernel.org>
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

Catalin Marinas <catalin.marinas@arm.com> writes:

>> >> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
>> >> > option in realms?
>> 
>> This is getting fixed in  
>> https://lore.kernel.org/all/20260701054926.825925-9-aneesh.kumar@kernel.org/
>
> You might want to bring this early together with the swiotlb adjustment
> here.
>

That is already part of dma -next tree.

-aneesh

