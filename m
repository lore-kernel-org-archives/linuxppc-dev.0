Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC1606A69F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaJmLHh7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXv5x35g4z2xwP;
	Mon, 23 Nov 2026 16:05:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795410341;
	cv=none; b=G07fGBv0XqkXQV6ttPihosHXHNcDjB1pA9gbVKfkRe9NJ89zKF1Zxc1f2mgcQ1F5a19JzduBGTAQlGKW7fSnkekzXpK5HTAuuUI5RMYWHOtopNBWYGd93Zk5iTqmD2OZUGpttEbQtqppZQFi50n90+1PR84gHKoNKw96R3+uTqKUezEtedA7excd8/xJM42ko894YsIxXvP2yvxqUicupJZjPn37breIUGUeTbiqfrwJt4hOmAAUjr4x6E/7MROJ0gu7W4k65Pw0gvBF5JOGGb7rGtEdBTvv12E+bdY5TVc21cDvkRgCS1o4mPodXh+bdiva8RJcc0qunyIO5etPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795410341; c=relaxed/relaxed;
	bh=kc1WDNzqnWa7MzsqOAzEg3sXZ0FXTjUIsij2hS/psy8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsxSpetxdmzwp/Q1G+gudNSJCuA7CoKXgMfZqJkaa8j13y5pw/LhviFPudjzbeFx3FO0m/3BnhnWnRTEShEvl+uLbCleCqUay+Mvr5X/BlwHfTn9AhPboDfiecwyEjSFMUj+adODF+2E2jgzp4yNZaBfzILD6Q9TgLNyoDTpNa1c3XgrnvWqahaqt74+M/D8rEwrNB7Ql75wuYXEjVQfwVRLYBTroCskIWsEUuXdVW1zAvBt8tdoFQCESh0wbDsxYekF3M6cicsY9grgiiX+Z251P2U9AOJZpv7SWLrmen+3p1h2nGs3+2jMlwOkHlIDK4tCwiXjFk0dWA4Vn0ouCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaJmLHh7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaJmLHh7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXv5w3K9gz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 16:05:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39A4F602D3;
	Mon, 23 Nov 2026 05:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6C1F000CA;
	Mon, 23 Nov 2026 05:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410336;
	bh=kc1WDNzqnWa7MzsqOAzEg3sXZ0FXTjUIsij2hS/psy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MaJmLHh73l7lNwukwY22xJ7TRPlLyjsKgI6pQH3BWlzUQYCqKS6z5xd9rP6LXTe4s
	 NDRy/Kdzc1QCkY8khTw91OdWz9E38XGfiyjbKlxz8VJ5GJ67k+MKXBnHvkIvbKOKaF
	 i2lEzuClX9n2A2rFbOC9dLOcP1RpTiq8BWLsqKx+XxtKkv1X5Sd0Oad+NJ+u/P21sq
	 49uho1bKuptVA/znJFwH0qo+mIZ2gDReW9eyAr9MNFyAomkqcRBhLZVmhNXE/GQ+qM
	 PP2dqtmReItxuqsTqV3WiwPpCl/jS0oqf12gHVKteZHYIFda+sKvbxAr/zQOX3Lx67
	 Bz2PZVJKjrvJw==
Subject: Re: [PATCH v8 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 23 Nov 2026 05:05:35 +0000
Message-ID: <179541033517.3135.5228725617878780083@kernel.org>
In-Reply-To: <20261119030534.1892935-5-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-5-wei.fang@oss.nxp.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch changes how netc_switch_pci_init() handles a failed
  probe-time FLR, and the commit message does not say so.

--

net: dsa: netc: tie setup resources and reset to DSA setup/teardown

This commit adds netc_switch_reset() so that every netc_setup() after the
first one does a PCIe FLR and starts from a clean hardware state. It also
converts the setup-path devm_ allocations to explicit alloc and free.
These are released in netc_teardown() and on the error paths.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 1225ff8153d44..f724f95add36b 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -1042,7 +1161,10 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
>  	void __iomem *base;
>  	int err;
>  
> -	pcie_flr(pdev);
> +	err = pcie_flr(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "FLR failed\n");
> +

[Severity: Low]
This hunk changes probe behaviour, and the commit message doesn't say so.
Before, the return value of pcie_flr() was ignored and probe always went
on. Now any FLR failure in netc_switch_pci_init() makes probe fail.

The commit message only says:

  The probe path already performs a FLR in netc_switch_pci_init(), so the
  first setup will skip the reset because the priv->configured flag is
  not set.

and later:

  The NETC switch does not support multi-switch yet, so there is no
  functional problem today. This only reworks the driver so that
  multi-switch can be added later without hitting these issues.

Both passages read as if the probe path is unchanged.

pcie_flr() can fail in three ways:

  - -ENOTTY when pci_dev_config_accessible() fails
  - an error from pci_dev_reset_iommu_prepare()
  - an error from pci_dev_wait() after PCIE_RESET_READY_POLL_MS times out

In any of these cases, a NETC switch that bound before this patch would
now fail to probe.

Failing probe is probably the right behaviour, since the driver relies on
a clean post-FLR state. Could the commit message mention this change, or
could it go into its own patch? The hunk is still the same at the end of
the series.

>  	err = pcim_enable_device(pdev);
>  	if (err)
>  		return dev_err_probe(dev, err, "Failed to enable device\n");

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119030534.1892935-1-wei.fang%40oss.nxp.com

