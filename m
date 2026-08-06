Return-Path: <linuxppc-dev+bounces-25461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5B3C55174
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 02:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFrHl0jTrz2yMn;
	Thu, 06 Aug 2026 12:06:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785982003;
	cv=none; b=CfMSHbe1UExmoOi7ZrCgwAlVFWAohKiFDIXSjIbCfg1WtqHwWzNMLh+IqtblW0+jh2dwDbO48yrTGPkuaGSHBn9zwLF0G045xhCdVOFfePgPDYfUkiB4IZIdmN+AjES4HqVmFzoPhr4DXS1A9mxTDUKBr+lyHGDCTkMUUI5NK0GOEa/++ptOWIzD/YCo+VMF4eOXHi+VQwQK2uEgSgnUO0do57c9mZGQd0TXTQJ/m7YJ06S14RIqosskCREr+5Vk2FGJmrSbI0r4yrWQ38Yryv2BQct/Uici5fHebwBKbILmi5eRBgK4l6t5Oce+/JCu7tS746icyNWi0493mKO7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785982003; c=relaxed/relaxed;
	bh=yE9my2hCRl/Fk0L+bvY28h5Zsxtyr/3Bp4AJEGkl/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsV3zdn2Om2FNjd0pjntGtBzBhPufB+kZU2M+Yq3ZMe0jl0Gv8VLXfqo7+4fd/ek5xOvOFT8HGdD+OiDI3Vemk5kNJPEaxv9FbhC7BwYbol3Ta4Iokx6Sdgt9LJo+2HtxPojXuVlJLr/YayND87v6YUW4TC8WFIUtwiiQOK88KK3hYHVsyWySkOavP18QpdaMnOOEn/LRgRH3tsZxqZU3TEYt/ntqPoPxisWL598Lmd+HxhbrcAmD7fK7QWXYHDLvzdBV7dkKKgdIQaddn/ROhiUsCFTjORvpzRfFdhiBkecXN9QHr/biNCQVbblede+ObFWvQiqEtyz2WLc65HMDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ao8pnfBB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ao8pnfBB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFrHj5snlz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 12:06:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9716560A63;
	Thu,  6 Aug 2026 02:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBDE1F000E9;
	Thu,  6 Aug 2026 02:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785981997;
	bh=yE9my2hCRl/Fk0L+bvY28h5Zsxtyr/3Bp4AJEGkl/oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ao8pnfBBeTvO/JdOu3S7CRyX7bKKcgSK0FuvEvYHcEHsHoJKB7V/jfZwHYThVe6zh
	 mEyQIbt0sGO8fK7iaC6oBO1ZW18qYAeanjANc4+cjl6qai9oBZoiLj2m+0+1+7qYyf
	 z5x5bactR5AayqEjE0vEsEcMi+oU1HhpWThQexZ/06lv4E018V85d40IksbnRWyH48
	 t6/KGJfu9TPd+1+LvbSbG25VQ8uab0zIG9nGW6emLuZP2RMsYwAQvs4bqIrDmt7+Np
	 +ARonfwFMfW6BIV43xqd/2qc2pljtBTQrC1NRzyemygI0ykgm36QxbsDWqT6iRFxi7
	 tph9TTyhBq09w==
From: Jakub Kicinski <kuba@kernel.org>
To: mhun512@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	khc@pm.waw.pl,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com
Subject: Re: [PATCH net v2] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Wed,  5 Aug 2026 19:05:42 -0700
Message-ID: <20260806020541.2011936-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803133048.42650-1-mhun512@gmail.com>
References: <20260803133048.42650-1-mhun512@gmail.com>
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

Could you make a patch series which fixes all the bugs reported
here which look real?
---
This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wan: fsl_ucc_hdlc: release HDLC device on remove

The patch makes ucc_hdlc_remove() unregister and free the HDLC netdev
before freeing the ucc_hdlc_private object, and adds dev_close() to the
generic unregister_hdlc_device() helper so ndo_stop runs while the HDLC
protocol is still attached.

Link to v1: https://lore.kernel.org/netdev/20260728171545.49247-1-mhun512@gmail.com/

> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 809f21fb93f56..4c843c94cf436 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
>  {
>  	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
>  
> +	unregister_hdlc_device(priv->ndev);
> +
>  	uhdlc_memclean(priv);

[ ... ]

> diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
> index cbed10b1d862e..a38f90d3006ed 100644
> --- a/drivers/net/wan/hdlc.c
> +++ b/drivers/net/wan/hdlc.c
> @@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
>  void unregister_hdlc_device(struct net_device *dev)
>  {
>  	rtnl_lock();
> +	dev_close(dev);
>  	detach_hdlc_protocol(dev);
>  	unregister_netdevice(dev);
>  	rtnl_unlock();

[Severity: Medium]
Should this hunk be a separate patch?  The subject is scoped to
fsl_ucc_hdlc and the Fixes tag points at c19b6d246a35, but
unregister_hdlc_device() is exported generic HDLC code with eight other
callers: c101_cleanup(), n2_destroy_card(), pc300too_remove_one(),
pci200syn_remove_one(), wanxl_pci_remove_one(), hss_remove_one(),
qmc_hdlc_remove() and farsync's fst_add_one()/fst_remove_one().

For all of those, detach_hdlc_protocol() -> hdlc_setup_dev() previously
cleared IFF_UP:

drivers/net/wan/hdlc.c:hdlc_setup_dev() {
	...
	dev->flags		 = IFF_POINTOPOINT | IFF_NOARP;
	...
}

so netif_close_many() dropped the device and ndo_stop never ran.  After
this change every one of those drivers runs its close routine during
unregister.  Were the other users audited?  The changelog does not say,
and with Cc: stable plus a driver-only Fixes tag the core behaviour
change lands in stable as if it were an fsl_ucc_hdlc-only fix.

One call site that looks worth a sentence in the changelog is the
farsync error unwind:

drivers/net/wan/farsync.c:fst_add_one() {
	...
rx_dma_fail:
	fst_disable_intr(card);
	for (i = 0 ; i < card->nports ; i++)
		unregister_hdlc_device(card->ports[i].dev);
	...
}

Here fst_close() can now run after fst_disable_intr() and after the rx
DMA buffer has been freed.  Was that considered?

[Severity: High]
This isn't a bug introduced by this patch, but the function this hunk
newly drives can dereference a NULL protocol pointer.  uhdlc_open()
calls uhdlc_close() precisely when hdlc_open() failed:

drivers/net/wan/fsl_ucc_hdlc.c:uhdlc_open() {
	...
		rc = hdlc_open(dev);
		if (rc)
			uhdlc_close(dev);
	...
}

For a freshly probed device the only failure hdlc_open() can return is
the no-protocol case, since ucc_hdlc_probe() only calls
register_hdlc_device() and never attaches a protocol:

drivers/net/wan/hdlc.c:hdlc_open() {
	...
	if (!hdlc->proto)
		return -ENOSYS;	/* no protocol attached */
	...
}

uhdlc_close() then calls hdlc_close() unconditionally, and hdlc_close()
has no NULL check.  hdlc->carrier is initialised to 1 in hdlc_setup(),
so hdlc_proto_stop() reads hdlc->proto->stop, and the tail of
hdlc_close() dereferences hdlc->proto again:

drivers/net/wan/hdlc.c:hdlc_close() {
	...
	if (hdlc->carrier)
		hdlc_proto_stop(dev);
	...
	if (hdlc->proto->close)
		hdlc->proto->close(dev);
}

Can "ip link set hdlc0 up" before any IF_PROTO_ ioctl oops here?  Peer
drivers such as c101_open() and fst_open() call hdlc_open() first and
just propagate the error without entering their close routine.  Since
this patch makes hdlc_close() reachable from the unregister path too,
would it make sense to fix this at the same time, either by calling
hdlc_open() before the hardware is enabled or by making hdlc_close()
tolerate a NULL proto?

[Severity: High]
This is a pre-existing issue, but the new dev_close() gives it a second
trigger, and this one runs with rtnl_mutex held.  uhdlc_suspend()
disables NAPI and can then return an error without re-enabling it:

drivers/net/wan/fsl_ucc_hdlc.c:uhdlc_suspend() {
	...
	napi_disable(&priv->napi);
	...
	priv->ucc_pram_bak = kmalloc_obj(*priv->ucc_pram_bak);
	if (!priv->ucc_pram_bak)
		return -ENOMEM;
	...
}

The PM core does not call resume for a device whose suspend failed, so
the device stays running with NAPI disabled.  uhdlc_close() then calls
napi_disable() again:

drivers/net/wan/fsl_ucc_hdlc.c:uhdlc_close() {
	...
	napi_disable(&priv->napi);
	...
}

and the wait in napi_disable_locked() has no timeout or alternative exit
condition:

net/core/dev.c:napi_disable_locked() {
	...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

Those bits are only cleared by napi_enable(), which never runs on that
path.  With this patch the call chain becomes ucc_hdlc_remove() ->
unregister_hdlc_device() -> rtnl_lock(); dev_close() -> netif_close() ->
uhdlc_close(), so can an unbind or module removal after a failed suspend
spin forever while holding rtnl_mutex?  Would fixing uhdlc_suspend() to
call napi_enable() before returning -ENOMEM be preferable to leaving
this reachable from the unbind path?
-- 
pw-bot: cr

