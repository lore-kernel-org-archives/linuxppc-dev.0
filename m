Return-Path: <linuxppc-dev+bounces-29353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA486CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3rsL5Stjz3bsR;
	Tue, 13 Oct 2026 21:57:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791889078;
	cv=none; b=Yl80YHK2WJmjai0M5IfdOVtCYwS3p2omO3j5s2L8IYECjRlEquS4UAt6jraRjRJTkx2wqLvWayOFdIvNr0m+zjlZCSIQpFYpPTBJQGBEPHGHFrCXyAzxR/2X24S8B7un34/JVCYyObhXgJ8E3IBONp90jZNbxdtW160IbW/Y4KAXZRPiwuIcfeJdl1uTIrs5sA7Gpk4vOrRjWeFjhKVjpWU5Ts5QfCnQ4dN79nlgf7TmIg+mfYkmjtYV7LPGXvQezqBeJ2d/dPJ064vq0YtuSEfTR8gq+BcFJ0Ax3m11pSL9Ivypaf2mJh3J4H4noZM9L5x0/YJes0UqWZhg4lkzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791889078; c=relaxed/relaxed;
	bh=qnKi+7ADQG/VWxlGCq3ag9AtsA95cFTpxw3B8yHY6Is=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4Jh3fMO6FyVzbC8gnO47oFBDvkbipNJwWeqOh5AlCP1awZo6d05nyMhYJnWw3CVbkTUe3KfuQnrIoxx6NMGjBWNIhgI+mTmczEXkQROEoUpKV9qaZTgNqGQdjlKOUrsKKf5JBCO2lYAQDacpJ0S8NwrJToFkE7aoj9r7Dbjkub7fNi6hXJ8kjfVFXKnOb7dqwj7yLQUxxyZcNgNndHZ6NRfdE6Cr6AVovFeV02twx02Dl5joHMi6xBzdyvVzk2E8Om87mt4XKAQaPPzTpPOii7S+XMZ8Kfb4jZ5BqvSnS33kYdBvVIgeYM1P9wvsNnHvZG/w9VI7S3KAKgJfWfprg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ9VNlsy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ9VNlsy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3rsK1QDCz3brP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:57:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D54641A0A;
	Tue, 13 Oct 2026 10:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A62B1F00899;
	Tue, 13 Oct 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889074;
	bh=qnKi+7ADQG/VWxlGCq3ag9AtsA95cFTpxw3B8yHY6Is=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hZ9VNlsyT3Z+fNT5UOrRnZPOKchhLvUfhBAFg03Rt02L9yj3H4m7uoyW9rrLRrzoV
	 LT0fdOf+FvEdEDRFKMK5aZ+3k3jDS5EIshqjXtn85u8/AGldCzyqtgQY5fWRxfdOxx
	 BbhHDub9llJaK6QKR92fkLaswLuHMlnJlrg3FrHSvrfbOG2rVLABkqSw0sTi0hPgIZ
	 dS+imhoEw69fZ48G8mFqvEPiGYEviHf3avQYS49ajGZby3FDUMHcs/myrht7f21X8G
	 VoIJoTOMJYtJanQCFHw86kfuYrgTICIk5tycusG7Me3xl0v/806uKcZA6e3NrfJcm8
	 k5kxGwHBgPHMg==
Subject: Re: [PATCH v5 net-next 6/9] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Oct 2026 10:57:52 +0000
Message-ID: <179188907298.434549.12622968877593744091@kernel.org>
In-Reply-To: <20261012095924.1129312-7-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-7-wei.fang@oss.nxp.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the delete-then-add reorder costs only
  a 'brief window' in which packets are dropped.
- [Medium] netc_port_remove_host_flood() now treats every
  ntmp_ipft_delete_entry() error as 'entry still installed' and keeps…
- [Medium] A failed VLAN-unaware bridge join can permanently disable an
  all-multicast (or promisc) configuration the standalone port already…

--

net: dsa: netc: check return value of ntmp_ipft_delete_entry()

netc_port_remove_host_flood() now returns the error from
ntmp_ipft_delete_entry(). Driver state is cleared only after a delete
succeeds.

Host flood rule replacement in netc_port_set_host_flood() changes from
add-then-delete to delete-then-add, with a bounded retry on the add.

