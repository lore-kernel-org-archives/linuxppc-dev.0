Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F36C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:03:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC8520700
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp+J0KVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC8520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TNrW3lDvzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:03:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xp+J0KVS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TNph5Rb3zDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 08:01:32 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 116AF20700;
 Tue, 26 Mar 2019 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553634090;
 bh=OyGK1NDb6I+kvmdYDA5ghahPKtxN//wz8HKe7ZLrN+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xp+J0KVSVV4Ue36xx428+Eu1xX4Itdd0ESx0zA5J9ujq7Wj7Jd0PGC4qZWRzDEjMh
 w+uLHMyZxfZxOgOAOn5NNJfjhQs6jy5AHSRALgnLr+PTdJBe3jaCF6/m4LCv262W8A
 7s1aLP9xoEHERLHNnxCdt+TQzs/+4Mjyv/GJs+3k=
Date: Tue, 26 Mar 2019 16:01:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 17/21] PCI: Calculate boundaries for bridge windows
Message-ID: <20190326210128.GW24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-18-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-18-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:18PM +0300, Sergey Miroshnichenko wrote:
> If a bridge window contains fixed areas (there are PCIe devices with
> immovable BARs located on this bus), 

I think what you mean by "immovable BARs" is "drivers that don't
support moving BARs".  I want to keep the concept of legacy and EA
resources separate because those are immovable in principle, but
drivers can always be improved.

> this window must be allocated
> within the bound memory area, limited by windows size and by address
> range of fixed resources, calculated as follows:
> 
>            | <--     bus's fixed_range_hard   --> |
>   | <--  fixed_range_hard.end - window size   --> |
>            | <--  fixed_range_hard.start + window size   --> |
>   | <--                bus's fixed_range_soft            --> |
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  4 ++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index a1fd7f3c5ea8..f4737339d5ec 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1809,6 +1809,61 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
>  }
>  #endif
>  
> +static void pci_bus_update_fixed_range_soft(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *parent = bus->parent;
> +	int idx;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		if (dev->subordinate)
> +			pci_bus_update_fixed_range_soft(dev->subordinate);
> +
> +	if (!parent || !bus->self)
> +		return;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(bus->fixed_range_hard); ++idx) {
> +		struct resource *r;
> +		resource_size_t soft_start, soft_end;
> +		resource_size_t hard_start = bus->fixed_range_hard[idx].start;
> +		resource_size_t hard_end = bus->fixed_range_hard[idx].end;
> +
> +		if (hard_start > hard_end)
> +			continue;
> +
> +		r = bus->resource[idx];
> +
> +		soft_start = hard_end - resource_size(r) + 1;
> +		soft_end = hard_start + resource_size(r) - 1;
> +
> +		if (soft_start > hard_start)
> +			soft_start = hard_start;
> +
> +		if (soft_end < hard_end)
> +			soft_end = hard_end;
> +
> +		list_for_each_entry(dev, &parent->devices, bus_list) {
> +			struct pci_bus *sibling = dev->subordinate;
> +			resource_size_t s_start, s_end;
> +
> +			if (!sibling || sibling == bus)
> +				continue;
> +
> +			s_start = sibling->fixed_range_hard[idx].start;
> +			s_end = sibling->fixed_range_hard[idx].end;
> +
> +			if (s_start > s_end)
> +				continue;
> +
> +			if (s_end < hard_start && s_end > soft_start)
> +				soft_start = s_end;
> +		}
> +
> +		bus->fixed_range_soft[idx].start = soft_start;
> +		bus->fixed_range_soft[idx].end = soft_end;
> +	}
> +}
> +
>  /*
>   * first try will not touch pci bridge res
>   * second and later try will clear small leaf bridge res
> @@ -1847,6 +1902,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	/* Depth first, calculate sizes and alignments of all
>  	   subordinate buses. */
>  	__pci_bus_size_bridges(bus, add_list);
> +	pci_bus_update_fixed_range_soft(bus);
>  
>  	/* Depth last, allocate resources and update the hardware. */
>  	__pci_bus_assign_resources(bus, add_list, &fail_head);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7a4d62d84bc1..75a56db73ad4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -574,9 +574,11 @@ struct pci_bus {
>  
>  	/*
>  	 * If there are fixed resources in the bridge window, the hard range
> -	 * contains the lowest and the highest addresses of them.
> +	 * contains the lowest and the highest addresses of them, and this
> +	 * bridge window must reside within the soft range.
>  	 */
>  	struct resource fixed_range_hard[PCI_BRIDGE_RESOURCE_NUM];
> +	struct resource fixed_range_soft[PCI_BRIDGE_RESOURCE_NUM];
>  
>  	struct pci_ops	*ops;		/* Configuration access functions */
>  	struct msi_controller *msi;	/* MSI controller */
> -- 
> 2.20.1
> 
