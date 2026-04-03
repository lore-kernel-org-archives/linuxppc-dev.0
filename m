Return-Path: <linuxppc-dev+bounces-19253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3238BD6AAFA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:18:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16t6J1Jz2yvL;
	Fri, 03 Apr 2026 12:17:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179062;
	cv=none; b=Vv4usyuWhQTJOyTveREL2ImRkzKYIBr+45O29V4mFnU0Vrapr6q2lGW1dgsPgH6CL6QNOhkAll7xfN1lIXa5E/m5R3SSLJoGNahW7RamMo1JmUIBZWYHmAR7fGuhDg/qpuTEH2FDREPl/sgFg3k5tpPnzSkVgpK3d2OGcfkGj1yfixdPQtc0Ou9k+H+e8lO7wpA4iBknjvVwbbsPJxtkKuz/j7r6HX5C/xO4BNGC2LSzcuT2r2X+eUV6DRsh8PIg5IDAbPR+FafnglOZYsKzz9CMWPnT4lQt+rU8aneHFmigjK1taEROjeIDip3QL68oOWm4FrltXhkHvyFjx/A3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179062; c=relaxed/relaxed;
	bh=pPkUfoHrBUjyOkKwEgFHSDNbZTIKiOhveRpXV2NZ8KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV0CGwFiBv0qVUx23YtsI737AmebZfqmkVbvdPnOKmHpQtw5OseV3wT2nROD5UY9urMlpoBJb20kwz0oMcURaZNzD93UM/5YBxRkAICfSqE9455yt/qnTjkQC5444w4N+KzN526M8kgP03IVOA2NWWQPJCMSuwOdzejRzfvBiHDKSBNSLYWJ/IdL0PFz1Iho7uM4rEV25Lh7yxbnvko6/2B/hBVq8D4v4HnsewLJWnYcB/aKCg9gPeRquUyFbO/w0zabzfjgWMf3UTeAdGRdfx9ouvwtcYs0My4fN9oiZJssflqjM2ZBerwv7sIOkaXtcGPX4Nf/mINI0UEgWz/ykw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MeW8Fp7e; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MeW8Fp7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16t1Kq9z2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A4804441B5;
	Fri,  3 Apr 2026 01:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A65CC116C6;
	Fri,  3 Apr 2026 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179060;
	bh=Qo5WYyKMeV7hp8RN7S6hSeBu5J+1l7VvgvLybc0R8cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeW8Fp7eYP/CuVWuq7dX7B7pzgPFmvM6dhFAaKmM3gWLSO5f10MO+Ya+UeyMCy2YF
	 RRZQYOk8eN60TuEF8jSk08eoCCq/3IF0kk/7O61DqFW67UypRKbQbISlfYAWNZr7E9
	 nr3FvErd9D8PQ7uME3Uq6cvez2SrwAIjs3uKBuu3XKk0pNJXhhNjkfJT7LgS3l0haC
	 RMhTu+dCGe2kSF15x7CnfeRL2plx6wC8AsMMZ+VXNq4RFhDgBl8teFOTqGYOD39298
	 xiNAmGPb/zcB/kITk2cuLUWYuMvQm0RaehPff/7mLMgao/b+Sc/RykYvKTArOyNW+U
	 l48zSk6T+aIMw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 10/14] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
Date: Thu,  2 Apr 2026 18:17:38 -0700
Message-ID: <20260403011738.1795644-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-11-wei.fang@nxp.com>
References: <20260331113025.1566878-11-wei.fang@nxp.com>
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
---
net: dsa: netc: introduce NXP NETC switch driver for i.MX94
    
