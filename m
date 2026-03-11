Return-Path: <linuxppc-dev+bounces-18007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30190FD88F7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 05:04:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVzFJ2t3Zz3c9r;
	Wed, 11 Mar 2026 16:04:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773205476;
	cv=none; b=ozlZ3EWcBdR5Cu0Odnu/bR0gRmlPD07EAqK6J6Rta/IJ9gpXKNmvzvdVUYIYXhLm8mHBfIoOTWTbo1JJyvMXKf2tdnct/A4pj37KCqEQVOqKMzzQkPHJn4AXQRF+PZvWe3QyRh6SFEoix4mV+j3JsL4MbXcgPJUl75KBTyDgfLO9w41tk6473jK3eqDUe1i3o0/xdriZ/hn78ZqbnvtO7/6KShBC0v+LAcC17Vpn6aMiOBeS5hPCE0jT9lZAvFZO3xJygblFp0+pwHIvmcofAIqHfejAMqEt+iuPhaecuuXnEfr/A0sMfNmMsEH+m/krJ7ofjmueF3XNCohgnuPQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773205476; c=relaxed/relaxed;
	bh=h59uLNd2xV76PXDM3+f5UYNA+XidIXY/4r4ME8WXvsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOfAHWro8Qd4j5RHu77BmOui95Q2cfzcAuefNY/9yjXGnXid8vdglVkS2hiBtW+W1eT0D/fc/jBmeK4PbJuVLAW1ezRgBET4PCe4/B7aTg5+3e9uFup1jqWnycQixsvv7b2Trtah0f8KXqYx7vU/HhZ4SG9PZKjmMmIcpWSlGo1SJ7blYOas4lf1ok+U7HkPFmAn9fKbuCUO6ApTnSLz9/rU448LztDtzNm9ezRy5eD61Yv30ZD5ZVDy2PFflbADeZhp63FEA4vUAlLbr4j4leJ80ptsJGqs33lcbruu4GRawnu9+peHY5tjmjSd1JObXN7O56r/51kEQX8WgS5Zuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nqL4eVSc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nqL4eVSc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVzFH32yXz3bTf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 16:04:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C9E1418C1;
	Wed, 11 Mar 2026 05:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB3FC4CEF7;
	Wed, 11 Mar 2026 05:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773205473;
	bh=fYyP3Zu9FaIM29drE15IUXdeAZe+0BRP7elc4vr6eGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqL4eVSceLQkWZy2agF52UXOujfj7w7KrEuOhM4cOGhKUUw59uYN9x/5NytgiLzOR
	 xyWmn0w8TWKhJQe9w/xoJxPfAi391pPUereu4K3uFM6v04Vy0yAg19kdVdcsk+Uybf
	 M2Rb7gOuGWtqzdzH2HbGgZU1OqH3JIw2AyDnYgJBndJ7Du6iRkyELJwQFdExIOU4Ue
	 Sm1dIkfSaGoEcCsDEFhczs0iyNeXbjA2koRhzqOeqDPtcX7Yl6WJiiPLg+Cqqkp7pf
	 tKgqGLem++ya1KScueLxRfgME5XE5rfWQxjtKpmX42uZbg7S1f/VNDZtR75TxwvL13
	 hssZiohpAg36Q==
Date: Wed, 11 Mar 2026 10:34:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Lukas Wunner <lukas@wunner.de>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Brian Norris <briannorris@chromium.org>, 
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 2/4] PCI: host-common: Add link down handling for Root
 Ports
Message-ID: <vnsmjvtwaeticdxwz6u43dxnpi6duhc3r5motwnfer4l2bpqcm@noeme6lgq4jf>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <20260310-pci-port-reset-v7-2-9dd00ccc25ab@oss.qualcomm.com>
 <2eb738fb-9dfe-1e88-6ea7-afdba9cb3d25@rock-chips.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eb738fb-9dfe-1e88-6ea7-afdba9cb3d25@rock-chips.com>

