Return-Path: <linuxppc-dev+bounces-29354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A21CC6B08
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3rsN0FBpz3bwd;
	Tue, 13 Oct 2026 21:58:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791889079;
	cv=none; b=c473+Bsda4ZCX8W7/d7H6+9V+Rk5M8c97WuJ2fsUSjbXvdVnlFls89S45QKsDbmWBpSvHb4NfIL7/hk/HwL0eWYZwpSCcrTPGljp5zPZNUz3kPYHJbS6+737RZJFSmOLwMXmKDTUtbLCT+uZU8rwiyH/X3fX3vq0f+RtlOo37qI5VMGWGFIKOUNE47Ni0S46W5bY62FIZyfZOpjmpjeQc1fE7nlG9z639g8PftE8bL7D0WHJa8iWKOcVa5+LiQchEMiHy0nIHU0Kjji6XaUYWjNHkfIKECgszRbKH89S4TJ2TNuzwwDYY38d7jW3Q9glslUfPzGdK4j/52T/dAMUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791889079; c=relaxed/relaxed;
	bh=VJhU1qBrBVbAOFYCePkgAk69lkNrGBLNq3G7BdVn93M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Io/wdGfi9G+CN5wFVknr0p5pGpkyOuxJ3m2ZPG+g+W/8Sn2x+k+GR64KH3wQR8WmLnFPxsDZCcWlWLGKgpSr0W1ebIcauC44OlBBsEm1yHY1LiIEdbe8zncdLV+kS7ltc5w7eyfwqkBKDNxoyCNlOkZ2LtrZ3q0bjgmtq56w6WBcpCU+EbWUIvo35ItGI4rfCSEheiQ+cKyi31BBMu32qz4uxiJXA/t1MRPGwon7XSBDHWjcRZ0MkzzE+YEsy/waDpVefqlEhidfs7t7/sZmeFy4grRD/WvHY3ZyRIfu5sa1CRAlcbo3GDRkYjuykwxeyW7rHB5PPVKWD3avinmw6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuybJzBb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuybJzBb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3rsL5B5rz3bsP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:57:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A2E360A6B;
	Tue, 13 Oct 2026 10:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0188B1F0089A;
	Tue, 13 Oct 2026 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889075;
	bh=VJhU1qBrBVbAOFYCePkgAk69lkNrGBLNq3G7BdVn93M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UuybJzBblO6oJ97g5jgv8dO8qHJdBItSYlXIXKMygJypJMdxjghhRRAg0JJMEPfYM
	 CmSquNoHGjh+JVr/N8wTPyrPSNZlk1NXDP6jl+gmr0LlXKyyRSWNnp0mdKiVRXCIqN
	 GvStM3z+l/gSzytgAu12kZSYG3numKLVU8ogvonQIk0pKTnr32SFxfG2CoSDAqH41P
	 uFNrZre2Sy6HL3TluCBLqyuuNLzqcNu80pkgLgg/oY05q10W95Ok0T693b7OMZynNi
	 3QzF7lCFZQDT34iunO2gBaxtaUUpBH5m0Qb9ZSqIw2CNW9tXUYo7iCshMeW6Gbs7g1
	 UCeH7Pg1/bspw==
Subject: Re: [PATCH v5 net-next 8/9] net: dsa: netc: add PTP two-step
 timestamping support
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Oct 2026 10:57:54 +0000
Message-ID: <179188907456.434549.2930790264143047960@kernel.org>
In-Reply-To: <20261012095924.1129312-9-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-9-wei.fang@oss.nxp.com>
X-sashiko-severity: High
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NULL pointer dereference on the netc_setup() error path, in
  netc_free_all_ports() (drivers/net/dsa/netc/netc_main.c).
- [Medium] The comment in netc_port_del_ptp_filter()
  (drivers/net/dsa/netc/netc_ptp.c, line 139) says: 'No -ETIMEDOUT here:…
- [Medium] netc_get_ts_info() (drivers/net/dsa/netc/netc_ptp.c) never
  sets SOF_TIMESTAMPING_TX_SOFTWARE.
- [Low] Switch timestamping stays armed after the NETC PTP timer is
  unbound.

--

net: dsa: netc: add PTP two-step timestamping support

This adds two-step TX timestamping and RX timestamping to the NETC DSA
switch driver. RX timestamping installs IPFT rules that trap PTP frames
to the CPU with a To_Host tag that carries the timestamp. Two-step TX
uses per-port request IDs, which a tagger callback matches against the
hardware response frames.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 1a7103fe1e343..cb262ae5ba796 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -277,6 +291,11 @@ static void netc_free_all_ports(struct netc_switch *priv)
>  		if (!np)
>  			continue;
>  
> +		if (np->dp && dsa_port_is_user(np->dp)) {
> +			disable_delayed_work_sync(&np->tstamp_timeout_work);
> +			netc_port_purge_tstamp_queue(np);
> +		}
> +

[Severity: High]
Can this hit an uninitialized tstamp_queue on the netc_setup() error
path?

