Return-Path: <linuxppc-dev+bounces-25520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE59C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGf4yHlz3byP;
	Fri, 07 Aug 2026 04:37:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041434;
	cv=none; b=ObdTUszoApxNuD3BsRYzTghVDLpYRuSXIOuoQ6wv04SzBA2++IDlo+4qtr+jF67KokYLCEWJVlHX/iN/1I5z90fQ5qp4p6cMAeNKhGMk+GKTOI8Bi7qh0vTSx+nW260HNy93wkzqJKTB98Ixj0tpmRzHlaPSuThpuBaJyWO5nZMvUUGEXhnQqrh2fRIvLN5xhmtXdberrSw/VvH9+6CpoD0pFMfnWfGn2dzj4q3ic2SB+CqQJWF8I4pkJ+cBxHRB+Q6uAGfuw80wKATTB4g5Yj1SJzf3ire/PHycXytExHdV7n8N8/mbwJ+LVwQcsdlcEr11bWBGtBi16osXgpYCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041434; c=relaxed/relaxed;
	bh=9QPqJh8kGjhOClC1zTxEmzWflg6EdWMchjCKguX0I4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7NKI5J96KEkKDoZfgkfvzNWatE0y3D2Je3Gx1JGNvNoc5JIm5CmTEeEv2/ulv/U278pENFKAxb7SMo+yUnyqfvfEw9HZU6KbeZ8oVGiyFHqdqsJXwQO+6/Nlh/N/JwQ2C/DOSQPcYuGmimfTZX4tv07FFcA3Tds+c95DxBhCp5uf31j9PoSxCY+3YwBLh3AZ7kgi3JGKHQBj6ou686kBdHJYyx3BiChzYoH3jEcrUt++YRn3eyHRgD+zx/c6PVXw1o7JZ2e05PiQ1vTWlkfMfLyXpFG9j+ihwDk31DpVl78QPHauIdWKYTHabqkxJ3jCJjRgxKQDvxr9UpAG4/LRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPo0hjVu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPo0hjVu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGW49S4z3bx5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 125C642E9E;
	Thu,  6 Aug 2026 18:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550D01F00A3E;
	Thu,  6 Aug 2026 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041425;
	bh=9QPqJh8kGjhOClC1zTxEmzWflg6EdWMchjCKguX0I4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPo0hjVuUC9Upsic12nrwRxVwaYtysdtGyNlIEax7qtcOKW52+Fdkll6HTDxzEpfP
	 hEQJtyr618aRZMgDecOKxLjqv0IUTE+vRMJ+10CCSEuudkoKA5/CnDDyAMR8uQlnn0
	 gZPE5HkM7nMqw9hrHUKkyua8Ix5q7xBy1gDepiKB60i41e1hi/QY9Wf6FtSelgkgoj
	 bbJmxkHR7yEtKrfvl0cTw6S4NRR53ZARFIkMGW9Xrd9PTlABXrF76qDWsUcyNJWWaI
	 hEj9L3dOjfXqQa/CZLdC+mEz+OqoSX/Lo6fUmOZ6u9YAGgFGftt4YCwmw+WCM/GVQG
	 EJokYbUlh3PkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 05/14] ibmveth: Refactor RX interrupt control for MQ RX queues
Date: Thu,  6 Aug 2026 11:37:03 -0700
Message-ID: <20260806183703.3175289-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <3375291b81496032d02dc769c962a2fa323fb20b.1785457143.git.mmc@linux.ibm.com>
References: <3375291b81496032d02dc769c962a2fa323fb20b.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Refactor RX interrupt control for MQ RX queues

