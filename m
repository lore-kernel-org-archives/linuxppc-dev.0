Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F23C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 05:40:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B43C20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 05:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B43C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CsP44bb6zDqtl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:40:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CsLn5TyrzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:38:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43CsLn2B9jz9s4s;
 Mon, 10 Dec 2018 16:38:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] misc: cxl: Use device_type helpers to access the node
 type
In-Reply-To: <20181205191655.14612-1-robh@kernel.org>
References: <20181205191655.14612-1-robh@kernel.org>
Date: Mon, 10 Dec 2018 16:38:35 +1100
Message-ID: <878t0yeyas.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rob Herring <robh@kernel.org> writes:

> Remove directly accessing device_type property and use the
> of_node_is_type accessor instead. While not using it here, this is
> part of eventually removing the struct device_node.type pointer.
>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Reword commit message as this change was using the .type ptr.

I already have v1 in my next.

cheers

> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index b66d832d3233..c79ba1c699ad 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1718,7 +1718,6 @@ int cxl_slot_is_switched(struct pci_dev *dev)
>  {
>  	struct device_node *np;
>  	int depth = 0;
> -	const __be32 *prop;
>  
>  	if (!(np = pci_device_to_OF_node(dev))) {
>  		pr_err("cxl: np = NULL\n");
> @@ -1727,8 +1726,7 @@ int cxl_slot_is_switched(struct pci_dev *dev)
>  	of_node_get(np);
>  	while (np) {
>  		np = of_get_next_parent(np);
> -		prop = of_get_property(np, "device_type", NULL);
> -		if (!prop || strcmp((char *)prop, "pciex"))
> +		if (!of_node_is_type(np, "pciex"))
>  			break;
>  		depth++;
>  	}
> -- 
> 2.19.1