In netc_init_all_ports(), np->dp is set before
netc_port_get_info_from_dt() and netc_port_create_mdio_bus() are called.
Both can fail and jump to free_all_ports before netc_port_ptp_init()
runs:

	dsa_switch_for_each_available_port(dp, priv->ds) {
		np = priv->ports[dp->index];
		np->dp = dp;
		...
		err = netc_port_get_info_from_dt(np, dp->dn, dev);
		if (err)
			goto free_all_ports;

One example is of_clk_get_by_name() returning -EPROBE_DEFER for the "ref"
clock. Probe deferral is a normal event at boot.

The port struct comes from kzalloc_obj(). That leaves tstamp_queue.next
and .prev NULL and tstamp_lock zeroed, and tstamp_timeout_work was never
initialized. The new check above is still true for that port, so we get:

netc_free_all_ports()
    disable_delayed_work_sync(&np->tstamp_timeout_work)  <- work->func is NULL
    netc_port_purge_tstamp_queue()
        spin_lock_bh(&np->tstamp_lock)                   <- never initialized
        skb_queue_splice_init(&np->tstamp_queue, &free_list)
            skb_queue_empty() returns false (next is NULL, not &list)
            __skb_queue_splice()
                first = list->next;          /* NULL */
                WRITE_ONCE(first->prev, prev);

This looks like a NULL pointer write in __skb_queue_splice(), preceded by
WARN splats.

The later one-step timestamping patch in the series leaves both
netc_free_all_ports() and the order in netc_init_all_ports() unchanged,
so the problem remains at the end of the series.

Could netc_port_ptp_init() be called before the steps that can fail? The
other option is to record whether it ran and check that here.

>  		netc_port_free_emdio_bus(np);
>  
>  		if (!IS_ERR_OR_NULL(np->ref_clk)) {

[ ... ]

> diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
> new file mode 100644
> index 0000000000000..756c69a02064e
> --- /dev/null
> +++ b/drivers/net/dsa/netc/netc_ptp.c

[ ... ]

> +int netc_get_ts_info(struct dsa_switch *ds, int port,
> +		     struct kernel_ethtool_ts_info *info)
> +{
> +	struct netc_switch *priv = ds->priv;
> +
> +	info->phc_index = netc_get_phc_index(priv);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> +				 SOF_TIMESTAMPING_RAW_HARDWARE;

[Severity: Medium]
Should SOF_TIMESTAMPING_TX_SOFTWARE be set here? Neither the early
return when there is no PHC nor the hardware branch sets it.

The frames go out through the ENETC conduit, and its xmit path calls
skb_tx_timestamp(). __ethtool_get_ts_info() adds only
SOF_TIMESTAMPING_RX_SOFTWARE | SOF_TIMESTAMPING_SOFTWARE. Both
ocelot_get_ts_info() and enetc_get_ts_info() advertise TX_SOFTWARE, even
when there is no PHC.

Before this patch, dsa_user_get_ts_info() returned -EOPNOTSUPP for this
switch. ETHTOOL_GET_TS_INFO now succeeds but leaves out TX_SOFTWARE.
Applications that check capabilities first, such as ptp4l in software
timestamping mode, could then refuse software TX timestamps on these
ports.

> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);

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
> +		 * hardware never times out on a command. Any remaining error
> +		 * means the entry is still present in the table.
> +		 */
> +		err = ntmp_ipft_delete_entry(&priv->ntmp,
> +					     np->ptp_ipft_eid[i]);

[Severity: Medium]
Is this comment accurate? netc_xmit_ntmp_cmd() in
drivers/net/ethernet/freescale/enetc/ntmp.c posts the command to
hardware first. It then polls for completion with a 1 ms software
timeout:

	netc_write(cbdr->regs.pir, i);

	err = read_poll_timeout(netc_read, val,
				(val & NETC_CBDRCIR_INDEX) == i,
				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
				true, cbdr->regs.cir);
	if (unlikely(err))
		return err;

	if (unlikely(val & NETC_CBDRCIR_SBE)) {
		dev_err(cbdr->dev, "Command BD system bus error\n");
		return -EIO;
	}

So -ETIMEDOUT and -EIO can both come back after the command has been
submitted. The command is not withdrawn, so the hardware may still
execute it later.

If a delete completes late, ptp_ipft_eid[] keeps a stale ID. Every later
netc_port_set_ptp_filter() tries to delete that ID first. If the hardware
rejects the unknown ID, hwtstamp_set keeps failing, and hwtstamp_get
reports a filter that is not installed.

The add side has the same issue. If ntmp_ipft_add_entry() in
netc_port_add_ipft_ptp_entry() times out and the add completes
afterwards, a REDIRECT + TIMECAPE trap rule is installed. Its ID is never
recorded, so no later disable or rollback can remove it.

Doesn't this weaken the commit message's claim that deriving the active
filter from the handles keeps software and hardware consistent?

> +		if (likely(!err)) {
> +			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
> +			continue;
> +		}

[ ... ]

> +int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
> +			   struct kernel_hwtstamp_config *config,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct netc_port *np = NETC_PORT(ds, port);
> +	struct netc_switch *priv = ds->priv;
> +	int rx_filter, err;
> +
> +	if ((config->tx_type != HWTSTAMP_TX_OFF ||
> +	     config->rx_filter != HWTSTAMP_FILTER_NONE) &&
> +	    netc_get_phc_index(priv) < 0)
> +		return -EOPNOTSUPP;

[Severity: Low]
What happens to switch timestamping when the PTP timer driver goes away?
Timer availability is checked only here, at configuration time.
netc_setup() takes only a pci_dev reference in priv->tmr_dev and creates
no device link to the ptp_netc driver.

If ptp_netc is unbound while timestamping is enabled,
netc_timer_remove() unregisters the PHC and writes 0 to NETC_TMR_CTRL,
which stops the counter. On the switch side:

- the IPFT entries keep IPFT_TIMECAPE
- ptp_tx_type stays HWTSTAMP_TX_ON
- netc_port_rxtstamp() and netc_port_txtstamp_handler() keep passing
  timestamps from the stopped counter to sockets

Meanwhile get_ts_info reports phc_index = -1.

Should there be a device link, or some other way to disable switch
timestamping when the timer is removed?

> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_ON:
> +	case HWTSTAMP_TX_OFF:
> +		break;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095924.1129312-1-wei.fang%40oss.nxp.com

