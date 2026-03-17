Return-Path: <linuxppc-dev+bounces-18334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF860FF6E95
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 22:41:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb6Pz6fjWz2ygK;
	Wed, 18 Mar 2026 09:41:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773787287;
	cv=none; b=CbBSfCQ7XxywOb+qREdc1HKjlVZh8ULpepJyYRr4AHW/T6A4eHHuH14UeY0cPmNqJ7HFwdGrlGastpZUpJoYTkUvP5A115l8/wJUlTg8rdANPWN33xAHFLd/IAK+GbfpynLDmRjT9S7WgclhQ4VvD+PRQQwGH60mJtorfBWpRJOaghj3oZvRbza+97MjEFK95FOykVOjCEsTYkcHnQke+qHqOwvtM3OHIDdr6hbrwrs2f5EnE99CRIPsNVwdC93HIEMIeW1YcyhTazu4mx5OVvfwQTwYtdDhr2hFZYge94aBiixEkBs5z67nJrTc0FvXmhojq3mikYFp5qgLnFDsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773787287; c=relaxed/relaxed;
	bh=8oBmF4DPhKwbg+7vhSOziw0ETGItzql/tzkq13a9Mrw=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:
	 In-Reply-To:Content-Type; b=VM8xT3mxOZNJNq0WT2OVX/IlXUWovayauChhq4kqs5GYDeJN2EqFWwDcr9lJgq5kJB94/bOk9ngjeCyXxQoeiROASVBZ9scp3G+eXoqbl1gcdIk30yMkJX3f7aWvya2xZ9ae/p7cl9qpdwUBnzQ2WxN0qH+g8WuixnLdBfHZUnbMCKzm9E/qXq++JkiTRwWLL2KhxHKUQQR0uQ4SjhkFp9KDKPRMx7DG022pzeMBVYZwfFGNeDE84ZYjvmZNpFX63vYI+2NCiwrBM/0v+Rmmz34l+/KEdb/K029ttS8VklbGFfH2BDPlZnumxLVb41s/bsIRuXGJTfGdAebZMUy87w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.de; dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=2017 header.b=pDABxx2y; dkim-atps=neutral; spf=pass (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=schimanek@posteo.de; receiver=lists.ozlabs.org) smtp.mailfrom=posteo.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=2017 header.b=pDABxx2y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=posteo.de (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=schimanek@posteo.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 393 seconds by postgrey-1.37 at boromir; Wed, 18 Mar 2026 09:41:24 AEDT
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb6Pw666rz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 09:41:22 +1100 (AEDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7AD10240101
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 23:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773786884; bh=8oBmF4DPhKwbg+7vhSOziw0ETGItzql/tzkq13a9Mrw=;
	h=Message-ID:Date:MIME-Version:To:Subject:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=pDABxx2yxkazTduMlNVYpRHSj3Q/9RYtPZdFSavnY17vb3xNC0Ff5nfTlJfnlqaoa
	 aTB8vtjgmS38/auKmVSp1dxIDSyySjJ66tGJkklvgh2GR2o6iRLtXjjsabSon5Ptao
	 cdevelNhntsDbf91JlEZA7JeFysfUNFNc91ucBZjkRMV+bgljtK+gRtBOy/yssVwGI
	 vMVlNv4bGrIsippAiF3ryhGM02psCuikuaDXivRR6V3CXQOg8IaWG76IFAwpbUSLLW
	 8D548Qtgv0Vc4wi50Qrl6YsbcaX0sgp5y4t20F3hjybwbqvh7UCz7n0z6sz6MsTBHn
	 2HEUttUvivYtQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fb6GC494Xz9rxP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 23:34:43 +0100 (CET)
Message-ID: <4d28b579-52a8-44d7-a15b-2daee20bfa8a@posteo.de>
Date: Tue, 17 Mar 2026 22:34:43 +0000
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
To: linuxppc-dev@lists.ozlabs.org
References: <ms06y93w.ritesh.list@gmail.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
From: Karl Schimanek <Schimanek@posteo.de>
In-Reply-To: <ms06y93w.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ritesh,
Dan,

I can reproduce the issue on my system running Chimera Linux with 4K 
page size.

System details:
- Machine: RaptorCS Blackbird (POWER9, PowerNV)
- GPU: Sapphire Pulse Radeon RX 5500 XT (Navi 14)
- Kernel: 7.0-rc1

The failure is identical, ending in:

 > amdgpu ... (-12) failed to allocate kernel bo
 > amdgpu ... amdgpu_device_wb_init failed -12
 > amdgpu ... Fatal error during GPU init

I also see:

 > iommu: 64-bit OK but direct DMA is limited by 0
 > dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff

This is with 4K pages, so it does not seem to be limited to 64K page 
configurations.

Regards,
Karl


