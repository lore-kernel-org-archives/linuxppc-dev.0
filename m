Return-Path: <linuxppc-dev+bounces-4876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2D4E77188
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2025 22:13:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YT2HW3jb7z2yhR;
	Thu,  9 Jan 2025 09:13:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736374407;
	cv=none; b=ajmDJGIMuXeiG7RE/R6RKOLHKA5JfuWBHTghoxoC76bKLurcm9pE2+abCHVEaviWn2WLSKTltceN5HoImElhn9HuNQj+r7BnHMgUwuGgQiWF4Cm+wwBI7H4PEnDWz9w83gsgWKU+rnBuNxl5gvB0NZ0mbshwwN0EZWU6QT2W8ej9UrKwdQJrSe9Y8sePnNQo999JEUe0Vbe66siGXo238JS18a7TfYP2zs3SOsM8jxsARnHb6YKnrPEUcKXEF/J8GLcF7PB89SheOhgUMdPWt1b3tYa7wnKRrefXwpfCyf5GKM0V/04um4S5chRJOw/97VbhbFhW+aDM+5VaA3bLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736374407; c=relaxed/relaxed;
	bh=gaFZT7bVllkDDMow74Ra/SKmxwXf7BbuWhEhbnATjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CtSPBOSKDDux7ezfJf3rk2cAobDHvg/jtVNDxLtcZ1ELOxnxPnkk5mOVKaZhgCDjDfJaxOC2+oqtIYLCgSG11P/DNUo7S/hEe1pyGdmRW8NCDe+4b/rUkCkevBgbqyi/0KyP/vzEJolz4bWeIQMx63vedDAbCnJYzBnUVAeUeuB2EwWzYXAenKRraxkmsIkkI6XBObRKHrdcsMIwagE7aKfY8qGgk2piARTJmrLrNurkkqXEBBp2KIHyOErfVnMTzaLg5uwUCJgijjKdGvkRfIFXSQDPcbTHTZLA3vjLLpPHnsPG+H/9zRUAb/yG+3OlFiSle7KjkPlb5RqguvyBaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAPqRI6q; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAPqRI6q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YT2HV3Mtwz2xt7
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2025 09:13:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D54C5A41C31;
	Wed,  8 Jan 2025 22:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6453C4CED3;
	Wed,  8 Jan 2025 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736374400;
	bh=txUAMzhnn7qnCj8VsLdnRbJXjg/Wnh8MafOMw9qmsJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OAPqRI6qhZFwKNSL1zVQhAgS3F4n5EqH4LM0jvyt5QAHNLFKETMnozpP/d306lw7W
	 70yl3BBuN4/J0h2VUVSBAJJRXfEQYjMOsF/EH77qUY9fo3RnUndVFiMyuyKNWmN3cK
	 RPJUJf3TLxH70w85oxWkv9C7SyoVrPfkRVsi7wL/zIWstBm2gZsw97ZC9wY7FGf12o
	 qg94rEnw2B+9uwGcTH7jbWGAVBEposCXtRDhHeOJbZxtWCliSUe7GaU3QQ5K0FYUPc
	 gkeVDPSxlc8idghs8J99knDTQ8OlVvIxfwZK3GFUmJo2mXFhsfi2Pk3FrxXCzm+XZQ
	 z4ZSD/vCPC7CQ==
Date: Wed, 8 Jan 2025 16:13:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 3/7] PCI: Make pcie_read_tlp_log() signature same
Message-ID: <20250108221318.GA232458@bhelgaas>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108204011.GA1342186@yaz-khff2.amd.com>

On Wed, Jan 08, 2025 at 03:40:11PM -0500, Yazen Ghannam wrote:
> On Wed, Dec 18, 2024 at 04:37:43PM +0200, Ilpo Järvinen wrote:
> > pcie_read_tlp_log()'s prototype and function signature diverged due to
> > changes made while applying.
> > 
> > Make the parameters of pcie_read_tlp_log() named identically.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Just wondering, could this be squashed into the previous patch? Or is
> the goal to be strict with one logical change per patch?

I haven't looked closely enough to opine on whether this should be
squashed, but I generally do prefer one logical change per patch.

It's much easier for me to squash things when merging than it is to
untangle things that should be separate patches.

Bjorn

