Return-Path: <linuxppc-dev+bounces-19247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2608D6AB1A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:17:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16g0jcdz2yVP;
	Fri, 03 Apr 2026 12:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179051;
	cv=none; b=d87D/Uv521S12162UuySaOpACPySv3JD8mKAF9PfS3ZdG4F48od/l++yMIpzlLSdJ9oQ9xIq179h75er8R/HkkamMpxwxkSGzCzqj3gd1ijZw8o9XW6DxrpGyZ57RouqyzYmiEvfTeaxmJ0yUu3h1/wFA1Vxqm9s+CUsVJ87rQsMOpemNfSW2F/VKQ/PrG3+nqzfxUfJlHzvmHVXRp8SnMBKqh9WTbRkvotOr5Y7Ju1aYnsahSpB39M0lkKzSFK8pXHPy0kgvlE6lXnXI57O/PmkHgCuwfWYmnOeJ0TO14HDLLWcE1oaf8TJm7Eiyqx174BL2gBtITHOmLkYRPeVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179051; c=relaxed/relaxed;
	bh=meWBkb9JLY55JlrbJk4pJtQ1K06TmCWc4A9vSb/0KTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDEFsCqFyvlPukfleJn6s9tqFRxgNYQALmiQHE8u8sWoFsliXHsUwky0y1lsCP0TctszeduwP8/iMfQ4MrYu+3b23dgUySk3KFthUS0entwWRBjmHLOBwWaVM4VvTvA1qVD/EkcltEkiPNshNkoTdxSCZ73tURcMHbD5R01yxIt4/khOg+qTJjXijnYKDFdBM3uTuIatxgIuy0fD8F7H8SCaoUvdskRdBM0sLKKxWUznTvIOHpKl6UTw6defywdCOLUn31xqxdlxk1NVieFBV5TnzOhUneTrGfiLbzQBRWvVhDbQgdpP+/6FZ03zp3L/aBWDuOPWKZfOjWIof9ZPMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=odmCkW0v; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=odmCkW0v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16d49yDz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D5657443DB;
	Fri,  3 Apr 2026 01:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5498C116C6;
	Fri,  3 Apr 2026 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179046;
	bh=JaZaqXx7UjhAu1o2iKmm1mcnfKWDRIbQehAs9zgMebg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odmCkW0vCuh4urc8EBRzGnbdsI1D7bki86zEYeShQ5iBGE0KbhZtGUh1TYW61UifM
	 vlZHEIb9RaVRJGFQM90CW2FTMdJVg7rTtV3Cn6qKnA6Udo6V2mCALGdOOkpc7sWyL7
	 1/mYbbTxLddFsySO148Z/Di7Bi0W8SPd3NAHFa/gBoX46ljq7C9wKjgbsSufCiBleV
	 BzDqEBm7D2ZkGrCurTK/ahccod50nLtj/EEtaNvDUbNyMG3jUXrtG9MXFelGSUExpp
	 lLGnyvayMqtQU/dbr2Mwt942GBzYgPP47aePrQlIDLtC0Iir7STP++CxmJmplaBXM5
	 iC2+aAECkb13Q==
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
Subject: Re: [PATCH v4 net-next 03/14] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Thu,  2 Apr 2026 18:17:23 -0700
Message-ID: <20260403011723.1795349-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-4-wei.fang@nxp.com>
References: <20260331113025.1566878-4-wei.fang@nxp.com>
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
net: enetc: add pre-boot initialization for i.MX94 switch

This commit adds pre-boot initialization logic for the i.MX94 switch
in the NETC block control driver. It configures external ports, MII
protocols, and MDIO PHY addresses, and handles the MAC selection
constraint between switch port 2 and ENETC 0.

> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 92a0f824dae7..c21230f7a7fb 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
[ ... ]
> +static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
> +				    struct device_node *np,
> +				    bool *swp2_en)
> +{
> +	struct device_node *ports;
> +	int port_id, err = 0;

Since of_property_read_u32() expects a u32 pointer, does passing a
signed int pointer here trigger an incompatible pointer types warning
during compilation?

> +
> +	ports = netc_get_switch_ports(np);
> +	if (!ports)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(ports, child) {
> +		if (of_property_read_u32(child, "reg", &port_id) < 0) {

If the device tree provides a reg value with the MSB set, port_id
would be evaluated as a negative number.

[ ... ]
>  static int imx94_netcmix_init(struct platform_device *pdev)
>  {
>  	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
>  	struct device_node *np = pdev->dev.of_node;
> +	bool enetc0_en = false, swp2_en = false;
>  	u32 val;
>  	int err;
>  
>  	for_each_child_of_node_scoped(np, child) {
>  		for_each_child_of_node_scoped(child, gchild) {
> -			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> -				continue;
> -
> -			err = imx94_enetc_link_config(priv, gchild);
> -			if (err)
> -				return err;
> +			if (of_device_is_compatible(gchild, "pci1131,e101")) {
> +				err = imx94_enetc_link_config(priv, gchild,
> +							      &enetc0_en);
> +				if (err)
> +					return err;
> +			} else if (of_device_is_compatible(gchild,
> +							   "pci1131,eef2")) {

Is it possible for the switch node to be disabled in the device tree?

If so, should we check of_device_is_available() for gchild before proceeding,
similar to how it is checked for enetc0_en?

Without checking availability, if the disabled switch lacks a ports subnode,
imx94_switch_link_config() might return -ENODEV and abort the entire probe.

Alternatively, if the disabled switch node has a ports subnode with an
available port 2, it could spuriously set swp2_en = true and cause a false
conflict with ENETC 0.

> +				err = imx94_switch_link_config(priv, gchild,
> +							       &swp2_en);
> +				if (err)
> +					return err;
> +			}
>  		}
>  	}
[ ... ]
> @@ -610,6 +682,77 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
>  	return 0;
>  }
>  
> +static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
[ ... ]
> +static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
> +					    struct device_node *np,
> +					    int port_id, u32 phy_mask)
> +{
> +	int addr;
> +
> +	/* The switch has 3 external ports at most */
> +	if (port_id > 2)
> +		return 0;

If port_id is negative due to the signed type, it will bypass this upper
bound check.

> +
> +	addr = netc_get_phy_addr(np);
> +	if (addr < 0) {
> +		if (addr == -ENODEV)
> +			return 0;
> +
> +		return addr;
> +	}
> +
> +	if (phy_mask & BIT(addr)) {
> +		dev_err(&priv->pdev->dev,
> +			"Found same PHY address in EMDIO and switch node\n");
> +		return -EINVAL;
> +	}
> +
> +	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
> +		       LBCR_MDIO_PHYAD_PRTAD(addr));

Could this lead to an out-of-bounds register write prior to the array base
since port_id is negative?

> +
> +	return 0;
> +}
> +
> +static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
> +				  struct device_node *np,
> +				  u32 phy_mask)
> +{
> +	struct device_node *ports;
> +	int port_id, err = 0;

A similar signed int declaration is used here for port_id, which would run
into the same pointer type warning and negative value issues.

> +
> +	ports = netc_get_switch_ports(np);
> +	if (!ports)
> +		return -ENODEV;
[ ... ]
-- 
pw-bot: cr