On Wed, Mar 11, 2026 at 08:55:01AM +0800, Shawn Lin wrote:
> Hi Mani
> 
> 在 2026/03/10 星期二 22:02, Manivannan Sadhasivam via B4 Relay 写道:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > The PCI link, when down, needs to be recovered to bring it back. But on
> > some platforms, that cannot be done in a generic way as link recovery
> > procedure is platform specific. So add a new API
> > pci_host_handle_link_down() that could be called by the host bridge drivers
> > for a specific Root Port when the link goes down.
> > 
> > The API accepts the 'pci_dev' corresponding to the Root Port which observed
> > the link down event. If CONFIG_PCIEAER is enabled, the API calls
> > pcie_do_recovery() function with 'pci_channel_io_frozen' as the state. This
> > will result in the execution of the AER Fatal error handling code. Since
> > the link down recovery is pretty much the same as AER Fatal error handling,
> > pcie_do_recovery() helper is reused here. First, the AER error_detected()
> > callback will be triggered for the bridge and then for the downstream
> > devices. Finally, pci_host_reset_root_port() will be called for the Root
> > Port, which will reset the Root Port using 'reset_root_port' callback to
> > recover the link. Once that's done, resume message will be broadcasted to
> > the bridge and the downstream devices, indicating successful link recovery.
> > 
> > But if CONFIG_PCIEAER is not enabled in the kernel, only
> > pci_host_reset_root_port() API will be called, which will in turn call
> > pci_bus_error_reset() to just reset the Root Port as there is no way we
> > could inform the drivers about link recovery.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > Tested-by: Brian Norris <briannorris@chromium.org>
> > Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/pci/controller/pci-host-common.c | 35 ++++++++++++++++++++++++++++++++
> >   drivers/pci/controller/pci-host-common.h |  1 +
> >   drivers/pci/pci.c                        |  1 +
> >   drivers/pci/pcie/err.c                   |  1 +
> >   4 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > index d6258c1cffe5..15ebff8a542a 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -12,9 +12,11 @@
> >   #include <linux/of.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_pci.h>
> > +#include <linux/pci.h>
> >   #include <linux/pci-ecam.h>
> >   #include <linux/platform_device.h>
> > +#include "../pci.h"
> >   #include "pci-host-common.h"
> >   static void gen_pci_unmap_cfg(void *ptr)
> > @@ -106,5 +108,38 @@ void pci_host_common_remove(struct platform_device *pdev)
> >   }
> >   EXPORT_SYMBOL_GPL(pci_host_common_remove);
> > +static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +
> > +	pci_lock_rescan_remove();
> > +	ret = pci_bus_error_reset(dev);
> > +	pci_unlock_rescan_remove();
> > +	if (ret) {
> > +		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> > +
> > +	pci_info(dev, "Root Port has been reset\n");
> > +
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> > +static void pci_host_recover_root_port(struct pci_dev *port)
> > +{
> > +#if IS_ENABLED(CONFIG_PCIEAER)
> > +	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
> > +#else
> > +	pci_host_reset_root_port(port);
> 
> Since pci_host_reset_root_port() returns pci_ers_result_t, shouldn't we
> check the result? If the return value is intentionally ignored here,
> maybe pci_host_reset_root_port actually doesn't need a return value at
> all?
> 

The return value is mostly for pcie_do_recovery() which iterates through the
subordinate devices and calls pci_host_reset_root_port(). It also makes use of
the return value, so we cannot make it void.

The reason why I skipped the return value in pci_host_handle_link_down() is
that, we canot do much in the case of failure other than reporting the failure,
which is already taken care in pci_host_reset_root_port().

> > +#endif
> > +}
> > +
> > +void pci_host_handle_link_down(struct pci_dev *port)
> > +{
> > +	pci_info(port, "Recovering Root Port due to Link Down\n");
> > +	pci_host_recover_root_port(port);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
> 
> This function shouldn't be called like in interrupt context because of
> the pci_lock_rescan_remove() and pci_bus_error_reset()::pci_slot_mutex,
> but it's not so obvious from the API name. It's prone for host drivers
> to use it like:
> 
> register_LDn_irq -> irq isr -> pci_host_handle_link_down()
> 
> So perhaps add a comment about it would be better.
> 

Yes, I agree. I mentioned in the cover letter that this API should be called
from a threaded IRQ handler, but it should be mentioned in the API description
too. I will add it in next version or ammend it while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

