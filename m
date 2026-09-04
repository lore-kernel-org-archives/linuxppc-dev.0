Return-Path: <linuxppc-dev+bounces-26575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4EC624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:25:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc9yk1G7Mz2xy3;
	Sat, 05 Sep 2026 08:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788560734;
	cv=none; b=RCD3VcFbKigoZYYAv9p4KCEGoXBsbKe2o4rRMTA3/oTJ+reqq+QFjY+coJuyr2zfw2rR9eoaEzsFcJpC83tM6PUMZPJxgNMhtmaxlU+XjyApyiaiVgHMdr1j9QD2QwV6HPETDNukBHHfxI/i7R6/RF8f1sttPz55J19daYfgDyzJwK1t0f8LpVqB7NgHusr9BGhq9GU6vOtWuJ21vdwq/0VBas5ERCCbODLFAq+pLKEz2B32XzVDb6E20UGYGEh+y8Z1P5cib2IWKca6/2ej5lqS7G2IL/gdJcZMMnRS/51x8HiFbLcsvO1tyKW15pdyzI/xTQz0RHbof6kPanGhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788560734; c=relaxed/relaxed;
	bh=A3vjSlAs0WBHdXPrKIdEU45RVIMErm6MTbTPGAeH5Mg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoNP79yKX3dE1NaOEcVhKFlPYKW3RxVx+8Gh2bNBsBaqxQxhf0Xxj3YHMQpHnqT/1wwHPXE80PXArM+QDt9uLORbrJaSCzFOlf1QqjMblzE5iqb5djaURU86I8v0DfHllzvb9LcRsNXWquJu2iHKYcm85hHRUthARZCXR/pZCybKMOSlQCX6sxXVej8aQEyIpld2xECmjsCyzNz/n3vET8jDcZoFLwnrdFpfhKYC5yL5CqDZriRZ5KUqMAyFzpbmgGEh4rz8ySG8sAW0tgdUmRW+s96f3afTYnuDt/ugKPyCbVR6NKy5ushw/Hzu7VhMefke3ZIoZgLUTeBRM3tpxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsWtfwMZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsWtfwMZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc9yj089Kz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 08:25:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6D09602C5;
	Fri,  4 Sep 2026 22:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EB1F00A3E;
	Fri,  4 Sep 2026 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560730;
	bh=A3vjSlAs0WBHdXPrKIdEU45RVIMErm6MTbTPGAeH5Mg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AsWtfwMZAsOhd/EHu1R6YT6uEIPQ1zf7gnP8JMWV6E+byb2+AB3I9Ycb0TgfVgFPh
	 u4AW5djx9sTysx9quDjX0XjMXMYtx4YPkuzSUga3kHAmoilTGCrYlcFLYRrDwrKwDX
	 a4kiAAsVLFBbLL5+NkC3hFTuMJzx1PS+JXGSUml40EAMPMzMQretVQfLhB7zeMTHPz
	 l1VMgd/3Fn3hlbILorbORD49XdKDj/sDB/wLYOe5L7/jhA6O2RmL8gXGKyxnBBDX9K
	 df4PtdREgHZjYSUYHZpgxGKdxieuVjsk+Q1CEAknz42n8qxamkhJfiUHEPicc6eGiv
	 Es/F0A4OywG7Q==
Subject: Re: [PATCH v3 net-next 4/8] net: dsa: netc: use entry ID instead of
 pointer to track host flood rule
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:29 +0000
Message-ID: <178856072932.219967.8769401886867777305@kernel.org>
In-Reply-To: <20260831082335.1184605-5-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-5-wei.fang@oss.nxp.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2 (1)