This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
disable, setup/cleanup, schedule) and wires them into open(), close(),
poll(), the IRQ handler and the process-context RX kick paths. request_irq()
now passes &adapter->napi[i] as the cookie so the handler can derive the
queue index, and napi_enable()/napi_disable() move into the new setup and
cleanup helpers. Runtime behaviour stays single-queue.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 7a2ed49cad4f1..664169c4d27a4 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -329,6 +331,203 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>  	}
>  }
>  
> +/**
> + * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts
> + * @adapter: ibmveth adapter structure
> + * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
> + * @enable: true to enable, false to disable
> + *
> + * For queue 0 (primary), uses h_vio_signal() as it's registered via
> + * h_register_logical_lan(). For subordinate queues (1+), uses H_VIOCTL
> + * with H_ENABLE/DISABLE_VIO_INTERRUPT for per-queue interrupt control.
> + *
> + * Return: 0 on success, error code otherwise
> + */
> +static int
> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
> +		   bool enable)
> +{
> +	unsigned long rc;
> +	unsigned long irq = adapter->queue_irq[queue_index];
> +	const char *action = enable ? "enable" : "disable";
> +
> +	if (queue_index == 0) {
> +		/* Primary queue: use h_vio_signal() */
> +		rc = h_vio_signal(adapter->vdev->unit_address,
> +				  enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
> +	} else {
> +		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
> +		struct irq_data *irq_data = irq_get_irq_data(irq);
> +		irq_hw_number_t hwirq;
> +		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
> +			H_DISABLE_VIO_INTERRUPT;
> +
> +		if (!irq_data) {
> +			netdev_err(adapter->netdev,
> +				   "Failed to get IRQ data for queue %d (virq=%lu)\n",
> +				   queue_index, irq);
> +			return -EINVAL;
> +		}
> +
> +		hwirq = irqd_to_hwirq(irq_data);
> +		rc = plpar_hcall_norets(H_VIOCTL,
> +					adapter->vdev->unit_address,
> +					vioctl_cmd,
> +					hwirq, 0, 0);
> +
> +		if (rc == H_PARAMETER) {
> +			/* H_PARAMETER is non-fatal when IRQ is already in
> +			 * the requested state.
> +			 */
> +			netdev_warn_once(adapter->netdev,
> +					 "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
> +					 action, queue_index, hwirq);
> +			return 0;
> +		}

[Severity: Medium]
Is folding H_PARAMETER into success correct for both directions here?

hvcall.h documents H_PARAMETER as "Parameter invalid, out-of-range or
conflicting", and ibmveth_toggle_irq() cannot distinguish "already in the
requested state" from a bad hwirq, wrong unit address, or a queue that is no
longer registered.

In the enable direction the swallowed status bypasses the recovery in
ibmveth_poll():

	lpar_rc = ibmveth_enable_irq(adapter, 0);
	if (WARN_ON(lpar_rc != H_SUCCESS)) {
		schedule_work(&adapter->work);
		goto out;
	}

so NAPI can complete with the queue still masked at the hypervisor and
nothing left to reschedule it, i.e. that queue stops receiving, with a
single warn_once as the only trace.

In the disable direction, ibmveth_schedule_rx_queue() goes on to
__napi_schedule() and ibmveth_cleanup_rx_interrupts() goes on to
synchronize_irq()/free_irq() while believing delivery is masked.

For comparison, ibmvnic treats any non-zero rc from the same hypercalls as
an error in both directions, in disable_scrq_irq() and enable_scrq_irq().

The branch is dead in this commit (num_rx_queues is 1), but it becomes live
once the MQ patches land, where setup, resize and poll all depend on this
return value. Would restricting the folding to the disable direction, plus a
rate-limited per-queue message instead of netdev_warn_once(), be closer to
the intent?

> +	}
> +
> +	if (rc)
> +		netdev_err(adapter->netdev,
> +			   "Failed to %s IRQ for queue %d, rc=%ld\n",
> +			   action, queue_index, rc);
> +	return rc;
> +}

[Severity: Medium]
Does this mix two error domains in one int return?

rc holds an unsigned long hypervisor status from h_vio_signal() or
plpar_hcall_norets() (H_BUSY 1, H_HARDWARE -1, H_FUNCTION -2, H_PARAMETER
-4), truncated to int on return, while the irq_get_irq_data() failure path
returns -EINVAL.

The callers then disagree about what they got. ibmveth_schedule_rx_queue()
and ibmveth_poll() do:

	unsigned long lpar_rc;
	lpar_rc = ibmveth_disable_irq(adapter, qindex);
	WARN_ON(lpar_rc != H_SUCCESS);

while ibmveth_setup_rx_interrupts()/ibmveth_open() treat the same value as
an errno. One printk formats it with %ld, the other site logs it with %d.

By the end of the series this reaches userspace: the scale-up loop in
ibmveth_resize_rx_queues_incremental() does

	rc = ibmveth_enable_irq(adapter, i);
	if (rc) { ... goto cleanup_new_queues; }

and cleanup_new_queues ends with return rc, which flows through
ibmveth_resize_rx_channels() -> ibmveth_set_channels() to ethtool. H_PARAMETER
(-4) then surfaces as -EINTR, and H_BUSY (1) or H_CLOSED (2) as a positive
return that ethtool reads as success even though the queue count was rolled
back.

Since this commit establishes the helper API for the whole series, would it
make sense to settle the convention now, either normalizing to errno or
keeping the raw hcall status with a matching type, name, kernel-doc and
format specifier?

[ ... ]

> +/**
> + * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
> + * @adapter: ibmveth adapter structure
> + *
> + * Registers interrupt handlers for all RX queues and enables NAPI polling.
> + * On error, cleans up any successfully registered IRQs before returning.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i, rc;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (!adapter->queue_irq[i]) {
> +			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
> +			rc = -EINVAL;
> +			goto err_free_irqs;
> +		}
> +
> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
> +				 0, netdev->name, &adapter->napi[i]);
> +		if (rc) {
> +			netdev_err(netdev,
> +				   "request_irq() failed for irq 0x%x queue %d: %d\n",
> +				   adapter->queue_irq[i], i, rc);
> +			goto err_free_irqs;
> +		}
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		napi_enable(&adapter->napi[i]);

[Severity: Medium]
Can an interrupt arrive in the window between these two loops?

request_irq() unmasks the virq via irq_startup(), and the LAN is already
registered with the hypervisor by the time ibmveth_setup_rx_interrupts()
runs, yet NAPI is only enabled in the second loop. Previously
napi_enable(&adapter->napi[0]) was the first statement of ibmveth_open(), so
this window did not exist.

If an interrupt (including one latched at the controller while the line was
shut down by the previous close's free_irq()) is delivered inside the
window, ibmveth_interrupt() -> ibmveth_schedule_rx_queue() finds
napi_schedule_prep() failing:

	if (napi_schedule_prep(napi)) {
		lpar_rc = ibmveth_disable_irq(adapter, qindex);
		WARN_ON(lpar_rc != H_SUCCESS);
		__napi_schedule(napi);
	}

so nothing is scheduled and nothing is masked, while the handler still
returns IRQ_HANDLED. For a level-asserted hypervisor source that repeats
until napi_enable() runs.

This is also the inverse of the invariant the later scale-up path in this
series states, "publish -> replenish -> napi_enable -> enable_irq ... so
ibmveth_interrupt() cannot run on an unpublished, empty, or NAPI-disabled
queue". Would enabling a queue's NAPI before installing its handler restore
that ordering?

> +
> +	return 0;
> +
> +err_free_irqs:
> +	while (--i >= 0)
> +		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	return rc;
> +}
> +
> +/**
> + * ibmveth_cleanup_rx_interrupts - Mask PHYP, disable NAPI, free IRQs
> + * @adapter: ibmveth adapter structure
> + *
> + * Tears down RX interrupt delivery for all queues. Mask PHYP before
> + * napi_disable so ibmveth_interrupt cannot return IRQ_HANDLED without
> + * masking (same storm window as scale-down). Safe for close and for
> + * open failure after setup_rx_interrupts() already unmasked PHYP.
> + */

[Severity: Low]
Do these comments describe what the commit actually does?

"Safe for close and for open failure after setup_rx_interrupts() already
unmasked PHYP" - ibmveth_setup_rx_interrupts() only does request_irq() and
napi_enable(), and the changelog agrees ("setup does not yet unmask PHYP").
No ibmveth_open() failure path calls this helper either; setup rolls back
through its own err_free_irqs label and open goes to
out_free_buffer_pools/out_free_tx_ltb/out.

"Mask PHYP before napi_disable so ibmveth_interrupt cannot return
IRQ_HANDLED without masking" - see the question on the mask/napi_disable
ordering below; an in-flight ibmveth_poll() can undo the mask.

"Dispose IRQ mappings for subordinate queues (1-15)" sits above a loop that
starts at 1, but ibmveth.h defines IBMVETH_MAX_RX_QUEUES as 1U and
num_rx_queues is set to IBMVETH_DEFAULT_RX_QUEUES, so the loop cannot
iterate in this commit.

And ibmveth_toggle_irq()'s "Return: 0 on success, error code otherwise"
conflicts with returning raw H_* codes that callers compare against
H_SUCCESS.

The first and third become accurate later in the series; the second and
fourth remain as they are. Could the comments be trimmed to what this
commit provides?

> +static void
> +ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (adapter->queue_irq[i]) {
> +			ibmveth_disable_irq(adapter, i);
> +			synchronize_irq(adapter->queue_irq[i]);
> +		}
> +	}

