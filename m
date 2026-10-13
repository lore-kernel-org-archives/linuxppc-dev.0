Return-Path: <linuxppc-dev+bounces-29352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0614CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:57:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3rsK5RVPz3brV;
	Tue, 13 Oct 2026 21:57:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791889077;
	cv=none; b=QpD1mZkxgjLtK0Eygd4whFcuiKQpkrMUn8PThzqKJvBcyJwsldBc9c5atjRxTqoCzPmsbMhqO7bO8kX/TjuR7Lua0wRwnNP4e6bQ5gcG9iFnc+GoVyF3sxlk315gEO4vM/0wgu6k6G2wbu/C7EEx7nVOEX50oh9XZpkengLnJc45DsHud9EwWiqOCxH0x0Rpcbqnn1N2dXtN2x1TjLYb7HnPFRasleKzbHxevmC6h0YhRIfYPEQFRfArGqafwvpnblyjOZNB6A84vG6d7qMicf/yy0rzLhQZsX8RJ8A0ZlhJnuG7dHXgM4UvSQIziehoyl3L/AMUkeruXrW7zkNevg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791889077; c=relaxed/relaxed;
	bh=oXLSiEF0IbD5c5Y/dirPwQYZ27Ijc9UIrfKVhG9lics=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ll0quXv0wXbVNI+VT1vMNNtSwh9jHHjvtAU2nlZyrNevTviayUe+11tbuuAjN+8AztpjiGMtuHBG+p9or2fcMRNCZnUTGTnHSHfj/fV+9YIWuU4HqTyKp0eMcwPR2YwzmybRivgQ2pHXtCUB7FMIU1kGR7ZIjmWmFth1r8fTsbgxZLcz/sKBhaKCQPDGoRRoNt60bw3v9/XO8ozfCqXs6iBlhqzG63yKvNimDFZ5dxil6/UZsUkzL1id3gj6ZpCdEtUqUL0+kaFZOghOhXeIsnwoZ+eI3K3ROxYxoVSHOyptNS2N/CjZlXl4gr5VzNyheCGWiBUkTvgVfI/2rmBTlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDM2u2u6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDM2u2u6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3rsJ1Mgjz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:57:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CD52600D1;
	Tue, 13 Oct 2026 10:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B881F00898;
	Tue, 13 Oct 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889072;
	bh=oXLSiEF0IbD5c5Y/dirPwQYZ27Ijc9UIrfKVhG9lics=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NDM2u2u68Vrs4dIlY6eEnOWD5LQ43rY0JHUxZsTwFnxNcLaYqhfFN5XHx9Ki8LxJQ
	 kFcXgTqwrZdtv1hjYXOGJZM6XNVwIKjDnQzIDrhdJ5R/lO+kxtJCMMjDqeSxnB3Kbc
	 DuhCSi/YbU/GQfuzuMUdHTLV+7WZ3/dSfkrNTAGp7LFOGPnWsLnYQPYoq/sotFQwe/
	 Q8oDsf5OCnbq4a1Je9L4cfBHRGIr8VoVT8147YrN71qmVijXTXH7YZoEXJCyed8ZEN
	 wlGwfxN6DrpXOwgEZ4D8QsZI+f9+4AQYIHQwFeQlTn5BC0kcNi+o6rZhMRE6GRDUBG
	 JlxgxcT5enpGQ==
Subject: Re: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Oct 2026 10:57:51 +0000
Message-ID: <179188907149.434549.9657555602480791517@kernel.org>
In-Reply-To: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netc_setup() now calls pci_reset_function(A->pdev) whenever
  A->in_probe is false.
