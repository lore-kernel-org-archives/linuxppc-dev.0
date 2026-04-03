Return-Path: <linuxppc-dev+bounces-19250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D3AD6AB1A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:17:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16n0M1qz2yr0;
	Fri, 03 Apr 2026 12:17:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179057;
	cv=none; b=nIF2lLTreVBORW5ocZD6dd8RMMcgr29SM6VOOv/40Ng9169YzSleZmF5JDIMCcs9sPR/f1Uc72fOiWYx27z66Y9XR6rwgtVWZUm13hmcpzaG1RsqNPQTOLD/37+9xcLRluQtAkrY0bPDWDAcrct0D7xI7CCOCUZD6Wcn6tlYwK9UepzwVZn8R+BSEIYZzSXQsswsGxKmpA5gWiX2gZezvPbQ9bxHWgjjADKmcukHdMOQXXgT+/fGjKnBHk6ALNI5FE4AqIsHbtn+isPAwfPItzmj7LgGZ2hnqTKmtseciDC1OzIXQ8AF7RkVZzFJOeHzj50q16SjEHprPyR6V67KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179057; c=relaxed/relaxed;
	bh=q6YaZNE7pOlYEWI69TmOBoEfHRzSwR+IqGqAPhEKmmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOggYLsXjGD0ygdUQIPEbhgsnlVBimpeRaPsrrdERqgXjcI5WlkCmiXmX64BDhDAhJHktott6A4bkF4bdw4Dn0LtokBrP9aF23fp+v4fi3C1mW8toR7iujcg3AZQmWLmlhDEe9k859nJQ9/kqoV8w+MjZbg0ItGSE7KMCXu4tG6e83UJbCnJ/R39USGm+phbezeGHp/+cBfilcCyyr1TDKpmuc6nkOHPRchWzvKo43NigWhe6d3ypGV5o4NJIdLJDeclrkJl8XIusO+uOOvbeII34CFSWVb2Ai82Mdi2xvOHm0IYUeXgdWmIAQReLVwG1f4Yt5ULKmQnkPvF3kGMgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bhn8oIIZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bhn8oIIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16m1fhGz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 31FBC60127;
	Fri,  3 Apr 2026 01:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBD8C2BCB0;
	Fri,  3 Apr 2026 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179053;
	bh=IjIkp8FIjKATBd7jIiPxzeFBb13nS3nzbxHI2WLxLcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhn8oIIZoi0uI1nny0o2U/uU6bOCJ18EbsQFHJ0o0GygSh3+ENa6fhY3GkI0iCyrk
	 hvVgRxi2ktGgQpzlhRDKy98XX4MVSOAfFRM+p4jch8H2GsIVb9dzK1cGJCOUi5ygf2
	 /zOVHYommileHwaqOG+qtdlo3PjQgRKaJZmBdONj2ZpJKjMzVjNCNRSSYy7nlRanPt
	 ephSAaiMHZ5HoXUqb6WA18U3xq4DgD7nCALIJx9ExdA/06yMAS/aIwjVovYbnsafvJ
	 3F3sK3c3VM8Lr6N0yIRau3XhtEvyeowJ7vTYz5vsTyZehYj057yx8SK4Z0NoGIaukV
	 n1lmuT0ONOs7A==
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
Subject: Re: [PATCH v4 net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Thu,  2 Apr 2026 18:17:31 -0700
Message-ID: <20260403011731.1795517-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-7-wei.fang@nxp.com>
References: <20260331113025.1566878-7-wei.fang@nxp.com>
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
Subject: net: enetc: add support for the "Update" operation to buffer pool table

This patch adds the ntmp_bpt_update_entry() helper function to support
updating a specified entry in the buffer pool table. It provides the
ability to update buffer pool configuration data.

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> --- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h

[ ... ]

> +/* Buffer Pool Table Request Data Buffer Format of Update action */
> +struct bpt_req_update {
> +	struct ntmp_req_by_eid rbe;
> +	struct bpt_cfge_data cfge;
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c

[ ... ]

> @@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
>  }
>  EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
>  
> +int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
> +			  const struct bpt_cfge_data *cfge)
> +{
> +	struct ntmp_dma_buf data = {
> +		.dev = user->dev,
> +		.size = sizeof(struct bpt_req_update),
> +	};
> +	struct bpt_req_update *req;
> +	union netc_cbd cbd;
> +	int err;
> +
> +	err = ntmp_alloc_data_mem(&data, (void **)&req);
> +	if (err)
> +		return err;
> +
> +	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
> +			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);

Does this update action mask match the size of the request buffer?

The mask includes both NTMP_GEN_UA_CFGEU and BPT_UA_BPSEU, which instructs
the hardware to update both the configuration entry and the status entry.
However, struct bpt_req_update only contains the configuration data,
omitting the status data.

If the hardware attempts to read the missing BPSE data, could it reject
the command due to an undersized request length, or read beyond the
intended payload into zero-initialized DMA padding? This might overwrite
critical buffer pool tracking variables like amount_used_hwm.

If only the configuration is being updated, should the BPT_UA_BPSEU flag
be removed?

> +	req->cfge = *cfge;
> +	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
> +			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
> +
> +	err = netc_xmit_ntmp_cmd(user, &cbd);
> +	if (err)
> +		dev_err(user->dev,
> +			"Failed to update %s entry 0x%x, err: %pe\n",
> +			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
> +
> +	ntmp_free_data_mem(&data);

Can this result in a DMA use-after-free if the hardware command times out?

If netc_xmit_ntmp_cmd() times out waiting for the hardware to process the
command, it returns -ETIMEDOUT without resetting the hardware ring or
explicitly cancelling the command.

The descriptor remains active in the ring, and ntmp_free_data_mem()
unconditionally frees the DMA-mapped buffer. If the hardware eventually
processes the descriptor, it will read from the now-freed DMA memory.

Could this lead to an IOMMU fault or cause the hardware to read garbage
data if the page has been reallocated?

> +
> +	return err;
> +}

