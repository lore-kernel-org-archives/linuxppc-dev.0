Return-Path: <linuxppc-dev+bounces-29067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971EFCA600D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:17:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j109g6LqWz30W9;
	Fri, 09 Oct 2026 06:17:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791487031;
	cv=none; b=drpEXJQx5L1HIa3Txo3/DEWPhlSQ+V5E3mzX8+yJdaQ24iJ3YuiW4byrA0vtnaPndyp94tZzZTNowCYKcTgKXaeSetkXq3Yf0oWLigqd/WOKUf7yNkOoMc4Mhb6DXMVqro4vhNqNPl/DyYUmlPup/UMTiLg9Hviya/pq8TBxw/TiucW5A0pt67uWGCeCzEqoPIinQfeXiRZMaHMB6Tz801OlP15pU0vchvQkMUSqFHeHOPpqYTMKHorzvn2B/pkhs+y5y1RIv2rUbFwuZ939bwglt8IvfYTR7vZiNgw+4226TKJERFmyHPtJ5qzHtT+R7nKiqNLly0HL7KtB3k5AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791487031; c=relaxed/relaxed;
	bh=O1FWBfwWl6paSlptrDmIcyH9EcRMPkhHCGTApLaIGSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=azN8eOPRORFQzkmHubmFFRzFNWfJF2iJS19d+aVl4Us0jHnfPnOEL/LkznGrMmlAey77Qdt6v97kHZRdfH1+AFdU/Kq3rVH8NN1QIhS5IR4STK6Dckn0pXlcQEhfW5biSgvRvPHf0O1f7aPYv2X19hF2KROCMzup0MNFTGuQCUKuAwNvNhXJEo3FzOcPtnL7pMnzCwnGttuU8/ySB8J1s5NvLRfVnSt3JGUP2nueoE6xN5kjokYNycHRK5Kdq+arODb1UGOMT7LEZQ57XuulYT29t5evKTyQnc+GsKZS3SNi5qGYjPwPz8z/NgR1MEYcbYu5WZmTAF4BDBn3Uw6ZOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVcCJ68u; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVcCJ68u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j109f1l99z30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:17:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9BCFA40D9D;
	Thu,  8 Oct 2026 19:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E29B1F000FF;
	Thu,  8 Oct 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487026;
	bh=O1FWBfwWl6paSlptrDmIcyH9EcRMPkhHCGTApLaIGSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WVcCJ68uLOw+zUK6AYaH8Ii9Csm94aDXARP0lkpM9yxwzSLMyj2JxmOuzVfo+3SSn
	 1q2hqILrb8gI4bS2Ht+AUu0df4cCQZsEvFmUtb9b3xiYRybZvJLejhvDQDA66O/QnP
	 n6ShmPlpYHVSpIBykbeHjv64247vBdNZzJg32Tbc2AwncGuWNntpnLoj6ZaG9mUWsV
	 JUXFk1zLH6Z7dy7kK6Oa0e4jh8OpndkS7+pDgykPkOnUeZv1yssNNc0lIuuIaK8KlV
	 fPC+PnSwss3i1ZX05O6coajosFQ0xM6eDELkoUjkX1e4OaVfq8eUxKxZ7vPp4Mpb4g
	 oHmjU8CPWmjrg==
Date: Thu, 8 Oct 2026 14:17:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261008191705.GA917105@bhelgaas>
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
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>

[+cc Thorsten]

On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
> 
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
> 
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
> 
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
> 
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
> 
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
since he hasn't tested this change by itself.

If we're confident that this also fixes the MacBookPro16,1 power-off
issue reported by Jason (it would be ideal if you could test this,
Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
If so, I'd like to add Jason's Reported-by and link.

But if we're not sure whether this fixes the MacBookPro16,1 power-off
issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
it with this fix and try again for v7.4.

As far as I'm aware, the reports are:

  https://lore.kernel.org/all/CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com/
    Alex's report for AMD Navi10 and Vega20

  https://lore.kernel.org/all/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com
    Jason's report of power-off issue on MacBookPro16,1

> ---
>  When applied to pci/for-linus, this will cause a conflict during the
>  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
>  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
>  
>  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
>  and move the pci_dev_put() out of the if-clause (so that it gets
>  called if pdev != NULL but err == 0).
>  
>  If this is all too complicated and/or late, I can respin on top of
>  pci/aer or v7.4-rc1.
>  
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..922a726a52a5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
>  
>  static void aer_recover_work_func(struct work_struct *work)
>  {
> +	struct aer_capability_regs *regs;
>  	struct aer_recover_entry entry;
>  	struct pci_dev *pdev;
> +	u32 err;
>  
>  	while (kfifo_get(&aer_recover_ring, &entry)) {
>  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_struct *work)
>  		}
>  		pci_print_aer(pdev, entry.severity, entry.regs);
>  
> +		regs = entry.regs;
> +		if (entry.severity == AER_CORRECTABLE)
> +			err = regs->cor_status & ~regs->cor_mask;
> +		else
> +			err = regs->uncor_status & ~regs->uncor_mask;
> +
>  		/*
>  		 * Memory for aer_capability_regs(entry.regs) is being
>  		 * allocated from the ghes_estatus_pool to protect it from
> @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_struct *work)
>  		ghes_estatus_pool_region_free((unsigned long)entry.regs,
>  					    sizeof(struct aer_capability_regs));
>  
> -		if (entry.severity == AER_NONFATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_normal,
> -					 aer_root_reset);
> -		else if (entry.severity == AER_FATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_frozen,
> -					 aer_root_reset);
> +		if (err) {
> +			if (entry.severity == AER_NONFATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_normal,
> +						 aer_root_reset);
> +			else if (entry.severity == AER_FATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_frozen,
> +						 aer_root_reset);
> +		}
>  		pci_dev_put(pdev);
>  	}
>  }
> -- 
> 2.53.0
> 

