Return-Path: <linuxppc-dev+bounces-19030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7221F1061B1E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 20:11:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl2SX5ZW9z2xSb;
	Tue, 31 Mar 2026 07:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774901468;
	cv=none; b=BWTxj7CRUL6MnMdCCvS4W2Nx54rSOhiMY0peyeHou43sU/ZEeM/ohPuZa09W2kRhUnTU4Rt9TKoZkPfnnDRHm4rZC82ETTZjWDc1Qdgb9zz7sGzJBvolnkD5+cyfAIXqvI4oXEHz9YfSKwTvg/43Ua49+ZT7xIme8RbgcRtr4lVxzRECcMJ/3iubAdqs+txkfxNpUvbtUaHOMC4r/jgTw6TeHfYYNgCtOlvbK44Bm1UzaC54xzFMa1aoe7R2PyujKbhD3jhqtOKEwoqO1ZO2QYf1eVaMd6a3XYrtCe8YSKYgrFiEzg0T3ZU7OW+H9QDJZSRNUPQbFdAr04dqVJI3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774901468; c=relaxed/relaxed;
	bh=l6vFZymkQIpCjGyZZ0waTIjtR5dYu9l/RauB0EHs2cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsj5mCf9WBEyequywowIzxWGWyWsgP3lMwmKP7iq+vH+kd64tNZAYn89jWjcLmBHimc9vEz0SOzJJu9Mm8xXP2aa2dVKMoF72rbO+znOxyIKZqGPZya1JNh7Bl3Knxp0sWMpDiCYJVOYiJ0uPoDIEG15HVi0L6ITAvx+YjJfCr2E3R2kbt4iplVCZM2dHrOQaY/GYonmrgqzHVmsVqFkKjwszBy2UeoEcnTtdsMqdV9Q5lMQ8RveD55uLFUdJXrCojGLzylxszjkLOHMJOQojvpPp0gFsHKr/eum+yAio8r0faOldWwpdLLrylZAfbjfhpEFy4d+iGwQRqBKiikhoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=p3Q7z9HD; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CAP30Hzc; dkim-atps=neutral; spf=pass (client-ip=103.168.172.141; helo=flow-a6-smtp.messagingengine.com; envelope-from=alex@shazbot.org; receiver=lists.ozlabs.org) smtp.mailfrom=shazbot.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=p3Q7z9HD;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CAP30Hzc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=shazbot.org (client-ip=103.168.172.141; helo=flow-a6-smtp.messagingengine.com; envelope-from=alex@shazbot.org; receiver=lists.ozlabs.org)
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl2SP5x7bz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 07:10:59 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 32B1F1380404;
	Mon, 30 Mar 2026 16:10:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 16:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774901456;
	 x=1774908656; bh=l6vFZymkQIpCjGyZZ0waTIjtR5dYu9l/RauB0EHs2cg=; b=
	p3Q7z9HDaMO9l49KzGyd6QCozBDRkYMrNAMT016WX/fHIPodDvJbWxfN7o7Rq7vD
	ssq4dL3KEVXFE49rB8recUd5fVpSerRill0EPB9eG2k4c2akGO+Qp/G8D31RmPbX
	7TlkrNox2UjWyTlfcttMC7E71kdY+trnef5Hm61drgcfUPakTcCNL6kKwNKjRSBV
	U1uiNaG+fKZAZmTv0+H0872Gvi06OSqLLzx0vsDX2qjVrQBFMlsZacR2mbGsDkc/
	gT6xVnpGv8MRHmzJBZo58FBd6w5IU+6ogcmojJLtPY3KydD8fWurT3VIXthGtQVM
	kQSao6bXLTSzYllu1/tldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774901456; x=
	1774908656; bh=l6vFZymkQIpCjGyZZ0waTIjtR5dYu9l/RauB0EHs2cg=; b=C
	AP30HzcjqUcGAYtq0Vy0npz+WQZ0xoM+V3KrqPMrmRQ5BSmU53GGUiyx5E4wI6yA
	FyTr5/p4paazsu/Iipz8yYZU+1phMDKI7hagtD986FHeu0o1F4zYmBZsEakuW92m
	weI9ASAX8aFEL8Rs0Uec3ctb/HnJ1MgKC92d8MBdvS6OH7G3ewGRc0+tfGddZ4Gk
	WxhrjWBcLoGs93zMy/odTXwHEJHh5W5FS+Et9LrpEfOcBRgJ0bBAStrIpl6DkWE0
	Q7ETKFm9iu5onjWSvKFXn0ELTMMUBd/OPVAOOtwXaNWNshQ6cuB1Amc/2nwRZfpT
	eHg87urYI5Ec6Lkq0sXvA==
