Return-Path: <linuxppc-dev+bounces-16614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16811E91294
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 08:54:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f69yB4Hpkz2xrk;
	Thu, 05 Feb 2026 19:54:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770281666;
	cv=none; b=Ln6RF/dH/mbKBTPyshCVD1ixp2gMmu5bJhJQku2mjGBx/XeousIWCa+jE1EobMLZZGMTQtuMGuXMOW6XgQu2XzgOr5Z1G0dMRdLO5pSRIwvFZ/FUjUbbsQnv1Ow+G2myzQm6eerc3AwJqMh7Er7GLaF7+tKe2WqmzfPDn8akKd9Hz8LUx+CPwDRxEQUqPJ6OEqBxrQ1356/1xBordgUGVAvZQIECajc9jJKoAFHyM5fXY5We7REuKylYYaTErnPtaixq2d9gQKKSPO/g+LePJh0GnVIQpD3GEfg33QTg7i0UjZPHAmv1yNzKXaSKd62rvywwwddRjvtM8+rH5Rx1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770281666; c=relaxed/relaxed;
	bh=SUeJNyehexqoYDeID7nGrc+f51GZT9nIaXngPQXE76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbgrmGdFbldhVzXBkS0bQTb83sZq00X404r9YP0gJALEeZF52V0mQMohfwu3456Icitp8ofjtWaw/FABP/xvsiuLxOIKrmv3vBG/qJJ8IXwdecEFhIcuo3+73DR6dszcT59YyW3g/ReOjFhxtsuzjcnaCSEBYuXH76cTGfXbql+OmzFBMFmKUSIpDb6dkWsfYIxp7y9M4TsJ6L8VPzDw1fclobuDqDbBHX+lXytd+RKfr8oLahumOYo2TjHeLXqRS/mH1xvSYcikcmQfU/utlzwoZwG+eSquN8DrmhoSk21PDPm6rNfLEpEuYwkKO/2H1t8LHpDJPDOm6BSnazojCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=144.76.133.112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f69y93gDdz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 19:54:22 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3F7ED2C0161B;
	Thu,  5 Feb 2026 09:54:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F0B4A36476; Thu,  5 Feb 2026 09:54:15 +0100 (CET)
Date: Thu, 5 Feb 2026 09:54:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com, ErosZhang@zhaoxin.com, TonyWWang@zhaoxin.com
Subject: Re: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC
 recovery
Message-ID: <aYRatwSvUG0yQkHd@wunner.de>
References: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>
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
In-Reply-To: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>

On Wed, Feb 04, 2026 at 11:55:42AM +0800, LeoLiu-oc wrote:
> For example, The execution of the ice_pci_err_detected() in the ice network
> card driver exceeded the maximum waiting time for DPC recovery, causing the
> pciehp_disable_slot() to be executed which is not needed. From the user's
> point of view, you will see that the ice network card may not be usable and
> could even cause more serious errors, such as a kernel panic. kernel panic
> is caused by a race between pciehp_disable_slot() and pcie_do_recovery().
> In practice, we would observe that the ice network card is in an
> unavailable state and a kernel panic.

Unfortunately v2 was submitted without answering all of the questions
and testing all of the things asked for during review:

https://lore.kernel.org/all/aYBoP-B2E9fp_4YZ@wunner.de/