[Severity: Medium]
Can a running poll undo this mask before free_irq()?

synchronize_irq() waits for the hardirq handler only, not for an
ibmveth_poll() already running in softirq context, and that poll
unconditionally re-arms delivery on its completion path:

	lpar_rc = ibmveth_enable_irq(adapter, 0);

Sequence with RX traffic flowing during "ip link set ethN down":

CPU0 ibmveth_close() -> ibmveth_cleanup_rx_interrupts()
	ibmveth_disable_irq(adapter, 0);	/* PHYP masked */
	synchronize_irq(queue_irq[0]);		/* no hardirq running */
	napi_disable(&adapter->napi[0]);	/* blocks on the poll */

CPU1 softirq ibmveth_poll()
	lpar_rc = ibmveth_enable_irq(adapter, 0);	/* PHYP unmasked */
	napi_complete_done(...)

CPU0 then resumes and calls free_irq() with the source unmasked, and nothing
re-checks or re-masks after napi_disable(). If an interrupt lands in that
window, ibmveth_interrupt() -> ibmveth_schedule_rx_queue() takes the
napi_schedule_prep() failure path, so no mask is applied while the handler
still returns IRQ_HANDLED - the storm window the new kernel-doc says this
ordering avoids. The window is bounded by the following free_irq(), but the
teardown no longer reliably ends with the source masked.

