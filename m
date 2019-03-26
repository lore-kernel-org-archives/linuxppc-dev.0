Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:36:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A19206DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrysglNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A19206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TLx13JKQzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:36:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrysglNv"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TLlW5NXqzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 06:28:39 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B71ED206DF;
 Tue, 26 Mar 2019 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553628517;
 bh=oXG6GQu1LQEb6F+ueBN+gThZWYzBcvbWT0Wx+PcJKPI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KrysglNvyY/6Bo+8GuVDMjspsPfnRU6/6sx4zVWni659cW13tvyWnHBC19GbVqJr6
 jKpCGg6bFqvMLm0ILlm+fHNr7Ri5At4IEDrC6RTPgEFRJvQyBne+gr0i3g+7ahlmIj
 zzgmwM3fASKDHSl1CeehLdMU2Al5cRakMdfU+wm4=
Date: Tue, 26 Mar 2019 14:28:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 07/21] PCI: Wake up bridges during rescan when
 movable BARs enabled
Message-ID: <20190326192835.GO24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-8-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-8-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:08PM +0300, Sergey Miroshnichenko wrote:
> Use the PM runtime methods to wake up the bridges before accessing
> their config space.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 88350dd56344..dc935f82a595 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3252,6 +3252,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> +	pm_runtime_get_sync(&bus->dev);

This should be part of the patch that adds the config space access
so we can tell specifically what code requires the wakeup.

>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		struct pci_bus *child = dev->subordinate;
>  
> @@ -3278,6 +3280,8 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
>  			dev->driver->rescan_done(dev);
>  		}
>  	}
> +
> +	pm_runtime_put(&bus->dev);
>  }
>  
>  /**
> -- 
> 2.20.1
> 
