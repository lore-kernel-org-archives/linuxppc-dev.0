Return-Path: <linuxppc-dev+bounces-24903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D1EC53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 15:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h833p2Gztz2yhD;
	Tue, 28 Jul 2026 01:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785167478;
	cv=none; b=XJYoGhYxbgdOM4TmyIMlAb06CGJ/Ic8zJUVc4RCjcYdM5QRyVjzMmq7BDQrzH6kN0A9wwCgThIXHPJea/vQ/xuJCz2QgtgtwHFp0OlBbLLU7l5+Kcgsxso1ZLHmQREbnuYtgae/FGn+RDXinkZL6kPCOkQIxG0dP2NQ/9vwyA2ksHwd9tddKaRFaHokLUvn3XCaFr30rDjZfh+7jkYWR4kbxJY5Quxz/AkdnUELzq4fWRXGzkp0EB82KaTWZGgTSw/Ut75QNn7IKxHExqITEEaGvYvPyIFyLfQmVhSbvQkHTHJ/Py2FYcyUytwT/Kv2udHfjUxEsa/EDCYs64vjYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785167478; c=relaxed/relaxed;
	bh=L0Y+MjztMze6dzvUP1kkwe6PSrgocCQE9UXUfP8KTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LW39iF+5AVmyhNYNsL5CcwD0aeWTGXUpTLS/VFyVukEAbog3OPzohbxGCwAbo9WNPI93mr7s2J90xdg90I/F7XUYKD+ALgQ+Juow7W7aJZ/zQAeu9zginHL90hYJMRurEhN6mhJVXF9noWvq0ZHwSuYDaIA+sN4S66vTiHvG9j+VouE9oZhHS1DQvQBnmsE0wGIOcBDQFIaT8S49i7fpsrbrzkzS80yKhaNapHrURIHuAcxauMCcC79Sc6oQRNil7Gr40E4AyyMeum+Q7n3gP9xU/ErjqHGdcMC57yzAdZb2x1H3lKmrmDY6yxzou8w6y/vFqvLBY9D63nPsn4ZS2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4jLuJ7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4jLuJ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h833l5zg1z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 01:51:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 26EAD4039A;
	Mon, 27 Jul 2026 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44EF1F000E9;
	Mon, 27 Jul 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167472;
	bh=L0Y+MjztMze6dzvUP1kkwe6PSrgocCQE9UXUfP8KTyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BX4jLuJ7qp1/B3HwbUb+4GRdr0DV9mClD+XdY68oxxyj3WwZrdtKzoQtYj+13wbaD
	 kxdOq/ezFgLb/9lV6E6mucTY/9ganVYPb/pxioG4QUY8ORjvJeK0OUud0SwlqqM++u
	 0Rb21x+oT1fQE1nLa75+rAkYrTMtUhhyoWOpuqEtx64LXzvI/R77GFM/XGDrUy8wcy
	 GDm0Bnn9JpwOUPyxrhQAQohqY8k2t2QfnLJ46M/wpEaRXQR+ZGM6zJpHNgh5AtTnPF
	 eLlA6g74sVhLKeUUjUMrBL2MsGsdbLIao6ASu9rPVvuc8n1iUPUIVb6R8kk2fQ6Px2
	 JL1T6AS/UB67w==
Date: Mon, 27 Jul 2026 10:51:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <20260727155110.GA1218153@bhelgaas>
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
In-Reply-To: <amdnMg_J6T3Sys45@wunner.de>

On Mon, Jul 27, 2026 at 04:12:02PM +0200, Lukas Wunner wrote:
> On Fri, Jul 24, 2026 at 05:39:03PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> > >   PCI/AER: Fix mapping of errors to agent & layer
> > >   PCI/AER: Log agent & layer for each individual error
> > >   PCI/AER: Deduplicate logging of Error Source Identification
> > >   PCI/AER: Emit TLP Log only for unmasked errors
> > >   PCI/AER: Move retrieval of FEP and TLP Log into helper
> > >   PCI/AER: Support Advisory Non-Fatal Errors
> > > 
> > >  drivers/pci/pci.h      |   4 +
> > >  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
> > >  2 files changed, 200 insertions(+), 54 deletions(-)
> > 
> > Applied to pci/aer with the intention of v7.3, thank you!
> > 
> > I noticed a sashiko comment on 6/6 but haven't had time to look at it
> > yet.  I left the series on pci/aer for build testing in the meantime.
> 
> Below is a fixup for the first valid finding reported by sashiko.
> If you could fold that into the top-most commit on pci/aer,
> I'd be grateful!

Fixup folded into "PCI/AER: Support Advisory Non-Fatal Errors",
thanks!

> -- >8 --
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ff6ff7abc286..2a380bb9bfcb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,7 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);

