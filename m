Return-Path: <linuxppc-dev+bounces-16698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23455EE6B4B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 18:50:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f737z2Rl3z30GV;
	Sat, 07 Feb 2026 05:50:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770403855;
	cv=none; b=GExAWc4lPoZ5kgA141eMkzsI8Xa7CuI8pXC5xDw6R2Vxgbo2cNT45AYulmn6jJug5FdwINVUUv2Uk013jfGwB1ZhqUEv8mB8jJ2m/KUkXSExsIkKlHBN6e6sWWBVE2aSYnUNQMYMhlpsZn4ikvyCV3OapRTFZEvLMzOpuWIE6RLEKYSCLQH8ZoEhgEBZD3XdQu56W/+uYoEFbaWQDE+mJ12FEyONXKV+SvmG38stiphDWzAOdOBWw19ZoZ1eBrgcrXCGnzVHX0f7L9NTp4Tet90cxnQ/nDwE5V77HZcYxYVLnm7t09lOQWvXfJXQUzB/bwMeDh3hPtM8VnFeqFaBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770403855; c=relaxed/relaxed;
	bh=DwP0r7/WbfM/CLxBPe3ai7QrJhkY90H00FkMpv48y1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg2iB6cqpAu/LkK43npfDaNEf5Qk49+CfwAfcHSc3vCfgAP+7XSvTCqQVVHdSBB9ra4qmRDQpdqNBoLjIOhTdLw82bEURDb6LOrJ0o60x2/+wnmN/n7tAZ4bFZ0eLheyWZRYUB0Ew7PaU4SJIW+2silRZ2HwqrTkDbnDiqNkZ6v1X6aOpSJRd9XXye6RHYLnduJ3VPXtSO+ZS7Dj1v2137vgyKgSRSZ25A/tD9zOjkurVNfKplXnJGfd+hCP5kf0vsT5HwJp3JpiPaeqCTFOWgqCM0tHMG9lRY5kGM6TDnPk3tcYgwK4fK8rxezv7yiAdEzr3Py1HHkzEKeTPMs2Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pxyFKwXv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kbusch@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pxyFKwXv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kbusch@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f737y5LMcz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 05:50:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 87B466011F;
	Fri,  6 Feb 2026 18:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65AEC116C6;
	Fri,  6 Feb 2026 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770403852;
	bh=b7gJhLGTQ+HWX3NqvexmNOefuii7am5PdYARZew9KYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxyFKwXv3EXlR14/QVX/sB5KZArfRSp/u+NjNOKonYduh9rZYZjVW/wM4vwGUGD3/
	 BBb/ShMIsOjQJA1l028syRDH/+h9oHvuWmVOw81TYTp1Kr4NPAbbwT1P4YMf4MOCXf
	 xe7BtcDR5LDNN1l5TScoP/Lu5bfZLrckjXP06E1okP1MplqETJKchVMy+b/t7H/lZg
	 mmCMgSB5p6vMOM8+WD24lMbVZyQQFx7k1tS75R7oqwYMmlMVqPyxA7t6wLqeMBtShF
	 BsZH8BvQRB3B/G4HWFXRteldoZb4z7rljLPM/VdefSYDLweEvvfTpieDqqHkE/JO4q
	 CFLsaWxkbxWMQ==
Date: Fri, 6 Feb 2026 11:50:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYY4CSsUVrUtrLoH@kbusch-mbp>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
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
In-Reply-To: <20260206-pci-v1-1-85160f02d956@debian.org>

On Fri, Feb 06, 2026 at 10:23:11AM -0800, Breno Leitao wrote:
> When a device lacks an error_detected callback, AER recovery fails and
> the device is left in a disconnected state. This can mask serious
> hardware issues during development and testing.
> 
> Add a module parameter 'aer_unrecoverable_fatal' that panics the kernel
> instead, making such failures immediately visible. The parameter
> defaults to false to preserve existing behavior.

Sounds like a good idea. There used to be a code comment suggesting
there are probably conditions where you want this panic behavior but it
was removed with commit:

  b06d125e6280603a34d9064cd9c12748ca2edb04

Which I'm not sure was an accurate thing to do as it assumes the system
can remain operational without recoverying, and that's just not always
the case.

> @@ -73,6 +73,9 @@ static int report_error_detected(struct pci_dev *dev,
>  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>  			pci_info(dev, "can't recover (no error_detected callback)\n");
> +			if (aer_unrecoverable_fatal)
> +				panic("AER: %s: no error_detected callback\n",
> +				      pci_name(dev));

Is this the only condition that the panic behavior should apply? I feel
like we may want to defer the panic to the recovery failed case and even
include the "disconnect" condition. Maybe something like this?

---
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d75..c5a631e2b565b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -295,5 +295,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_info(bridge, "device recovery failed\n");
 
+	if (aer_unrecoverable_fatal &&
+	    (status == PCI_ERS_RESULT_DISCONNECT ||
+	     status == PCI_ERS_RESULT_NO_AER_DRIVER))
+		panic("AER: can not continue, status:%d\n", pci_name(dev), status);
+
 	return status;
 }
--

