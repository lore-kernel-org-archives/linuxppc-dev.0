Return-Path: <linuxppc-dev+bounces-12868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7402CCD184
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Oct 2025 18:51:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmNbv0ybwz305S;
	Wed, 15 Oct 2025 05:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760467899;
	cv=none; b=jS/fxYSWsMeKUqyqP3OgweJJf1kM+yOZd03t97BvSyQUxxYLg5BKv6/+UXq5hSy2P4O/SSRuqhMF3UXYW5jXBgPzKRSAAHO1n2Zcoa76mHo6v9Rre9xsj9mQ8Us/HgYSNLU/UAogKuoa2jDDsLGuHIGBf5ImBozqVowGu3xUx/eED5ghxTIanmi5IkI1rqYS3r0xx0DBG1nNhlj2n51Gb/2i4QyV9VOeSDs9CRdXhxv/XC/ggff7jqKJong/utP1VjqgIdSZdR9TagaZzoRId9kQ6Fa1FvtCgkr/w14wbG7JrfVwBzjWQugUH5GD5DK8nq6erj+spCR0iXLbt22VkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760467899; c=relaxed/relaxed;
	bh=6W9+dn17q8PcyyIxrsB97A8oP0SfYq9Q/LwPjNYB9HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PTXLlWzXpqWBHJD+0MYatsf1krXjTOIhRln7mzOYc6InEskZfb8tQKm38Jd9BbggM6VT3ADf3RQG7vVpjyz7i4O13d4oW+qavCAOR83R1uZOlz39cMGTtSJ24JjaZNG9SxvK1714Io5VrCTFUFGKAuqTpdDN2yd3lHNUX2oCSJtaUqMLSPfD++N6hhAPl3VWK+j7q3Ziov89opH3M95CJHMV0XnEWy33xQYXLYiy9Ku90Ic2mMf8mU0q+o9dRWtnLCPF33mymb/RiKY9AIRFMpJwWmT4QdMYxX/Z+tDM2S5IOlXvUGt1gzk1gzvMGEZ8RdMaQX8jRxX/l/9h2f9Dgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EcbMZCng; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EcbMZCng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmNbt2Tk5z2yrZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2025 05:51:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B505E4069F;
	Tue, 14 Oct 2025 18:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A377C4CEE7;
	Tue, 14 Oct 2025 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760467895;
	bh=6W9+dn17q8PcyyIxrsB97A8oP0SfYq9Q/LwPjNYB9HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EcbMZCngfRrA/xLgNse0X1ojCMSb5VC5Pf7eWJWrOBEtGR4pSiO/nM6m441taRqxp
	 6RwwJesb3t0cU0xwdfLpG79hnmGKkcwDq8/1k+25dkILncIB4BFTc/dXyZiF9FVIvf
	 U0PgyZu6rPzKo8G/ftEMpht3oa8gUiuCCNRxXX4NLDA2yk5wkpqjwVCjAJU87f8xgJ
	 jOlHR2DJf84djiHy8+2dUh3KuQUWdCvT7363a7yHmeCGnDBNTu86nIJDahxZ0e9H2I
	 EUf9tKTFoppcXvhmz3vz3Wo5MlDS9JLQhCnQVKzfs+vjzTQgXKkFiGRXSzzopgQ7L+
	 t/CkVozAHmHIg==
Date: Tue, 14 Oct 2025 13:51:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251014185134.GA899287@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013210602.GA864364@bhelgaas>

On Mon, Oct 13, 2025 at 04:06:02PM -0500, Bjorn Helgaas wrote:

> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")

#regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17

