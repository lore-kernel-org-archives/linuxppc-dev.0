Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0FDC47DAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jan 2024 18:17:43 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KyTBGJ/R;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJdjx4GY2z3c3W
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jan 2024 05:17:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KyTBGJ/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJdj36JKbz3brL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2024 05:16:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 07FF7CE2B15;
	Mon, 22 Jan 2024 18:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC88C43390;
	Mon, 22 Jan 2024 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947411;
	bh=zs4odd+WvZxxeJZAIgTFXLhjdsQ/+nQnKFxVYEnrn5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KyTBGJ/Roe52KXBtV6pUS2z2guHxTPRqLqAbKA7P7brGduEu6SHbdDU5jikzGQ/5+
	 W/ERfaZ450P+TB1QSC3SG27MfKirkVxWRso1UHQ/p1oLAZVJN8VzE2f2S4n/pA8tUn
	 /b3PDIfS7yt634Rv5MhUjn6h9gv497E7B3KbLq7lC8LF9EmkXW99PiE9fNJM2GbiPd
	 Jv3rzlMqRfUmSSN2WK60I0MrOXbj6Me1dPQSzYkJ+jn1IvJ0TKd+DMH7HoqiR6sDTe
	 pXxHDyvFAYvRvfk4SDDTLA3LrOVZxUFJ+2FjZWX46RAV2iV1vJzNfSiA2VPsXfY53R
	 maWi+q3muzhtg==
Date: Mon, 22 Jan 2024 12:16:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI/DPC: Fix TLP Prefix register reading offset
Message-ID: <20240122181649.GA276863@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240118110815.3867-1-ilpo.jarvinen@linux.intel.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Dongdong Liu <liudongdong3@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 18, 2024 at 01:08:15PM +0200, Ilpo Järvinen wrote:
> The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
> 7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading
> from the first DWORD. Add the iteration count based offset calculation
> into the config read.
> 
> Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/dpc for v6.9 with commit log below, thanks!

    PCI/DPC: Print all TLP Prefixes, not just the first
    
    The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
    7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading from
    the first DWORD, so we print only the first PIO TLP Prefix (duplicated
    several times), and we never print the second, third, etc., Prefixes.
    
    Add the iteration count based offset calculation into the config read.
    
    Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
    Link: https://lore.kernel.org/r/20240118110815.3867-1-ilpo.jarvinen@linux.intel.com
    Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    [bhelgaas: add user-visible details to commit log]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 94111e438241..e5d7c12854fa 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -234,7 +234,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  
>  	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
>  		pci_read_config_dword(pdev,
> -			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
> +			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
>  		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
>  	}
>   clear_status:
> -- 
> 2.39.2
> 
