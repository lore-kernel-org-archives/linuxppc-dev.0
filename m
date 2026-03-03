Return-Path: <linuxppc-dev+bounces-17607-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FB4EDA694
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:30:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLrw6Xd2z30Lw;
	Wed, 04 Mar 2026 03:30:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772555456;
	cv=none; b=HyJ8ljhw52p0pXKNOIVTqSjMUiPxa5IQaIHgCItu0hLE3sl//tW8owhIo6kyDdRAkzilR+O3b+aZYoKQEQhKDc4VCLU09h4acfAaIwMg/6g6QzRD38i/4pdYu/cd4leQdjhAuAJm/OGOBx3eBrCVoc+Rsbia4KbhFwWfYDgQ06EacTz1RyEfAlByamOp/Apk5nNVVQ1mKM3EDf06zq2lbRkyYL3zIiPow7Ok2mb61m8zqZVYgIn9EnQglo5mOiNxssJkLoeNMEIkh48osNGCkdnv0h92KtdD1FeYRfRnZCeXc62HQlyul9dXMCNSX6FtesTUqwW8bo0J8wd64b4PrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772555456; c=relaxed/relaxed;
	bh=UTOTk/ZV24+OID7LJEgvcIOA3TZg/dywwJRwEN2hzOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TbSnNqwTHktHkowEaA4Ui8iSNU1tc3a9B3mJ95Wo590YTErkVqYliXGRp/vZfPFdwlXvdxNnifZQzLV1CJX41D/wXiikd6FExfqmYqYOWq8A6RxRkarS4Ju/qeeiBM9BH9OwC1OfD0fy0WPBYOG3iqynaucMA9g4EhN61nITMM3Ps/pye31WQqwmkezjCsGfNIJOXyAlvAbWwjRcXKe2OVkBO+j08Dql6dIfLBvb0Z/8e2uQFOS/V1YSOB0FbJ+Z5ZfDGcg2p/5jXtNBLhYGM1qfikIecoiqAAh0zcAtJTpeaqRG+rPjxQz0vXKg87uKkhPzRmXAqvZHimAPOEraxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W5KbtB6A; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W5KbtB6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLrw0vR0z2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:30:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ECD9060008;
	Tue,  3 Mar 2026 16:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734E8C116C6;
	Tue,  3 Mar 2026 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555453;
	bh=D2pPg2evVcS3OwEffdyZzwyhu5mGQ3DavyPjm4j33e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W5KbtB6A0G2m/2ihT3XDZLZ1J31O6g7kq8xkLz7SMDzdBFPEaAXJKPILxy/5pZFxo
	 VD3ug1zEfyyGRMgzj5yYbUGUZKzDhz1SKIs9+iJ2+oxjTxfCYw+mr5Ol63WP8jwjbY
	 hOosGeo+emjWgCMGDrbFRWEmayrPXfx/NYajhHtgl1eSf02IYfo98sa5MP5S8vw3Q+
	 xRud5IB6QOoqtIOWN2WIT7Bp8uGvpOkxMBuN5JiBEAPQLN/8XocgX22s/sGb2+grKN
	 cHD08FRGQM0Vxkia4iLgppWy+vide3XkHT6UuM+9JIha9+PvKW9BgBN/7aNUr9wbPF
	 bCbzflpQ0R+Bw==
Date: Tue, 3 Mar 2026 10:30:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, wangruikang@iscas.ac.cn,
	tglx@kernel.org, npiggin@gmail.com, chleroy@kernel.org,
	gjoyce@ibm.com
Subject: Re: [PATCHv2 0/2] pci: fix msi_addr_mask on powerpc and sparc systems
Message-ID: <20260303163051.GA4059101@bhelgaas>
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
In-Reply-To: <d8440351-7394-4444-9891-b9af1982bd06@linux.ibm.com>

On Tue, Mar 03, 2026 at 09:59:15AM +0530, Madhavan Srinivasan wrote:
> On 2/27/26 10:14 PM, Bjorn Helgaas wrote:
> > On Fri, Feb 20, 2026 at 12:32:26PM +0530, Nilay Shroff wrote:
> > > Hi,
> > > 
> > > Recent changes [1] which replaced pci_dev::no_64bit_msi with pci_dev::
> > > msi_addr_mask inadvertently missed to initialize the pci_dev::msi_addr_mask
> > > to the DMA_BIT_MASK(64) on powerpc platform. Due to this, later the
> > > validation the programmed MSI address against the msi_addr_mask fails.
> > > This causes pci device probe method failures on powerpc platform. We also
> > > realized that similar issue could potentially happen on sparc system as
> > > well. So this series initializes pci_dev::msi_addr_mask to DMA_BIT_MASK(64)
> > > when pci_dev is instantiated for both powerpc and sparc platforms.
> > > 
> > > The first patch in the series fixes this on powerpc platform. The second
> > > patch fixes this issue on sparc platform. Please note that as I don't have
> > > access to the sparc platform, this patch was only compile tested on the
> > > sparc system. Anyone from the community is welcome to test it who has
> > > access to the sparc machine.
> > > 
> > > [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/
> > > 
> > > Changes since v1:
> > >    - Initialize the pci_dev:msi_addr_mask on sparc platform (Vivian Wang)
> > >    - Some minor cosmetic fixes (Bjorn Helgaas)
> > > 
> > > Nilay Shroff (2):
> > >    powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
> > >    sparc/pci: Initialize msi_addr_mask for OF-created PCI devices
> > > 
> > >   arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
> > >   arch/sparc/kernel/pci.c           | 7 +++++++
> > >   2 files changed, 14 insertions(+)
> > These fix regressions on powerpc and sparc caused by 386ced19e9a3
> > ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address
> > mask").
> > 
> > These fixes have been tested by Han Gao (SPARC Enterprise T5220),
> > Nathaniel Roach (SPARC T5-2), and Venkat Rao Bagalkote (IBM Power
> > System LPAR (pseries)).
> > 
> > It'd be great to have acks from the powerpc and sparc folks so they
>
> Sorry for the delayed response, yes we tested this from our end.
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Added your ack to the powerpc patch, thank you very much!

