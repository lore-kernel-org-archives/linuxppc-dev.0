Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB6BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:26:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECD4206DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3NR8QAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TLj22cXpzDqNr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:26:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3NR8QAz"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TLgJ2k1WzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 06:24:59 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7346520823;
 Tue, 26 Mar 2019 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553628297;
 bh=Tqq4THWtjlYn1tW04YUldKqpOXYiHwUKtX6cGrceRiM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l3NR8QAzvl0SRP9sjowAsWVfGbqOf3tsLpCQuOIee2zmUODvFBsLzsYVeF6WwlhYQ
 HbX+cjXh9F9TJNTqtV19PkGrlHJGiKJXJ2aeKxyDQaoG1BlhLhvWzl5YfHdyI8boAB
 CFMTT1ZbpDOnJXYCzGK6jkRfpeTD8n5vRBLtiGQw=
Date: Tue, 26 Mar 2019 14:24:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 05/21] PCI: hotplug: Add a flag for the movable
 BARs feature
Message-ID: <20190326192455.GN24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-6-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-6-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 11, 2019 at 04:31:06PM +0300, Sergey Miroshnichenko wrote:
> If a new PCIe device has been hot-plugged between the two active ones
> without big enough gap between their BARs, 

Just to speak precisely here, a hot-added device is not "between" two
active ones because the new device has zeros in its BARs.

BARs from different devices can be interleaved arbitrarily, subject to
bridge window constraints, so we can really only speak about a *BAR*
(not the entire device) being between two other BARs.

Also, I don't think there's anything here that is PCIe-specific, so we
should talk about "PCI", not "PCIe".

> these BARs should be moved
> if their drivers support this feature. The drivers should be notified
> and paused during the procedure:
> 
> 1)                 dev 8 (new)
>                        |
>                        v
> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> 
> 2)                             dev 8
>                                  |
>                                  v
> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
> 
>  3)
> 
> .. |  dev 3  |  dev 3  |  dev 8  |  dev 8  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> 
> Thus, prior reservation of memory regions by BIOS/bootloader/firmware
> is not required anymore for the PCIe hotplug.
> 
> The PCI_MOVABLE_BARS flag is set by the platform is this feature is
> supported and tested, but can be overridden by the following command
> line option:
>     pcie_movable_bars={ off | force }

A chicken switch to turn this functionality off is OK, but I think it
should be enabled by default.  There isn't anything about this that's
platform-specific, is there?

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++++++
>  drivers/pci/pci.c                             | 24 +++++++++++++++++++
>  include/linux/pci.h                           |  2 ++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb644..d40eaf993f80 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3417,6 +3417,13 @@
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_movable_bars=[PCIE]
> +			Override the movable BARs support detection:
> +		off
> +			Disable even if supported by the platform
> +		force
> +			Enable even if not explicitly declared as supported
> +
>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>  
>  	pd_ignore_unused
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 69898fe5255e..4dac49a887ec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -139,6 +139,30 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>  
> +static bool pcie_movable_bars_off;
> +static bool pcie_movable_bars_force;
> +static int __init pcie_movable_bars_setup(char *str)
> +{
> +	if (!strcmp(str, "off"))
> +		pcie_movable_bars_off = true;
> +	else if (!strcmp(str, "force"))
> +		pcie_movable_bars_force = true;
> +	return 1;
> +}
> +__setup("pcie_movable_bars=", pcie_movable_bars_setup);
> +
> +bool pci_movable_bars_enabled(void)
> +{
> +	if (pcie_movable_bars_off)
> +		return false;
> +
> +	if (pcie_movable_bars_force)
> +		return true;
> +
> +	return pci_has_flag(PCI_MOVABLE_BARS);
> +}
> +EXPORT_SYMBOL(pci_movable_bars_enabled);
> +
>  /* Time to wait after a reset for device to become responsive */
>  #define PCIE_RESET_READY_POLL_MS 60000
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cb2760a31fe2..cbe661aff9f5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -866,6 +866,7 @@ enum {
>  	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
>  	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
> +	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
>  };
>  
>  /* These external functions are only available when PCI support is enabled */
> @@ -1345,6 +1346,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  					 unsigned long type);
> +bool pci_movable_bars_enabled(void);
>  
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> -- 
> 2.20.1
> 
