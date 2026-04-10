Return-Path: <linuxppc-dev+bounces-19560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E8F44841
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:13:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZ1M6qyWz2yZ6;
	Fri, 10 Apr 2026 21:13:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819623;
	cv=none; b=KAmFNxhhXHCEgMuH3QUTnqM1Tt9lkbR+QYNKj0vlAmiiPJN3s2q2aCJCKnrc5vJ8kAdFkP0rzRlJHi+B1b3u36ouOFqmlbKhF0Sejy1t8oIHpuIXHSguGAEO58kb+acr05QSHx3OlRay82hUYF66er/CC3IezmJIk0SvAidgYDaaTl4BBlthWEWauFrO8rutJMoLl4mxJyTaktYNWJqXpsDFzr2j3Xrs1afv5vnibyGwBPvYpz+HpiZuK5AJyhliwspgF83ob2lrxbXKL16162JxSC5kS3en+jvWtN5csgo0Q/tn8/Za4qk45c9vDLAO0Hdwbs0E1zLqscY43C3SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819623; c=relaxed/relaxed;
	bh=RqNVnzl4sbELZDa2E3es1i/+o9lHIHVJUcSg0Sefjak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH9fAf5soYICCLAjMNb8VnuvbSYbWomZqUIDVCA6krzxv49Bqwt0k6HUs3xeszpeCM/OZkboLQmbcist71+LhflZdAQ97QoQbcydmaBjtHtj3lrrLqNgHvH+MbUcZ+N1fohjRXFyJoS3ZZBIUnxgN1MVMj8TNqbkZJJlDsJK8o1CFZofQ7RMc4ac7eSC68ZmFRaQfUc942VlmOQMpFHpJ+stVnqjrB92TzWNyyZkxUt3oDTZMt5dElf5IEMWuX0j3AnXp2Ujxf0y65IhiGljErRUJkZt5xT7nnx1SY9KRfk4OUL98/bgf4bPQtE578rD87K2DEjhrzymMNVaA2kyuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X5l16K95; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X5l16K95;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZ1M1wtHz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:13:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0836A6014B;
	Fri, 10 Apr 2026 11:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BC9C19421;
	Fri, 10 Apr 2026 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819620;
	bh=tp+2vBtC3b7i++pW7T3oZUkkQ00XThq2Bf8TIH4wQGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5l16K95Yuy7Zv4u2Ee+Up4qtxS0POfOwlZpsSGzrt9Ojmt3piTwXDoyWVgseWXnE
	 BE1JTvmcNII3Rc6iilUmw/jJL/PBTRga43FG1gGeILK4OVNM7OKK9FUzYXel4sElhg
	 /EzZY/omP6f6NsjJlZ1lVRYAYLkQC1UFVtqIce6UXJWtaCvLa0faqH7IhfUWjfPoiU
	 Z4B3RwVIrJbExnBeBJwyqduESMXXdJyGkzKeIYCL3jlNGM0rFFh8JrhxIsBb6OlgJW
	 cqWeDJanlZfnOnWa90YObE79zRwptPIDMf0XaXxMrtOBMxZ98I6EKnpFY1GzK1TrdZ
	 1L3qfid+pwhPw==
Date: Fri, 10 Apr 2026 20:13:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/20] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260410111338.GB1750802@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-7-kwilczynski@kernel.org>
 <4fc23ce0-7103-545b-bc11-230b52c2de94@linux.intel.com>
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
In-Reply-To: <4fc23ce0-7103-545b-bc11-230b52c2de94@linux.intel.com>

Hello,

> > -	/* Expose the PCI resources from this device as files */
> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +	if (!pci_resource_len(pdev, bar))
> > +		return 0;
> 
> I know it's same as in the previous code but I dislike assuming len != 0 
> implies resource has been assigned. While it currently holds, I'd want to 
> change that eventually.
> 
> The current behavior causes issue e.g. if IOV resource fails to assign, it 
> is reset (making its len 0 among other thing) and since IOV resource are 
> optional that is fine from kernel's perspective. But resetting the 
> resource means we also lose access to that resource because its type gets 
> cleared so from kernel perspective the VF BAR stops to exist. Losing it 
> means the user cannot solve the issue by e.g. resizing some other BAR 
> smaller to make space to allow the VF BARs to assign successfully.
> 
> So I think this code would actually want to check resource_assigned() 
> which implies also non-zero size.

Makes sense.

I will update the code to use resource_assigned().  Since we are working on
this code anyway, it would be only prudent to also do the right thing.

> AFAICT, this change looks fine (despite the diff being very messy).

Thank you!

	Krzysztof

