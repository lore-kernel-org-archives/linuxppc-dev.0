Return-Path: <linuxppc-dev+bounces-14143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D335CD4F2F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:02:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6RSY2dWSz2yrg;
	Thu, 13 Nov 2025 15:02:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763006573;
	cv=none; b=M/IKKXX/WlcsADM3nZxT9JRCoRtfeiULKC2jeSoahE9SUGWMtJcA5cwphpBVJJSo4YnemjAQC+ZUsIGkS5C3XG6cq/cR11u4pC0j455f8mn+cDi8CP5aoX9YIfGMtMiiVXddjm8UWY7dezBJfuzg+FqIseQpkFUVmcwKbjlEyJlqdZR2kbcnB42nHYN8C/PFdgVyys4YP73EKzMUHnk8TtrFFJiLQibathADTpsydJN5h5VinHkR0IUlOIBSp3uh87OxRXa/k4aQ3cUft1559zN2sbvigBYmSI+xUPIGC8KFNL8h3BrNeyFYO5Lr2CTe8iNLK5oXkcDuOqpc/9vj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763006573; c=relaxed/relaxed;
	bh=/3iziekue9WvCStTScG6K7mZ4NRnZctYfo7BPPMdMoU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z50phZNI1T/nYFUX5DBl2riKm1nrN1VITrCZvy7zHh8rV+SZyEGEtkpgF6bjrKjhvTgyY6jb5s0W9j9EX4ErdIfRdvGUYXtSg1H4nNcDpXQ1yiBkjaDpeC0Ke2DwoQ/ZP01LabH7EFDdb6TRBiTq1TnYEuTJm9OQGrYb8ufsL5WgV9geDBku0D+i8yBdP5Vws5N7UdENUQPQa2YbVrUMYOtbgxrGQMJdOmXHZqM+9Xof5HOaEAhqsNnICpWajUx8pOxSjo3xu4Kznv9qtJnGITGUBf/t9L2ed6FkB7RjotNguDzFtHig1qT4PIjaYp+fGwMFaJOwS6FczFfMMyff4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none (client-ip=78.133.224.34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org) smtp.mailfrom=orcam.me.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=78.133.224.34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6RSX1B8Jz2yjq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2025 15:02:52 +1100 (AEDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8753292009C; Thu, 13 Nov 2025 05:02:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8093392009B;
	Thu, 13 Nov 2025 04:02:39 +0000 (GMT)
Date: Thu, 13 Nov 2025 04:02:39 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
    Christian Zigotzky <chzigotzky@xenosoft.de>, 
    mad skateman <madskateman@gmail.com>, "R. T. Dickinson" <rtd2@xtra.co.nz>, 
    Darren Stevens <darren@stevens-zone.net>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, 
    Al <al@datazap.net>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
    hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org, 
    debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/4] PCI/ASPM: Add pcie_aspm_remove_cap() to override
 advertised link states
In-Reply-To: <20251112204658.GA2242023@bhelgaas>
Message-ID: <alpine.DEB.2.21.2511130354500.25436@angie.orcam.me.uk>
References: <20251112204658.GA2242023@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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

On Wed, 12 Nov 2025, Bjorn Helgaas wrote:

> > > +	pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to avoid device defect\n",
> > > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L0S ? " L0s" : "",
> > > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L1 ? " L1" : "");
> > 
> > I think this gives a false impression that the ASPM CAPs are being
> > removed from the LnkCap register. This function is just removing it
> > from the internal cache and the LnkCap register is left unchanged.
> 
> Very true, this is confusing since we're not actually changing the
> LnkCap register, so lspci etc will still show these states as
> supported.  The quirk needs to work for arbitrary devices, and there's
> no generic way to change LnkCap, so the quirk can't do that.

 There's no way to poke at hw, but that is only relevant for x86 I believe 
and not the default access method for `lspci' anyway.  For sysfs we do it 
already for things such as fixing the device class; cf. `quirk_isa_bridge'
(arch/alpha/kernel/pci.c), so why is it a problem here?  Unless we want to 
keep it for `lspci' actually.

  Maciej

