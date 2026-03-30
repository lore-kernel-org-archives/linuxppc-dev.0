Return-Path: <linuxppc-dev+bounces-19027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FCB1061B1A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 19:19:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl1KR0pNXz2xT6;
	Tue, 31 Mar 2026 06:19:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774898395;
	cv=none; b=YZ5tGzCZq4/hKCz1dpUE2e4gybEFAknvqxctGn8GVhr8Mqef9oPZUV5dsZ+J6N5cdjuZ6wqTszv8QsyyISHCzvKZY3UYgw7MlzgjVIYawlAvX2onkr6d6gelr06DEYTL4g/y11+sFz0tAHorFnJzlxL3v4SCzvDqYessdAi8+l2yigAC8vhQ2GmJ6jPZS4/K2CYKIO0YlTrmJYs/GsBNOIaiW89/W+0F3CePonxF3Hn9fvbZ/k0DAvGYQ3iKxs586iStp6MOiwzIt5yF3y3ctJ+/6aSMXjLbaDBLHSvJZ8ZhgDtuD7a+sUpxbcik8ZLKQsDltGiuKHMp3eJitug08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774898395; c=relaxed/relaxed;
	bh=AoqCpVcLmNp1jSfmmWWyUl6YvKHs4TQqUZkRhSzUu5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=akp80WB6K4VjDx6QHcVM8NGvoJkNbRg4r4FVFfSPYeD4zWo04e7xYytIwwsR44ynsh1VrXwJTrULktppQYUN1OUwsKk4OTDlerdvll9AqRHF9f2w01q2R16LPrOvWAI+1H4OBkqaSl5eRH6+2j4kSNqBvdExF0c3bY5/sngN3krg9bbafMhogvwJvfI/fRv4zJxHL1Z51HYWhP4q6aSK1Lto5E2WZ53voKZHGjswP1eC1YPmx6e9QQg97hTwdDVG6Br7jycJFTu6emRfqFpiQdMbcMMtqSFEeM9MrIlMCU7hsljY8CRJS22H8nmRvRixhnoFPwuoH0azDfmbnjRjOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ofwVknvc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ofwVknvc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl1KQ3LJzz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 06:19:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7470F60130;
	Mon, 30 Mar 2026 19:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B17FC2BC9E;
	Mon, 30 Mar 2026 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774898391;
	bh=f2moM282vPvyLgsGb1zIT4CivF0cYkAINWw6P3Qsu3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ofwVknvcK53YQ8AnfEsD07hNUQYx9UMoC2QRm+p2b4iBIOkITweay5u2bpDph774S
	 fgYrhxg2/6b3p9sTyU5QSgY2RS3bHfpEA4f9+SSMhxRUDkvty3b8pj8t+RnPcGDC4x
	 SRL5Yj4Hm6GuzRSnPVZCfsciJxC0xKL+09ajChWnc+G7+r54MQwMkpEJlWT1u1y0AH
	 AhtG/Jxna1HCSVyof0WxnHt14ATr4QbqYtnHB06lKxZs4WfWZArIYbbXbvLdFS9ttz
	 iIFwcg9JxJq1giOE1undMWFh0zxXoXiD2cnZ6ha8oyTWr5Z8POQWev3LMWcfUrjvTf
	 lE3+jWGhyEuyA==
Date: Mon, 30 Mar 2026 14:19:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
Message-ID: <20260330191949.GA90884@bhelgaas>
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
In-Reply-To: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>

On Fri, Mar 27, 2026 at 10:56:43AM +0100, Lukas Wunner wrote:
> When searching for the error source, the AER driver rules out devices
> whose enable_cnt is zero.  This was introduced in 2009 by commit
> 28eb27cf0839 ("PCI AER: support invalid error source IDs") without
> providing a rationale.
> 
> Drivers typically call pci_enable_device() on probe, hence the enable_cnt
> check essentially filters out unbound devices.  At the time of the commit,
> drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
> and so any AER-enabled device could be assumed to be bound to a driver.
> The check thus made sense because it allowed skipping config space
> accesses to devices which were known not to be the error source.
> 
> But since 2022, AER is universally enabled on all devices when they are
> enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
> AER is native").
> 
> Errors may very well be reported by unbound devices, e.g. due to link
> instability.  By ruling them out as error source, errors reported by them
> are neither logged nor cleared.  When they do get bound and another error
> occurs, the earlier error is reported together with the new error, which
> may confuse users.  Stop doing so.
> 
> Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+

Applied to pci/aer for v7.1, thanks!

> ---
>  drivers/pci/pcie/aer.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4299c55..384d026 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	 *      3) There are multiple errors and prior ID comparing fails;
>  	 * We check AER status registers to find possible reporter.
>  	 */
> -	if (atomic_read(&dev->enable_cnt) == 0)
> -		return false;
>  
>  	/* Check if AER is enabled */
>  	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
> -- 
> 2.51.0
> 

