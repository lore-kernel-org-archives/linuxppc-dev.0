Return-Path: <linuxppc-dev+bounces-26574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75EFC79F82
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:25:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc9yk027zz2xpn;
	Sat, 05 Sep 2026 08:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788560733;
	cv=none; b=DVL4vrBpANV2b9GdvuzETkh4jzPITZWIH6OPQxNuTJ1NXe9IoeU/mRad13auyHhQd5h1/o985/zXKU2wqw/fshl2ujO00Dtk3PwvEnOVAtZU3iAhKx2a9Lt2AV7OwQJFCmLOZtp7RhHHivi4M6QfMKsGq2CXEfNI+ukj7sJBmDjbU5V7ixT86rdbt/ZeogiMKI5NCKtop3usIb9Q0dT4eo0nqk+jC6zkpfMUiteH8LnUTOVFNHtnbgf5+tgseZxf/ILg0weuSrx9NIEWJFVeHHbZhyuophGfXW/qoVJPRPZRZJLWrShkqrJXinbuFlJaXcYaNnVdN52IAoKE9+p1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788560733; c=relaxed/relaxed;
	bh=nNOtf2TzRxsLyFHPcWQa1TjnFgr337may2J1744aXQs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1E/q7sozQmAyAe16QDZGEDTBWRffsHjd3euqkWeYoUYomOTBku6Tyfo87Wmlan/7p/zNOET0uZZmkrfDuEfyOxBTr55TMuy5lgbCetpJEyP/nhYlgRn4H/QGotYzhCVpwkUcWW1c9DOwo3RNxeCjRktvx5OiVwvYUrHb/Pm3dMrJAShWlXuk9lINgfClRP3ZQWHcdfART31DEkuSHNP04jsevs5UZGMVUZ0OhtwyApRsyppuDMuM+mjtwDINfOicwUSUC5Sx4wIyr9+hSgTs3lCvWxcQkxnpjhIcaCyHZ5CLreJvBO6UTCUEuM2yIzvY0EH68ZbpEHVs61X1CN2Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7uq9pUX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7uq9pUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc9yh4XKGz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 08:25:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6DF0B60229;
	Fri,  4 Sep 2026 22:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DF91F00A3D;
	Fri,  4 Sep 2026 22:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560729;
	bh=nNOtf2TzRxsLyFHPcWQa1TjnFgr337may2J1744aXQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7uq9pUX0v5IDlI+2oVNdVSZ5YmNUUqzE6Hp9xgYoZZ3WXF0DmymGxhv5d2VS+Trv
	 sdN3Q5RcSE80qNAVxD5bPUvX8vvxjMVrySggfBAciRnlMMdlBs9xrH3DvlkhnhEPtx
	 Sl2XPn70QVsE0UnHhxJfDx7tafDN883vIQ45BwPtJgvPsUUY/u4PeVGHQjbalebRWn
	 rbT0qj1/2UToSVnCf0q/P+3JO1rhI4NCWaJUF9sA3bfOqSsGc1dl/2oE/HYTDySoPY
	 9nS5ysZllX0M/VnI4pUHMES2p2QiAPfAii8QK07b/3fEVkO/KDrdOvHe0+u9CChgRt
	 11DvYkhjmcVgA==
Subject: Re: [PATCH v3 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:27 +0000
Message-ID: <178856072792.219967.11680386922247714173@kernel.org>
In-Reply-To: <20260831082335.1184605-4-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-4-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] Using device_lock() in an exported API to protect against driver
  unbind is an architectural anti-pattern that creates a circular lock…
- [Medium] The newly exported netc_timer_get_current_time() gates the
  TMR_CUR_TIME MMIO read only on 'a netc_timer driver is bound' and…
- [Low] Inconsistent / semantically wrong errno contract for the new
  exported API netc_timer_get_current_time().

--

ptp: netc: export netc_timer_get_current_time() for cross-driver use

This adds netc_timer_get_current_time() to the NETC Timer driver and
exports it so the NETC Switch driver, which is a separate PCIe function
with its own driver, can read TMR_CUR_TIME. The helper takes the device
lock to serialize against unbind and the per-device spinlock around the
register read, and spin_lock_init() moves earlier so the lock is
initialized before pci_set_drvdata().

> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index aa9be8e2a6304..854a206b6c5bc 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c

[ ... ]

> @@ -1021,5 +1021,55 @@ static struct pci_driver netc_timer_driver = {
>  };
>  module_pci_driver(netc_timer_driver);
>  
> +/**
> + * netc_timer_get_current_time - read the current PTP time from the NETC Timer
> + * @pdev: PCI device of the NETC Timer
> + * @ns: The current PTP clock time in nanoseconds, returned to the caller
> + *
> + * Reads the 64-bit current time register (TMR_CUR_TIME) from the NETC Timer
> + * device associated with @pdev. Returns an error if the Timer driver has not
> + * yet probed or has already been removed.
> + *
> + * Context: Process context only. Acquires the device mutex via device_lock(),
> + *          which may sleep. Must not be called from atomic context, softirq,
> + *          BH, or while holding a spinlock.
> + *
> + * Return: 0 on success, otherwise a negative error code.
> + */
> +int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	/* Serialize against driver unbind: the remove() callback runs under
> +	 * the device lock, so holding it here ensures that priv remains valid
> +	 * for the entire duration of the register read.
> +	 */
> +	device_lock(dev);
> +
> +	if (pci_dev_driver(pdev) != &netc_timer_driver) {
> +		err = -EINVAL;
> +		goto unlock_device;
> +	}
> +
> +	priv = pci_get_drvdata(pdev);
> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto unlock_device;
> +	}

