Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F3C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:14:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50C12075C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omY5iDsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50C12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TLRJ4bWszDqGX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:14:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="omY5iDsV"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TLPg5cC0zDqGB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 06:13:11 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4B0520700;
 Tue, 26 Mar 2019 19:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553627589;
 bh=qo+GKUPJZX+bvvD/bhL0EMpl8YD8x5KfuoRsDygMmQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=omY5iDsV7tn5seOWolhnzXmV71Fui1Zs+3PTNpCkew6KYmy02I8tbjx5Denwu3fkM
 qRxVZD58y+XAKGnq0RZ/BeRgg7F1WFesNCFhHw97HSrsNnJqUaMUNuldGOKSQrFUTe
 2OA8b5YURkSsOHFSlmr9lhcm4u/piYTOed6xshTI=
Date: Tue, 26 Mar 2019 14:13:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 03/21] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
Message-ID: <20190326191307.GM24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-4-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-4-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:04PM +0300, Sergey Miroshnichenko wrote:
> After updating the bridge window resources, the PCI_COMMAND_IO and
> PCI_COMMAND_MEMORY bits of the bridge must be addressed as well.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 895201d4c9e6..69898fe5255e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1622,6 +1622,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  		pci_enable_bridge(bridge);
>  
>  	if (pci_is_enabled(dev)) {
> +		int i, bars = 0;
> +
> +		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
> +				bars |= (1 << i);
> +		}
> +		do_pci_enable_device(dev, bars);

In what situation is this needed, exactly?  This code already exists
in pci_enable_device_flags().  Why isn't that enough?

I guess maybe there's some case where we enable the bridge, then
assign bridge windows, then enable a downstream device?

Does this fix a bug with current hotplug?

>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
>  		mutex_unlock(&dev->enable_mutex);
> -- 
> 2.20.1
> 