X-ME-Sender: <xms:z9jKafG3C1ppH9T_m6ALHXE4Xg8LRK7hBmf8rBxsDTwjV0YmtGN7zQ>
    <xme:z9jKafRfVIq8DMXZsvpeUjwD446zuGALRlY6oTA_zptsdyXkE-2d-NbNcA082cKf0
    ss8FY21mgRpxHw-PTPA5PC2K5vCU9145ou0r7AQwqll0ampOmU>
X-ME-Received: <xmr:z9jKaX5EMTRV_NaboCc_h79atFYxCsQIiTsRvvS3id2SmTFWS4FBTgmuiO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeehuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdp
    rhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    rhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohgrnhgrrdgtihhorh
    hnvghisehngihprdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdr
    tghomhdprhgtphhtthhopehnihhkhhhilhdrrghgrghrfigrlhesrghmugdrtghomhdprh
    gtphhtthhopehkhihssehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:z9jKaXPahdSu6NAxzDLCWHFq0SjTPnbaOV6q1JEVDN1n0TGZgvSOLg>
    <xmx:z9jKaYs_pZi1AKnrgY4kd6IlWW19DwfnZAklgCAjMJf5o-edI-wG2g>
    <xmx:z9jKaebkSHmk2-FfV3M99S1E_Kbm3scLKfLmyO_zzcLIBxoGL3vJxQ>
    <xmx:z9jKacg_NAD9M03CgHB8mak7EEebVzjqapJHxaBa4zGAHu1ISFIb7w>
    <xmx:0NjKafrBqSu7i3ficH69WDNrAzczvh4pW1jhPhZmK7WHcIBXnovlo-fr>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 16:10:52 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:10:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Russell King" <linux@armlinux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Nipun Gupta" <nipun.gupta@amd.com>,
 "Nikhil Agarwal" <nikhil.agarwal@amd.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Armin Wolf" <W_Armin@gmx.de>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Vineeth Vijayan" <vneethv@linux.ibm.com>,
 "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Harald Freudenberger" <freude@linux.ibm.com>,
 "Holger Dengler" <dengler@linux.ibm.com>,
 "Mark Brown" <broonie@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowang@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>,
 "Gui-Dong Han" <hanguidong02@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Message-ID: <20260330141050.2cb47bd9@shazbot.org>
In-Reply-To: <DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
	<20260324005919.2408620-6-dakr@kernel.org>
	<DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 19:38:41 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> (Cc: Jason)
> 
> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index d43745fe4c84..460852f79f29 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
> >  	    pdev->is_virtfn && physfn == vdev->pdev) {
> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
> >  			 pci_name(pdev));
> > -		pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
> > -						  vdev->vdev.ops->name);
> > -		WARN_ON(!pdev->driver_override);
> > +		WARN_ON(device_set_driver_override(&pdev->dev,
> > +						   vdev->vdev.ops->name));  
> 
> Technically, this is a change in behavior. If vdev->vdev.ops->name is NULL, it
> will trigger the WARN_ON(), whereas before it would have just written "(null)"
> into driver_override.

It's worse than that.  Looking at the implementation in [1], we have:

+static inline int device_set_driver_override(struct device *dev, const char *s)
+{
+	return __device_set_driver_override(dev, s, strlen(s));
+}

So if name is NULL, we oops in strlen() before we even hit the -EINVAL
and WARN_ON().

I don't believe we have any vfio-pci variant drivers where the name is
NULL, but kasprintf() handling NULL as "(null)" was a consideration in
this design, that even if there is no name the device is sequestered
with a driver_override that won't match an actual driver.

> I assume that vfio_pci_core drivers are expected to set the name in struct
> vfio_device_ops in the first place and this code (silently) relies on this
> invariant?

We do expect that, but it was previously safe either way to make sure
VFs are only bound to the same ops driver or barring that, at least
don't perform a standard driver match.  The last thing we want to
happen automatically is for a user owned PF to create SR-IOV VFs that
automatically bind to native kernel drivers.
 
> Alex, Jason: Should we keep this hunk above as is and check for a proper name in
> struct vfio_device_ops in vfio_pci_core_register_device() with a subsequent
> patch?

Given the oops, my preference would be to roll it in here.  This change
is what makes it a requirement that name cannot be NULL, where this was
safely handled with kasprintf().  Thanks,

Alex


[1] https://lore.kernel.org/all/20260302002729.19438-2-dakr@kernel.org/

> 
> >  	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
> >  		   pdev->is_virtfn && physfn == vdev->pdev) {
> >  		struct pci_driver *drv = pci_dev_driver(pdev);  