Should ibmveth_poll() avoid re-enabling while teardown is in progress, or
should cleanup re-mask after napi_disable()?

> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		napi_disable(&adapter->napi[i]);
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (adapter->queue_irq[i])
> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but the refactor makes the
unbalanced teardown harder to see and hands the same invariant to the rest
of the series, so it seems worth raising here.

napi_disable() runs unconditionally for every queue, and free_irq() is gated
only on queue_irq[i]. After a failed ibmveth_open() that leaves the
interface administratively up, NAPI was never enabled and no handler was
installed, yet both run on the next ndo_stop.

napi_disable_locked() does:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
		usleep_range(20, 200);

and sets SCHED|NPSVC when it completes, so a second napi_disable() with no
intervening napi_enable() loops forever, under rtnl_lock() plus the netdev
lock. free_irq() on a never-requested IRQ additionally warns with "Trying to
free already-free IRQ".

Trigger in this tree: veth_pool_store() calls ibmveth_close() and then
ibmveth_open() directly; if open fails (-ENOMEM from
ibmveth_alloc_rx_queues(), -ENONET from ibmveth_register_logical_lan(), or
request_irq() failure inside ibmveth_setup_rx_interrupts()) it restores the
pool values and returns the error with the netdev still up. The same
close()/open() pattern exists in ibmveth_set_csum_offload() and
ibmveth_set_tso(). A later "ip link set dev ethN down" then reaches
ibmveth_cleanup_rx_interrupts() and hangs.

In the baseline, open() did napi_enable() at entry and napi_disable() at
out:, and close() called free_irq(netdev->irq, netdev) unconditionally, so
the same hang existed. What changes here is that queue_irq[0] is published
in open() before request_irq() can succeed and is deliberately never
cleared, so the new "if (adapter->queue_irq[i])" guard means "we have a virq
number", not "a handler is installed". Could the helper track whether
napi_enable()/request_irq() actually ran for each queue?

> +
> +	/* Dispose IRQ mappings for subordinate queues (1-15).
> +	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
> +	 */
> +	for (i = 1; i < adapter->num_rx_queues; i++) {
> +		if (adapter->queue_irq[i]) {
> +			irq_dispose_mapping(adapter->queue_irq[i]);
> +			adapter->queue_irq[i] = 0;
> +		}
> +	}
> +
> +	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
> +}
> +
> +/**
> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
> + * @adapter: ibmveth adapter structure
> + * @qindex: RX queue index
> + *
> + * Shared by the IRQ handler and process-context kick paths (open, resume,
> + * pool sysfs, netpoll). Keep ibmveth_interrupt() as the IRQ-only wrapper.
> + */
> +static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
> +				      int qindex)
> +{
> +	struct napi_struct *napi = &adapter->napi[qindex];
> +	unsigned long lpar_rc;
> +
> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
> +		return;
> +
> +	if (napi_schedule_prep(napi)) {
> +		lpar_rc = ibmveth_disable_irq(adapter, qindex);
> +		WARN_ON(lpar_rc != H_SUCCESS);
> +		__napi_schedule(napi);
> +	}
> +}
> +
>  /* setup the initial settings for a buffer pool */
>  static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
>  				     u32 pool_index, u32 pool_size,

