Return-Path: <linuxppc-dev+bounces-24559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157D0C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 23:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3xYc2PXmz2ySg;
	Tue, 21 Jul 2026 09:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784590164;
	cv=none; b=ko/82TtSc/o7jXzVoIqVYO+wl2WsViEG6g0kCzq7UkUF75YXjXuUcGIv0B7SvaK36XpMvvEJghvAYJZSFm684RUJiVO4PV0OmdF9zcm5kZ6+gZYnHgiifZNKvex3Op/z+invXBcnh1hW0Ya4k7WxQPod30vlZ/fP115l7eVvoPefNBNUbDlK90QrsKa4qdP7DhrUWkGUYWoO/0FUzvjvj5qkK0px0eSpu8tzlhPolF8lLqcvhMk9Xhy1TE3a4JUYlxKo2NQp+bE+jgApN4KOXNsHXMovpHGYfMZeZ3nP8W+WvvO7sF3A/D6pDXtMHc0tiG+0rL7lSOpQXqhAscM5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784590164; c=relaxed/relaxed;
	bh=dp6ANPOYAdsA1dUjByrInv/hyQ5xs3rfp8+0xMO3IXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKwGwQysBL/zRcC9kh9FTqv7PVIAnpnF2vvoxh8/Ug6YmmKxg5cxAZHtNUU9rEc7pT20gppOIzNFA/s4CdjJWFdAHrtN7o2FbVeLOXaVfxK9XY3bpDOqIzQSsaW8uVstzUP9M+QDU1AQchUb1M6JKXRPVth2FEMzyd6QFfmNOKgV2BG6NnX0GPk6MspGgLk+p8DgyGH1iWpz15KNr8eImT9zlpvZWGEpZptvJg7xoilV1h6e+LGXsNsHyYJpKxZM88Du9ukEey7HLX28WKU4X0+5R46OE9bhlXh0vAhqKKHvVEaqJ8/j6hpNOvroirftR/G0oetRtFqB6mbdELwvxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSPDNGVY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSPDNGVY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3xYb26Sbz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 09:29:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4199443F87;
	Mon, 20 Jul 2026 23:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878EF1F000E9;
	Mon, 20 Jul 2026 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590159;
	bh=dp6ANPOYAdsA1dUjByrInv/hyQ5xs3rfp8+0xMO3IXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fSPDNGVY3fnMfjzzHYSeUM7uxpLnUYS2sRb8d2D3UeGWs92N4j/s5zvARrdAUEkBA
	 EBH3YKoqTxqbX+sPuiG6tS4u9QJuJRQ1GSi8SdS5XLGTD9XmdmYikXZuv+Qe2cxT6V
	 vxZ7rp6AEHY0UB1UQTPmOHUwXa+4hqKhsopjVSH7g0LPLYSqL9p22em6x2LfDDlT0w
	 2nDMRnoegS5B4lEKF9YXmwWnzV7suICFuEou6TgRJXM3jl/oqdPmosVs7EViby3Dpp
	 KB73sddqvNiNz8T8dqKCR5HQttu47PdXIizHzVH6Rx3Vr4xLiNNKf3EIqcVqU22fLL
	 UCqhF1vmf+bOw==
Date: Tue, 21 Jul 2026 00:29:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
Message-ID: <20260721002911.580c822d@jic23-huawei>
In-Reply-To: <20260717222706.3540281-10-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-10-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:02 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Rename cxl_error_detected() to cxl_pci_error_detected() and rename
> the struct pci_error_handlers instance to cxl_pci_error_handlers to
> avoid shadowing the struct type tag.
> 
> Document the unconditional CXL RAS read policy: on a dead link,
> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
> triggers a panic. If RAS registers are not mapped the read is
> skipped and the frozen/perm_failure switch cases defer to AER
> recovery for devices without active CXL.mem traffic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
A couple of trivial things inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>  drivers/cxl/core/ras.c | 24 +++++++++++++++---------
>  drivers/cxl/cxlpci.h   |  8 ++++----
>  drivers/cxl/pci.c      | 12 ++++++------
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 6f4a3c1b0bb85..d5dc2c22565da 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -328,10 +328,8 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>  	return true;
>  }
>  
> -
> -

This white space removal should be in patch 7 I think.

> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
>  {
>  	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>  	bool ue = false;
> @@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		}
>  
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS read is unconditional regardless of channel

Keep the 80 char wrap for comments. Also local style is single space after .
(I'm terrible at not following style on that stuff but do as I say not as
I do!)

> +		 * state.  Any uncorrectable error bit set in the CXL RAS
> +		 * status register triggers a panic because CXL.mem cache
> +		 * coherency is already lost; continuing risks silent data
> +		 * corruption across interleaved HDM regions.
> +		 *
> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
> +		 * UCE bits and also triggers the panic - this is intentional.
> +		 * If RAS registers are not mapped the read is skipped, the
> +		 * panic is not reached, and the frozen/perm_failure switch
> +		 * cases below handle AER recovery for devices without active
> +		 * CXL.mem traffic.

Now this comment I like. Good and clear and explaining the non obvious decision.

>  		 */
>  		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5c21db36073fe..6cf1db7b85020 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1000,18 +1000,18 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> -	.slot_reset	= cxl_slot_reset,
> -	.resume		= cxl_error_resume,
> -	.reset_done	= cxl_reset_done,
> +static const struct pci_error_handlers cxl_pci_error_handlers = {
> +	.error_detected		= cxl_pci_error_detected,
> +	.slot_reset		= cxl_slot_reset,
> +	.resume			= cxl_error_resume,
> +	.reset_done		= cxl_reset_done,

Do we need the re-indent?  Nice to make it more obvious what didn't change.

>  };

