Return-Path: <linuxppc-dev+bounces-24542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84275C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 21:26:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3tqm4vg4z2yLY;
	Tue, 21 Jul 2026 07:26:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784582788;
	cv=none; b=PbCoBXZclfINkL0UGONnU5305PUSl9lV8i0HX/0svzGdc8yh1qI2b4Ofn65rVOAY12fcRknBTnUXQ1OYM3igI/dLJTjqNaOJAihHqpHtA+ocjaEC1H5JLQnTDMpBU+j4+7Oxg0Vb5Tl2UmkCmR7WXedRfle/PdplpasryLeS048oAuUWV1gSFWZIPm3IbrkS72WUBFtj8Lwqsu4AMx338BaqH9NdMQZ+1phDksipoiieERovx5CaN71jpoeYmVMIENaDm0G1Ycy8Lbm2ggtRjAcQPSnHXWeIEvikDPLnFKwMEdS7gCslChRPbRP5UMbHzz9JIkZPYtcpdDI7AuSaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784582788; c=relaxed/relaxed;
	bh=hgzEzv8KzgA973IVv/uKk4z9kYIa69UBaICYLVX6RMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9/43peaejkKt/2bnRg9tup02qb4CpDgfYzfIbBPcVqUiSTao7J5HvXDhZROW973CCSoopDvo8bmcLopaILnac31xmvFR7HNAGJWAj/RddzdkZJhL264x/OWWG55nodoz3J8tEY75OtRmuRwdJezd/Vm7JSatnWBkZDHSnT1avxMWvLi9Kme/kE9zLTz2U+hy/JSayNe3BLUEZt1T3pwDtlHZCNNR7/Tw0VjHrcDw/+bWTmZIa0/ToLZN2G4I+5yjTuKOAmy07aBl5FsOixszFXb1Q0TkrN8w4/3JB5BcCf6RQHz3a2/msqi7MQ1lCGZY32zoOBz++5Vj+8an8vAkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knv+WWyz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knv+WWyz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3tql4JJkz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:26:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E584560A7A;
	Mon, 20 Jul 2026 21:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A221F000E9;
	Mon, 20 Jul 2026 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784582784;
	bh=hgzEzv8KzgA973IVv/uKk4z9kYIa69UBaICYLVX6RMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=knv+WWyzLr/C2po5DrcJFrX9FdjRP9H+TlZLo1CLUoIgIpyhO82mKxuQdkEmibVlz
	 jX6p05F1rxsZFJd4bkrUl4RnpeVF2D6iJkvChjuJDDxsw6DxVmXkb1WN1iS4FZJ4E4
	 yFRdFayH9GnyH9dlNK2ROKWXjkRS9klUCMYl2Qjio8Xiq6eZ9wogLMx/jboQKLWWN4
	 kgAZDqRiP2JyGH2uvgQrV6wWsNQWxkkonhwHfFdYV8mTUkG6k/Og/vd/22Z1Gblm+p
	 V7b81n6qwDfZYdZsx64YW+aUgqrb7XeoEggT/vHCrrTiUPoyNKop5lfX9Q6Mq5MMHU
	 eaYv04sBAePUA==
Date: Mon, 20 Jul 2026 22:26:17 +0100
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
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <20260720222617.29d5676c@jic23-huawei>
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-2-terry.bowman@amd.com>
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

On Fri, 17 Jul 2026 17:26:54 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
> 
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
One trivial thing below, otherwise LGTM

Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/ras_rch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &

This bit looks familiar (see line above!)  Worth a local variable maybe?


> +		    aer_regs->uncor_severity)
>  			*severity = AER_FATAL;
>  		else
>  			*severity = AER_NONFATAL;


