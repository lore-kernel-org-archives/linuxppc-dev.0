Return-Path: <linuxppc-dev+bounces-19024-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18A1061B0F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 16:29:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkxXH1gC6z2y7r;
	Tue, 31 Mar 2026 03:29:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774888143;
	cv=none; b=E6cRElZBmw+MOvvRniI5/+wZt9z96tu3H0ZITd7INOrJXVpHL+v8Yt+J6BBincA86mq1WTfbc2qptZzPARzAkWuCEy3cyH8zUa22H458ruxQ5jO4YZ+yy0+gT32LWPXhI39vZ9BNhLNi8J6YolLFW8YHczqKRJW/J8KsSSDLCo739vot7lO1/Z6fQ59R+wd1P6yBBb3dA+ZS03XzzCZtRv4m3dqXdsji63KjuS3g/YoXqtA1T1Y/aLhHcEQ/eukM7paxgj/Mm4mvGrvWYrOlbUGiERLmx9apTunWDs3E1HCARhtuRJsdTnNas1F0mhS6DdAXb2zDpt8xCt9E/Jy1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774888143; c=relaxed/relaxed;
	bh=UE/8+ax0UXohGYhnmj94zLq/V9mFDN9c3i4RTAaAc5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OeY658ylrHwDJTcnRyZAHr9VvzfIoVpCZimdoTDyb4HDVC+PQUAIHfLcCQ9nSgaRrWjsLTewKKXRvOt0E7uXhbA3dzgmhDq6ALnP8aRVeRuFduqaGbqpoylK64+nHcE3e1bWyL54i104k2jiVuR4TWp5g8cQ5gx6CdtAZ74LssQLis5AQeuZr7tGN64VtycTlTyhm+pyMiAhnOCM5aD53TPvfGxjQhqUPnLdhCVS/PdIg82E3m7MQqT671I2reQhOLoXHSYaCQBaA1tFxhJlxDTqGWSShbPe5qHQ2gLnWCJVBs1+4SEhIZ2S4RaC1cyMicQxbIe7tEQu6ZuRf59HUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P/3XWocf; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P/3XWocf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkxXF6qqHz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 03:29:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C334600CB;
	Mon, 30 Mar 2026 16:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2732FC4CEF7;
	Mon, 30 Mar 2026 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774888138;
	bh=HnR3T8HyhR5zh3UidQc9tY5GP+iCNJ+9G4eesNsn66c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=P/3XWocfTvHDzL/TvgnY90VGL4nSlLd5QBe5hsYLKubBK3nWHOJaPjPq5JQAaRhM8
	 iAGk5KjaD3ik9GNqL6YSdRdGeXxBgLs24zJtsj3e6fxOpDbi7ZZd8I/d1cyMypX8NE
	 2XOL2YHA8im3TC/6MZc4CKSvIWYdWZeBHcvNBDXSWRJJuejsAH9jaZzQRbryV+m5kG
	 lnPI2WxSgVXB97c4laa/t/vZgU3QAb4tmja9ypMEFSoxTNm4EFRWFco06IOLdeGzNC
	 AdWvpkXe36xoTq6sFQYDIMUXUgS6vorYizdKVDGjM2rmv+ZiFnuwAzo46ijHVV7DUf
	 PA+6jJae0BAbA==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 18:28:48 +0200
Message-Id: <DHG9BXUEUEU4.2DTNLE8Z61DKX@kernel.org>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Cc: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Long
 Li" <longli@microsoft.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Armin
 Wolf" <W_Armin@gmx.de>, "Bjorn Andersson" <andersson@kernel.org>, "Mathieu
 Poirier" <mathieu.poirier@linaro.org>, "Vineeth Vijayan"
 <vneethv@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Alex Williamson" <alex@shazbot.org>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>, "Gui-Dong Han"
 <hanguidong02@gmail.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-6-dakr@kernel.org>
 <20260326180825.GA1330769@bhelgaas>
In-Reply-To: <20260326180825.GA1330769@bhelgaas>

On Thu Mar 26, 2026 at 7:08 PM CET, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2026 at 01:59:09AM +0100, Danilo Krummrich wrote:
>> When a driver is probed through __driver_attach(), the bus' match()
>> callback is called without the device lock held, thus accessing the
>> driver_override field without a lock, which can cause a UAF.
>>=20
>> Fix this by using the driver-core driver_override infrastructure taking
>> care of proper locking internally.
>>=20
>> Note that calling match() from __driver_attach() without the device lock
>> held is intentional. [1]
>>=20
>> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@ker=
nel.org/ [1]
>> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
>> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_d=
ev.driver_override")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/pci/pci-driver.c           | 11 +++++++----
>>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>>  drivers/pci/probe.c                |  1 -
>>  include/linux/pci.h                |  6 ------
>
> For the above:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> "driver_override" is mentioned several places in
> Documentation/ABI/testing/sysfs-bus-*.  I assume this series doesn't
> change the behavior documented there?

Correct, none of this is altered.

