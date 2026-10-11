Return-Path: <linuxppc-dev+bounces-29192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72805CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 11:40:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2dvM6t71z2yY0;
	Sun, 11 Oct 2026 22:40:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791697501;
	cv=none; b=avHSX8hWD7LEXvttxjplZQ0UWJbE/dCxq4bNRqpwwbe/A9wJPWwsJexPRutwhu2xexVMm+y9JzPQFYoDIPJ7hlQzNPnYkFGXNYOsAklPjtkVfDKLa7LpEJioKG+04aofcS5xRhXMnfojlsPct4waIzKbAdDZ2jSh9UIN5GjYReu/ahZHBV9gO6godcXliJZlKdizZ/zYzUyfGQ/SfRuU7GDToeVddrlxXv+uX0t9DWpjKSHNJbPxjso8gjnzye4bfvs8V98AFKEJXeKGuCGyz7Ib195p6aZu5y6PmSDr08MXeySjaHEQkzK1ze3KbIqJDNaIvWISj+gXgxDwq08U/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791697501; c=relaxed/relaxed;
	bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWsqhjYcN35g5yZWwcTc7gxmrhCEvKjPfMVHtxP0F3MnMeDMBjge1vG1fgFhr4FCW5hYaDf9sFyLG19i7tKkHM+lc81Rki8ck9xr/RSHqrh8vr32SRO/LB9XiCCt2Wykmp+y2v+BrTLDyvr8B0M7anqjK88qgUIbONeAIm18Xv/LzTE1RkIjcacBDY4q1Pgj0YZwczjEP4cw/2u5u4U30U0s/EutukGq9+JsUYeX13Ny9lUMNFuFRQH9ermDYQWQyQOXS0GoktEG1jqse4g1dyl/HHhiN3VIMx66CYG3yfc4nnvl8cyv+Dlw423xv9on8FHB9EWM9TD8LTPUIkd/cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PCwn/8Sc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=unixpro1970@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PCwn/8Sc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=unixpro1970@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2V171t9fz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 16:44:57 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3222236eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791697495; x=1792302295; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=PCwn/8Sc8IUOr4fLPB3ZV64LPkAtAuXfEiuk3GIkrW93dGtIEEReDxbmvtwZ/wAG4I
         SA+ZGA/ugW0Mukd3jAHIB2T86r6o8584iHwdkG7aSXpEKQsPfFMa8n9+m7frTOaNd/1x
         hqzm1bAFuYTb/pP/wNVj1rU5J7/ZOxfdjEQ77TAm4sNOOxhy0kkPwOscg/08uXBBJrsZ
         2aNmCbg2DO36Dn339WolbCbw5GF+nmh/uT1U7J3uy9oXxdr3TYssEZTb8grI41gkpSCR
         DTcnBWLhLVaeJZMKhjew6v965wE6qmxLLrK4KSEy3Wl0gAsA/oLqbv4J3oPwRGxXdpMu
         PsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791697495; x=1792302295;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8diuNZ+zrgNOaX3UMVCcddQtmK2jbIBOVFz+8CGVq0=;
        b=sHJX4tXAkTGEvnlV/RYyfexeMMj7+ctLfAZdtt0Km0e8dT2VODYRA9Za8r5cIwqA1V
         AMilzSFmVTITbOHiCuk/rVQXt8KgRSN4aTP+o3iRotQ6iAoz07D0VearkA7FaMFpiP3g
         3y+c6wJoA72rHxiuHLpeLbQITujPFT646US+y3cgV1hIq2YVn0c95GDogb1lSkmMhlTW
         V4pKOoACi8+R7hJ5TgKTX8CdG3NIrth9VyCBzTQIEWxZiT3TF0R5kvdmWTNv6sCSwfCa
         BrgtAuTQtj8b/C2LipSAZsv6xMP7ysU7sVS3UiG1v2+1t5/oyrP7GxKvK+HVBth6kTZC
         t2IQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhhy/ZSbRJsd/8DyGOJxLfcGmAL7rjAUO5yTQghQyxOpt3E628HHJUXc0iEulEQA5GDiAZFo4T4Q9C5b0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ1WbFpnV5bFBtf2z05Icb2MjAVKFuOyXFHsH/6GkIkYmk769bC
	VdUTku7l215fTbtS5F8mWyjPJGDVQ+s4rE3rHHLtbRseZPiJDxRWEipk
X-Gm-Gg: AYBFou2Sm9Y5llooyr8ZMBbbRcHZatScXuoZhqwzZPC810XS1oev6YnKESrNDe3Kwii
	tJ8emp7V98YewFkABle1Gb9n9fB497BfXLk43pYPw07iNAD0oiM4K5pBs1wkjWv4T9Jw2cje+wE
	UKAlhOP05eC8U8s5DWQpvMz1wutEmEJZ0hmR9DybYhiTQg+scgJvLFB6KwB5nMNu2qh6nPCMcuu
	48GkA1BSTs3AgtvZcRytebp2LxRX8r78QFsX6WAS0gnm5mndckhfP4Ebc/AJ7hHKwneE/gUUqDk
	yYiHiXovM4bDYARkvpJRG/8NDLtnRy2c6msRXDAK54ebQ9ztH7fpToAkkgtRTu7XuhQlG8V7jIF
	9SRUHuiQtNZh8hOL0OmrTSdcU/dVVz/+ufKyOtzpMkyYWR+7dxsHMvqgsaU90G9qWlWGlbZOduv
	azA3xpDvsiFmM94GFqLzhYbT+BQGiMPM+LzIO2qnc7T94XSuKLT2/YRGm994Jy+RSgrdIDV5/99
	829j/pE0nFrZQC48I4BALxpDb6YT29XXiW4/oy/vruPZA==
X-Received: by 2002:a05:693c:8811:20b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-3567ddb2f02mr6808511eec.29.1791697494583;
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm23485573eec.3.2026.10.10.22.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 22:44:54 -0700 (PDT)
Message-ID: <17a20959-44ed-43e5-8414-201120468f2f@gmail.com>
Date: Sat, 10 Oct 2026 22:44:52 -0700
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
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
To: Stian Halseth <stian@itx.no>, Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andreas Larsson <andreas@gaisler.com>, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261007131304.309511-1-stian@itx.no>
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261007131304.309511-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch also works on the Sparc S7-2, the correct x8 link is shown 
instead of unknown.

# dmesg | grep -iE x8 | grep -iE link
[    8.421411] mlx5_core 0001:03:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[    9.472465] mlx5_core 0001:03:00.1: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)
[   14.734746] mlx4_core 0001:04:00.0: 63.008 Gb/s available PCIe 
bandwidth (8.0 GT/s PCIe x8 link)

Tested-by: Tony Rodriguez <unixpro1970@gmail.com>

On 10/7/26 6:13 AM, Stian Halseth wrote:
> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
>
>    WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0
>
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
>
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
> warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
> devices report their real speed and the quirk lifts the 2.5GT/s
> restriction without a warning. Not tested on powerpc.
>
>   drivers/pci/probe.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..52a79b033b069 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>   		pdev->aspm_l1_support = 1;
>   #endif
>   
> +	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
> +
>   	parent = pci_upstream_bridge(pdev);
>   	if (!parent)
>   		return;
> @@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
>   
>   	set_pcie_untrusted(dev);
>   
> -	if (pci_is_pcie(dev))
> -		dev->supported_speeds = pcie_get_supported_speeds(dev);
> -
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
>   

