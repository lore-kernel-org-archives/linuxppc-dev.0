Return-Path: <linuxppc-dev+bounces-29073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CDDCA6016
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 21:28:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j134x51srz2yHD;
	Fri, 09 Oct 2026 08:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791477779;
	cv=none; b=h2yMrtAGGJ5cElxpNYLTwcufi9GRtpdmB9PgSRh5lop1bLYYYnyqMdDDgl0kJigQG6tL7l6i8T6Gh58eTWn51rfqmUcn0oW4VvZYRuwow/IgVzUP+cDx8P716HJDeSbeczlrjZfl/PSLm919aYNxywmCZ/OVKKgOzi/VEj2gGm0Uc6g9nuN9R/6bRUTVGpHgBwC7C8W9UT8yBUW/y32NohaQn4sNvCbMWWBUTHE0l1Tbee2BZzH5GFUSnL6eSY9XUrSJGQBjGCh2+8rJRKzfpaOclhDAP692k99SCqo+/PdZ/T+nSDBJqxbeOrmwl7C1TCCDl9DGxbg6oKNWP+svcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791477779; c=relaxed/relaxed;
	bh=RrdGR8+5+7JD9zLubC3R5Nrwx3f6rQnHI7MHAeeFjZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S699w8a0oLN9bEgxuS+7pHkIwcb6z0+aL/K5pKh4j2DNk7wxER5XzZ7pxZZ21Stf869U2DeIHnRy8LIYtEG1mF+NeihrOejpzH3MLnhGLWVX++Y80UUMMpTpeM5gTWd/AtUTSceg1KfjgU3G9RPQZFEkH2/Oqfi0d9ib5h3uN7Hc13qRP86uqBhyCltraIbfX5IMndpRfO98D4RiHiR/tSk+vCiZ1Hsn5LF9LHXpAa/oKaKkgxRifUuuUdY5MGf7O5Q/H5GxbF5DRcx3gHYENgXcwAKG0uG7sS18wY8ke12JoVQVCRJ1WpabI0VqnpiJ6IEn5YAT7DiAQ8k6V4VA9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iEZgnBHl; dkim-atps=neutral; spf=pass (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=easwar.hariharan@linux.microsoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iEZgnBHl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=easwar.hariharan@linux.microsoft.com; receiver=lists.ozlabs.org)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0wlk6fZ7z2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 03:42:58 +1100 (AEDT)
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [20.114.54.184])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25BB820B7166;
	Thu,  8 Oct 2026 09:41:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25BB820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791477690;
	bh=RrdGR8+5+7JD9zLubC3R5Nrwx3f6rQnHI7MHAeeFjZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEZgnBHlg1T1yn8CZKhtuBx45f1+HQol4iZG3iM7TQiQXiFIlmf21T9mvH4xgbgRy
	 qUB/J1fkHFphCRL55R8CWqDa4i5ZPlrg3EWE4PLqdRgqrJtOfmoZ39QDPhyiFLR0uK
	 JIx2GA3l12I4vaoXbAFUVMUa5oGTMjpbEw8yJcIw=
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
To: jeffbarnes@linux.microsoft.com
Cc: Frank.li@oss.nxp.com,
	Zhiqiang.Hou@nxp.com,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	robh@kernel.org,
	roy.zang@nxp.com,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: [PATCH v2] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  8 Oct 2026 16:42:02 +0000
Message-ID: <20261008164202.64477-1-easwar.hariharan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
References: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

> This reverts commit 84d897d69938
> ("PCI: layerscape: Change default error response behavior").
> 
> The Layerscape PCIe driver programs the DesignWare
> AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.
> 
> For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
> returns OKAY with all-ones data for errors on non-posted requests.
> Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
> with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
> PCIe completion errors.
> 
> The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
> Request, Completer Abort, and Completion Timeout to SLVERR.
> 
> A PCI configuration access can race with the link going down after
> dw_pcie_other_conf_map_bus() checks the link but before
> pci_generic_config_read() performs the MMIO access. If the transaction
> results in a Completion Timeout, the Layerscape error response setting
> propagates it to AXI as SLVERR, resulting in an asynchronous SError and
> kernel panic.
> 

Could you bring back the kernel panic backtrace from v1?

With that,

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

> Reproduce the race by obtaining the configuration-space mapping while
> the link is up, then disabling the link from another CPU immediately
> before performing the MMIO configuration read.
> 
> With the error response override enabled, the overlapping configuration
> read results in an asynchronous SError and kernel panic. With the
> DesignWare default behavior restored, the same test returns 0xffffffff.
> AER reports a non-fatal Completion Timeout, and no SError or kernel
> panic occurs.
> 
> Restore the documented DesignWare default error response behavior so a
> failed non-posted PCIe transaction does not become a fatal AXI error.
> 
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> 
> Changes in v2:
> - Change the subject to identify this as a revert, as requested by
>   Frank Li.
> - Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
>   decode the 0x9401 setting used by Layerscape.
> - Clarify that the setting propagates Completion Timeout as AXI SLVERR
>   rather than causing the underlying PCIe transaction failure.
>
> ---
> drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
> 1 file changed, 12 deletions(-)