[Severity: High]
Taking the supplier's device lock from an exported cross-driver
helper worries me, both for the lock ordering it creates and for the
contexts it rules out.

On the ordering side, consider the consumer added later in this
series. netc_switch_remove() runs with the switch device's dev->mutex
held by the driver core; it calls dsa_unregister_switch(), which takes
rtnl_lock(), and netc_port_disable(), which takes
&onestep->work_lock. That gives dev->mutex -> rtnl_lock ->
work_lock. In the datapath, netc_onestep_work() holds
&onestep->work_lock and then calls netc_timer_get_current_time(),
which takes the timer's dev->mutex here. Since lockdep tracks the
dev->mutex of devices initialized through device_initialize() as one
lock class, that second chain is work_lock -> dev->mutex and closes
the cycle. A splat there disables lock debugging for the rest of the
boot, so it is not something we can leave to be discovered by
whoever unbinds the switch while Sync frames are in flight.

On the context side, the kernel-doc you added already spells out the
consequence: process context only, may sleep, no softirq, no BH, no
spinlock held. That is a fairly severe restriction for what is
fundamentally a single 64-bit register read on a timestamping path,
and it is imposed purely by the unbind protection rather than by the
hardware access itself.

The usual way to express "this consumer needs that supplier to stay
bound" is a device link. If the switch driver called
device_link_add() against the Timer's pci_dev at probe time, the
Timer could not be unbound underneath a live consumer, and
netc_timer_get_current_time() could drop device_lock() entirely and
keep only the spin_lock_irqsave(&priv->lock) around
netc_timer_cur_time_read(), making it callable from atomic context
too.

Is there a reason a device link would not work for the
Timer/Switch pair here (for example probe ordering between the two
PCIe functions)? If so, could you describe what else guarantees the
lock ordering above is safe?

[Severity: Low]
This isn't a bug, but the errno contract of the new exported interface
looks inconsistent.

The same logical state, "the NETC Timer is not available", is reported
three different ways:

  - netc_timer_get_current_time() returns -EINVAL when no netc_timer
    driver is bound
  - netc_timer_get_current_time() returns -ENOMEM when
    pci_get_drvdata() is NULL
  - the !IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER) stub in
    include/linux/fsl/netc_global.h returns -ENODEV

The -ENOMEM in particular does not match what happened, since this
function performs no allocation at all, and the kernel-doc above
describes the only failure condition as "the Timer driver has not yet
probed or has already been removed".

Would -ENODEV for both in-function checks, matching the header stub,
make the interface easier for callers to test?

> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*ns = netc_timer_cur_time_read(priv);
> +	spin_unlock_irqrestore(&priv->lock, flags);

[Severity: Medium]
Can this read return a fabricated time and still report success while
the Timer function is suspended?

The two checks above only establish that a netc_timer driver is bound
and that drvdata is non-NULL. Neither implies that the Timer PCI
function still decodes memory, that it is in D0, or that TMR_CTRL[TE]
is still set.

netc_timer_driver registers no PM callbacks:

drivers/ptp/ptp_netc.c:
    static struct pci_driver netc_timer_driver = {
        .name = KBUILD_MODNAME,
        .id_table = netc_timer_id_table,
        .probe = netc_timer_probe,
        .remove = netc_timer_remove,
    };

so during system suspend the PCI core takes the no-dev_pm_ops path:

pci_pm_suspend()
  pci_pm_default_suspend()
    pci_disable_enabled_device()   /* clears PCI_COMMAND_MEMORY */
  -> D3hot

The driver is not unbound in that window, so pci_dev_driver(pdev) ==
&netc_timer_driver and pci_get_drvdata(pdev) != NULL both still pass,
ioread64_lo_hi() reads all-ones, and the function returns 0. The
cross-driver consumer added later in this series treats a 0 return as a
valid time:

drivers/net/dsa/netc/netc_ptp.c:netc_onestep_work() {
    ...
    if (unlikely(netc_get_phc_time(priv, &tstamp))) {
    ...
}

and programs the value into a transmitted one-step Sync frame and into
PM_SINGLE_STEP.

Does the same apply after resume? Nothing re-runs netc_timer_init(), so
TMR_CTRL (CK_SEL/TE/TCLK_PERIOD/COMP_MODE), TMR_PRSC, TMR_ADD and
TMR_CNT are never reprogrammed after the D3hot->D0 transition, while
the exported reader keeps reporting success. The driver's own comment
documents these as preconditions:

drivers/ptp/ptp_netc.c:netc_timer_init() {
	/* Software must enable timer first and the clock selected must be
	 * active, otherwise, the registers which are in the timer clock
	 * domain are not accessible.
	 */
	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
		   TMR_CTRL_TE | TMR_CTRL_FS;
    ...
}

The lack of suspend/resume support in ptp_netc predates this patch, but
this patch turns that unchecked power and enable state into a
cross-driver contract. Would it make sense for the exported helper to
also check pci_dev->current_state == PCI_D0 (or TMR_CTRL[TE], or take a
PM reference), or for the driver to gain suspend/resume handlers that
re-run netc_timer_init()?

> +
> +unlock_device:
> +	device_unlock(dev);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
> +
>  MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index 5b8ff528d3699..d4a26c17f99a4 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h

[ ... ]

> @@ -22,4 +23,13 @@ static inline u64 netc_read64(void __iomem *reg)
>  	return ioread64(reg);
>  }
>  
> +#if IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER)
> +int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns);
> +#else
> +static inline int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com

