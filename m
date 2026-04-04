Return-Path: <linuxppc-dev+bounces-19316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F56AD7308D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 15:08:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnzVV6tymz2ygd;
	Sun, 05 Apr 2026 02:08:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775315282;
	cv=none; b=kaUJrdP2iECm8bZSW3NdG/PbXJgUQFWyagkE4zylrxr8Ynim6q6LqgTDU3lyVhHMVSGRj0d+elw7rk2qPARsW9Ps2Mr764a3C7y4q/J2hyRDXIft4j/l1Bk5UU6+t23Nz5Czg6L/h+bxaJLgHAfv60cqdBCGTRXJnjcirEgAP1C2JA0axuNoCGe9qOBRmkwC5LS07gu1OyXR8/Sz9rhtlTDNqpDzbBo1RftnpoB4qtnai0gb8FDzyPM70pedMTHhS5sw8FQLa2Sm5oCLWfouT3ZPTcfRkpInVfWSEl+Of6KgurdKX5xF0G7VTZHuErRS8M1cUz4heHM+umpYQiIysw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775315282; c=relaxed/relaxed;
	bh=Gs1kMOlXrbZsLGY84yk6OiZKLkuZPgIWvrdhGV8DpHE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=aATQf+xls6UQkGbMxVsGbSRsmrwz1GXZGqEYQaF1qnWMDaizJnCemUemzaco+skw+WTVc+aGbD7+iAhKpO+4G4RfHTj4/h3Y0Nm+lxdiVSuNCs9o5cAtR4i2EAyN6LneFprsmFWhDIXZPCd1SWaGQ0Kmabs7vkuqwPUd0NOwHOJG/WZV5OUw1bcRtZPtCNsFbTtTwpf0F2vF1fzPpCN84oSEq4U6X3SR0npwUizSWOgvYM2qm0r1ZMYCgTJTi3L1v85u+/6DT7132lOtxxS0gYxlkeKiwu7ARuyCOBLkAewkGMdszCxGLJ0dIobEAA5BolZlBa0t9PQcbeRRMFINGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BqFwLyJn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BqFwLyJn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnzVV0BQPz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 02:08:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09D4760008;
	Sat,  4 Apr 2026 15:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D01C19421;
	Sat,  4 Apr 2026 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775315278;
	bh=vsboea1jS0mbXrEN888C7vI6KSnNsfnadcjKrpMmAnY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=BqFwLyJnTBhpomTB+sXRdwyVaWyzA1LM4x/jRCX0BFGrA8JpgKS8rfJ3LIpPDY9yk
	 p+d1jqhJ1Mjf2wU0RpwYFVVUOlAbdMj9UlGnuClj9FmR1QC9ZSfTvrkB18QTB/RfaR
	 3w4rXTh/VlmdJJ+A6SXPJawUID7A7XZSgzuHSGqEFu6Tbouz8uVWV9o1VaA1GFu7gI
	 3NdNsOM8C1NHzuvTeKFcIyrqClEFUe0UqumonfV9MfwITs9dnEyWj08ERsdYv9WbWd
	 01HVmLT594g3v4oxts7zZYAk6RxZP3qVHdO7PiI+5yTu0pvGRJP4QeyHxy5PzJrrxp
	 3oxcw/dlirZ+g==
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
Date: Sat, 04 Apr 2026 17:07:48 +0200
Message-Id: <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
To: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
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
 (CS GROUP)" <chleroy@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
Cc: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>,
 "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>

On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
> Danilo Krummrich (12):
>   PCI: use generic driver_override infrastructure
>   platform/wmi: use generic driver_override infrastructure
>   vdpa: use generic driver_override infrastructure
>   s390/cio: use generic driver_override infrastructure
>   s390/ap: use generic driver_override infrastructure

Applied to driver-core-testing, thanks!

>   amba: use generic driver_override infrastructure
>   cdx: use generic driver_override infrastructure
>   hv: vmbus: use generic driver_override infrastructure
>   rpmsg: use generic driver_override infrastructure

I have not picked these up, as they have not received ACKs from the
corresponding subsystem maintainers so far.

>   bus: fsl-mc: use generic driver_override infrastructure
>   spi: use generic driver_override infrastructure

These have already been picked up via the respective subsystem trees -- tha=
nks!

Thanks,
Danilo

