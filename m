Return-Path: <linuxppc-dev+bounces-18363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80DF103E190
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:53:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWzR48mSz2yjp;
	Thu, 19 Mar 2026 01:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773845603;
	cv=none; b=YhAlZFVneVkCCh7GW8pgViVDKyTJRCvBNTW5j4Imd5zQf2rfES0GnrYXVYD32KPmh1Left7YC+VBRxJKmIWiIZbitBHy4FYeueTprXMSmDoPjfI0GpPwzWY02mBhue4tz9xsgNcQEb7V30yOB7iWeFP4+gIdjeEdx/vHoBI1mOYtgke0uRfo0CSGiEnii9v9Xp4vnOerR8SpWPoUHcR3wfOgVswrvEipZhezLfplJAQGT/+x4zDXqOEu/xWj/Uet2dEJAs4mzj48kPcPVRJuGP+yReQY9+GLgpfg9G5xX6RoEtzRJL8v6eF2v80+2LSy81UU0nANtkvj5EGljSnT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773845603; c=relaxed/relaxed;
	bh=o11Iy2EUiKEQzzjcnzv2FzaG64egcxcdSF/X7Q0VS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQzEjblBdvKI2Z9yYXG9HCnRTG1ma1XDS8ZI9Id2+8HvH7USkfSC3n/G2woP+Vnxs78iPMqizykN6jdTI4e9hNeWiEkQcm2AAyoB1vWVIYdQJogvkBVnnt98ZauaHycAmC/lDheeOWm2aW9HIR+cTSHUWfjdq9U4QVJi7b6/PMu+yjF6iRossTh5cVhym4OqiLqvKGK1hdcDNZODEm9DPSeM3+egj18YutdGxpmosqdGlLlvNa95N8Iyp9NmlldxIAhBv0zdYv7D6WQxjPcDbvbAPGrW23QMCcWRxyGcL+ULjZ5tmnwJUVqHz46e6gHIRP4bQwQPEDzclqMp9os+rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fAtjlSky; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fAtjlSky;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWzP6b3wz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:53:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 488A060133;
	Wed, 18 Mar 2026 14:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C1C19421;
	Wed, 18 Mar 2026 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845599;
	bh=felRz9HjKIpiMojzCYck9P/yFifvYQCbmR4et9IJMCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAtjlSkyrrMyzIBZ7N2NlRzPZBtw8remOkjH7r+8O59bkBW9qIQf+rzgbHGyeJBZK
	 0+T4qwG8pBLnqm5DlGljHViPzqML4ExtKFxOgILq0kFmbQ4uvSAukqpPijCffZKz5k
	 Y7SBwklP6pAK+QeUH6IaeFjQHqZO+bN3SRjdRExWC97ff3txc5AZ03kJMwY0a8UlDW
	 Od9QgSz11fcD99EJ8ap1pH+Sv8ZBKcHDb5mms12ptgEjzCziEJPXor9Pn/4l4lV15A
	 92QuVOu/VnAHsV+FpmWB25zl5ivwjGt0EdgLwJPp1oONsKUcmW0Oon4456rAUBshvk
	 SdVMgMdIqIi2w==
From: Simon Horman <horms@kernel.org>
To: wei.fang@nxp.com
Cc: Simon Horman <horms@kernel.org>,
	robh@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	devicetree@vger.kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	chleroy@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,12/14] net: dsa: netc: add more basic functions support
Date: Wed, 18 Mar 2026 14:49:56 +0000
Message-ID: <20260318144954.1893193-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316094152.1558671-13-wei.fang@nxp.com>
References: <20260316094152.1558671-13-wei.fang@nxp.com>
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
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: netc: add more basic functions support

This patch expands the NETC switch driver with several foundational
features, including FDB and MDB management, STP state handling, MTU
configuration, port setup/teardown, and host flooding support.
At this stage, the driver operates only in standalone port mode.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 884ee899fc89..fd952b507cbd 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -427,24 +658,57 @@ static int netc_setup(struct dsa_switch *ds)
>  	if (err)
>  		goto free_mdio_bus;
>
> +	INIT_HLIST_HEAD(&priv->fdb_list);
> +	mutex_init(&priv->fdbt_lock);
> +
>  	netc_switch_fixed_config(priv);
>
>  	/* default setting for ports */
>  	dsa_switch_for_each_available_port(dp, ds)
>  		netc_port_default_config(priv->ports[dp->index]);
>
> +	err = netc_add_standalone_vlan_entry(priv);
> +	if (err)
> +		goto free_ntmp_user;
> +
> +	err = netc_add_standalone_fdb_bcast_entry(priv);
> +	if (err)
> +		goto free_ntmp_user;
> +
>  	return 0;
>
> +free_ntmp_user:
> +	netc_free_ntmp_user(priv);
>  free_mdio_bus:
>  	netc_free_mdio_bus(priv);
>
>  	return err;
>  }