- [Medium] priv->in_probe is a plain bool.
- [Medium] Moving the initial reset from before pcim_enable_device() into
  netc_setup() means pci_set_master() (netc_switch_pci_init(), line…

--

net: dsa: netc: tie setup resources and reset to DSA setup/teardown

This patch replaces the one-time pcie_flr() in probe with a
netc_switch_reset() call at the start of netc_setup(). The reset uses
pci_reset_function_locked() during probe and pci_reset_function()
otherwise. It also converts the devm_ allocations on the setup path to
explicit alloc/free, so their lifetime matches DSA setup and teardown.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 77077352c1a57..c639ae67c9b71 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> +static int netc_switch_reset(struct netc_switch *priv)
> +{
> +	if (priv->in_probe)
> +		return pci_reset_function_locked(priv->pdev);
> +
> +	return pci_reset_function(priv->pdev);
>  }

[Severity: High]
Can the pci_reset_function() branch deadlock against unbind in the
multi-switch case this patch is preparing for?

In a multi-switch tree, ds->ops->setup() runs under dsa2_mutex for every
switch in the tree, including switches that are already bound:

dsa_register_switch(B)
  mutex_lock(&dsa2_mutex)
  dsa_switch_probe()
    dsa_tree_setup()
      ...
        netc_setup(A)
          netc_switch_reset(A)
            pci_reset_function(A->pdev)
              pci_dev_lock(A->pdev)    /* device_lock(A) */

The remove path takes the same two locks in the opposite order, because
the driver core already holds device_lock(A) when it calls the driver:

device_release_driver(A)           /* holds device_lock(A) */
  netc_switch_remove()
    dsa_unregister_switch()
      mutex_lock(&dsa2_mutex)

Shutdown has the same ordering through
netc_switch_shutdown()->dsa_switch_shutdown().

If CPU0 is probing switch B while CPU1 is unbinding switch A, would both
threads hang forever? Re-probing A while B is being unbound looks like
the same inversion with the roles swapped.

device->mutex uses lockdep_set_novalidate_class(), so lockdep would not
report this.

This code is still the same at the end of the series. Should this
branch use a different approach, rather than resetting another switch
under its device lock from inside .setup while dsa2_mutex is held?

>  static int netc_setup(struct dsa_switch *ds)
> @@ -875,6 +957,10 @@ static int netc_setup(struct dsa_switch *ds)
>  	struct dsa_port *dp;
>  	int err;
>  
> +	err = netc_switch_reset(priv);
> +	if (err)
> +		return err;
> +
>  	err = netc_init_switch_id(priv);
>  	if (err)
>  		return err;

[ ... ]

> @@ -1045,7 +1136,6 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
>  	void __iomem *base;
>  	int err;
>  
> -	pcie_flr(pdev);
>  	err = pcim_enable_device(pdev);
>  	if (err)
>  		return dev_err_probe(dev, err, "Failed to enable device\n");

[Severity: Medium]
Now that pcie_flr() is gone from here, netc_switch_pci_init() calls
pci_set_master() before the switch has been reset. The first reset now
comes much later. It happens after netc_switch_get_ip_revision() and
netc_switch_platform_probe(), once dsa_register_switch() reaches
netc_setup().

Is that ordering safe after a kexec? pci_device_shutdown() only clears
bus mastering:

	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
		pci_clear_master(pci_dev);

netc_switch_shutdown()->dsa_switch_shutdown() does not call
netc_teardown() or ntmp_free_cbdr(). Also, netc_xmit_ntmp_cmd() can
return on a read_poll_timeout() expiry after it has already advanced the
producer index.

The switch could then keep enabled command BD rings with a pending
command that points at the previous kernel's DMA addresses. If the
hardware resumes fetching as soon as bus mastering is set again, could
it access memory the new kernel has reused? With an IOMMU, would it
cause faults instead?

Also, if probe fails between pci_set_master() and netc_setup(), for
example in netc_switch_platform_probe() or dsa_register_switch(), the
device is never reset before devres disables it.

Would it work to keep a probe-time reset in netc_switch_pci_init()
before pci_set_master()?

[ ... ]

> @@ -2475,12 +2565,15 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->ageing_time_max = U32_MAX;
>  	ds->priv = priv;
>  	priv->ds = ds;
> +	priv->in_probe = true;
>  
>  	err = dsa_register_switch(ds);
>  	if (err)
>  		return dev_err_probe(dev, err,
>  				     "Failed to register DSA switch\n");
>  
> +	priv->in_probe = false;
> +
>  	return 0;
>  }

[Severity: Medium]
netc_switch_reset() reads priv->in_probe to decide whether the current
thread holds A's device lock. The flag only records that A's probe is in
progress somewhere, not that the current thread owns the lock.

dsa_register_switch() drops dsa2_mutex before it returns, and it returns
0 when the tree is still incomplete. Consider this sequence:

CPU0 (probe of A)
  priv->in_probe = true;
  dsa_register_switch(A)
    mutex_unlock(&dsa2_mutex);
  <window>
  priv->in_probe = false;

CPU1 (probe of B, async probe or deferred probe)
  dsa_register_switch(B)
    dsa_tree_setup()
      netc_setup(A)
        netc_switch_reset(A)    /* sees in_probe == true */
          pci_reset_function_locked(A->pdev)

In this case pci_reset_function_locked() runs on B's thread, which does
not hold A's device lock. Wouldn't device_lock_assert() fire under
lockdep?

The FLR includes msleep(100) and a readiness poll. Could it still be
running after A's probe returns and the driver core releases
device_lock(A)? If so, it would not be serialized against other
device-locked operations such as a sysfs reset.

The cross-CPU write and read of in_probe is also unsynchronized.

This code is still the same at the end of the series. Could the caller
context decide whether the lock is held, for example through a parameter
or by doing the probe-time reset directly in probe, instead of a shared
per-device flag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095924.1129312-1-wei.fang%40oss.nxp.com