> @@ -947,8 +1146,6 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	netdev_dbg(netdev, "open starting\n");
>  
> -	napi_enable(&adapter->napi[0]);
> -
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>  		rxq_entries += adapter->rx_buff_pool[0][i].size;
>  
> @@ -972,7 +1169,8 @@ static int ibmveth_open(struct net_device *netdev)
>  					adapter->rx_queue[0].queue_len;
>  	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
>  
> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
> +	adapter->queue_irq[0] = netdev->irq;
> +	ibmveth_disable_irq(adapter, 0);

Related to the teardown question above: queue_irq[0] is published here,
before h_register_logical_lan(), the buffer pool allocation and
request_irq(), and it is never cleared on any failure path.

>  
>  	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
>  
> @@ -993,21 +1191,16 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_free_tx_ltb;
>  
> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
> -			 netdev);
> -	if (rc != 0) {
> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
> -			   netdev->irq, rc);
> +	rc = ibmveth_setup_rx_interrupts(adapter);
> +	if (rc) {
>  		do {
>  			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>  		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
>  		goto out_free_buffer_pools;
>  	}
>  
>  	netdev_dbg(netdev, "initial replenish cycle\n");
> -	ibmveth_interrupt(netdev->irq, netdev);
> +	ibmveth_schedule_rx_queue(adapter, 0);
>  
>  	netif_tx_start_all_queues(netdev);
>  
> @@ -1024,7 +1217,6 @@ static int ibmveth_open(struct net_device *netdev)
>  out_free_filter_list:
>  	ibmveth_free_filter_list(adapter);
>  out:
> -	napi_disable(&adapter->napi[0]);
>  	return rc;
>  }
>  
> @@ -1036,11 +1228,10 @@ static int ibmveth_close(struct net_device *netdev)
>  
>  	netdev_dbg(netdev, "close starting\n");
>  
> -	napi_disable(&adapter->napi[0]);
> -
>  	netif_tx_stop_all_queues(netdev);
>  
> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
> +	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
> +	ibmveth_cleanup_rx_interrupts(adapter);
>  
>  	do {
>  		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> @@ -1051,8 +1242,6 @@ static int ibmveth_close(struct net_device *netdev)
>  			   "continuing with close\n", lpar_rc);
>  	}
>  
> -	free_irq(netdev->irq, netdev);
> -

Also part of the teardown question: free_irq() now happens inside
ibmveth_cleanup_rx_interrupts(), i.e. before h_free_logical_lan(), where the
baseline order was napi_disable -> tx stop -> h_vio_signal(DISABLE) ->
h_free_logical_lan -> free_irq. The changelog mentions the mask/napi_disable
reordering but not this one. Was the free_irq/h_free_logical_lan inversion
intended?

>  	ibmveth_update_rx_no_buffer(adapter);
>  
>  	ibmveth_free_buffer_pools(adapter);
> @@ -1798,15 +1987,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	/* We think we are done - reenable interrupts,
>  	 * then check once more to make sure we are done.
>  	 */
> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
> +	lpar_rc = ibmveth_enable_irq(adapter, 0);
>  	if (WARN_ON(lpar_rc != H_SUCCESS)) {
>  		schedule_work(&adapter->work);
>  		goto out;
>  	}
>  
>  	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
> -		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
> -				       VIO_IRQ_DISABLE);
> +		lpar_rc = ibmveth_disable_irq(adapter, 0);
>  		goto restart_poll;
>  	}
>  

[ ... ]

Cross-instance finding from sashiko-gemini (e3f4ca1fbf9d3f3114fde9e903e88e76f2f763bdede83ba454f20f9e157db105):
[Severity: Medium]
Incomplete Refactoring / Future Out-of-Bounds Access in ibmveth_poll

