Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35E606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIfq0H3m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXv602sqgz2yRn;
	Mon, 23 Nov 2026 16:05:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795410344;
	cv=none; b=QDurLdsz56kt+ffcACscWzL9mDG21ELXDqVDoQRk6RZW0lTelxgNk6Mff3BEqU7+hAaWiHNV3CAhUBtDzpSiA/J9JC6+zM8YTXfaAOW42SxozA5OQwqBwVdVV7gywsgGn8rJZUEQ33OK1TONJXbskan1OMxeEHqh6rbC9zeHlTw36ufWlKczTB9XlpEiuGdTNNuJ2hUdYtRnsHycZFmCqORHFih0Gcu47vBmT+9bUN6lIg6Jvy9X12SgKWRfz7zvKaimAMicWwq+0o+5Q8pn+YqHjhYeG7sQEMts0zyT82p3FPG+NZkZ3WbXL60M/1eUzm9C+Tt/4O1/AI2zTkMMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795410344; c=relaxed/relaxed;
	bh=w8e+3WRbDOUCO3CM0bxDt3Ty+eAqQazN2XhtHI1VjrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8We6/mzGWatqJbpIgQ8ZkI0tS15jMq047Y0gJgWGw16sw7r5OHm5O0xGPNyiQzR6Px54hf6rn/Cpscnl9pOScNZ9vcN8hnihOgFnQEyCU+vYWrU5DU31aSaUFG9po0yFVZ0TlvYTaizhkxG40bh5rmHYrGL14Yp/6W9FwBJJNqHIKfGk7Uolqcvhdqe8retJ7bvTG2f17Xg8G+0/V8cV795eOB2+Uu3TQP9+qmCjCNP1hK5KJfHacw8eIVi2gUlrBw0iYsExG8JyzCDnPcaDut6T9ntnHOnBLX0JNF1FO5JBZrucfAsGxaRO/C9g2axsNuGArNTNmVg2cOmsUsVTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIfq0H3m; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIfq0H3m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXv5y6v4tz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 16:05:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 77D9F42378;
	Mon, 23 Nov 2026 05:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4456F1F000E0;
	Mon, 23 Nov 2026 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410340;
	bh=w8e+3WRbDOUCO3CM0bxDt3Ty+eAqQazN2XhtHI1VjrY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lIfq0H3mK5sdaXj7zpLKBnPA2do9QNohK1yaRLNQiyO7eS0fXUg9pBdBoDW7P291k
	 4x/EjDSsoVzpOWWBM6VzOLiK5blWykSpjzCrGJ8DXb1Qh1B/nEPUT/0eGCcEtSKspA
	 UipdOChW9Y4o97ga1GdoH9hDa1He8EWgsXBG/2hzCBk2UInmFBAlW/F6cwJDPyLNuE
	 MspTK+f3Iye+CIjptOZlpfGK7fXh/a4uVfF4H94Jz1v9TVdBDZs9QV/1iYOYRD9Xj1
	 pUt5oLDTGCsBA/a2sSy1zBvzzYDiDxDy55h7sx3KPJKuNeYHyhf9Z/D0hMXfN5TMq1
	 4WwX+kdsxFHAw==
Subject: Re: [PATCH v8 net-next 8/9] net: dsa: netc: add PTP two-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 23 Nov 2026 05:05:38 +0000
Message-ID: <179541033885.3135.10657211800089692875@kernel.org>
In-Reply-To: <20261119030534.1892935-9-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-9-wei.fang@oss.nxp.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] netc_port_del_ptp_filter() (drivers/net/dsa/netc/netc_ptp.c)
  handles every error from ntmp_ipft_delete_entry() as "the entry is…

--

net: dsa: netc: add PTP two-step timestamping support

This adds two-step TX timestamping and RX timestamping for the NETC
switch. For RX, IPFT rules trap PTP frames to the CPU port with an
ingress timestamp. For TX, the driver queues the skb clones and matches
them by request ID against hardware response frames delivered through a
new tagger callback.

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> new file mode 100644
> index 0000000000000..bd4d0b70e7ee5
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_ptp.c
> @@ -0,0 +1,502 @@

[ ... ]

> +static int netc_port_del_ptp_filter(struct netc_port *np)
> +{
> +	struct netc_switch *priv = np->switch_priv;
> +	int ret = 0;
> +	int err;
> +
> +	for (int i = 0; i < NETC_PTP_MAX; i++) {
> +		if (np->ptp_ipft_eid[i] == NTMP_NULL_ENTRY_ID)
> +			continue;
> +
> +		/* No -ETIMEDOUT here: with the command BD ring enabled, the
> +		 * hardware execution time for a command is much less than
> +		 * 1ms, so no timeout error will occur. Any remaining error
> +		 * means the entry is still present in the table.
> +		 */
> +		err = ntmp_ipft_delete_entry(&priv->ntmp,
> +					     np->ptp_ipft_eid[i]);
> +		if (likely(!err)) {
> +			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
> +			continue;
> +		}
> +
> +		ret = err;
> +		dev_err(priv->dev,
> +			"Delete PTP entry 0x%x (type %d) on port %d failed\n",
> +			np->ptp_ipft_eid[i], i, np->dp->index);
> +	}

[Severity: Low]
Is the claim in this comment guaranteed by the NTMP layer? The delete
goes through this path:

netc_port_hwtstamp_set()
  netc_port_set_ptp_filter()
    netc_port_del_ptp_filter()
      ntmp_ipft_delete_entry()
        ntmp_delete_entry_by_id()
          netc_xmit_ntmp_cmd()

netc_xmit_ntmp_cmd() hands the BD to hardware and only then waits:

drivers/net/ethernet/freescale/enetc/ntmp.c:netc_xmit_ntmp_cmd() {
    ...
	i = (i + 1) % cbdr->bd_num;
	cbdr->next_to_use = i;
	netc_write(cbdr->regs.pir, i);

	err = read_poll_timeout(netc_read, val,
				(val & NETC_CBDRCIR_INDEX) == i,
				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
				true, cbdr->regs.cir);
	if (unlikely(err))
		return err;
    ...
}

If the consumer index does not advance within NETC_CBDR_TIMEOUT, this
returns -ETIMEDOUT. The hardware may still run the DELETE after that.

In that case np->ptp_ipft_eid[i] is kept. netc_port_current_rx_filter()
would then report an rx_filter that is no longer installed. The commit
message says this design avoids exactly that:

  "so a delete or rollback that fails partway does not leave software
  reporting a filter that no longer matches the hardware."

Every later netc_port_set_ptp_filter() also starts by deleting the stale
entry ID. If the hardware rejects deleting a missing entry (the response
error status maps to -EIO), could every later hwtstamp_set on that port
fail until the switch is set up again?

This needs the hardware itself to stall, because read_poll_timeout()
reads once more after the deadline. The host-flood path added earlier in
the series by "net: dsa: netc: check return value of
ntmp_ipft_delete_entry()" makes the same assumption. This patch adds a
second user whose reported state depends on it.

Should -ETIMEDOUT be handled separately here, for example by treating
the entry state as unknown? Or should the comment say this is an
assumption about the hardware rather than a guarantee?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119030534.1892935-1-wei.fang%40oss.nxp.com

