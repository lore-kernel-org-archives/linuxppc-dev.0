Return-Path: <linuxppc-dev+bounces-24585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B2EC4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:45:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49tn5S8nz2xlb;
	Tue, 21 Jul 2026 18:45:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784623505;
	cv=none; b=fCMpvQFW3lqxmQeWfVdL3C+05L6TuMbvaPuSE/lA1L698pMAPaLqBgZg2GDnHSTka/ibpPQANqXtgzItWLH5zc2EzrvbzrknBkU/dPhyLenKhaX+AZBT0eghFtv2+PQVne5c2HQhCTyJfp/WoaJOiQmZp2CjoiSroG8XHcf0YT8ATcviPHeovJ+qeniqdbsEfqS0wcnPJAQKjJWtqO9UqBeK3c2vsxXQ4JPVC9PheEDGIgRKMD+RfH28C3ixmwv9JGeinOgn3PM5ATfdhNjxMIgjXxfozaVzpuGhjjjGTprhVtcDft2FOw1t2ibK8IVbX0cjkp65CWaLpboSaQBTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784623505; c=relaxed/relaxed;
	bh=swnwaxub/DCWbnxVjtBXcqEJvdHzrhXboU6tKqWaY/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9jtSNJoPd3VRUxdVxLQVniwzkJYkYiL+0t1DMZve1+1Rtp18gZpY8O5fIhOUBIYe1S6FxIvwUVP7bvw2to0KMQjTqrcHlbWp0Lpx3ddbbrPjKo2RYbwm38/J+snCj+thWDs6PvHXY/maKSRKfA1NnjtnE8vxzrDWUO3i6seG/STJOAc8pkZZqFUKT2soBO7ZdiB7gxL4baKmwWAKqsiEgk3MPFnhJyXDU+F3IbVrtC3ZQaejNKrlkm1q9tCIfhtDgY2ooOkSodYz61KwkBAYmSPJ9COO8azVNdK1443653OdQyxHnC1Bjkrt/TBP0kgu2LQizoT01Jn5mCEjwjbOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 434 seconds by postgrey-1.37 at boromir; Tue, 21 Jul 2026 18:45:04 AEST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49tm1PPSz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:45:04 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 695A11062F;
	Tue, 21 Jul 2026 10:37:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 641F6614B893; Tue, 21 Jul 2026 10:37:40 +0200 (CEST)
Date: Tue, 21 Jul 2026 10:37:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Message-ID: <al8v1PRFw1_MjjGk@wunner.de>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com>
 <alsk97jVqw9jbRdQ@wunner.de>
 <91e35807-9483-45f5-b4a8-0388aa48ff6f@amd.com>
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
In-Reply-To: <91e35807-9483-45f5-b4a8-0388aa48ff6f@amd.com>

On Mon, Jul 20, 2026 at 10:48:06AM -0500, Bowman, Terry wrote:
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -90,7 +90,6 @@ extern int pciehp_poll_time;
>   */
>  struct controller {
>         struct pcie_device *pcie;
> -       u64 dsn;
> 

Please drop the kernel-doc for this struct member as well.

> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1086,8 +1086,6 @@ struct controller *pcie_init(struct pcie_device *dev)
>         }
>  
>         pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
> -       if (pdev)
> -               ctrl->dsn = pci_get_dsn(pdev);
>         pci_dev_put(pdev);
>

Please drop the pci_get_slot() + pci_dev_put() as well,
they're obviously superfluous now.

> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -73,7 +73,6 @@ int pciehp_configure_device(struct controller *ctrl)
>         down_read_nested(&ctrl->reset_lock, ctrl->depth);
>  
>         dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
> -       ctrl->dsn = pci_get_dsn(dev);
>         pci_dev_put(dev);
>

Same here.

Thanks,

Lukas