- [Low] struct netc_port is devm_kzalloc()'d, so the new `u32
  ipft_hf_eid` starts at 0, but the patch only writes the…
- [Low] Removing netc_free_host_flood_rules() also removes the only in-
  tree documentation of a deliberate design decision: 'No need to clear…

Pre-existing issues:
- [Low] netc_port_remove_host_flood() discards the return status of
  ntmp_ipft_delete_entry() (drivers/net/dsa/netc/netc_main.c:1776) and…

--

net: dsa: netc: use entry ID instead of pointer to track host flood rule

This replaces the struct ipft_entry_data pointer in struct netc_port with a
u32 entry ID using NTMP_NULL_ENTRY_ID as the sentinel, frees the
ipft_entry_data allocation inside netc_port_add_host_flood_rule() once the
hardware entry is committed, and drops netc_free_host_flood_rules().

A few questions below.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 77077352c1a57..d326a00104e1d 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> @@ -286,6 +286,12 @@ static int netc_init_all_ports(struct netc_switch *priv)
>  				dev_err(dev, "Failed to create MDIO bus\n");
>  				return err;
>  			}
> +
> +			/* The ipft_hf_eid is initialized to an invalid entry
> +			 * ID because the host flood rule (IPFT entry) has not
> +			 * been created.
> +			 */
> +			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
>  		}
>  	}

[Severity: Low]
Should the sentinel be written for every port rather than only inside the
dsa_port_is_user(dp) branch?

Each netc_port is devm_kzalloc()'d in the earlier loop of
netc_init_all_ports(), so ipft_hf_eid starts at 0, which is a legal
hardware IPFT entry ID rather than "no rule".  The old field was a pointer,
where the zeroed value (NULL) was inherently the safe "no rule" marker.

netc_port_remove_host_flood() only recognizes the 0xffffffff sentinel:

	if (entry_id == NTMP_NULL_ENTRY_ID)
		return;
	...
	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);

so a port that never got the assignment would pass that guard and delete
hardware entry ID 0, which may belong to another port.

I could not find a path that reaches netc_port_remove_host_flood() or
netc_port_bridge_join() with a non-user port today - dsa_port_set_host_flood()
comes only from dsa_user_manage_host_flood(), and the bridge join/leave
callers all operate on user ports - so this looks latent rather than
reachable.  Would moving the assignment into the devm_kzalloc() loop that
sets np->switch_priv and np->iobase make the representation fail-safe for
all ports?

> @@ -938,30 +944,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
>  	mutex_destroy(&priv->vft_lock);
>  }
>  
> -static void netc_free_host_flood_rules(struct netc_switch *priv)
> -{
> -	struct dsa_port *dp;
> -
> -	dsa_switch_for_each_user_port(dp, priv->ds) {
> -		struct netc_port *np = priv->ports[dp->index];
> -
> -		/* No need to clear the hardware IPFT entry. Because PCIe
> -		 * FLR will be performed when the switch is re-registered,
> -		 * it will reset hardware state. So only need to free the
> -		 * memory to avoid memory leak.
> -		 */
> -		kfree(np->host_flood);
> -		np->host_flood = NULL;
> -	}
> -}
> -
>  static void netc_teardown(struct dsa_switch *ds)
>  {
>  	struct netc_switch *priv = ds->priv;
>  
>  	disable_delayed_work_sync(&priv->fdbt_ageing_work);
>  	netc_destroy_all_lists(priv);
> -	netc_free_host_flood_rules(priv);
>  	netc_free_ntmp_user(priv);
>  }

[Severity: Low]
Could the deleted rationale be preserved somewhere?  Behaviour is unchanged
(netc_teardown() still leaves the host flood IPFT entries programmed in
hardware), but this hunk removes the only in-tree record of why that is
intentional:

	/* No need to clear the hardware IPFT entry. Because PCIe
	 * FLR will be performed when the switch is re-registered,
	 * it will reset hardware state. ...
	 */

Note that the FLR assumption holds for a PCI re-probe, where
netc_switch_pci_probe() calls pcie_flr(pdev), but a DSA teardown/setup cycle
on the same pci_dev does not perform FLR.  Would it help to keep the comment
in netc_teardown() or next to the ipft_hf_eid field so the assumption can be
re-checked later?

> @@ -1759,37 +1747,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,

[ ... ]

> -static void netc_port_remove_host_flood(struct netc_port *np,
> -					struct ipft_entry_data *host_flood)
> +static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
>  {
>  	struct netc_switch *priv = np->switch_priv;
>  	bool disable_host_flood = false;
>  
> -	if (!host_flood)
> +	if (entry_id == NTMP_NULL_ENTRY_ID)
>  		return;
>  
> -	if (np->host_flood == host_flood)
> +	if (np->ipft_hf_eid == entry_id)
>  		disable_host_flood = true;
>  
> -	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
> -	kfree(host_flood);
> +	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
>  
>  	if (disable_host_flood) {
> -		np->host_flood = NULL;
> +		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
>  		np->uc = false;
>  		np->mc = false;
>  		netc_port_wr(np, NETC_PIPFCR, 0);

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but can the
IPFT entry become unremovable here?

ntmp_ipft_delete_entry() can fail (DMA buffer allocation or command BD
error), and its status is discarded before np->ipft_hf_eid is reset to
NTMP_NULL_ENTRY_ID, so the armed entry (FLTFA=REDIRECT, HR=NETC_HR_HOST_FLOOD)
stays in hardware with no software handle left.

This appears to be addressed by the following patch in the series, which
makes netc_port_remove_host_flood() return int, checks the delete status
before clearing np->ipft_hf_eid/uc/mc, and handles the error at all call
sites.

> @@ -1818,20 +1805,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  
>  	/* IPFT does not support in-place updates to the KEYE element,
>  	 * we need to add a new entry and then delete the old one. So
> -	 * save the old entry first.
> +	 * save the old entry ID first.
>  	 */
> -	old_host_flood = np->host_flood;
> -	np->host_flood = NULL;
> +	old_entry_id = np->ipft_hf_eid;
>  
>  	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> -		np->host_flood = old_host_flood;
>  		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
>  			port);
>  		return;
>  	}
>  
>  	/* Remove the old host flood entry */
> -	netc_port_remove_host_flood(np, old_host_flood);
> +	netc_port_remove_host_flood(np, old_entry_id);
>  }

[Severity: Low]
Same pre-existing concern in this key-update flow, which this patch does not
change: because the new entry is added before the old one is deleted, a
failed delete leaves two live IPFT entries matching the same source port with
PIPFCR still enabled.  The subsequent patch in the series inverts the order to
delete-then-add, which closes that window.

> diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
> index 305f2a92e2f9a..020e3661b8667 100644
> --- a/drivers/net/dsa/netc/netc_switch.h
> +++ b/drivers/net/dsa/netc/netc_switch.h
> @@ -84,7 +84,11 @@ struct netc_port {
>  	u16 uc:1;
>  	u16 mc:1;
>  	u16 pvid;
> -	struct ipft_entry_data *host_flood;
> +	/* ipft_hf_eid applies only to user ports and should be initialized
> +	 * to NTMP_NULL_ENTRY_ID. Other ports (such as CPU ports) do not
> +	 * require initialization.
> +	 */
> +	u32 ipft_hf_eid;
>  };

[Severity: Low]
This comment records the partial initialization discussed above as an
invariant.  Since 0 is a valid IPFT entry ID, would it be safer to
initialize ipft_hf_eid for all ports and drop the "other ports ... do not
require initialization" wording?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com

