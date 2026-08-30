Return-Path: <linuxppc-dev+bounces-26203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F24C61DD9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 21:02:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY4M12xm9z2xwN;
	Mon, 31 Aug 2026 07:02:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788123741;
	cv=none; b=BYP4SPtxdEDS1CDWqsEMnkGwx7z5bwL1E/kLmNcDwX9ldsmQaeecvLSQpEO1tuA1Ng9YWhNTo0z8dMHNqI2eJcZZY+9whEz27T/6BQ7/qlT2kztXV0HyPK5vZ4/Fg/HWpW/pvofi290PIZLJG0AKM4uNWjsGxVCagZzZYVx648fUdHwgnAYFOAaz01S1SY1O9jOqfDciUjAVCTzFJGRpy56spDGBxwcpLO5AqIB4b2rT7McADFpNIqIsXo4X/xrpxVQFznlUZ52f2xVQb2JlBr8x5Ad4z+BVgnoUBRlWuNvovBWp3XNo/X3x/NSa1DLWNxnyaZWOGXB/RGXEVFlTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788123741; c=relaxed/relaxed;
	bh=FIEkV1/diau0dLHdgt/m7cbiKzRSycL/0dRAVuXTU5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMXzrUZ7e8f1kYBceSk6YAuL68ibR2Q4VOQkNH0zKsUcw5+F8E071AtyEr19FDdldXVbVtAB8aacnl4Wh1cEbT1B0Ti7d3ZsnPecMZsnmWxBECIZkrMGH1vstwsHCqfV6N/jgzllV37nFMdUGSDdUk1xljCGRTZWUeKVo4qcofXCD1kw0WfpXW5fjiDTOJaSHtA4G23AuBkllYR23JzHkIYFXIxSyICi7GGzE6yzGE8sop2GCmqsdWinwIFvZAiBeFrH2QZ2ZzGfLatBTpxQXC/zdKJ/dw5C1GcMCmsPmP2foqRZvONgU4srprPBddwlwT/8pXz70l71qanBWGnyNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY4Lz3rnYz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 07:02:15 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id A865210629;
	Sun, 30 Aug 2026 23:02:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6E59760FB887; Sun, 30 Aug 2026 23:02:09 +0200 (CEST)
Date: Sun, 30 Aug 2026 23:02:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Fix struct pci_dev reference leak in
 aer_process_err_devices()
Message-ID: <apSaUQIc2ig-Icgq@wunner.de>
References: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>
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
In-Reply-To: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>

On Sun, Aug 30, 2026 at 08:28:28PM +0000, Priyank Rathod wrote:
> When an AER error occurs, candidate error-source devices are identified
> and recorded into e_info->dev[] via add_error_device(), which increments
> each device's reference count with pci_dev_get().
> 
> If is_error_source() matches a device purely by Requester/Completer ID
> match (e_info->id == pci_dev_id(dev)), the device is added to e_info->dev[]
> even if it lacks the AER extended capability (dev->aer_cap == 0).
> 
> Later, during aer_process_err_devices(), aer_get_device_error_info()
> returns 0 when dev->aer_cap is 0 (or if no active error status is read),
> causing aer_process_err_devices() to skip handle_error_source().
> Previously, handle_error_source() was responsible for calling
> pci_dev_put(dev). When handle_error_source() was skipped, pci_dev_put()
> was never invoked, permanently leaking the struct pci_dev reference.

The problem is real and the fix looks fine...

> Fixes: 1ab4a3c80508 ("PCI/AER: Stop ruling out unbound devices as error source")

... but the Fixes tag seems to be a hallucination.

Thanks,

Lukas

