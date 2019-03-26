Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF13C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:30:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0376F2084B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRbtN2mI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0376F2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TN6h6xX6zDqNC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 07:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="jRbtN2mI"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TN4p4spwzDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 07:28:42 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A808120823;
 Tue, 26 Mar 2019 20:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553632119;
 bh=WFvvcDuZs9rrsvT4pMUhl0PiMgnIV0Gt5788pwiVv+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jRbtN2mIEgGLQ9gmE9LOgyzswxXCmu/YPe8mmZCs9KOojKaW0GGx9mVI1JVEHCxgw
 zsFHcviWD/i5eMurNuakaV2ORqCm4rhvCWW9VRETTgBhyZH5T8sI7MIXXgEDb7VfSV
 7ytHdGLoa2lb6GH/MG264ZOgtXOxfqnLYscvC4tE=
Date: Tue, 26 Mar 2019 15:28:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 09/21] PCI: Mark immovable BARs with PCI_FIXED
Message-ID: <20190326202838.GQ24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-10-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-10-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:10PM +0300, Sergey Miroshnichenko wrote:
> If a PCIe device driver doesn't yet have support for movable BARs,
> mark device's BARs with IORESOURCE_PCI_FIXED.

I'm hesitant about using IORESOURCE_PCI_FIXED for this purpose.  That
was originally added to describe resources that can not be changed
because they're hardwired in the device, e.g., legacy resources and
Enhanced Allocation resources.

In general, I think the bits in res->flags should tell us things about
the hardware.  This particular use would be something about the
*driver*, and I think we should figure that out by looking at
dev->driver.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/probe.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dc935f82a595..1cf6ec960236 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3262,6 +3262,21 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
>  		} else if (dev->driver &&
>  			   dev->driver->rescan_prepare) {
>  			dev->driver->rescan_prepare(dev);
> +		} else if (dev->driver || ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)) {
> +			int i;
> +
> +			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +				struct resource *r = &dev->resource[i];
> +
> +				if (!r->flags || !r->parent ||
> +				    (r->flags & IORESOURCE_UNSET) ||
> +				    (r->flags & IORESOURCE_PCI_FIXED))
> +					continue;
> +
> +				r->flags |= IORESOURCE_PCI_FIXED;
> +				pci_warn(dev, "%s: no support for movable BARs, mark BAR %d (%pR) as fixed\n",
> +					 __func__, i, r);
> +			}
>  		}
>  	}
>  }
> -- 
> 2.20.1
> 
