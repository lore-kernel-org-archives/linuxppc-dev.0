Return-Path: <linuxppc-dev+bounces-18742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D112EFEC107
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgL932kZ7z2yng;
	Wed, 25 Mar 2026 06:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774381495;
	cv=none; b=f5wM8x0095XSETQIWc4SlqWwiSHpbN/GJT/N4vPZ36BZh97rsTMW1mdGVcNYcH5ogwLcqB+olTXYDBuu8ztUazhzBB7i7Yqs7sFkumNZCv1uaQCgp54ReAKMfE7vvQ8/g7dRL/onRCnRdMzEaou5KnFgalPWR6AW5r3Y+64Ax/j6toDDuNiLeuLGszxm0+9KIJcKpU4owGQbc3+O7dRMDpstbIWLMstWgzu5MfbOuTHnX1gzDWuYpkT8vyq3Wrv98UAc8z9jZkeZFxTRXa3tf+bSDQ46pzD7obAjmBTSMNevV8vT92cUWDGrFXRL9L1EYcxp5xxbiPk1lIVrZRTdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774381495; c=relaxed/relaxed;
	bh=oTkOFqM2M39cWVqUtU9Hd88xIizvMwzDXk70xhu+U1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dUmNBqCOkvjw1HTWpTqpBmYbc5cr+KQMZpJ7SykEb7QvIqQDIjqfenxNod5vv4jKFdd2fYECyplWWZaCEJwRfKWzgt+Spy+lB1gCvsNB60WFFt74MOh52svlzLpjhQnDMGa5RfGZpkFu5WQwBEZUhrUoTaETGWeFamscOussnuGyFwUlcNdoIKk9yRF2EVBcKG4Ne+e6OokhW/OERIdRAvt3YqRGc9jViGtNgU7KKjct7BuTpO/V9xyQYCMLZ+ci/E/NqugBbfIstvkXP87+hdo4kdAHLEyXUx3tZrwDB2wVXbuzKjc5U0xE6Hsw6XX3y+V9w2lO0Ctfz7DUw4xC3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BI/PyKSY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BI/PyKSY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgL916RBTz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 06:44:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B3A3600AC;
	Tue, 24 Mar 2026 19:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF553C19424;
	Tue, 24 Mar 2026 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381490;
	bh=WRF/0A79XI/IfrPujL8sWiRG4jtPsIHG8/HKlYhxfwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BI/PyKSYvjLJXWbEpQrc+czH+55hhTQfVKT55Uu1wKsITHQaRklHZhshTVjzHQFZN
	 XI99w4CrCK+yRfm2877TM5yV4pPdvKaG1DWbUoq9X2UMljaiVAeNppp3zNtFe6VQcR
	 Nbxio4BzKuKvbSdbHpiqyp9b0V4Wi4iBFmRLBu0AraFrnoul9PN3a4ntDRFnw+1WBV
	 6VOLh/84HoNWnxFvJA4p13awciT/KZz8A8WdIkArI2aCUbV0ZkSk5h4r/JYUTPRIIT
	 T8Jt8zQSnSc69wMDv4JXXRT2onYDSQlxz5UqGBDTvOp1c1OxGFbD7+EZxoeS8MPSTJ
	 8n38/skizDzlQ==
From: Mark Brown <broonie@kernel.org>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
Message-Id: <177436441990.98682.12977271865531185229.b4-ty@b4>
Date: Tue, 24 Mar 2026 15:00:19 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-6cc06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WRF/0A79XI/IfrPujL8sWiRG4jtPsIHG8/HKlYhxfwg=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGnC6amgudhaUXvPlk+pDm3GoyUp8H0DzJj7P23jodGH3vgaM
 YkBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJpwumpAAoJECTWi3JdVIfQ7W4H/0HK
 bnLD6QxQOBC+fzyIxZ6G6kEKZPO4GVW3Pfn4yfAzX5qrdKQRkDgps7IYWut/u33hS3f+Z04EmOJ
 lYrLIJIM422nR6nge6hF8EhqNBiTq/w9q7cGC48hH540F15d0sLd2//XCIGupIA1RXpBqVdzq5x
 OT6qjdHSfs8FyZ+oeQmp08Rcg1XfVc+MneH1PzidJufZ+tJUtayZw29OlGfNk6vGZ389vkRi+Ec
 XFn5qSzIYh78B0Z0zXzPv2/IjG8frEcheWdi3dJbD2bUS4h2S1US62r3HG8U3Au0lRz8ggXRMML
 03vuVW3IP0egShhpeZHJhBzFqhYb6LFlY+k9hXc=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 24 Mar 2026 01:59:04 +0100, Danilo Krummrich wrote:
> treewide: Convert buses to use generic driver_override
> 
> This is the follow-up of the driver_override generalization in [1], converting
> the remaining 11 busses and removing the now-unused driver_set_override()
> helper.
> 
> All of them (except AP, which has a different race condition) are prone to the
> potential UAF described in [2], caused by accessing the driver_override field
> from their corresponding match() callback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[11/12] spi: use generic driver_override infrastructure
        https://git.kernel.org/broonie/spi/c/cc34d77dd487

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


