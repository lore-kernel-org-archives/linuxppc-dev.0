Return-Path: <linuxppc-dev+bounces-18828-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C0C10A88EE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 17:38:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhWGd39FHz2yVB;
	Fri, 27 Mar 2026 04:38:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774546729;
	cv=none; b=NQDX2peoJ1V2LRllNZUejc0ahiEySP0A+/HfWoDycBZyo2PSEpSZzLoZF99n9hGgbpjyqRHEw07EwoM7RY+4K93CQkl0s/KV+lQoHLVBIhEzN4Tw5jTVoxePcsLiU9NenJ5NygyxgVs9u6sVOJzJ/UbilvB9skxc0yoaxx7nNhugsIsHxuzipUgdR1zzrRnPauVxWxE3X8n77Og/e5gqbDUAsDeQlCZFJlL88/ByIVMbBIM3f9K+0fE+gtLoaYUQrBMloo/OKDOlZmGrpaO10zWu3ZRRAAa0CDldQNwNqKWkTmpLI0J1rYPxBJFjjXUnW1vUt9xWLhtLCrBkO5ZJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774546729; c=relaxed/relaxed;
	bh=hAAiF8xSgL3z4E5G5/XmRxGLgvCy/D0+zQfYgHI39gw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=e1F5lotGOS8dBtW3eWDeMaP3iaap2qKNrp0YnZr+VqblnoPcpe4F8Tcjg8MIFkNTh/eZRzyq43AljYRLzwxwD5gwGWGyDGlif8C+bEarQn4MhvgSWlkJCyOfQwgjCvUIczpCxcKdzEkTSKkxnhN+kR0dPw6dHgWu7fKmVu0YgDch+4u2FIcl6ui1WdePCkmbB1jW1pZKf+pweRH9Xsz4L6NUONTw4GlNpvYgKKzP1aacPUSVmefUXYNp/6hkrdNxc2vYNiwCF7NwJzZvU+PC90J+lXdwqNLJcFeH01jDjftFO0dUiquI4KiUcCfizsHRwXRQFXzcWYk2pKqCV+0PHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ArEAbT+s; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ArEAbT+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhWGc56Zzz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 04:38:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F2DE6011F;
	Thu, 26 Mar 2026 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF3C116C6;
	Thu, 26 Mar 2026 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546725;
	bh=hAAiF8xSgL3z4E5G5/XmRxGLgvCy/D0+zQfYgHI39gw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ArEAbT+s3n7x1zNm2qUyfultheclQsMn7Cylk1mxfVokFRrNp3WpcDfI8mmayZ+0h
	 m2cGLs0n6Sh6ZCu8EvHXqLDxmAX8LMqlZoRnQEfHReuoiYU3xPG1brRn0xv/B7nG91
	 dfctDdAzWRRIBz5wDeTdWGKHbyzznewMhiup0tTEhLqFpUABWkXccnP5fkKD1V8bqG
	 AQrp8yU+1knEeWB4pCRAjqoVJNKbnXs/r4tup9fByZXD5EgZfswwbwv0q7Wo741gye
	 MvHPzW2Tb0nrON4/+fHRtWe9N46CjKkZ5ux8WM6YRAe6n1JfA4kFbYnKDRvMa6t1Pa
	 3vRMCPXPpyakA==
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
Date: Thu, 26 Mar 2026 18:38:35 +0100
Message-Id: <DHCWB6YQ7B8E.1I9WCHXJ6FBPH@kernel.org>
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
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Jason Wang"
 <jasowang@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, "Alex Williamson"
 <alex@shazbot.org>, "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini"
 <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260325052919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260325052919-mutt-send-email-mst@kernel.org>

On Wed Mar 25, 2026 at 10:29 AM CET, Michael S. Tsirkin wrote:
> vdpa bits:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> I assume it'll all be merged together?

I can take it through the driver-core tree if you prefer, but you can also =
pick
it up yourself.

