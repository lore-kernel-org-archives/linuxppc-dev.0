Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA9606A320
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVnQXRQw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDmZ32ZqGz2ynZ;
	Wed, 28 Oct 2026 10:15:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793142939;
	cv=none; b=NVf8anfWAs5+FEr9RsLATBPnJi/8g1hgIZziawqZVyGw8YeFdzHVEpudJEyHY8ddNg6qzC5tM9GTSmgLY5IG36pUR8+gTpPndVneM6XUKa+UXdpIDOTRkXI23FqkKrqozdE0drC7kjaSfMW4RuQRS7yfUsTTP3swFxzUzIt9ppZGX6kacwbiSDUGAE7aV246R/5D5QKWKV5Nr2Y+2ophYHg83ahO6pZLs6Jcpy7rm0Z+6z/11HZs/41I6yLjU+ZnAiTD00si2cofk4OopzypyukfkHWNAbtTFM4v9+c2MhPob+jzkIiEmey+uXYm3cwVYKI76rcd6FM9Y4b2HLcEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793142939; c=relaxed/relaxed;
	bh=CA/7Tox0t7EgvF7I3HnmzpFFxPiq5q1ElSMkzQot6VE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VODGlevDRMNCEASBIzaQbThBCY7nAXkcpLPvtxnDmWp32klU4TvEy2CsCunP2iMuaF7yFG5C+BgZfyNlfCVj5j8fwbPQIt7eVuw7npIkOUlxdffL/i3d6VvbCzC9p1QtRBtm0Wp0UAvpiW7ZWqw4pnRy1qxzt6LDQuJcbiz4foDSgWZ7IDuQ9F6/nsgVQ9+VM+tky1ZiCt+xIGIRlG2hDvxY/9JgVp9QCQ+ylj3Z5qqciGAqw+DChTNcmgdbmYsNYzCDI4YV83lzKIZAiIgOnKkQnrLvrKMx4gbyruXc03TiOLGnV9FlNxuR7A9Tj1yUXuyzIJYVxDHmLrrZrvkSMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVnQXRQw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVnQXRQw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDmZ24XXRz2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 10:15:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D51FC43E67;
	Tue, 27 Oct 2026 23:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875A81F01825;
	Tue, 27 Oct 2026 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142935;
	bh=CA/7Tox0t7EgvF7I3HnmzpFFxPiq5q1ElSMkzQot6VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PVnQXRQwjWsHVoayiNThshV99xcymU/V/pIZswtKDDmYMDJnOaOF0e4WQ7NFLyn2U
	 hgbefSKUGrnKZ0wCwyAx6tS3q1iVEd2hqs5S1mvjxrh7pnqk7AkuDvh0wc0rFHGQZW
	 CCI0r4bHaPu9ujtyJPNsRSPmR/5zGCIWHZHLXZ5Wp8LZlMpqX2Pd+u+Ay/HTGI+req
	 r/99UDdROlN1XtaPaPQIWoAM1cKqtxREE8Szyk5HcNBzLT3i1yjFBRXX1sUwq8EkYr
	 wrMun3XHkKgkbcRXvN7v9s6BDe1OKuYAOrghVqQXkizpkbbFOoNsm+SD4JzlS8ufzX
	 6Z8j9YCxGv+ew==
Date: Tue, 27 Oct 2026 18:15:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] PCI: dwc: Cache PCIe capability offset
Message-ID: <20261027231534.GA520774@bhelgaas>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 08:28:11PM +0800, Hans Zhang wrote:
> Hi,
> 
> The DWC PCIe core and its platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure, including in paths that run more than
> once such as link polling, suspend/resume and interrupt handlers.
> 
> Add a cached pcie_cap field to struct dw_pcie and a
> dw_pcie_get_pcie_cap() helper that performs the lookup on first use and
> caches the result, then convert the core and the 14 platform drivers
> that use PCI_CAP_ID_EXP.
> 
> After this series, dw_pcie_find_capability(..., PCI_CAP_ID_EXP) no
> longer appears in drivers/pci/controller/dwc/ outside of the helper
> itself.
> ...

> base-commit: 4352b8aee98005853aa63f57d6377282de17a33f

This does indeed apply cleanly on 4352b8aee980 ("Merge tag
'i3c/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux"),
but that's pretty old and not really useful any more.

PCI topic branches are typically based on -rc1, but of course v7.4-rc1
hasn't been tagged.  Until it is, you can use pci/main as a good base.
It's currently 17bb0e2f6c80 ("Merge tag 'pci-v7.4-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci"), so
drivers/pci/ in v7.4-rc1 will be pretty close to that.

