Return-Path: <linuxppc-dev+bounces-26204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1A3C61DE8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 21:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY4dF0kk9z2xwN;
	Mon, 31 Aug 2026 07:14:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788124481;
	cv=none; b=Sa/wv3mtnq/HOfTXWvBTazy/+PpVGofKGUDGVTreoTNqGFbdQp3REwb1k6YMradrfu0G8vcAzFH0izKUPAusoEJspIud/aAgo9I5B6qXO74DZ5u0Eo4H3qbNxNTjNF4UeluxXcP0jpH7UsYm8IiisXzL+0/5SHu+k5Q4MvbLREft+4ZH4AHReCMYzpDkpP3WZNRspz4JWijF1y0o/wkoMYrWJe56nTTrejTgRQFJDKUtIH/TQr/iwyQJUTjNXacqWolkl//Oa355pXfesCBJm5C6fEwEmrB0uKi+Ry+olKOyGUY5nxiZ3OVf1SkKKQaN7xGc1eMjeNSRTsl1Sfzyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788124481; c=relaxed/relaxed;
	bh=ESbNiwDVkkY1jyYeYnsaq4/wVNSeRccftl88mBQbfEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+wBARHc4s3dXA4d/Q2qs6vtv3y7wswgy2w4IqbbJN3OLMv0dDCXACKbv5THQnA4lA6PKpFoSGMMygKSTHQd5t9ilCCc7SuOC/v7Drv5gLmIyacB/v8qKYQKS2/hlc4ZgSz3YoFqaAeVghdIgDIVQb3s6q1uZTCEONueqQO6YD0B7G/wtpVHWwu15fSW5a61PVl4kyazxTrkFGvtoiTeYR4Gw/m1SNK3+bg/wlvfqtCkwdA0maUqxQpM2NvO1884zVU4qzlxoBaO1t17eOPOm09tMfKn5UJBk5yf0k0lTvCzEwE4wS9BJ2P73WUsLZocry/8Jv6ICjyqgfeQJzdQnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY4dC6vkbz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 07:14:39 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 31ED837A;
	Sun, 30 Aug 2026 23:14:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0E4A160FBB96; Sun, 30 Aug 2026 23:14:34 +0200 (CEST)
Date: Sun, 30 Aug 2026 23:14:34 +0200
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
Message-ID: <apSdOnbdLdrJ7ksF@wunner.de>
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
> If is_error_source() matches a device purely by Requester/Completer ID
> match (e_info->id == pci_dev_id(dev)), the device is added to e_info->dev[]
> even if it lacks the AER extended capability (dev->aer_cap == 0).

Hallucination, we do not enable error reporting on devices without
AER capability, see pci_aer_init().

> Later, during aer_process_err_devices(), aer_get_device_error_info()
> returns 0 when dev->aer_cap is 0 (or if no active error status is read),

The "no active error status is read" is the only scenario where
this *could* happen.  However if no error bits are set in the
status register, why did the device send an error message upstream
in the first place?  That would be a broken device.

Another theoretical possibility would be that the device becomes
inaccessible by the time aer_get_device_error_info() reads the
status/mask registers.  They'd both be read as "all ones",
hence info->status & ~info->mask == 0.

> On the ID-match fast path (a), is_error_source() returns true without
> checking whether the device implements the AER extended capability
> (dev->aer_cap != 0). This creates a real, non-exotic situation in several
> common hardware topologies and operational states:

Hallucination, this is by no means "real, non-exotic",
it's an unlikely corner case.

Thanks,

Lukas

