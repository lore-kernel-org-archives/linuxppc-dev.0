Return-Path: <linuxppc-dev+bounces-13918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E98CCCF9E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Nov 2025 06:10:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2pZ950QMz3bsN;
	Fri,  7 Nov 2025 17:10:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762495809;
	cv=none; b=FyI2PkNgUxwGTHnITl5L3M917KZa9h4cBkJvAL55v5fGa6pQIccEnJQjIZWKf3lNvlsLsHNJXHICZNfQ2S7tsr1+XDIVJYpYqunC54JcIb8C9pghWlryO1XeDz4RrKjQ5aZ4+gsVt5w4FYkAapcJ6xmD8lwNymq6lVFIcWJYRvhcBTbkwuiVD4zxnK4d7XAfvwbtOG0ysbGhXhVtb9vPxyhJ9XuYD7YPqVGnT7SbqK5D304LkZfwPYrz9CJClz0nk8BpNinx44zrFmiYhYD61j6JcY19ItyHm7g7VhFxkWv0dRHediNHXMdPBX2dW3S5G4HSJ1KYNhlRCEBPcYlHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762495809; c=relaxed/relaxed;
	bh=fG9FG2AJcoRIYJL3kEnx8WNoWwjDR6hATf5Lyst+85A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMsDO2W87T7XdasQ0pLXU1U8Vd4ifhUX18R2LcEk+aLGq+Z2m/F+aw9mLRQVlQFX0vEioibdOFg+K+WInHlbW+6L+/s7N5X5+dPddw8fh7NcL9s9rjTdGWe/rHVlSpPSfwlRonR1yiTFEHLoAqYk3vdEhMNz3P9imvhSX4stQLiFKz5xwsuUia0sgF4XhZAJK+aUEQreA8w3VuYYdJV9eVCTNDF6dnubdCRYPXirxWnaunz+rQfQfG7K18S/mclkyptHPlkhhnptk5RYv0ccKf93WA91STsWDF7j7Impmrjkx9Emzo1/cynJH5qJxrYZ53r6f3qrYmNAeYO1ukMMAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tfRhim6y; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tfRhim6y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2pZ86KVcz2yfL
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2025 17:10:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C2596013B;
	Fri,  7 Nov 2025 06:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86FDC4CEF5;
	Fri,  7 Nov 2025 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762495805;
	bh=Qw47Ypxh6hCFBJwUZNmfzHzoZf62V55gj0I8Wbneo2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfRhim6ylIxts3xnNHkB7gm6zcHD1Jy69uXevGxzCCF5oaN9yLlEmGqGMbxxR3QEx
	 iIBh9pgnRsEW0eNMazmYNzfUSgJwAo1q/4BvoIB/jqAAjBLaYS4Ye4E1nsaP36ts4f
	 y7XFx+Rg14Bbj53V2bW+o7vqINfIoSP/T5bio6AQhzQSFiqFQh1lvWLGnR9gn34wcS
	 hqC8UTGRWfHwJ0tvepmuc/82HNuOgjpHHOg4LD31RyqUW+2fQU2dC74qw9Pb15Gr3e
	 3Q1GfGhHowctqQ5cTa4XVftpSx/EQbL00AC6qMJ8heP6jaiBiMzrcVuY7KQ7a+58o2
	 P/FdDkL7E/yvg==
Date: Fri, 7 Nov 2025 11:39:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>, 
	Darren Stevens <darren@stevens-zone.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, 
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, 
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Message-ID: <ogkty663ld7fe3qmbxyil47pudidenqeikol5prk7n3qexpteq@h77qi3sg5xo4>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-3-helgaas@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106183643.1963801-3-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:39PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
> ASPM states for devicetree platforms") broke booting on the A-EON X5000.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms"
> )
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..44e780718953 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +/*
> + * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
> + * aspm.c won't try to enable them.
> + */
> +static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
> +{
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);

From the commit message of the earlier version [1] you shared:

    Removing advertised features prevents aspm.c from enabling them, even if
    users try to enable them via sysfs or by building the kernel with
    CONFIG_PCIEASPM_POWERSAVE or CONFIG_PCIEASPM_POWER_SUPERSAVE.

Going by this reasoning, shouldn't we be doing this for the other quirks
(quirk_disable_aspm_l0s_l1/quirk_disable_aspm_l0s) as well?

- Mani

[1] https://lore.kernel.org/linux-pci/20251105220925.GA1926619@bhelgaas

-- 
மணிவண்ணன் சதாசிவம்

