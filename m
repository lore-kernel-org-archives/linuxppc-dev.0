Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBF606A8B5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+r64Xg7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQckX0P74z30V0;
	Fri, 13 Nov 2026 10:57:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794527827;
	cv=none; b=mf05DIwzuqJPisfpNWGjgzXBnj0pYO0JQx0YkwtQL6PeROAH+5mFTieT3I92R4Th4xGrwbu7iFMD+EENHSp8mfY0JuI0xPaKMD9Zjn2zN7ozdmuf2UCEyHduJFeURIXXqvCqtbF++edTE+u6cY5KXqJhA7UyjOEXmzCKea8nVL00pwtABYIJvYq/kEYVs04eGSjcN0Bl90Rp5YHhtZkt8TDfEX7bK4KJd6pC4sLu4D2Zm00+r2zwjaLTem4ItiYFJGUBGxC0NlDOzXDWr+sFRJXmPuYGfHWc1Rpf7Z9BSBDXyfR8hzEixBMUWyUv4RrYyQgqELDrp8uhr1NkSqJr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794527827; c=relaxed/relaxed;
	bh=BcuV1gWNisCg/9F3/C637W1E9nzmP0Y2IeewjExvB6s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDXPEc1p/6WWtB7pjwnm4Wr6CmNOfx5RNlX7azoqVcIJHHCifCExn/e9w7v5ONI5i6TUSyOytSEboEwFszI4XV+f0/3IHjoCYW+2KBDPbEGLROocerxorWmj3O1xa9mXg47ZxU/FG6nF6nslGINhTjGRvoHSSZo8+3dxfviB5opgDQ9JsrY2eOghUZJsRyFaBfEliBfzkbMnybyo88XW7XRcfjx8d6mEgY6TDt0vQ8DEjtw/mzbskPpwNxEcgARijqXOz0Xi4VN3k5VTQUzSxYJwSYVxhVCdkpUqZFjjo8AqWsP0NWZ08qNzToGbfg+XlfKNtfoRyV8z4AV8WZtoWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+r64Xg7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+r64Xg7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQckV0wxlz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 10:57:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD63B60E24;
	Thu, 12 Nov 2026 23:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE9C1F000C4;
	Thu, 12 Nov 2026 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527822;
	bh=BcuV1gWNisCg/9F3/C637W1E9nzmP0Y2IeewjExvB6s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X+r64Xg793k6B8MjAQB74eZpcBQ4tYGiLwKP3qPohMrydRmPdGQL2bLO8+ACjdUIc
	 yD/FasWerMDSnu11FN9idK1MPDsp7UcGq0+nzjU4lzUAUa47gnOKNqp/Uj8n7RxVd9
	 XcMyXlFh3gdjhgTzJ1NIvn0oFgA58BiW5hhKgiJFthGR+T617Hx4wkZZIERoR7gXN9
	 mobETwl8r9jibWjaDfNyK9fbDG3L7jf3okadQdLhTnX5FIvMlJkJFULf0nnPS1Nwog
	 tcxG4mIVk/Yfw5/0Lq8+wCODbR/kGYBPzMNdKjCF9vUrcBDJ7PcTJ5en4JqsHl6OAy
	 3QZLVP/XbZzeA==
Subject: Re: [PATCH net-next v8 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:00 +0000
Message-ID: <179452782074.2199510.13462227035463955143@kernel.org>
In-Reply-To: <20261109235556.60604-6-mmc@linux.ibm.com>
References: <20261109235556.60604-6-mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This is speculative and latent.
- [Low] For subordinate queues, ibmveth_toggle_irq()
  (drivers/net/ethernet/ibm/ibmveth.c) treats an H_PARAMETER return from…

--

ibmveth: Refactor RX interrupt control for MQ RX queues

This adds queue-indexed RX interrupt helpers that use h_vio_signal() for
queue 0 and H_VIOCTL for subordinate queues. It wires them into
open/close/poll/interrupt and the process-context RX kick sites. Runtime
stays single-queue (num_rx_queues is still 1).

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 31fad7713dc70..62e6c9a9f5e91 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -347,6 +349,325 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)

[ ... ]

