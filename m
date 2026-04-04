Return-Path: <linuxppc-dev+bounces-19319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F4E63FE5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 16:59:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp1yn4RZ8z2yk6;
	Sun, 05 Apr 2026 02:59:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775321953;
	cv=none; b=JM9LtyMTNAlkjL9TpAVUWHRYPxlyTKs9Ujw5ckZKVAHra81Kfn9Y4rri5GP76ekVP/1bDqPLvfdTzNOw3xIoVD1NJOywtt+F5eOEJZS1dmwG70RGCQi/yU8iUXBRyjkWv/NNGeYoQr3xiWmIteAxWuphv9nXLjr7R2H/xpU5OayhaI9eERGPY+hTO1nDVmgRujC07qDRvZCTXVs2lMKLk3PzwZVh5b0eYD7YC0/QNmY7GGWH044PeP8a4dFjnMCXjJnD+Q6lQgg2kNiliyk/24znaVUwca9SzxH2bCLUY4vk76rgvB9PeN+etjaBs/kGa5JY6JgRBEW0ZcPB8hyiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775321953; c=relaxed/relaxed;
	bh=ImHUbCmanc0Ar6XtjjzggRp554WxKEvvo2Sre5Dw0wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuTY8jqB3UxclhTnJaR/PRuVTulDKHe79OGwbm7Zc37qigTA8NR861x6Wkipb9eAITH9b4U/rJZ+KW6X6wjN1vqyGG0o8KZKxtWD5b2TrwOIvcGbCkPzntngM7FqIm60XGOO2KiZzRVdZeUwST/Qbf6XHi3ilpZxJOZCMOzNJp/gaeFjs1KzT8LpKo4lZusQUgwq7v8kwXw6ueDN0vEdQspxdBgjpBfrRBqzePmp24J2kGKR/ewPDVfT8w09AEA4LYW2rh0dyo3DzEIvsie9QpcZdrawNJje84t9KPTUVXn+XitdNUH1N/qnahVNFSa82fHUGiFbZZ0/qat7H6AwQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pzHa0ltJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pzHa0ltJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp1ym4lXnz2yjx
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 02:59:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0732D40212;
	Sat,  4 Apr 2026 16:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF2C19421;
	Sat,  4 Apr 2026 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321949;
	bh=2nmDBifOoextQmoTG695I77JtU4IfJ6hHi18F/uovOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pzHa0ltJ7P/3nc4QK7/bV808HOZOGXaMyVekR/DB1WE+018orzHWLwztSYy1/aXtb
	 SzI8tsEInej9eoHjBzyIJaVGBr9u74dLFfrXcTThineYb99ODPDwsaOS5PNoPpADEf
	 RKWNJ7Ic0kSfp5FmUOXVQ6PFQBKcfI9b1bar1hvVu+oDjNbThyquuuXTFP/2f4hh2r
	 sNZXBYXoEYlp3D9Lzsjn9fgXUhLg5zak6jG42FprWSVJLQdnerHFANSStlrij56Tl/
	 nq4W3Agf2uSQ+xhFuLGyUpc0A63CtjXoWAelZzEtiaPysfp3k4jpj5PHDxaigPyBx2
	 FsekL+yzYor6g==
Message-ID: <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
Date: Sat, 4 Apr 2026 18:58:53 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
To: Danilo Krummrich <dakr@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/04/2026 à 17:07, Danilo Krummrich a écrit :
> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>> Danilo Krummrich (12):
>>    PCI: use generic driver_override infrastructure
>>    platform/wmi: use generic driver_override infrastructure
>>    vdpa: use generic driver_override infrastructure
>>    s390/cio: use generic driver_override infrastructure
>>    s390/ap: use generic driver_override infrastructure
> 
> Applied to driver-core-testing, thanks!
> 
>>    amba: use generic driver_override infrastructure
>>    cdx: use generic driver_override infrastructure
>>    hv: vmbus: use generic driver_override infrastructure
>>    rpmsg: use generic driver_override infrastructure
> 
> I have not picked these up, as they have not received ACKs from the
> corresponding subsystem maintainers so far.
> 
>>    bus: fsl-mc: use generic driver_override infrastructure

I droped it from soc_fsl tree, some dependency must be missing.

Feal free to take it if you can, it is acked-by Ioana.

>>    spi: use generic driver_override infrastructure
> 
> These have already been picked up via the respective subsystem trees -- thanks!
> 
> Thanks,
> Danilo


