Return-Path: <linuxppc-dev+bounces-19249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10645CC6B3F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:17:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16k20hbz2ypW;
	Fri, 03 Apr 2026 12:17:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179054;
	cv=none; b=FsncuI3SBmczt08TZg91Yv9nb5g9w/9ugQkpgnHd3itnhNGlX2ym13ngyK0hEgdBrco+pYEaboaPVN71xdxm0K+GEjg8DU51jWtmGGzizcWLU214lvoCRXf7E8WwPUPuHKU2J88W7RQIoW1qmhajvQ9VzNiIBrThg8w46HN7aIN98EXr4/81QAEq87y5h9Pj5S0Ku/6MRNquxbWrv3wKe076/VzGN1m4Ptx4VEVoiY1+wVUL9iuA31JyL7ptu1z71b+PTzF9qn0685wqwW0wAJsE7iiQD9UZRkJKMIh4bnieln8GmzCBYAwj1QhBIHJTxfICFZoJoKnIpp3v2x3WxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179054; c=relaxed/relaxed;
	bh=FxQv7s5Odq+vZQmZIotCiow9lCNZu5hiBKdpZB9SFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRG0En6BL0uOnhOSoK1p2IqtEjEyKCRJ3NL+0jisFWH1j88/FionAjCPRyhe7xnNAUsn5QhfFkvtCxJz+GzFcNIs9v/CVhj5762oqHHzIDfaNn99pJUIQuv9lEOUQ1Hr42YZIpbVZAR+gDLVT5TUO8PZSeA5zek3NpXa2iu2qOLctEM/zgJmbd8mqsqQZ/mv4t1bmdSjO0DTCwJl5bQRlAMZDRFOzL5ZfRCS8UMD/iizVUnEM15f7hkypmHPYh5JxAnYAlM+9AQ0Z3Q6hH0YuRYumK4YmCKujVXsI+Q9N6dHrcqX6C56/mM8arZ3/WHpcwnwatg7YL0I1ZdCxkGx1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MdV9augW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MdV9augW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16j37cTz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 933D743488;
	Fri,  3 Apr 2026 01:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F30C19423;
	Fri,  3 Apr 2026 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179051;
	bh=z2oeBslkWxXFxUEpEWFwllAfQCf4n0yeC2tozbEVTlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdV9augW1jHZqVwnMVXugkgpU/OawSUTlXxgNHgItjcvmIUEWW2w4w5xit2HBBHif
	 0fr72BN15tfROcp/toAKBSg3iE65TFpJFCcgkJUUaNiLqsV4WKBJDI9DCEXedvzy49
	 FTgxWeo/a4aqiTElWJ/eegm2i4dVWVTQE1H1yvhkR3wBVxXxKBkQOuNPC/XC/yU+vv
	 LbxdimGIxIU1xU63GXKAh67M9AkUVRJmZa5OIJiisn/mSYglYqNtSwW0QWjlM82RXp
	 xYJe9TtgRr/AmJ3hxt7+XnkZQzPJqiUi6t+IFzrNdoJAoCmx2OSwm3w5oqP4a+TuDy
	 UcQy18A1RR15A==
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
Subject: Re: [PATCH v4 net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Thu,  2 Apr 2026 18:17:29 -0700
Message-ID: <20260403011729.1795413-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-6-wei.fang@nxp.com>
References: <20260331113025.1566878-6-wei.fang@nxp.com>
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
net: enetc: add support for the "Add" operation to VLAN filter table

This patch adds the ntmp_vft_add_entry() helper function to support adding
entries to the VLAN filter table. It allocates a DMA buffer, formats the
request, and transmits it via the command BD ring using netc_xmit_ntmp_cmd().

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c

[ ... ]

> @@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
> +int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
> +		       const struct vft_cfge_data *cfge)
> +{
> +	struct ntmp_dma_buf data = {
> +		.dev = user->dev,
> +		.size = sizeof(struct vft_req_ua),
> +	};
> +	struct vft_req_ua *req;
> +	union netc_cbd cbd;
> +	u32 len;
> +	int err;
> +
> +	err = ntmp_alloc_data_mem(&data, (void **)&req);
> +	if (err)
> +		return err;
> +
> +	/* Request data */
> +	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
> +		      NTMP_GEN_UA_CFGEU);
> +	req->ak.exact.vid = cpu_to_le16(vid);
> +	req->cfge = *cfge;
> +
> +	/* Request header */
> +	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
> +	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
> +			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
> +
> +	err = netc_xmit_ntmp_cmd(user, &cbd);
> +	if (err)
> +		dev_err(user->dev,
> +			"Failed to add %s entry, vid: %u, err: %pe\n",
> +			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
> +
> +	ntmp_free_data_mem(&data);

Does this code safely handle hardware timeouts?

If netc_xmit_ntmp_cmd() times out and returns an error, the pending
transaction is not explicitly aborted before ntmp_free_data_mem()
unconditionally frees the DMA buffer.

Could the hardware eventually process the pending command and perform a
DMA write of the response to the physical address of the freed buffer?

This might lead to silent memory corruption if that memory has already
been reallocated to another subsystem. Would it be safer to explicitly
abort the pending DMA transaction, reset the device on timeout, or
intentionally delay freeing the buffer until it is proven safe?

> +
> +	return err;
> +}

