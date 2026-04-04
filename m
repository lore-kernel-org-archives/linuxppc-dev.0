Return-Path: <linuxppc-dev+bounces-19323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E617E63FEA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 19:20:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp55m3kSRz2yC9;
	Sun, 05 Apr 2026 05:20:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775330428;
	cv=none; b=T6JUTdgz9CE9KOhn7aT1EdSS7s5o8/6M7673YVzy73vMwAPkRhQCePgAtXFc5LX2GhH6eKzJEvNhuY4+kTwqkGnhoN3Jigm6Nl3y+zRTJe0qSD3ViTStOsRuUrXNEJMDd473CvzlhS4AEhG+jkh+LgPDa6sjQaoxO6+4V0bglzCvkIb7hZBqvkquS3ziwYzrulV8gPmp6S2d2muzqmq1+jIrVlCv8hns1/Fe1eDnFhbOUk3QK/d8gZwteGC+t1hhzgMaxvK4ORDjbl8XVcFD0PFw3tK7Ohn/09aE+ErvjU4Sy2hgUSzG5fHmfesxOohSX4KOc8kZupy37LqxQb3mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775330428; c=relaxed/relaxed;
	bh=Gm9FGkRc1QRpNSImSwgwSEPvOU2SLgI61ARuYW5LgUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EZqoSu3iawPvO6y8adqzcQoBkTkuvV3tEgrvlC5n6qdvyLjdJGBXbMSidWxl53uGAIgAfou6IVlAeY+c4v38QDolMnuSjgPtZ+pQaIOLvu0MG27TZY6w7pTYVJ1salF5iugydud4Os01Q4oRs5hgliuRlpRYVeoeyscvqOXVky98ehtymLtWRzF7D0DwGD0p+/ROU1DPfxXDfJsschcAbjkuHJl7uI8OexAzdBVHM61i7GdGCGDmPlS1afOht39kkPNsdzfzdbP5BjWBGNJ4kWJXrBLzo1Ne14bHG9MktkZBwD14zO3KpxiV2TlS9PkzL7FasudgDlYVk3/RP0K8cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jmGUx9ea; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jmGUx9ea;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp55l0lZDz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:20:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1359541720;
	Sat,  4 Apr 2026 19:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00214C19421;
	Sat,  4 Apr 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775330423;
	bh=Gm9FGkRc1QRpNSImSwgwSEPvOU2SLgI61ARuYW5LgUM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jmGUx9ea8KKZGI+yk4InrpqyltSpIFXbxzumeqJLrPMsCCsI1AmriWu84nJMybHDm
	 YQX3Ac/MMmi2g9ubzYQwGTmoLjoD5HvqXXGENZ7sZF+bdgDoJQgXEb5+YyoFBlZFth
	 rIDl6Or9j72Pxfg8gbRbLoxXUMFAACLFbQ4DfxU/vKJfbDZ88r7qcAUikXvNARJnPR
	 UKzC1aGXBRx4bgxjkQ5ETAqx1gHtveCsTmzJzi7+wf9pVTh4t9trQOG4pictre3Zqy
	 coxYtZTwXCoUTOSXcrTxyqOyBWyu2eDrD5N4/86+0enySLlkVbuU3KeCQL6A1XpL4u
	 dWWtgOZ4j3TJA==
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
Date: Sat, 04 Apr 2026 21:20:13 +0200
Message-Id: <DHKM3WP2ZJYE.84WX6IAGUH5@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
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
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
 <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
 <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>
In-Reply-To: <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>

On Sat Apr 4, 2026 at 7:09 PM CEST, Christophe Leroy (CS GROUP) wrote:
> Yes please pick it up as my tree is based on rc1.

Applied the patch to driver-core-testing, thanks!

