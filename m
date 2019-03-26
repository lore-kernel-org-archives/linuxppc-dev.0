Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61724C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:02:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7661A20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+33IALq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TL9537lPzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:02:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+33IALq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TL7H2x0HzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 06:00:42 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D29A220823;
 Tue, 26 Mar 2019 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553626840;
 bh=wD0qcM2zjpCg+HzkOtXBH/1ZYsacIxOzvgiHalvukMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P+33IALqnRL3vKHa4U7M0WPk2c4dSIzJp3mxvQOXUX3vqPoklBw/47DQjDwxXKmD0
 DvAaRl44E3/NnpPc4e9erTlb50uuHrU5BMXwgdkEkC2kbi2VvI3DDwA5Tdg9y0ZIPx
 0XkRPl8H/ApfeDXfUiLV7dM/tjZeVjyJ9c8pv/M8=
Date: Tue, 26 Mar 2019 14:00:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 02/21] PCI: Fix race condition in
 pci_enable/disable_device()
Message-ID: <20190326190038.GL24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-3-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-3-s.miroshnichenko@yadro.com>
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
Cc: Marta Rybczynska <mrybczyn@kalray.eu>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@yadro.com,
 Srinath Mannam <srinath.mannam@broadcom.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Srinath, Marta, LKML]

On Mon, Mar 11, 2019 at 04:31:03PM +0300, Sergey Miroshnichenko wrote:
>  CPU0                                      CPU1
> 
>  pci_enable_device_mem()                   pci_enable_device_mem()
>    pci_enable_bridge()                       pci_enable_bridge()
>      pci_is_enabled()
>        return false;
>      atomic_inc_return(enable_cnt)
>      Start actual enabling the bridge
>      ...                                       pci_is_enabled()
>      ...                                         return true;
>      ...                                   Start memory requests <-- FAIL
>      ...
>      Set the PCI_COMMAND_MEMORY bit <-- Must wait for this
> 
> This patch protects the pci_enable/disable_device() and pci_enable_bridge()
> with mutexes.

This is a subtle issue that we've tried to fix before, but we've never
had a satisfactory solution, so I hope you've figured out the right
fix.

I'll include some links to previous discussion.  This patch is very
similar to [2], which we didn't actually apply.  We did apply the
patch from [3] as 40f11adc7cd9 ("PCI: Avoid race while enabling
upstream bridges"), but it caused the regressions reported in [4,5],
so we reverted it with 0f50a49e3008 ("Revert "PCI: Avoid race while
enabling upstream bridges"").

I think the underlying design problem is that we have a driver for
device B calling pci_enable_device(), and it is changing the state of
device A (an upstream bridge).  The model generally is that a driver
should only touch the device it is bound to.

It's tricky to get the locking right when several children of device A
all need to operate on A.

That's all to say I'll have to think carefully about this particular
patch, so I'll go on to the others and come back to this one.

Bjorn

[1] https://lore.kernel.org/linux-pci/1494256190-28993-1-git-send-email-srinath.mannam@broadcom.com/T/#u
    [RFC PATCH] pci: Concurrency issue in NVMe Init through PCIe switch

[2] https://lore.kernel.org/linux-pci/1496135297-19680-1-git-send-email-srinath.mannam@broadcom.com/T/#u
    [RFC PATCH v2] pci: Concurrency issue in NVMe Init through PCIe switch

[3] https://lore.kernel.org/linux-pci/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com/T/#u
    [RFC PATCH v3] pci: Concurrency issue during pci enable bridge

[4] https://lore.kernel.org/linux-pci/150547971091.977464.16294045866179907260.stgit@buzz/T/#u
    [PATCH bisected regression in 4.14] PCI: fix race while enabling upstream bridges concurrently

[5] https://lore.kernel.org/linux-wireless/04c9b578-693c-1dc6-9f0f-904580231b21@kernel.dk/T/#u
    iwlwifi firmware load broken in current -git

[6] https://lore.kernel.org/linux-pci/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu/T/#u
    [RFC PATCH] nvme: avoid race-conditions when enabling devices

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c   | 26 ++++++++++++++++++++++----
>  drivers/pci/probe.c |  1 +
>  include/linux/pci.h |  1 +
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f006068be209..895201d4c9e6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1615,6 +1615,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  	struct pci_dev *bridge;
>  	int retval;
>  
> +	mutex_lock(&dev->enable_mutex);
> +
>  	bridge = pci_upstream_bridge(dev);
>  	if (bridge)
>  		pci_enable_bridge(bridge);
> @@ -1622,6 +1624,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  	if (pci_is_enabled(dev)) {
>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
> +		mutex_unlock(&dev->enable_mutex);
>  		return;
>  	}
>  
> @@ -1630,11 +1633,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  		pci_err(dev, "Error enabling bridge (%d), continuing\n",
>  			retval);
>  	pci_set_master(dev);
> +	mutex_unlock(&dev->enable_mutex);
>  }
>  
>  static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>  {
>  	struct pci_dev *bridge;
> +	/* Enable-locking of bridges is performed within the pci_enable_bridge() */
> +	bool need_lock = !dev->subordinate;
>  	int err;
>  	int i, bars = 0;
>  
> @@ -1650,8 +1656,13 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>  		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>  	}
>  
> -	if (atomic_inc_return(&dev->enable_cnt) > 1)
> +	if (need_lock)
> +		mutex_lock(&dev->enable_mutex);
> +	if (pci_is_enabled(dev)) {
> +		if (need_lock)
> +			mutex_unlock(&dev->enable_mutex);
>  		return 0;		/* already enabled */
> +	}
>  
>  	bridge = pci_upstream_bridge(dev);
>  	if (bridge)
> @@ -1666,8 +1677,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>  			bars |= (1 << i);
>  
>  	err = do_pci_enable_device(dev, bars);
> -	if (err < 0)
> -		atomic_dec(&dev->enable_cnt);
> +	if (err >= 0)
> +		atomic_inc(&dev->enable_cnt);
> +	if (need_lock)
> +		mutex_unlock(&dev->enable_mutex);
>  	return err;
>  }
>  
> @@ -1910,15 +1923,20 @@ void pci_disable_device(struct pci_dev *dev)
>  	if (dr)
>  		dr->enabled = 0;
>  
> +	mutex_lock(&dev->enable_mutex);
>  	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
>  		      "disabling already-disabled device");
>  
> -	if (atomic_dec_return(&dev->enable_cnt) != 0)
> +	if (atomic_dec_return(&dev->enable_cnt) != 0) {
> +		mutex_unlock(&dev->enable_mutex);
>  		return;
> +	}
>  
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> +
> +	mutex_unlock(&dev->enable_mutex);
>  }
>  EXPORT_SYMBOL(pci_disable_device);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2ec0df04e0dc..977a127ce791 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2267,6 +2267,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> +	mutex_init(&dev->enable_mutex);
>  
>  	return dev;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..cb2760a31fe2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -419,6 +419,7 @@ struct pci_dev {
>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
> +	struct mutex	enable_mutex;
>  
>  	u32		saved_config_space[16]; /* Config space saved at suspend time */
>  	struct hlist_head saved_cap_space;
> -- 
> 2.20.1
> 
