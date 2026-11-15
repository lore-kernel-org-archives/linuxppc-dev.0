Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210F606A31D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDfdSkQN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS2Yp10Sqz2xRm;
	Sun, 15 Nov 2026 18:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794727470;
	cv=none; b=mR229q38gkYuu5TJhshyDxwHTdl7fLfL25Fs1A+j5doIsh61CiuAWU7/CsgLJhBEz4D4UzK9+U1cXAzZoMGFr7IB8LVMMo9KzyL2Kr1AXI4tbZ8ljK6WsNljZG4vmHXPOR3QTxh/ANgFFGsIqEUzOdw3gyWxWbxCmyeoux8QPql0cf8fw6GZ8P31fli63sLpeQtnMnjWHrwM0i/mZ0xsC7xMlX0Egc1mpstsCFLqRZHI+Lir4BmnrwOuok08wJ2wO6Z7ALAyxTopUkekZn5eqCbZUWP8t/AG+NYQPB3l7GIGNoc4LQf+h9xD3v4ANzHhesdduMhIOomIHsEaZ6uPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794727470; c=relaxed/relaxed;
	bh=NzpBRw/cBkBhGgg5TTiPsQ+nsl4pu7G97F49dIghoks=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQwL1bVatRNUNkGJspxALWc2wKQpkygGlyPxs07IfAeyJMNp/sImcidHaXVpq0Tp7Y6Lu1yxGMRiDJxzI0LP/jdpxCuCnW4HVPeaNuN0K96d0F5zdgbA5iqFMnKssh34uYegRITAc3cU5nxtuVvXLN9W5QTFLj9sZIMNzTz1fvHF05LHRh5CuFFOnRioC8uhYsGreCZaF7BSCX9XdoG1S9kEdRlX8v2T9bMSccVCS+52GLUSdSTjUjKeoPwUfVfNXYgKZsOPZUiU+6ZhRQR83mXM4xN8IZmstrWiD451eMj83VNXWbJGIjePWW8ZvXuUbRhZdN2XOIaYfdgnOfJgAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDfdSkQN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDfdSkQN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS2Ym6qPGz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 18:24:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B459C60CF7;
	Sun, 15 Nov 2026 07:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815CF1F000C4;
	Sun, 15 Nov 2026 07:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727466;
	bh=NzpBRw/cBkBhGgg5TTiPsQ+nsl4pu7G97F49dIghoks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eDfdSkQNh1lPjw015Splx3gPWiIVtpKuozkc9f7ptmS8U5jifBLBq29LFmeK6rDoQ
	 HqNK+c4xZVVvkdXR1fuMvjE3k1+c2hYzHGEsaoWcD5KVvNK+s7yDfFLgELibpBtmgW
	 JKx5k4iIS0dVnPhszuxMvoB/2fFLA5RlyMjhmKI4EI6XTmNHkJlgT41ja0wAgevt/4
	 i/XQntGJDMRKhFmWCPN8Q18duYH3juIRoCFMz3/voMvNGNbgQ0+wjXWDE9oTtYjD4d
	 1kkQcJVUhPkRDLurQzaMYbi5Frvx3SYtADB/Nn7TEOKsoE+d1JaBiSY3aPD3Bt8viY
	 Ct0cgORoJdbQQ==
Subject: Re: [PATCH v7 net-next 6/9] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Sun, 15 Nov 2026 07:24:25 +0000
Message-ID: <179472746510.2199510.5500169981091992734@kernel.org>
In-Reply-To: <20261111062753.1397582-7-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-7-wei.fang@oss.nxp.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netc_port_remove_host_flood()
  (drivers/net/dsa/netc/netc_main.c:1874-1898) keeps np->ipft_hf_eid on…
- [Medium] The new retry loop in netc_port_set_host_flood()
  (drivers/net/dsa/netc/netc_main.c:1943-1952) sends another IPFT ADD…
- [Low] The commit message says that if adding the new host flood rule
  fails, the driver will "log an error to help users find out why host…

--

net: dsa: netc: check return value of ntmp_ipft_delete_entry()

