Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34592C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:05:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16712086C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16712086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XnyK49pYzDqFK
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 21:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Xnwj3lR7zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 21:03:28 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7E6A78;
 Mon,  1 Apr 2019 03:03:26 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC163F690;
 Mon,  1 Apr 2019 03:03:21 -0700 (PDT)
Date: Mon, 1 Apr 2019 11:03:18 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH 1/8] PCI: dwc: pci-dra7xx: fix a leaked reference by
 adding missing of_node_put
Message-ID: <20190401100318.GB30501@e107981-ln.cambridge.arm.com>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: heiko@sntech.de, hayashi.kunihiko@socionext.com, shawn.lin@rock-chips.com,
 minghuan.Lian@nxp.com, paulus@samba.org, thomas.petazzoni@bootlin.com,
 ryder.lee@mediatek.com, kishon@ti.com, linux-rockchip@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, wang.yi59@zte.com.cn, rjui@broadcom.com,
 linux-mediatek@lists.infradead.org, tyreld@linux.vnet.ibm.com,
 matthias.bgg@gmail.com, linux-omap@vger.kernel.org, mingkai.hu@nxp.com,
 roy.zang@nxp.com, sbranden@broadcom.com, yamada.masahiro@socionext.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 12:40:36PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/pci/controller/dwc/pci-dra7xx.c:252:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./drivers/pci/controller/dwc/pci-dra7xx.c:255:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied the series to pci/misc for v5.2, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index ae84a69..627c91d 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -247,6 +247,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>  
>  	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						   &intx_domain_ops, pp);
> +	of_node_put(pcie_intc_node);
>  	if (!dra7xx->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENODEV;
> -- 
> 2.9.5
> 
