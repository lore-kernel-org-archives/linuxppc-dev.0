Return-Path: <linuxppc-dev+bounces-19026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F51061B15
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 17:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkz4v5Trgz2xnl;
	Tue, 31 Mar 2026 04:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774892335;
	cv=none; b=JZEvsN0uHsDz67lYAsaUpT75YypQBxnWg8dJRoaG3QgxtHXyNh7yuHvFfM6ABgTQ8n65s/jqh1kswcRlQlj9eJZsm1L5fC4itU5ZRdm6dQEpH2HRb4GhC4wh9+B1Q3UktqlO4zj/qWWAEbJvgsjloDPswfGTxraXQLjDSRKrIIFvJwguZWye4naiY/evyPCT8qaZzGlY5ZbRYs9U3e5JXn9Ppnn92t4v0K1yAFG9JAy43gIq0svzaM0AFIbbqCUe9TixEyrZfU35rk5V/WnLRokHMQkAmB71ClMSm/mybCIFwNqaHiIxgZ22EoqVk9udgVAzuhx8RW3Rw60ka87iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774892335; c=relaxed/relaxed;
	bh=Xa7H2ucUR/JUgOTFXSO4oxkQmITA6/wQrqo1d5LTeFw=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:Mime-Version:
	 References:In-Reply-To; b=K0XpPTLfltEjsc7hKXdDReMQa3L2WzLpC+30dV+PqePdPaPFs5LtV9vC6sDaW8XNipp4Dze+ZJLiH2Su9GT55ILgVhg8Wx5sPH5yRQQDQt67qRkqrQFAZ9hCihBCzde0YSrPIsKx+tnA41cFaWbkfmdtbVs1cCC+A6NijPgN2M3vGQIdfz+lXU8luYeW5avxGQeFxENT8n+D9bx38o5uR38FXOYIDi+6zai/he65m0gQ7Fub/SJxURfjUo2QSLgCC64AnZ3n5jzZxV++/HPMzLqH3XD9ur+4A1TAjvp3YRZtXqec9muLpcdmEPWKJoQJf2b5rZeCeijjEauSZ2ZDDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S56YWHrx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S56YWHrx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkz4t6shlz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 04:38:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9772E42A31;
	Mon, 30 Mar 2026 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39967C2BCB5;
	Mon, 30 Mar 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774892332;
	bh=/8RwifExta3hi9wb0UAvoCzja5DI/LlE9XUZDEKtDlU=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=S56YWHrxhwHLS+EfSzEoW6H9YreN8wrQZ/7HEDAWqAjDAvn6rNoi6jXsbwo3fyTXv
	 TjHIGPt2qRPbkCCC5yCfSjAbtAw6BzXCZXCaq/yn658JrR6/xBRJ7/mYaDQNBA9Pmv
	 wsEtOTKeR8oMh9VC6LyR87wz4W/9tT1+Zpl9oixkuOSdi9YZxoGPEs7WRJpEIUF6YP
	 QT3eMcBSThXdTkmokN7Q16p5we5dG5K2/LjDkgP9NUYvkxjgwB7vubbfIKhxuyu2dj
	 oq30Tych+FNSMtuze99IC0ZOa+AcROHbp3uZujJVXn+3TGN1ylZ7O8WH21Mk5oRMNX
	 /gBaIKRkeOGJg==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 19:38:41 +0200
Message-Id: <DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
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
 <eperezma@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gui-Dong Han" <hanguidong02@gmail.com>
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
Content-Transfer-Encoding: quoted-printable
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
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-6-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>

(Cc: Jason)

On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_bl=
ock *nb,
>  	    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>  			 pci_name(pdev));
> -		pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
> -						  vdev->vdev.ops->name);
> -		WARN_ON(!pdev->driver_override);
> +		WARN_ON(device_set_driver_override(&pdev->dev,
> +						   vdev->vdev.ops->name));

Technically, this is a change in behavior. If vdev->vdev.ops->name is NULL,=
 it
will trigger the WARN_ON(), whereas before it would have just written "(nul=
l)"
into driver_override.

I assume that vfio_pci_core drivers are expected to set the name in struct
vfio_device_ops in the first place and this code (silently) relies on this
invariant?

Alex, Jason: Should we keep this hunk above as is and check for a proper na=
me in
struct vfio_device_ops in vfio_pci_core_register_device() with a subsequent
patch?

>  	} else if (action =3D=3D BUS_NOTIFY_BOUND_DRIVER &&
>  		   pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>  		struct pci_driver *drv =3D pci_dev_driver(pdev);

