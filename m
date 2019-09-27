Return-Path: <SRS0=CCuM=XW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80465C4360C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 22:04:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2521F21841
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYwSf5Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2521F21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46g5Rs0hPzzDqnk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Sep 2019 08:04:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="VYwSf5Pq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46g5Ng66XpzDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2019 08:01:39 +1000 (AEST)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D221B2082F;
 Fri, 27 Sep 2019 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569621697;
 bh=3gKE7NR6aQzEoQPANayg8VF+vjEvBawquzUnQ3HOO9Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=VYwSf5PqkjJ2JobOy8WvasnNZ3WvFmaP8SFVwZcyFVuN5Fg7KgVkdxsUQCrjE+77r
 plMmJiTgWXq3/AAQCiu/J6PPxwUilv1znv/xF4viH8tLPbI9INAmzs2fYRWeBwyiAT
 Wxvk7JdwfwMlyu3n8HgjD16lipxW3I/VhKQkGyi0=
Date: Fri, 27 Sep 2019 17:01:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH v5 02/23] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
Message-ID: <20190927220135.GA55204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165101.911-3-s.miroshnichenko@yadro.com>
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

On Fri, Aug 16, 2019 at 07:50:40PM +0300, Sergey Miroshnichenko wrote:
> The PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits of the bridge must be
> updated not only when enabling the bridge for the first time, but also if a
> hotplugged device requests these types of resources.

Yeah, this assumption that pci_is_enabled() means PCI_COMMAND_IO and
PCI_COMMAND_MEMORY are set correctly even though we may now need
*different* settings than when we incremented pdev->enable_cnt is
quite broken.

> Originally these bits were set by the pci_enable_device_flags() only, which
> exits early if the bridge is already pci_is_enabled(). So if the bridge was
> empty initially (an edge case), then hotplugged devices fail to IO/MEM.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7f8c354e644..61d951766087 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1652,6 +1652,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
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
> +
>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
>  		mutex_unlock(&dev->enable_mutex);
> -- 
> 2.21.0
> 
