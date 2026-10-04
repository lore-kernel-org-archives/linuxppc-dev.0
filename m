Return-Path: <linuxppc-dev+bounces-28869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5DCCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 02:13:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hy5dr0ZG1z30BJ;
	Sun, 04 Oct 2026 13:13:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791079983;
	cv=none; b=jxu/O1ngCvYPObj6Pj07OyVHw/UNOHDXeRcN8X62p0nCocCDpH2acgEytqW2x3Sic9ibVxR0vG/E3IG/R1hn+34dazhq9upjCk4Y46pKpTFor5Za/0OhF9cxEncQirV3TaERNXzrVDKtGZ9D7HBaudfsnoJfGXIYXUsHcZfelKu4pdgl8/5YNuholqbaM9vMk7porm7tvLDmeauu6imgRfClWCS3TGdjtuzm6/6LWpK52aeHSjYnMz9FeRsNpw297yqyvJMU6rB7MKGIGD+qwpmBJTDgE1HgnehJIz7ty9sO8V14eBRyYtyO1uQ+GNWsN/9/xw4s3ErDx3QBh1YhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791079983; c=relaxed/relaxed;
	bh=XGIPL9EuyriPZ4ZDdC2jLlOsbYSmA3TBmbbk/fQDRJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIz2ixFLyKKtxQl0ZrBeodeNTq11IlG8CsJffvNq+EMiOFoH5UnEVbLXGcYGg3rW1U1PzEEiiVN/aV3LR2rwXDhCAPfARAHJw4z9l3FLDY5hzaMXoFSWPd1crebEJa2REgaw7n3+ZC2zRMjSjFAp7CpWSSmH0if9c5Vft0bRo/ifO5CnOgslLuwAcZmJujZ9FTYJreEbdcNwHo4KMtGY+9BLFi6/gDd9AVelsHZumtiy/q61EM4q6kFedvFAYMSDjiGL0xPdmlGVRstnzXSR+bqPwhUpUYthlTjZrdSRxxCmUtbdzPWLi3IXITTpxCqruw8a8oePa8XpOi/jbqqGIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0h/zuDd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0h/zuDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hy5dp4dl0z2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 13:13:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 01A3F60200;
	Sun,  4 Oct 2026 02:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F21F0089C;
	Sun,  4 Oct 2026 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791079979;
	bh=XGIPL9EuyriPZ4ZDdC2jLlOsbYSmA3TBmbbk/fQDRJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P0h/zuDd4yf+49PXJDojrAw8+m4YhJ2djB92J7Ebu+HBsPl4TKumPPkomYMEmqg9U
	 c3K0t5fm0ekKAyg3i2oHmaJ22+YwMy0Cmh2vVXsdmTrnGzuMj5GtXK/VJZjLWS8XDp
	 wyPUEv0pgZlLgOPqvYO35+t9yMoHivH23puIW5h7U3Srp+wgSCjRN2jzp0J24tt+yc
	 WYq5B8NKNghBTrYsSTqZgfex4aWJfceRUMtkGs2kwIZJNU9MTM+i07l0Me35g92LEX
	 9jKNXHXa3uCJLoIf7LG1wOHtzJmGrZgVZxAY4qkXobV0+GQ45vBH3tfXkdynkLEkid
	 UL5GDgwxyPkxg==
Subject:
 Re: [PATCH net-next 5/7] ibmveth: release the pool kobjects when probe fails
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com
Date: Sun, 04 Oct 2026 02:12:58 +0000
Message-ID: <179107997848.434549.4525032963009141215@kernel.org>
In-Reply-To:
 <f0186ae5ac4f9838b01c23fc42391abc328f814f.1790991039.git.mmc@linux.ibm.com>
References:
 <f0186ae5ac4f9838b01c23fc42391abc328f814f.1790991039.git.mmc@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the new err_put_pools path in ibmveth_probe()
  (drivers/net/ethernet/ibm/ibmveth.c), the code calls kobject_put() on…

--

ibmveth: release the pool kobjects when probe fails

This commit adds an err_put_pools unwind label to ibmveth_probe(). The label
calls kobject_put() on each rx_buff_pool[i].kobj before free_netdev(). It is
used when either netif_set_real_num_tx_queues() or register_netdev() fails.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b89ce389d951f..d5ba2f2650d0f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1981,13 +1980,18 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	if (rc) {
>  		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
> -		free_netdev(netdev);
> -		return rc;
> +		goto err_put_pools;
>  	}
>  
>  	netdev_dbg(netdev, "registered\n");
>  
>  	return 0;
> +
> +err_put_pools:
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		kobject_put(&adapter->rx_buff_pool[i].kobj);
> +	free_netdev(netdev);
> +	return rc;
>  }

[Severity: Medium]
With CONFIG_DEBUG_KOBJECT_RELEASE=y, can this path still free the pool
kobjects while their cleanup is pending?

The kobjects are embedded in netdev_priv(netdev), and ktype_veth_pool has
no release() callback:

static struct kobj_type ktype_veth_pool = {
	.release        = NULL,
	.sysfs_ops      = &veth_pool_ops,
	...
};

On that config, kobject_release() defers the cleanup to a delayed_work
that is embedded in the kobject itself:

lib/kobject.c:kobject_release() {
	...
	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);

	schedule_delayed_work(&kobj->release, delay);
	...
}

free_netdev() then frees the adapter while that work is still armed. The
work runs 1 to 4 seconds later. kobject_cleanup() then works on freed
memory: it reads kobj->state_in_sysfs and kobj->name, calls
__kobject_del(), and drops the parent reference.

Until the work runs, the pool%d active, num and size files under
/sys/devices/vio/<unit>/ still exist. A read or write goes through
veth_pool_show() or veth_pool_store(). Both use container_of() to reach
the freed pool, adapter and netdev.

A re-probe in that window could also fail to add pool0. That is the same
failure this commit is meant to fix.

The commit message mentions this and refers to ibmveth_remove(), which
uses the same put-then-free pattern. kobject_cleanup() also reports this
ktype as one that "does not have a release() function, it is broken and
must be fixed".

Calling kobject_del() before kobject_put() would remove the sysfs files
synchronously. However, the delayed_work inside the freed adapter would
still be armed.

Would it make sense to give the pool kobjects their own lifetime? One
option is to allocate them separately with a real release() callback.

This also stays the same later in the series. "ibmveth: wait for
in-flight transmits in ibmveth_close()" leaves both err_put_pools and the
NULL release in place.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790991039.git.mmc%40linux.ibm.com

