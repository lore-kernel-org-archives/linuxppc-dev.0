Return-Path: <linuxppc-dev+bounces-19321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F4E63FEA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 17:09:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp2Bg0dMqz2ynn;
	Sun, 05 Apr 2026 03:09:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775322571;
	cv=none; b=Hx5CHwiqIASj7FyxRua50a/+jeGIpeU/Un6OlvoTh/IH4mx/gb/KOgbTw9FtbX2t+6uV5RqSrIZ2+cK3rCA3BVGjABwYfFXxwfDRtL86Z024W6zHm9sgzBJ/hmDkw5vissA8oyjk6uLr6RrB4n1tkyncRB1e6/vxllG5gJcpRSJBpnJ0QsY/2Aj6hm8gv9ku0Za8ehc+q6clMyroN5MUiUlJCeiYsz6tpW7PsU70FVK7iud6hEB9ynBJaqeZs+tjTZP/sIAyG/uq/Uld1NznUUPsI7LQ00uQNHzinEgfq8d+FQ57FWsR2YudH/ffnbozv4cuzlG8xCo2w6bUtHev0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775322571; c=relaxed/relaxed;
	bh=nOMhaHen4cG4hzjrrUc9h0ZRxDi91n258PMJRo69mcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgjDm+y26C1RYYJYqI9SfQDY828FcIGfZoH6S/D3gLffX0tXvKu2aRNYB4LXCcCxCctRG0Y2Mn5kXw9gFhPAf6Y6KPg0kx25taa4d+x8QpRCg0Ctdax9i+jZJcX4rYS2SOOxamMADqeOxo9nYYQXe6hCUWxwDpBVhs3Jg4GQFm69/lebt/pgGlcWYCIsU3Nj7LxNvWMh+shG+g5MSto2l9arnoWRHN5iqOKzyYysp2jqDiq4wdP1F/e7o5VU0CbYaobDhaLWWUBUcvUohKTaDTF8r2xXKyqnfpKPGkpya9huVqr3flzDGhdHYPmFub4vi887KPRm26356r+a3DMd5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mur2l9g+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mur2l9g+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp2Bf14LYz2ynh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 03:09:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AE6C643C1D;
	Sat,  4 Apr 2026 17:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956BC19421;
	Sat,  4 Apr 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322567;
	bh=u8kt7OrQ/vRwebR8QID4XnX8+JNDMp1i5iK/K6bdNDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mur2l9g+deVKWOVOfXlkgvgdKFA4eMN3VFsDjrp+nvoKeM3X3pstiyexcKEvOeD0a
	 RbWpztozc0h4lQoSWYVOnXtkhFF+JRtMTTya2FNPQi3D7loBz93/IYN7Ge2fCwnYY6
	 Re4J05NhHq8kCVMn7SJKTXcUdNw54AUQcOdwffM3zMjz7evbLjl/s54+7J+0y2RhZM
	 +Mi+DO81POzfix85rvYo25MmliRWwTmiQ4w8GEjh3lU6Bg01dUBrobNBgfy2tPEGch
	 AFl8Q1R0jHMSDedYpY3Yug+qqjGh5y0LuX4UV4lD2NPGO2GuUGdy7lPrJwFQklpETH
	 wOUF3U6ODslbQ==
Message-ID: <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>
Date: Sat, 4 Apr 2026 19:09:11 +0200
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
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
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
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
 <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/04/2026 à 19:04, Danilo Krummrich a écrit :
> On Sat Apr 4, 2026 at 6:58 PM CEST, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 04/04/2026 à 17:07, Danilo Krummrich a écrit :
>>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>>> Danilo Krummrich (12):
>>>>     PCI: use generic driver_override infrastructure
>>>>     platform/wmi: use generic driver_override infrastructure
>>>>     vdpa: use generic driver_override infrastructure
>>>>     s390/cio: use generic driver_override infrastructure
>>>>     s390/ap: use generic driver_override infrastructure
>>>
>>> Applied to driver-core-testing, thanks!
>>>
>>>>     amba: use generic driver_override infrastructure
>>>>     cdx: use generic driver_override infrastructure
>>>>     hv: vmbus: use generic driver_override infrastructure
>>>>     rpmsg: use generic driver_override infrastructure
>>>
>>> I have not picked these up, as they have not received ACKs from the
>>> corresponding subsystem maintainers so far.
>>>
>>>>     bus: fsl-mc: use generic driver_override infrastructure
>>
>> I droped it from soc_fsl tree, some dependency must be missing.
>>
>> Feal free to take it if you can, it is acked-by Ioana.
> 
> It is based on v7.0-rc5; if you want I can pick it up.

Yes please pick it up as my tree is based on rc1.

Thanks
Christophe


> 
>>>>     spi: use generic driver_override infrastructure
>>>
>>> These have already been picked up via the respective subsystem trees -- thanks!
>>>
>>> Thanks,
>>> Danilo
> 