Does the error path handle the mutex properly?

In netc_setup(), the mutex is initialized with mutex_init(&priv->fdbt_lock).
If netc_add_standalone_vlan_entry() or netc_add_standalone_fdb_bcast_entry()
fails, the error path jumps to free_ntmp_user:

drivers/net/dsa/netc/netc_main.c:netc_setup() {
	...
	INIT_HLIST_HEAD(&priv->fdb_list);
	mutex_init(&priv->fdbt_lock);
	...
	err = netc_add_standalone_vlan_entry(priv);
	if (err)
		goto free_ntmp_user;

	err = netc_add_standalone_fdb_bcast_entry(priv);
	if (err)
		goto free_ntmp_user;

	return 0;

free_ntmp_user:
	netc_free_ntmp_user(priv);
free_mdio_bus:
	netc_free_mdio_bus(priv);

	return err;
}

But netc_free_ntmp_user() and netc_free_mdio_bus() don't call
mutex_destroy(&priv->fdbt_lock) to clean up the mutex.

Looking at the normal teardown path in netc_teardown(), it calls
netc_destroy_all_lists() which properly handles both the FDB list and
mutex cleanup:

drivers/net/dsa/netc/netc_main.c:netc_destroy_all_lists() {
	netc_destroy_fdb_list(priv);
	mutex_destroy(&priv->fdbt_lock);
}

drivers/net/dsa/netc/netc_main.c:netc_teardown() {
	struct netc_switch *priv = ds->priv;

	netc_destroy_all_lists(priv);
	netc_free_host_flood_rules(priv);
	netc_free_ntmp_user(priv);
	netc_free_mdio_bus(priv);
}

Should the error path in netc_setup() call netc_destroy_all_lists() before
calling netc_free_ntmp_user()?

> @@ -595,6 +859,261 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
>  	priv->revision = val & IPBRR0_IP_REV;
>  }
>
> +static void netc_destroy_all_lists(struct netc_switch *priv)
> +{
> +	netc_destroy_fdb_list(priv);
> +	mutex_destroy(&priv->fdbt_lock);
> +}
> +
> +static void netc_free_host_flood_rules(struct netc_switch *priv)
> +{
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		struct netc_port *np = priv->ports[dp->index];
> +
> +		kfree(np->host_flood);
> +		np->host_flood = NULL;
> +	}
> +}

[Simon says: I think this is a false positive and the clean-up
 suggestion is not needed in tear down]

Does this properly clean up the hardware state?

netc_free_host_flood_rules() just frees the host_flood memory and sets
the pointer to NULL:

drivers/net/dsa/netc/netc_main.c:netc_free_host_flood_rules() {
	struct dsa_port *dp;

	dsa_switch_for_each_user_port(dp, priv->ds) {
		struct netc_port *np = priv->ports[dp->index];

		kfree(np->host_flood);
		np->host_flood = NULL;
	}
}

But it doesn't delete the hardware IPFT entry or disable the PIPFCR register.

Compare with netc_port_remove_host_flood() which performs complete cleanup:

drivers/net/dsa/netc/netc_main.c:netc_port_remove_host_flood() {
	struct netc_switch *priv = np->switch_priv;

	if (!np->host_flood)
		return;

	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
	kfree(np->host_flood);
	np->host_flood = NULL;
	np->uc = false;
	np->mc = false;
	/* Disable ingress port filter table lookup */
	netc_port_wr(np, NETC_PIPFCR, 0);
}

In netc_teardown(), netc_free_host_flood_rules() is called before
netc_free_ntmp_user(), so the NTMP command infrastructure is still
operational at that point.

Should netc_free_host_flood_rules() call netc_port_remove_host_flood(np)
for each user port instead of directly calling kfree()?

