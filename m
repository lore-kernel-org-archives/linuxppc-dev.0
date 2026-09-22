Return-Path: <linuxppc-dev+bounces-27904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7495EC982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:26:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptTh4ckHz2ygK;
	Tue, 22 Sep 2026 18:26:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790065560;
	cv=none; b=MiWE2kyTAtF6X3OUhvpFvljKmDX5e+4n1qs2fxhR5m4ppKQmN7su8XDeSE8/lGZsQ4ozk28Z4WahvyG9AzRRWmr6mR1HoULe817bBrNbqzrjrjgnM+xrhDx2XCetL048WsE5m5EukCahCAqBEkEB3Kx3RbEwA6brSGDZ33rQ0moMlsG6+nqOcmCIX9BBx4d1hvcLWJMdNtssqa5jOOloQxNBfvASP2QFJKgBIPq/Zy7wrXF4PVJCbLSkwe9CHw2Desgo9+8sYXhEejxE1DrYn8CxonA8GfDRpvQ0oaj0caeeXhLuvFAmrEzYBzA1R8KimPz6PjDdj9lhUNCQMBu54g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790065560; c=relaxed/relaxed;
	bh=2X1OCcip9WdRidK88ayPzdYka+btvJ/3z+Cw7Fhbf18=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAFmbARliyz6hRnKuM6XN25I7+3KC4rkjT7XcbC1nzaJgxrhDkB3dsDp9koZ3WLj7A5WoCTTdZKwc8pT3CufoezYMgZ0RWF3qS1Oz23Bz0Mr4mAq8L2DVNpgahEoD5Ue3D3iMptjVNqH6hFwQa1PuIj1nxv7tdhStCaHICO6CK8aeH36ia0f9w0Cqkv2cRDAJhG+uEJU38oAc5dz18003ZUfILvWa3Lw9/fAropZ2QUC73fP4NXbGDoTVsiHTx6bVrU+e//bVVw3X681IOUxliS6oyefyogztfjMlDJOMz/ZeseR3Kxl0cCFV4H8j+ihqyu5KW+FuI/Jx7WdUietIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ibi/Fk9W; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ibi/Fk9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptTg0rRrz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:25:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37FEB41526;
	Tue, 22 Sep 2026 08:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291641F000FF;
	Tue, 22 Sep 2026 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065556;
	bh=2X1OCcip9WdRidK88ayPzdYka+btvJ/3z+Cw7Fhbf18=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ibi/Fk9W0CqbMvTkKEtatnrtBLseWmGefLP53I3Ejo4mg2mGDL0gokqO+sGacaYvB
	 6aGSVfnVYGxajwp9QIriZ0v04JrczoAaUBU8ry+YlFjyQlIa7mMydU8EeoEGpz0a0X
	 gKh3PYysPYERP7+wRqeTK4X76nCWuIaNaEfjf2U7Pz+4E+sCZ5YM1V/JFWYlTKehSU
	 31j9r9OL1qVq2PBMaKcDfADSlBlMpwHZu03k8TnSb1Ahhkgb0nmdbMr0C1v37RUB8e
	 2evBLmSfWKu85Bvs33SPNXNvWqJKuo+McNvY1D9DxDcqJB3TMb9XLftLZ6Bj3htfMQ
	 jrIgteyJHt11Q==
