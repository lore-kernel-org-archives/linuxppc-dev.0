Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C955606A8B4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9D0afPn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS2Yn0DYgz2xGw;
	Sun, 15 Nov 2026 18:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794727468;
	cv=none; b=DOf/v+Sllq2Sn2OigIMPnnbzWlEtmMHfmWZO/lxD9QQByHOSV6a/GCOkKM8XmMcMkxcNdpBCcFp3LE4M6rzskja4mTEIoswPDClj/r9V7YmSDjJ6Pwa79cw3s+L7dKDdiQeTXfxWJJ9r/DIIptbWX1nSBHHlSBElJf2QJRwxmURxrABwa8aMJVwH4kDoEhWt5Ql3Fcpu94jViyUekfNI9CEDjOruwgggwn1vwIebnvbkRWGjEh0UQ67bWo3huMc9XE6LvhbxRT2YWmAhDX2N/Iqj8mtZfgJ8c+z0JqWRlr5x8YNBSZpJVyteXcn1Wy+QIb5smGGcMXN3hOe3r3luXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794727468; c=relaxed/relaxed;
	bh=AidHs0Awemb2NZ24itVBVZKYL6ptkEfvldQHKQBgGl0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUxJtjvNU3K2M6HKSyPWyd8PhiyQp3WLW3jyFtUbAa4UqJFk7uHBu4UgSrTCLAK5IeuzgVavBebrqKrZkBUZH7y+GGmqX6wclk7tmbHa2RkrIZ1u7Ca+vPj7TX3EXgdunZwkKaMAdOvAOEG890PT9pDFrd34dw1gONCL24QBXT6mgrzb76mTfxnfVo/EAIkNN8PsVuOqXTzj02SXQsIX1xxmbew179uuFDbzyjSOeSNTvtms0DnrEodmxD0qLks9M0KfqqplozVRpr44GQIhWh7xyIUP42bCOgya0eRX6UnRzf0XKwcM3M8swWeGRCNS+E5P/qcT0stYY8ENieOjxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9D0afPn; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9D0afPn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS2Yl6jhFz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 18:24:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 385D6609F7;
	Sun, 15 Nov 2026 07:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50281F000C4;
	Sun, 15 Nov 2026 07:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727464;
	bh=AidHs0Awemb2NZ24itVBVZKYL6ptkEfvldQHKQBgGl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J9D0afPnqD/0sfW+WAvE5yqR5xx4q5F1P40g3fB8SgXIXt03kybektbsmLTAz7ka8
	 BJYYsvbzT8Gdg0OhCrqbtEy+XcVDpZ4a35cEv0HPLPFVVlWZ2kK2ZYzkgU6PBTirG1
	 jdCVoZEWD0S9FFoVdgkaVOATKn2i8CeA3IzhKCKpMnzmgcnYKup3qc6NCqFxO158/Q
	 bOMhJB9UPKjOH9abL0QMfx5HzjwGol/FqCgZ6VhfPZ4ncbzwmrJcNpR2zNlZsoGppH
	 kNItHofx6sfPkth1MoRpH8Jm8k98VOgu0i6oqaAtlej0fdJtp+KlOy7Q++TodO8fYd
	 flN96cmOMKOQg==
Subject: Re: [PATCH v7 net-next 4/9] net: dsa: netc: tie setup resources and
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
Date: Sun, 15 Nov 2026 07:24:23 +0000
Message-ID: <179472746345.2199510.13684304240938201686@kernel.org>
In-Reply-To: <20261111062753.1397582-5-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-5-wei.fang@oss.nxp.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes the first netc_setup() skip the reset
  (priv->configured == false) on the grounds that "the probe path…

--

net: dsa: netc: tie setup resources and reset to DSA setup/teardown

This patch adds netc_switch_reset(), which netc_setup() calls first so
each DSA setup starts from a clean hardware state. The first setup skips
the reset and relies on the probe-time FLR. The patch also turns the
setup-path devm_ allocations into explicit alloc/free calls, released in
netc_teardown() and on the error paths.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 77077352c1a57..c291123f53170 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> +static int netc_switch_reset(struct netc_switch *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +	int err;
> +
> +	if (!priv->configured) {
> +		/* The hardware will be configured after netc_switch_reset()
> +		 * is called, so set priv->configured to true.
> +		 */
> +		priv->configured = true;
> +		return 0;
> +	}

[Severity: Medium]
Can the first netc_setup() start on stale hardware tables if the FLR in
probe failed?

The commit message says:

    The probe path already performs a FLR in netc_switch_pci_init(), so
    the first setup will skip the reset because the priv->configured flag
    is not set.

But netc_switch_pci_init() ignores the pcie_flr() return value:

drivers/net/dsa/netc/netc_main.c:netc_switch_pci_init() {
    ...
	pcie_flr(pdev);
	err = pcim_enable_device(pdev);
    ...
}

pcie_flr() can fail. It returns -ENOTTY if config space is not
accessible or if pci_dev_wait() times out. It can also fail through
pci_dev_reset_iommu_prepare() for an ATS-capable device behind an IOMMU.

Suppose that happens after an unbind/rebind:

netc_switch_probe()
  netc_switch_pci_init()
    pcie_flr()            <- fails, error ignored
  dsa_register_switch()
    netc_setup()
      netc_switch_reset() <- returns 0 early, !priv->configured

The FDB, VLAN filter, IPFT, BPT and ETT entries from the previous binding
would then stay in hardware. netc_setup() builds empty software state on
top of them, and the driver has no record of those entries to remove.

Later setups treat an FLR failure as fatal, so a failed first FLR is
handled differently. Should the probe path check the pcie_flr() result
and fail probe? Alternatively, priv->configured could be set only after
a successful FLR, so that the first setup retries the reset.

> +
> +	/* Block user space config access and other PCI resets, which take
> +	 * pci_cfg_access_lock() via pci_dev_lock(), during the FLR.
> +	 */
> +	pci_cfg_access_lock(pdev);
> +	err = pci_save_state(pdev);
> +	if (err)
> +		goto unlock_cfg_access;
> +
> +	err = pcie_flr(pdev);
> +	if (err)
> +		dev_err(priv->dev, "FLR failed: %pe\n", ERR_PTR(err));
> +
> +	pci_restore_state(pdev);
> +
> +unlock_cfg_access:
> +	pci_cfg_access_unlock(pdev);
> +
> +	return err;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111062753.1397582-1-wei.fang%40oss.nxp.com