> +static int
> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
> +		   bool enable)
> +{
> +	unsigned long h_rc;
> +	unsigned long irq = adapter->queue_irq[queue_index];
> +	const char *action = enable ? "enable" : "disable";
> +
> +	if (queue_index == 0) {
> +		/* Primary queue: use h_vio_signal() */
> +		h_rc = h_vio_signal(adapter->vdev->unit_address,
> +				    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
> +	} else {
> +		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
> +		struct irq_data *irq_data = irq_get_irq_data(irq);
> +		irq_hw_number_t hwirq;
> +		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
> +			H_DISABLE_VIO_INTERRUPT;
> +

[ ... ]

> +		hwirq = irqd_to_hwirq(irq_data);
> +		h_rc = plpar_hcall_norets(H_VIOCTL,
> +					  adapter->vdev->unit_address,
> +					  vioctl_cmd,
> +					  hwirq, 0, 0);

[Severity: Medium]
This one is speculative. Do subordinate queues need the post-migration
EOI that ibmvnic issues for the same kind of H_VIOCTL-controlled queue
interrupt?

drivers/net/ethernet/ibm/ibmvnic.c:

/* Due to a firmware bug, the hypervisor can send an interrupt to a
 * transmit or receive queue just prior to a partition migration.
 * Force an EOI after migration.
 */
static void ibmvnic_clear_pending_interrupt(struct device *dev,
					    struct ibmvnic_sub_crq_queue *scrq)
{
	if (!xive_enabled())
		ibmvnic_xics_eoi(dev, scrq);
}

ibmveth_toggle_irq() is the only place that re-arms subordinate queues.
At the end of the series, ibmveth.c has no H_EOI or xive_enabled()
handling anywhere.

Suppose ibmveth subordinate RX queues have the same firmware behaviour.
On XICS, an interrupt pending across LPM would then never get an EOI.
That queue would stop taking interrupts: NAPI idle, PHYP enabled, RX
stalled on that queue.

Nothing would start recovery either. After LPM, ibmveth only schedules a
reset if the MQ buffer hcalls return H_FUNCTION.

Queue 0 has migrated over XICS for years without this EOI. It is
controlled by h_vio_signal() rather than H_VIOCTL, though, so that does
not answer the question for subordinate queues.

This path is latent until the later "ibmveth: Enable multi-queue RX
receive path" commit. Could it be checked against PAPR/PHYP behaviour
before multi-queue is enabled?

> +
> +		/*
> +		 * Fold H_PARAMETER only on disable (idempotent mask). On
> +		 * enable it is not already-enabled: a trivial enable
> +		 * returns success. H_PARAMETER means the interrupt
> +		 * number was not in the valid range for that unit
> +		 * address. Keep that an error so a missed LISN stays
> +		 * visible to poll/resize recovery.
> +		 */
> +		if (h_rc == H_PARAMETER && !enable) {
> +			dev_warn_ratelimited(&adapter->netdev->dev,
> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
> +					     action, queue_index, hwirq);
> +			return 0;
> +		}

[Severity: Low]
Does the comment above this fold actually support it? It says a trivial
enable already returns success, and that H_PARAMETER means the interrupt
number was not in the valid range for the unit address.

That describes a bad hwirq argument, not an interrupt that is already
masked. The same reading would seem to apply to H_DISABLE_VIO_INTERRUPT.
The commit message calls this an "idempotent mask".

ibmvnic makes the same hcall and treats any non-zero rc as a failure:

drivers/net/ethernet/ibm/ibmvnic.c:disable_scrq_irq() {
    ...
	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,
				H_DISABLE_VIO_INTERRUPT, scrq->hw_irq, 0, 0);
	if (rc)
		dev_err(dev, "Couldn't disable scrq irq 0x%lx. rc=%ld\n",
			scrq->hw_irq, rc);
	return rc;
}

Two teardown paths rely on the mask actually taking effect:
ibmveth_cleanup_rx_interrupts() and the err_disable_napi rollback in
ibmveth_setup_rx_interrupts(). Both run mask, synchronize_irq(),
napi_disable(), synchronize_net(), remask, then free_irq(). With the
fold, a disable that PHYP rejected looks like a successful mask there.

No subordinate-queue caller of ibmveth_disable_irq() checks the return
value. So today the visible effect is only the log level (dev_warn
instead of dev_err) and the self-contradicting comment. The path is also
only reachable once num_rx_queues > 1, after the later "ibmveth: Enable
multi-queue RX receive path" commit. The fold is still there at the end
of the series.

Should H_PARAMETER on disable stay an error, as it does on enable?
Alternatively, the comment and commit message could explain why disable
is treated differently.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com