This patch makes netc_port_remove_host_flood() return errors from
ntmp_ipft_delete_entry(), and it only clears the tracked entry ID after
the delete succeeds. Host flood rule replacement changes from
add-then-delete to delete-then-add, with a retry loop on the add. Bridge
join now fails if the existing host flood rule cannot be deleted.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index d23cfa076e842..6756bf9edfdb2 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -1877,32 +1871,37 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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
> +	/* The command BD ring is always enabled here, with the ring
> +	 * enabled, the hardware completes a command well within 1 ms,
> +	 * so -ETIMEDOUT cannot happen here. Any error therefore means
> +	 * that the entry has not been deleted, so keep tracking it.
> +	 */
> +	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> +	if (err)
> +		return err;

[Severity: Medium]
Does the NTMP command layer actually guarantee what this comment assumes?

ntmp_ipft_delete_entry()->ntmp_delete_entry_by_id() passes back whatever
netc_xmit_ntmp_cmd() returns. In netc_xmit_ntmp_cmd() in
drivers/net/ethernet/freescale/enetc/ntmp.c, the BD goes to hardware
before the completion poll starts:

	netc_write(cbdr->regs.pir, i);

	err = read_poll_timeout(netc_read, val,
				(val & NETC_CBDRCIR_INDEX) == i,
				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
				true, cbdr->regs.cir);
	if (unlikely(err))
		return err;

On -ETIMEDOUT the BD stays queued, so hardware could still carry out the
delete later. NETC_CBDR_TIMEOUT is exactly the 1 ms this comment relies
on, with no margin.

The -EIO returns (NETC_CBDRCIR_SBE and the writeback error status) are
only raised after hardware has consumed the BD. Only -ENOMEM and -EBUSY
seem to prove that the command never reached hardware.

Suppose the delete did take effect but np->ipft_hf_eid is kept. Wouldn't
every later delete of that ID fail?

In that case netc_port_set_host_flood() would always return early. Also,
netc_port_bridge_join() would always fail with "Failed to delete host
flood rule", so the port could not join a bridge again until the driver
is reloaded. Before this patch, the error was ignored and the state was
cleared.

IPFT entry IDs are assigned by hardware. Could a freed ID be reused by
another rule? Examples are the PTP trap entries tracked in
np->ptp_ipft_eid[] later in the series, or another port's host flood
rule. A later netc_port_remove_host_flood() would then silently delete
that unrelated entry and report success.

The commit message's statement that "the software state always stays
consistent with the hardware" seems to depend on this assumption holding.

[ ... ]

> @@ -1919,19 +1923,33 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,

[ ... ]

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

[Severity: Low]
This isn't a bug, but the commit message only says it will "log an error
to help users find out why host flooding is not working". Neither the
commit message nor a code comment mentions this retry loop with
usleep_range(). Could the reason for it be documented?

The loop retries no matter which error code is returned. Errors that will
fail the same way again, such as -EIO from a writeback error status when
the table is full, get retried too. Each retry also widens the
delete-to-add window that the commit message calls "very short".

The other add sites don't retry: the restore path in
netc_port_bridge_join() and the add in netc_port_bridge_leave(). Is that
difference intentional?

[Severity: Medium]
Can this retry leave an untracked IPFT entry behind?

netc_port_add_host_flood_rule()->ntmp_ipft_add_entry()->netc_xmit_ntmp_cmd()
writes PIR before polling. On -ETIMEDOUT, or on -EIO after the BD has been
consumed, hardware may still carry out the ADD. In that case
ntmp_ipft_add_entry() returns before reading back the entry ID:

	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
	if (err) {
		...
		goto unlock_cbdr;
	}

	resp = (struct ipft_resp_query *)req;
	entry->entry_id = le32_to_cpu(resp->entry_id);

netc_port_add_host_flood_rule() also records np->ipft_hf_eid only on
success.

The retry then queues another ADD. If that one succeeds, only its ID is
tracked. Up to two FLTFA=REDIRECT / NETC_HR_HOST_FLOOD entries keyed on
this source port could be left with no tracked ID. ntmp_ipft_delete_entry()
would never remove them.

netc_port_bridge_join() deletes only np->ipft_hf_eid, so such an entry
would survive bridge join. The comment at the top of
netc_port_set_host_flood() says this kind of entry sends bridged ingress
frames straight to the CPU, which skips FDB lookup and learning.

Isn't this the untracked-entry problem the commit message says the patch
removes? The -ETIMEDOUT argument in netc_port_remove_host_flood() covers
only the delete path, but this loop retries the add on any error code.

> +
> +		dev_err(ds->dev,
> +			"Failed to add host flood rule on port %d\n", port);
> +	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111062753.1397582-1-wei.fang%40oss.nxp.com

