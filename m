Return-Path: <linuxppc-dev+bounces-19318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E39E63FE0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 16:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp1vj4rDPz2yVL;
	Sun, 05 Apr 2026 02:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775321793;
	cv=none; b=mhQnTx5cjsXKIy/6ehy0zWUeXHnEqS4gfs7jyW7Y7LSHrTbrOG4iEfWp06SSznOuG5+wtkyvEcHfVGLEABk2Q02Ya95zW3/kEz+17DJ/dP9Hjw3QRkGR/HN6dIn8hkDJpDTMC/0Psf+W3jg0ZlZSO9WCiT2BwUr8dl9u9YRnS4Gan3lGmBvk0l5a/381U16hGFDnak3wQflrPTRlLsv0d94Bo5cefZFFMm6Lblw5n5iYpkMWiD6m5+IltggLCzq3yp4BaaTP69iZR3haNLcNlfxi/JXcfhlZzx7wlgYaoFTUBbUzfNLpYf9v1PME5NAeXJFRA4q1Cj0IucTToI99pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775321793; c=relaxed/relaxed;
	bh=ST2pb+/gQk3IV14UpJzT4A8hj7OcdgJQlHupwD1g5y0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZ/RtfwGd3WQw42d64NV+KeG+SvGVs8pO0gQ4dnleMOVq2FKWLBy/WJISKlzjuAcBHnW/7BlPd8s181pnjg+duPxnIFTu1Y2Kx3u88KgW2k4he6UfAkvAjDpN0Wued4q0LvhYN2uhERr5x8EEwHxeYkj5NWCTM1T+4vAMsTCvY7WUAsRTKnnHM/BsPqQYg7NDHQvPFKIYyKlVBD8/kqQJeeZi0djZZLjIPqAP4F2QN4sjMdYZ6qPSO6A0uRC7fBFsI2x2Z7cHCz2JbEeMoqVZBXOSClfGsmq9ykL98uyJ/QRgqXbAl7XhEiZ8eUdcQ7NoDd0l6oqfiWEbHPpxzs15A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Pvkgz2VY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Pvkgz2VY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp1vh2TZLz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 02:56:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C91694059C;
	Sat,  4 Apr 2026 16:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A189EC19421;
	Sat,  4 Apr 2026 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321784;
	bh=z0EKK9uCRclvxyjrhd1+SN0RRq/OFfBzrXy9eOqqb1Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Pvkgz2VYtss1MeKDd1hCnXOqFhZSJT7sCBgib4Ld40MuoHbsbTzaQtqEQlHI315/z
	 sSsTrUhsdTJPdFsI6MsazCxIagVra3Yz7Nj6ieza8kV78SqaqqkR1jw4ERelqbogu8
	 P2C5HKTLPE156wtoOmaEhBjNWmWs1/5XjIm7Pn+IztUEvzTxOWgE4ijDSgxwxt7sHW
	 /z+by/VjXh6iXK4C6vfLmsq7Ld8muhOBjOIJmJuiMgdiDbMtkSfkPxjp0+PDXt64DF
	 SAsEhipno3UJ1XHvp0XZyChIymjhWJhckqoZh6Dfi1SExI1b8SJikdcJieSIN27yIj
	 n1QGwKpOYjS/A==
Message-ID: <faa68f96-5b10-45d0-a5dc-fac4350a7dd7@kernel.org>
Date: Sat, 4 Apr 2026 18:56:08 +0200
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
Subject: Re: [PATCH 02/12] bus: fsl-mc: use generic driver_override
 infrastructure
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
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
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C4=82=C2=A9rez?=
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
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-3-dakr@kernel.org>
 <cvcetxkxjq2tz6n2vsofhyzove3qdi2e4r6rq6yxou3joejk2h@rmt5ygav7ssu>
 <4c5e9bad-82f0-4714-99c2-8ccd79a45043@kernel.org>
Content-Language: fr-FR
In-Reply-To: <4c5e9bad-82f0-4714-99c2-8ccd79a45043@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/03/2026 à 13:10, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 25/03/2026 à 13:01, Ioana Ciornei a écrit :
>> On Tue, Mar 24, 2026 at 01:59:06AM +0100, Danilo Krummrich wrote:
>>> When a driver is probed through __driver_attach(), the bus' match()
>>> callback is called without the device lock held, thus accessing the
>>> driver_override field without a lock, which can cause a UAF.
>>>
>>> Fix this by using the driver-core driver_override infrastructure taking
>>> care of proper locking internally.
>>>
>>> Note that calling match() from __driver_attach() without the device lock
>>> held is intentional. [1]
>>>
>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fdriver- 
>>> core%2FDGRGTIRHA62X.3RY09D9SOK77P%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4b9262ddecdd4ce29f9808de8a66485e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639100369055903282%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BRfjlUkq7oWV%2F0v2S2B%2BEuxCY%2FLRQv6qHiEWiupd6kc%3D&reserved=0 [1]
>>> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
>>> Closes: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D220789&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4b9262ddecdd4ce29f9808de8a66485e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639100369055936232%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=XL1K1ICiygOZnlvDUbQFe192KnLsBQms0HFNGCuyz%2Fw%3D&reserved=0
>>> Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' 
>>> in the mc-bus")
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>>
> 
> 
> Applied, thanks

Have to drop it for now, build fails:

   CALL    scripts/checksyscalls.sh
   CC      drivers/bus/fsl-mc/fsl-mc-bus.o
drivers/bus/fsl-mc/fsl-mc-bus.c: In function 'fsl_mc_bus_match':
drivers/bus/fsl-mc/fsl-mc-bus.c:92:15: error: implicit declaration of 
function 'device_match_driver_override' 
[-Werror=implicit-function-declaration]
    92 |         ret = device_match_driver_override(dev, drv);
       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bus/fsl-mc/fsl-mc-bus.c: At top level:
drivers/bus/fsl-mc/fsl-mc-bus.c:321:10: error: 'const struct bus_type' 
has no member named 'driver_override'
   321 |         .driver_override = true,
       |          ^~~~~~~~~~~~~~~
drivers/bus/fsl-mc/fsl-mc-bus.c:321:28: warning: initialization of 
'const char *' from 'int' makes pointer from integer without a cast 
[-Wint-conversion]
   321 |         .driver_override = true,
       |                            ^~~~
drivers/bus/fsl-mc/fsl-mc-bus.c:321:28: note: (near initialization for 
'fsl_mc_bus_type.dev_name')
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:289: 
drivers/bus/fsl-mc/fsl-mc-bus.o] Error 1
make[4]: *** [scripts/Makefile.build:546: drivers/bus/fsl-mc] Error 2
make[3]: *** [scripts/Makefile.build:546: drivers/bus] Error 2
make[2]: *** [scripts/Makefile.build:546: drivers] Error 2
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:2101: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Christophe


