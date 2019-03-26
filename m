Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A8C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:01:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C170220700
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 21:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozo50Idb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C170220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TNpJ6SkdzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 08:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ozo50Idb"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TNlL2sxSzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 07:58:37 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 522B320700;
 Tue, 26 Mar 2019 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553633915;
 bh=6ujCIOWsOpQAnCiYLQ10EoPrx6oW6RzFQfKyKQYBr2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ozo50Idbg48rciW+FqVAefhFQC39nGjXSRfq+wa0KzlDtByMsKO2WUDEekyBnzRac
 IPLlC9jQArhnkUYikTUEVz4uuc6/xnoMTdLwfUSSMq02RLo1mjfl2aHq9RkP42B+KY
 b41arw8i9BtoM2SMSnH4PWm30bJmHD6Uv8+rW/K8=
Date: Tue, 26 Mar 2019 15:58:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 15/21] PCI: Allow the failed resources to be
 reassigned later
Message-ID: <20190326205832.GV24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-16-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-16-s.miroshnichenko@yadro.com>
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

On Mon, Mar 11, 2019 at 04:31:16PM +0300, Sergey Miroshnichenko wrote:
> Don't lose the size of the requested EP's BAR if it can't be fit
> in a current trial, so this can be retried.

s/EP/device/, since this applies equally to conventional PCI.

> But a failed bridge window must be dropped and recalculated in the
> next trial.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c |  3 ++-
>  drivers/pci/setup-res.c | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f9d605cd1725..c1559a4a8564 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -309,7 +309,8 @@ static void assign_requested_resources_sorted(struct list_head *head,
>  						    0 /* don't care */,
>  						    0 /* don't care */);
>  			}
> -			reset_resource(res);
> +			if (!pci_movable_bars_enabled())
> +				reset_resource(res);
>  		}
>  	}
>  }
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d8ca40a97693..732d18f60f1b 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -298,6 +298,18 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
>  
>  	bus = dev->bus;
>  	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
> +		if (pci_movable_bars_enabled()) {
> +			if (resno >= PCI_BRIDGE_RESOURCES &&
> +			    resno <= PCI_BRIDGE_RESOURCE_END) {
> +				struct resource *res = dev->resource + resno;
> +
> +				res->start = 0;
> +				res->end = 0;
> +				res->flags = 0;
> +			}
> +			break;
> +		}
> +
>  		if (!bus->parent || !bus->self->transparent)
>  			break;
>  		bus = bus->parent;
> -- 
> 2.20.1
> 
