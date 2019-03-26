Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F70DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:13:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E214620823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5uhFalp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E214620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TP495c7FzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:13:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="O5uhFalp"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TP2W0nJBzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 08:11:46 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 146D320823;
 Tue, 26 Mar 2019 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553634704;
 bh=20gWlyw4rGk46s3Kgkmub1DeOv360cZMjWjgYTLyHEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O5uhFalpz9xrHhXt9b62w9P++MRYpmjyoJIYm72iIgtetz/vr3Km9prWfJUOdXq1K
 I4pMXz7dc4gDcTYhrwR9ncmWpqca5SvxLze03rwAw4OoaY6I0J0Ve+pf+r+59bp+If
 H5gW2Chm/hIIjkCDJPd+47QMb4OsTne69GE4IUz4=
Date: Tue, 26 Mar 2019 16:11:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 20/21] PCI: pciehp: Add support for the movable
 BARs feature
Message-ID: <20190326211142.GX24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-21-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-21-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:21PM +0300, Sergey Miroshnichenko wrote:
> With movable BARs, adding a hotplugged device may affect all the PCIe
> domain starting from the root, so use a pci_rescan_bus() function which
> handles the rearrangement of existing BARs and bridge windows.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/hotplug/pciehp_pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index b9c1396db6fe..7c0871db5bae 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -56,12 +56,16 @@ int pciehp_configure_device(struct controller *ctrl)
>  		goto out;
>  	}
>  
> -	for_each_pci_bridge(dev, parent)
> -		pci_hp_add_bridge(dev);
> +	if (pci_movable_bars_enabled()) {
> +		pci_rescan_bus(parent);
> +	} else {
> +		for_each_pci_bridge(dev, parent)
> +			pci_hp_add_bridge(dev);
>  
> -	pci_assign_unassigned_bridge_resources(bridge);
> -	pcie_bus_configure_settings(parent);
> -	pci_bus_add_devices(parent);
> +		pci_assign_unassigned_bridge_resources(bridge);
> +		pcie_bus_configure_settings(parent);
> +		pci_bus_add_devices(parent);
> +	}

The addition of a second path at this level, i.e., different paths
depending on whether movable BARs are enabled, seems a little
problematic because it's hard to determine whether they're equivalent
except for the movable BAR aspect.  For example, you don't call
pci_hp_add_bridge() when movable BARs are enabled, and I can't tell
whether that's intentional or whether it's a problem.

This looks like the sort of change that should be made in other
hotplug paths, e.g., enable_slot() for acpiphp,
pcibios_finish_adding_to_bus() for powerpc (maybe? I can't really
tell), cpci_configure_slot() shpchp_configure_device()?

If we have or could invent some top-level interface that all these
places could use, and somewhere inside that we could do the movable
BAR magic, I think that would make it more maintainable.

>   out:
>  	pci_unlock_rescan_remove();
> -- 
> 2.20.1
> 