Subject: Re: [PATCH v4 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Sep 2026 08:25:54 +0000
Message-ID: <179006555469.2160803.8873313402765313889@kernel.org>
In-Reply-To: <20260918072852.501420-4-wei.fang@oss.nxp.com>
References: <20260918072852.501420-4-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netc_timer_get_current_time()
  (drivers/ptp/ptp_netc.c:1050-1082) takes the module-global…
- [Medium] netc_timer_get_current_time() treats membership in
  netc_timer_list as proof that TMR_CUR_TIME can be read, and returns 0…
- [Low] Concern that the exported netc_timer_get_current_time() and its
  list/lock infrastructure have no in-tree consumer.
- [Low] Concern that netc_timer_get_current_time() keys its lookup on an
  unreferenced caller-supplied 'struct pci_dev *' (tmp->pdev == pdev at…
- [Low] include/linux/fsl/netc_global.h — a header that otherwise
  contains only trivial MMIO accessor inlines…

--

ptp: netc: export netc_timer_get_current_time() for cross-driver use

This adds netc_timer_get_current_time() to the NETC Timer driver and exports
it so the NETC Switch driver, which is a separate PCIe function with its own
driver, can read TMR_CUR_TIME. Each probed Timer is tracked in a
module-private list keyed by its pci_dev, and one global spinlock covers both
the list lookup and the register read so that an unbind cannot free priv
under an in-flight read.

A few questions about the new helper and the header change below.

> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index aa9be8e2a630..1211aa9a37d3 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c

[ ... ]

> @@ -123,8 +123,12 @@ struct netc_timer {
>  	u8 fs_alarm_num;
>  	u8 fs_alarm_bitmap;
>  	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
> +	struct list_head node;
>  };
>  
> +static LIST_HEAD(netc_timer_list);
> +static DEFINE_SPINLOCK(netc_timer_list_lock);
> +
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
>  #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
>  
> @@ -985,6 +989,10 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  
>  	enable_irq(priv->irq);
>  
> +	spin_lock_bh(&netc_timer_list_lock);
> +	list_add(&priv->node, &netc_timer_list);
> +	spin_unlock_bh(&netc_timer_list_lock);
> +
>  	return 0;
>  
>  free_msix_irq:
> @@ -999,6 +1007,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
>  {
>  	struct netc_timer *priv = pci_get_drvdata(pdev);
>  
> +	spin_lock_bh(&netc_timer_list_lock);
> +	list_del(&priv->node);
> +	spin_unlock_bh(&netc_timer_list_lock);
> +
>  	disable_irq(priv->irq);
>  	ptp_clock_unregister(priv->clock);
>  	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);

[ ... ]

> @@ -1021,5 +1033,54 @@ static struct pci_driver netc_timer_driver = {
>  };
>  module_pci_driver(netc_timer_driver);
>  
> +/**
> + * netc_timer_get_current_time - read the current PTP time from the NETC Timer
> + * @pdev: PCI device of the NETC Timer
> + * @ns: Output, the current PTP clock time in nanoseconds
> + *
> + * Read TMR_CUR_TIME from the NETC Timer bound to @pdev. The lookup and read
> + * run under netc_timer_list_lock, so the Timer cannot be unbound and its priv
> + * freed during the read.
> + *
> + * Context: Process or softirq context. Must not be called from hardirq.
> + *
> + * Return: 0 on success, -ENODEV if the Timer is not present (not yet probed
> + *         or already removed).
> + */
> +int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
> +{
> +	struct netc_timer *priv = NULL;
> +	struct netc_timer *tmp;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	/* Serialize against driver unbind, so holding it here ensures that
> +	 * priv remains valid for the entire duration of the register read.
> +	 */
> +	spin_lock_bh(&netc_timer_list_lock);

[Severity: Medium]
Is it necessary to hold the module-global netc_timer_list_lock across the
MMIO access, rather than only across the lookup?

priv->lock is taken from hardirq context with a plain spin_lock() in
netc_timer_isr(), and that handler can spin in the register drain loop in
netc_timer_handle_etts_event():

drivers/ptp/ptp_netc.c:netc_timer_handle_etts_event() {
	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
}

So while CPU A sits in netc_timer_get_current_time() waiting on
spin_lock_irqsave(&priv->lock) with softirqs disabled and the global list lock
held, CPU B can be inside netc_timer_isr() holding priv->lock for a period
bounded only by hardware. During that window every other Timer's probe(),
remove() and every other time query is serialized behind
netc_timer_list_lock. The same applies if the target function is unreachable
and the non-posted read stalls until the PCIe completion timeout.

Would an RCU-protected lookup (with the priv free deferred in remove()), or
taking a reference on the Timer, give the same lifetime guarantee without
holding a global lock across the register access?

Related to that: the BH-only requirement makes the exported symbol illegal
from hardirq or with interrupts disabled, but that constraint appears only in
the kerneldoc and is not visible at the prototype in
include/linux/fsl/netc_global.h, and nothing but an eventual WARN from
__local_bh_enable_ip() catches a violation. Is there a reason not to drop the
context restriction by using a lookup scheme that does not disable BH?

> +
> +	list_for_each_entry(tmp, &netc_timer_list, node) {
> +		if (tmp->pdev == pdev) {
> +			priv = tmp;
> +			break;
> +		}
> +	}

[Severity: Low]
This isn't a bug, but the lookup is a bare pointer comparison on a
caller-supplied struct pci_dev *, so its soundness depends on the caller
holding a reference on @pdev. The in-tree consumer does hold one
(netc_get_ptp_timer() obtains it with pci_get_domain_bus_and_slot() and
drops it with pci_dev_put()), so nothing is broken today.

Could the kerneldoc and the exported prototype state that the caller must
hold a reference on @pdev? Without it, a future caller that caches a raw
pci_dev pointer has no hint that a freed and recycled pointer could match a
different Timer's entry.

> +
> +	if (!priv) {
> +		err = -ENODEV;
> +		goto netc_timer_list_unlock;
> +	}
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	*ns = netc_timer_cur_time_read(priv);
> +	spin_unlock_irqrestore(&priv->lock, flags);

[Severity: Medium]
Can this return 0 together with a meaningless timestamp when the Timer
function is not accessible?

List membership only proves the pci_dev is bound to this driver: the entry is
added at the end of netc_timer_probe() and removed only in
netc_timer_remove(). netc_timer_driver registers no PM callbacks, so system
suspend takes the PCI core default path and the function is disabled and put
into D3 while the list entry stays live, and nothing re-programs
TMR_CTRL[TE], CK_SEL, TMR_ADD or TMR_CNT on resume. The driver already
documents the constraint in netc_timer_init():

drivers/ptp/ptp_netc.c:netc_timer_init() {
	/* Software must enable timer first and the clock selected must be
	 * active, otherwise, the registers which are in the timer clock
	 * domain are not accessible.
	 */
}

The same holds for a surprise-removed function or one contained by DPC/AER,
where the read returns all-ones. In those cases the helper still reports
success, and the switch side consumes the value verbatim as the one-step Sync
originTimestamp in netc_port_onestep_work():

drivers/net/dsa/netc/netc_ptp.c:netc_port_onestep_work() {
	NETC_SKB_CB(skb)->tstamp = tstamp;
}

Would it make sense to gate the read on pdev->current_state == PCI_D0 and
!pci_channel_offline(pdev), or on TMR_CTRL[TE], and return an error instead
of a successful-looking value? The missing PM support is not introduced by
this patch, but the new export is what turns an inaccessible-device read into
a timestamp handed to another driver.

> +
> +netc_timer_list_unlock:
> +	spin_unlock_bh(&netc_timer_list_lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
> +
>  MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index 5b8ff528d369..d4a26c17f99a 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/io.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/pci.h>

[Severity: Low]
This isn't a bug, but is the full <linux/pci.h> needed here? The prototype
and the stub only name struct pci_dev *, so a forward declaration of
struct pci_dev plus <linux/errno.h> for -ENODEV would be enough.

netc_global.h otherwise holds only the netc_read()/netc_write()/netc_read64()
inlines, and it is included by drivers/net/dsa/netc/netc_switch.h,
drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c,
drivers/net/ethernet/freescale/enetc/ntmp.c and drivers/ptp/ptp_netc.c, so
all four now pull in the PCI API.

Would a separate header such as include/linux/fsl/netc_timer.h be a better
home for an inter-driver service API than the register accessor header?

>  
>  static inline u32 netc_read(void __iomem *reg)
>  {
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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918072852.501420-1-wei.fang%40oss.nxp.com

