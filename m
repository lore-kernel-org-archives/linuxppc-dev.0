Return-Path: <linuxppc-dev+bounces-28543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170B2CA5FBB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 07:08:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvmNg3hGkz2yqT;
	Wed, 30 Sep 2026 17:08:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790752115;
	cv=none; b=XqEcrmhXes8LUa2Eu7CaSJpaC0VHNAZUwXtBIVNM2OeCW88OtT8bjG+E8jbIoFXd1H75S9na2GcaYMkp0IBNh5+pQlUdMpt7uOY/Q8FKKR06v0ymbnv63915DmTtK9bVsF3oao2yb4TPwzcKBbU61mhp8kxF28dKM6St4GxAXhJFH+lsW06yZo+ioAkC8farPcDOyrzPKr4waY/E+ErYD60ouYukNwMshX3TOdQSy5kONeoWzgTeHhfpcl0vb4Vr5r+ztWwQYFCbGdfIAV4YWryIEFw/tk2GpVVvlCEs9SvVfKvzGKIDH0XsF+fnnpMETNywvX8/tndKgqfYrJKlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790752115; c=relaxed/relaxed;
	bh=BWbDVfZ9B1OiufCm0uS8zi710OwylVpHPhUc5DhgoQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfjb/pCtpF36mptr06eF3kZMfLIpTqBO3nrXlL/geJMWAcxg+UiZF5hO4fK/vwcr9zMLWnLMulUsekNwmMiaQyFUChde/lW1nnXpXlz5M6UPGSLcOcA1udkszcFsmyTlAsAfFSQi7ZozI0avRGUdADohO7Qu0buZakuZy3fIeqozz2MrF9r2d/xELSpKcE79f1lv30BXRd77EGZ9R3foQnL1iNjSC+H0OksBBajzUdHUMODPn/yApMQVwhGE1eHZSeSHIBCPCS/dV/S4TdU6xfUzqL6i+wNo0naWWKcthKYcKqfeY6qMrYMKDqQq1nwZx2DcGXcbmxwoeD6/wM6ePg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvmNd3sMKz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 17:08:30 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 8560C63B;
	Wed, 30 Sep 2026 09:08:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7385C60C8EF0; Wed, 30 Sep 2026 09:08:24 +0200 (CEST)
Date: Wed, 30 Sep 2026 09:08:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 7/7] PCI/AER: Enable baseline capability error reporting
Message-ID: <ary1aMGD-hqf78L9@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
 <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>
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
In-Reply-To: <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>

On Tue, Sep 29, 2026 at 02:01:42PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > @@ -431,6 +432,9 @@ void pci_aer_init(struct pci_dev *dev)
> >  					       PCI_ERR_COR_ADV_NFAT, 0);
> >  
> >  	pci_aer_clear_status(dev);
> > +enable:
> > +	if (pcie_aer_is_native(dev))
> > +		pcie_clear_device_status(dev);
> >  
> >  	if (pci_aer_available())
> >  		pci_enable_pcie_error_reporting(dev);
> 
> This also enables error reporting below AER-incapable Root Ports, where
> no AER service handles the ERR_* Messages.  The Root Control System
> Error enable bits are only cleared by aer_enable_rootport(), which
> doesn't run on such ports.  If firmware left them set, the newly
> enabled Messages could result in System Errors.
> 
> Should reporting be enabled only if an AER service (or DPC) is above
> the device?

Excellent observation.  This is a pre-existing issue but I think you're
right.  However it's non-trivial to fix because just checking for DPC
capability in the ancestry or AER capability at the Root Port isn't
sufficient:

For RCiEPs, we'd need to check whether an RCEC exists which has
AER capability.  There's an "rcec" pointer in struct pci_dev which
allows discovering the RCEC responsible for an RCiEP.  But the pointer
is only set when portdrv binds to the RCEC (pcie_link_rcec()).
That's much later than when the RCiEP and its capabilities are enumerated.

When enumerating an RCiEP, we'd need to walk the entire set of PCI devices,
check if it's an RCEC, check if it's responsible for this RCiEP and assign
the rcec pointer.  We could try to avoid that by running pcie_link_rcec()
already on enumeration of the RCEC (and not on probing of portdrv),
but the RCEC may be enumerated after the RCiEP.  User space could also
force an unset rcec pointer by issuing remove/rescan of the RCiEP.

Also, right now when firmware does keep System Error Enable bits in the
Root Control register set, there's a window between endpoints being
enumerated (which enables sending of ERR_* messages) and Root Ports
being bound to portdrv (which clears System Error Enable bits).

Any errors that occur during that window will cause a System Error
right now.

> Or alternatively, clear the Root Control System Error
> enable bits on AER-incapable Root Ports?

I'm worried that users may deliberately enable System Error bits in
BIOS on such systems precisely because there's no other way to catch
them.

Thanks for the thoughtful review, much appreciated!

Lukas

