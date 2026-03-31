Return-Path: <linuxppc-dev+bounces-19104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE4109B494
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:43:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flXTD5PgNz2ybR;
	Wed, 01 Apr 2026 02:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774971808;
	cv=none; b=IL2f8YjmB3TdkShA2uXv4UPleyclGRkSbjqRTixKSYcsHoRVr4GeX0GARAH/L3IIYqqHfd3FrPBO7QttsBb7PIeJNcaCZupHu/UVbJ4tciSbg4rY+gZM5d4ihZsFkqsI0axlOzYsIEb0d8V0MYc1RKcsqOWdMo7xnW89LBiHhXu3URpnkM7qhZWFsKH1jYE6J1O1OAtz+Cj31D2cEuKPSCXJZMg5F+twCjWQ0HG4kHU19d+KZiEkWGuqKWakO5MGyfqMJn3/SOQlVmlJ342D3PwFyydro596ThpByQZlrtORhUjXx5To4Iv78l3vEve5WOpRAAbpZurfazQAbB3JQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774971808; c=relaxed/relaxed;
	bh=ZAO9LRuBf0t8RxZB3+UTHZ+v6QX+/RGEZTmLhofs9X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8MTI5urZOmX4dc53GnwNf2fLRxPklpeOBUlei6FqMWjI6dyopmZOUBN0hfqcR9c/U/fIMgDMpd9LtZJg1azl5Mome2TaSUxrgloF+f04wy2hNFR4GxXMg/yVvCrj3WXQQjvvCNpPT/+JUAihcOtY5IaKTjdM8ymkCJAcLmEiM8pnC9ch5wD2Oj5+uZWYuHxMjcslmrn9+27Rz4OP9XuldV+MmzvLGO2h7lwgScp3zl3yxdwmGCFmkwXOUzdDIaxB7jnqAwKxkbu8AQLdcSfIGNEo6DhatB0eFqOj+EN6vLaVtD+2HTTT26RL6KF57fMdWYOO5Tohl2JoiUzn31F7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AvEJIy/r; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AvEJIy/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flXTC6GpFz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:43:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33F5141AA1;
	Tue, 31 Mar 2026 15:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763AC2BCB1;
	Tue, 31 Mar 2026 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971804;
	bh=6Sh+nuXBMcAFDxKLCKsR5cDxicblUVjm/StrUH5xvws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AvEJIy/r0i0fIT0q1b7k0uixxXSVC1oh7xfO2lmos43V1mEkh9/oCyjjM/NIlIzDR
	 G4ToLsOxBoNZj9eIXjRIfgaF1JLikB4FAvsXjSce8BwELH8sXRPMxKzVfwC18KZVLM
	 xvaZCSjKCWIMAF0TL0BKofu4C2zQpBgPhfjifUkEE/91cdaFO2EcfVtNgpPrO7Xulf
	 fYkRcb4pifGLoTxuUkNA9ffXMCz8PqPYdeYYDg7woAcRkIdsrLp3N/31BR3QOWYwl8
	 kL1fnhPJvjBetXgl25fDvOAS7XsfRd59LIFlTx8YTswK4vMykSPYpL+e72NUmtvpp/
	 OhFF1YDMIAkew==
Message-ID: <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Date: Tue, 31 Mar 2026 17:43:12 +0200
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
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-7-dakr@kernel.org>
 <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 5:02 PM, Ilpo Järvinen wrote:
> I tried applying this to platform-drivers tree but it failed to compile so 
> I ended up dropping the changed.

As the cover letter mentions, it sits on top of v7.0-rc5, did you consider this?

I can also pick it up via the driver-core tree.

Thanks,
Danilo

