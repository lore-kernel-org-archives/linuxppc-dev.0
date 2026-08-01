Return-Path: <linuxppc-dev+bounces-25196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7388C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 09:08:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBxvF52Kgz2yQJ;
	Sat, 01 Aug 2026 19:08:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785575337;
	cv=none; b=n/je+GBMhjoWOWiVdNjU/iPycXdJgaDA3Lso+fdYOCiblx4b5yn6pGusHP8717lmseSlAsq+SX2XuCM98em4FDhORyJSZSJk59y/KiBUmOLK8v+ZGeZArsO3CG/vkYe3P5sUNKIiQ3wS6h6pSPt15Xao8/zr2lQGGuPo8Bcpa+mlYtO69QGGdOI/QDJI56+2rVtTRPBd2PwJBOr4RLsTeHwDegg9D4SP79wISYDpXYGFgShjLzxOSDPsnsrBorqgouBZRLerIkoy5O7a0vGoThoHn7j4dn0KpRyY65dWtGgORmzObwCw4uJKw52pPLatzehGKXEtNCjNrr/WwFXtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785575337; c=relaxed/relaxed;
	bh=Fge2IWDZ5gnW9RIv1RsXBSIsN84nA5y3U3vVSIESKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Mce9WWKMrGu50Rqo8KxnifxFHOSn+SWAknOD0BsjCY5DSP2L+bWo9KKtCMbhrFjyeXUBFM5uGeVeXY8qK9C28wBwj5KrVbbKjWKSFUGGA2ubXD3rtWhRhZh70kn4GzXr1VgLXoCLw4cq140rGKq7JQwGaO+krgicACkYa0RtUCxNv+kKc4KAy2JOqAFj1dGOomEoC3XGsiakOVli1e83BhEmpndhvIltpHEk5pjQGW/PSoXyN+bmeQewJ7QUKBRFkv8ezpwSt/WJpjAjrBR6iKU+ShEzDMeDXajDKxDyJS3klJX50gt9dMG0liXofnRW3aUiqPkx1g6neFWsRQgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBxvD3vXFz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 19:08:53 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 43A2C10607;
	Sat, 01 Aug 2026 11:08:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2CE87600D0F8; Sat,  1 Aug 2026 11:08:48 +0200 (CEST)
Date: Sat, 1 Aug 2026 11:08:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: agovindjee@purestorage.com, an.luo@enflame-tech.com,
	ashishk@purestorage.com, bill.wu@enflame-tech.com,
	dio.sun@enflame-tech.com, fernando.hu@enflame-tech.com,
	helgaas@kernel.org, jrangi@purestorage.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com, msaggi@purestorage.com, oohall@gmail.com,
	qingshun.wang@linux.intel.com, rhan@purestorage.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, sconnor@purestorage.com,
	terry.bowman@amd.com, xin.wang@enflame-tech.com,
	yang.yicong@picoheart.com, yurypm@arista.com,
	zhenzhong.duan@intel.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <am23oEnTurWaznAa@wunner.de>
References: <amztrrIGvz8gPxQb@wunner.de>
 <20260801082419.7780-1-mattc@purestorage.com>
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
In-Reply-To: <20260801082419.7780-1-mattc@purestorage.com>

On Sat, Aug 01, 2026 at 02:24:18AM -0600, Matthew W Carlis wrote:
> What if we decoupled the message received by the root port from checking &
> logging the AER status registers? In other words, when the root port
> receives a message we log the severity we received and whether it was
> multiple errors.

We already do exactly that in aer_print_source().

> Then, when we get to the device that sent the message we just always check
> the CE and the UE status registers? If any status is set that is also
> unmasked then we log the corresponding TLP Header for that. In addition
> we log the device status register so users can know what severities were
> signaled.

That's also already being done (in aer_get_device_error_info() +
aer_print_error()) , except we only check the status/mask register
corresponding to the severity that the Root Port received.

E.g. if the Root Port received ERR_COR, we only read the Correctable
Error Status/Mask registers.

> We can use the Error Message severity received at the root port to
> decide whether to walk the pci bus and do the error_detected() stuff.

Same here, we already do that.  For ERR_COR, only ->cor_error_detected()
is invoked at the reporting device, whereas for ERR_NONFATAL and
ERR_FATAL, ->error_detected() and the other callbacks are invoked
via pcie_do_recovery().

> If there are multiple UE status bits set at the reporter & Dev Status
> register says there was a Non Fatal Error as well a Correctable Error
> I don't think I care if simply logs everything in UE status as a UE,
> everything in CE status as CE as long as it also tells me the Dev
> Status Bits that are set.
> 
> Going a little further I would be fine with just always checking both
> CE/UE status because it seems like it simplifies things a lot &
> two/three extra config reads/writes is almost a nop if you're already
> at the device probing it for the other AER things.

This is where we differ right now from your proposal:  Errors received
at the Root Port are queued up in a kfifo and we then empty that kfifo
one by one.  If there is an Uncorrectable Error behind a Correctable
Error in the queue for the same device, we handle the two separately.

Would it make sense to combine them?  Maybe, but keep in mind that for
Uncorrectable Errors, we may have to perform a Secondary Bus Reset to
recover from them, which can affect other devices in the same part of
the hierarchy.  E.g. if a Switch Upstream Port signals ERR_NONFATAL
and then its ->error_detected() callback returns
PCI_ERS_RESULT_NEED_RESET, the reset will affect the Switch Upstream
Port and everything below.  That's very different from how we handle
Correctable Errors.  For those, the driver of a single device just
gets a notification via ->cor_error_detected() and that's it.

There are still many bugs and opportunities for simplification in the
AER driver, but refactoring it without breaking things is quite
difficult and your proposal would be fairly intrusive I'm afraid.

Thanks,

Lukas