netc_port_bridge_join() now deletes the host flood rule before the VLAN
setup and tries to restore it if that setup fails.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index e33a184fd0054..09154781df7a0 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -1851,32 +1845,32 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
>  	return err;
>  }
>  
> -static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
> +static int netc_port_remove_host_flood(struct netc_port *np)
>  {
>  	struct netc_switch *priv = np->switch_priv;
> -	bool disable_host_flood = false;
> +	u32 entry_id = np->ipft_hf_eid;
> +	int err;
>  
>  	if (entry_id == NTMP_NULL_ENTRY_ID)
> -		return;
> +		return 0;
>  
> -	if (np->ipft_hf_eid == entry_id)
> -		disable_host_flood = true;
> +	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> +	if (err)
> +		return err;

[Severity: Medium]
Is it safe to treat every error from ntmp_ipft_delete_entry() as meaning
the entry is still installed?

For -ETIMEDOUT, netc_xmit_ntmp_cmd() has already advanced the producer
index before it polls. It then returns without withdrawing the BD:

drivers/net/ethernet/freescale/enetc/ntmp.c:netc_xmit_ntmp_cmd() {
    ...
	netc_write(cbdr->regs.pir, i);

	err = read_poll_timeout(netc_read, val,
				(val & NETC_CBDRCIR_INDEX) == i,
				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
				true, cbdr->regs.cir);
	if (unlikely(err))
		return err;
    ...
}

NETC_CBDR_TIMEOUT is 1000us, so the hardware could still run the DELETE
after the timeout. The IPFT entry would then be gone while
np->ipft_hf_eid still holds its ID.

After that, every netc_port_remove_host_flood() call would send a DELETE
for the freed ID. If the hardware rejects it, the error comes back on
every call. With this patch netc_port_bridge_join() returns that error,
so the port could never join a bridge again.

What if the hardware instead gives the same ID to a later
ntmp_ipft_add_entry()? That could be another port's host flood rule, or
the PTP trap entries added later in the series. Wouldn't the stale
DELETE then silently remove that other rule?

The commit message says "so that the software state always stays
consistent with the hardware". Does that hold for the timeout case?

[ ... ]

> @@ -1893,19 +1892,33 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  		return;
>  
>  	/* IPFT does not support in-place updates to the KEYE element,
> -	 * we need to add a new entry and then delete the old one. So
> -	 * save the old entry ID first.
> +	 * we need to delete the old one and then add the new rule. If
> +	 * the deletion fails, return immediately.
>  	 */
> -	old_entry_id = np->ipft_hf_eid;
> -
> -	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> -		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
> +	if (netc_port_remove_host_flood(np)) {
> +		dev_err(ds->dev,
> +			"Failed to delete old host flood rule on port %d\n",
>  			port);
> +
>  		return;
>  	}
>  
> -	/* Remove the old host flood entry */
> -	netc_port_remove_host_flood(np, old_entry_id);
> +	/* Restoring the previous configuration is pointless because
> +	 * .port_set_host_flood() returns void, so the upper layer cannot
> +	 * detect the error and the RX flags have changed. Furthermore, we
> +	 * cannot guarantee that we can successfully restore the previous
> +	 * state.
> +	 */
> +retry:
> +	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> +		if (retry_num++ < 2) {
> +			usleep_range(100, 110);
> +			goto retry;
> +		}
> +
> +		dev_err(ds->dev,
> +			"Failed to add host flood rule on port %d\n", port);
> +	}
>  }

[Severity: Medium]
What happens to host flooding on a standalone port if all three
netc_port_add_host_flood_rule() attempts fail here?

By this point netc_port_remove_host_flood() has already done four things:

- deleted the old IPFT entry
- cleared np->ipft_hf_eid
- cleared np->uc and np->mc
- written 0 to NETC_PIPFCR

The add can fail with -ENOMEM from kzalloc_obj() or the DMA allocation.
It can also fail with an error from the NTMP command, for example a full
table or a timeout.

.port_set_host_flood() returns void. DSA calls it only from
dsa_user_change_rx_flags(), when IFF_PROMISC or IFF_ALLMULTI change. So
the port would have no host flood rule until the user toggles those
flags again.

With the previous add-then-delete order, a failed add left the old rule
in place.

The commit message describes the cost of the reorder as "a brief window
in which packets that would have matched the rule find no match and are
dropped". Should it also say that a failed add now leaves host flooding
disabled indefinitely?

[ ... ]

> @@ -2081,6 +2096,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
>  	if (err)
>  		return err;
>  
> +	err = netc_port_remove_host_flood(np);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
> +		return err;
> +	}
> +
>  	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);

[ ... ]

> @@ -2105,6 +2124,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
>  disable_mlo:
>  	netc_port_set_mlo(np, MLO_DISABLE);
>  
> +	if (netc_port_add_host_flood_rule(np, uc, mc))
> +		dev_err(ds->dev,
> +			"Failed to restore host flood rule on port %d\n",
> +			port);
> +
>  	return err;
>  }

[Severity: Medium]
Can a failed join to a VLAN-unaware bridge leave a standalone port that
has allmulti or promisc set without its host flood rule for good?

Take a port that already has IFF_ALLMULTI set, so np->mc is true and a
rule is installed:

br_add_if()
  dev_set_allmulti(dev, 1)     /* refcount 1 -> 2, flags unchanged */
  ...
    dsa_port_bridge_join()
      dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN)
        netc_port_bridge_join()
          netc_port_remove_host_flood()     /* rule gone, np->mc = false */
          netc_port_set_vlan_entry()        /* fails, e.g. -ENOMEM */
          disable_mlo:
            netc_port_add_host_flood_rule() /* fails, only logged */
      goto out_rollback                     /* no .port_bridge_leave */
  ...
  dev_set_allmulti(dev, -1)    /* refcount 2 -> 1, flags unchanged */

IFF_ALLMULTI never changes, so dsa_user_change_rx_flags() is not called
and nothing re-adds the rule. The saved uc/mc values are lost, and
np->uc and np->mc stay false.

Before this patch, a failure in netc_port_set_vlan_entry() returned
before the rule was touched. Could the host flood rule be deleted only
after the steps that can fail have succeeded?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095924.1129312-1-wei.fang%40oss.nxp.com

