Return-Path: <linuxppc-dev+bounces-24901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC12C531FC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 14:12:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h80sc51jfz2yhD;
	Tue, 28 Jul 2026 00:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785161540;
	cv=none; b=SZAQHHDSMMqFM8xZzx9R9Kx/PDsB4e24FFA89tbrXShCIW61jc9xLvMIloKfMRfc+VOawuZEicxcYwsUQky8t5cjAfcyF/wmApvyDXlQDy3ogExZ0RpL4oEQg9o3cJkND/AhK9vSjFcSoyBW+ATgmdfYHu7enU8JbZeSO/LJy6wF9U9DbetmHLwif11SR4De6nnHWiHw9+V/twPZGsV/ojAyMU3zOmssapKvaR1xEaHW5KXy2MnnBY0S0Vps2ictbQkDkaSuukCAIhbgAAUYOZQ/Co38cnViNLbMQEkQTSIL1mMO3ePbPxPf0b6Jjk6SKmoxNqglr4JR9udVCLYvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785161540; c=relaxed/relaxed;
	bh=RRXtwaeEc1Knw0zlVcu/TWqghBKvk1gnC2ySr9LP8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrWicO9r0b0KkiLArfU8IWJktU2Pi8F7IQp8hvOm81v4R1TaXvlB6/74tPHbF55k/Se9I4XWpDcjxWpAY6+w8ZifojaLPREaruSYuRvC+kLR80lw//u+8/JPvxe746FoClSuYugV+ByCZPKW0eTvMcu/gxtuqEFE4N2ymiI4eRg0zmXxeMpggeZTTtBB6xIEj7op2fHyyKuojT35+QFn6rAYQuD1pPEGR2J4qQ5Y2yvhNf9lZ/0VTRGiJXZSKWt8vNNclBhH1aun2jMf7tOw0H0psfPEJ4J+PIE2RU4wqXF2A1yYlzAkRjYzAUuzUjJKYNPrssPCLZevJ/Ztsf3E3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h80sZ6v8fz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 00:12:18 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 65E7B36F;
	Mon, 27 Jul 2026 16:12:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 617B760CDD36; Mon, 27 Jul 2026 16:12:02 +0200 (CEST)
Date: Mon, 27 Jul 2026 16:12:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <amdnMg_J6T3Sys45@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <20260724223903.GA1073029@bhelgaas>
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
In-Reply-To: <20260724223903.GA1073029@bhelgaas>

On Fri, Jul 24, 2026 at 05:39:03PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> >   PCI/AER: Fix mapping of errors to agent & layer
> >   PCI/AER: Log agent & layer for each individual error
> >   PCI/AER: Deduplicate logging of Error Source Identification
> >   PCI/AER: Emit TLP Log only for unmasked errors
> >   PCI/AER: Move retrieval of FEP and TLP Log into helper
> >   PCI/AER: Support Advisory Non-Fatal Errors
> > 
> >  drivers/pci/pci.h      |   4 +
> >  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
> >  2 files changed, 200 insertions(+), 54 deletions(-)
> 
> Applied to pci/aer with the intention of v7.3, thank you!
> 
> I noticed a sashiko comment on 6/6 but haven't had time to look at it
> yet.  I left the series on pci/aer for build testing in the meantime.

Below is a fixup for the first valid finding reported by sashiko.
If you could fold that into the top-most commit on pci/aer,
I'd be grateful!

There is one other sashiko finding I need to address:

It complained that in the native case, Advisory Non-Fatal Errors are
reported with the same loglevel and ratelimiting as the accompanying
Correctable Error.  But that's intentional.  However in the Firmware
First case, I got that wrong in that the loglevel and ratelimiting of
non-Advisory Non-Fatal Errors is used.  I'll come back with another
fixup for that!

My rebuttal of sashiko's findings:

https://lore.kernel.org/r/amdjR8LqIY0YmiG4@wunner.de

-- >8 --

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ff6ff7abc286..2a380bb9bfcb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,7 +428,7 @@ void pci_aer_init(struct pci_dev *dev)
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
 	 * 7.8.4.6).
 	 */
-	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
+	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
 		pci_clear_and_set_config_dword(dev,
 					       dev->aer_cap + PCI_ERR_COR_MASK,
 					       PCI_ERR_COR_ADV_NFAT, 0);