This commit introduces the initial NXP NETC switch driver for the i.MX94
series. It supports basic probe and remove functionality for the integrated
802.1Q Ethernet switch. The switch includes 3 user ports and 1 CPU port
connected to an internal ENETC.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> new file mode 100644
> index 000000000000..5828fd3e342e
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> +static int netc_port_create_emdio_bus(struct netc_port *np,
> +				      struct device_node *node)
> +{
[ ... ]
> +	err = devm_of_mdiobus_register(dev, bus, node);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Cannot register EMDIO bus\n");
> +
> +	np->emdio = bus;
> +
> +	return 0;
> +}
[ ... ]
> +static int netc_init_switch_id(struct netc_switch *priv)
> +{
> +	struct netc_switch_regs *regs = &priv->regs;
> +	struct dsa_switch *ds = priv->ds;
> +
> +	/* The value of 0 is reserved for the VEPA switch and cannot
> +	 * be used.
> +	 */
> +	if (ds->index > SWCR_SWID || !ds->index) {
> +		dev_err(priv->dev, "Switch index %d out of range\n",
> +			ds->index);
> +		return -ERANGE;
> +	}

Does this check cause the probe to fail unconditionally for standard
single-switch topologies?

The DSA core typically assigns ds->index = 0 by default for the first switch.
Because !ds->index evaluates to true for index 0, this setup function will
always fail unless the dsa,member property is explicitly overridden in the
device tree.

Could the driver translate the hardware ID internally, for example by writing
ds->index + 1 to NETC_SWCR, rather than forcing this hardware-specific
restriction onto the software DSA index?

> +
> +	netc_base_wr(regs, NETC_SWCR, ds->index);
> +
> +	return 0;
> +}
[ ... ]
> +static bool netc_port_is_emdio_consumer(struct device_node *node)
> +{
> +	struct device_node *mdio_node;
> +
> +	/* If the port node has phy-handle property and it does
> +	 * not contain a mdio child node, then the port is the
> +	 * EMDIO consumer.
> +	 */
> +	mdio_node = of_get_child_by_name(node, "mdio");
> +	if (!mdio_node)
> +		return true;
> +
> +	of_node_put(mdio_node);
> +
> +	return false;
> +}
> +
> +/* Currently, phylink_of_phy_connect() is called by dsa_user_create(),
> + * so if the switch uses the external MDIO controller (like the EMDIO
> + * function) to manage the external PHYs. The MDIO bus may not be
> + * created when phylink_of_phy_connect() is called, so it will return
> + * an error and cause the switch driver to fail to probe.
> + * This workaround can be removed when DSA phylink_of_phy_connect()
> + * calls are moved from probe() to ndo_open().
> + */
> +static int netc_switch_check_emdio_is_ready(struct device *dev)
> +{
[ ... ]
> +	for_each_available_child_of_node_scoped(ports, child) {
> +		/* If the node does not have phy-handle property, then
> +		 * the port does not connect to a PHY, so the port is
> +		 * not the EMDIO consumer.
> +		 */
> +		phy_node = of_parse_phandle(child, "phy-handle", 0);
> +		if (!phy_node)
> +			continue;
> +
> +		if (!netc_port_is_emdio_consumer(child)) {
> +			of_node_put(phy_node);
> +			continue;
> +		}
> +
> +		phydev = of_phy_find_device(phy_node);
> +		of_node_put(phy_node);
> +		if (!phydev) {
> +			err = -EPROBE_DEFER;
> +			goto out;
> +		}

Could this logic cause an infinite probe deferral loop for ports sharing an
internal MDIO bus?

The netc_port_is_emdio_consumer() function assumes any port node without an
mdio child is an EMDIO consumer waiting for an external controller. However,
if multiple sibling ports on the same switch share a single internal MDIO bus
defined under one port, the other ports will lack an mdio child node.

This would cause those ports to be mistakenly treated as external EMDIO
consumers, calling of_phy_find_device(). Because the internal MDIO bus is not
registered until later in netc_setup(), the PHY device cannot be found, and
the driver returns -EPROBE_DEFER.

Since netc_setup() is never reached, the MDIO bus is never registered,
causing an infinite deferral loop. Could the driver more accurately identify
whether the PHY belongs to its own switch before deferring?

> +
> +		put_device(&phydev->mdio.dev);
> +	}
> +
> +out:
> +	of_node_put(ports);
> +
> +	return err;
> +}
> +
> +static int netc_switch_pci_init(struct pci_dev *pdev)
> +{
[ ... ]
> +	regs->base = pci_ioremap_bar(pdev, NETC_REGS_BAR);
> +	if (!regs->base) {
> +		err = -ENXIO;
> +		dev_err(dev, "pci_ioremap_bar() failed\n");
> +		goto release_mem_regions;
> +	}
[ ... ]
> +static void netc_switch_pci_destroy(struct pci_dev *pdev)
> +{
> +	struct netc_switch *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->regs.base);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}

Does unmapping the memory here introduce a use-after-unmap issue when the
MDIO bus is unregistered?

The driver registers the MDIO bus using devm_of_mdiobus_register(), meaning
devres cleans it up asynchronously after the remove function returns or when
probe fails.

However, in netc_switch_pci_destroy(), the driver explicitly unmaps the PCI
I/O memory via iounmap(). Since netc_switch_pci_destroy() is called
synchronously inside the remove function and probe error paths, the memory is
unmapped before the MDIO bus is unregistered by devres.

When devres eventually unregisters the MDIO bus, it detaches PHY devices,
which often perform MDIO transactions during removal. Because the underlying
memory priv->regs.base is already unmapped, these MDIO read/write callbacks
could trigger a synchronous external abort or kernel panic.

Would it be better to use pcim_iomap() to tie the memory mapping lifecycle to
devres, ensuring it outlives the MDIO bus?

