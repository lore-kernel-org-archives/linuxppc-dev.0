Return-Path: <linuxppc-dev+bounces-24217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1BDC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzzwL6ZgSz2yY1;
	Tue, 14 Jul 2026 23:01:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784034114;
	cv=none; b=k16plXucMkR3sZF57HHX44IjPiqIi0+Kl+gaQLKVdr1yznnQNRAAtNMhmMymt7/vZ8XH0DBBxlETh48XuQRc7X3aIjEpXrsAGkyWZ9E11R0Swij4CRNjK/Vmwm2mhn5pXHm6qdQkYSwJNMVtdwYQzvBB1CFq5HUmBHqTz+FNaIwNlJxpKGEqxN6hg+plDNSgD8Zrr/Ie/mHdRjmJXnNSCrFUtpkie7B1gbGkJToMSbEBNrhqqWaNKuRCQKiScAYkZEYKoIWdxS93IyKV9LdPU1+ywuWI8g1jq0qZhW0nhTHBV4ai1p8ZKK3rwEYIW/LVOfpV7cqnni2sQxaJsflkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784034114; c=relaxed/relaxed;
	bh=PpTc1tqm/ZkWGVvlR4jp+OG8RxeNyx3F423/n9iys6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRLz0lDkLEmaw8Bv/rMBSsdmGkIdThRCOYUlx9808EKQbN0zWBoAmS5wfi3Wq3h+/YoNyfAmg6hj9VnB1d/s7eWThBzdrr1C5zUY60z9xbs0DCbvRzl93FK3zJl2fTwXoDGefqGYIFyIXAejkkE20/25oRK/SpkZEh99ZAmCvMKXitJ3+dpIK0asFDCTrMq+EcGieXqD2UPHkd0iCtKTrDnZV4RPnljgJWbT7JnhIlUt6Rqx8mXHyC9+nZXwA21Ouktek8d8i9o+ffDQY+DVMdxvmBhr6jP2HbDslAGBl3giz32zmpPy/Xvpy0ehA+FEgEQ3aLupFKnKonWoOAtFmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVBpMtSu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVBpMtSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzwL0GCkz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 23:01:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D04F46132C;
	Tue, 14 Jul 2026 13:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415DA1F00A3A;
	Tue, 14 Jul 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034111;
	bh=PpTc1tqm/ZkWGVvlR4jp+OG8RxeNyx3F423/n9iys6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVBpMtSu1vnKRKSwNtd8UALzvMUIB9fIS5OfRv2TRQBbHJPO4m9WGHvmaOyNbrbBo
	 XIc6e6Hy6TBiNeyTiAyWGTn+t+x+ylfokhOn+Y69ZJpGNEppAJ//XgYeMIDS5Y6uQr
	 UM8ZWfputmnuHWHoqeHNNwIYJMz5wcp/ru6tPOFqT7A9TVhjzBdRpWE7nTI4/Ou+Pm
	 goREmc5DK37o/46f5TSip4pU/A5xwDca43YJSv/2pvmBhSJ6Eu3mP44J7LxO+2seJL
	 KuZvg8hYUXuA2ITEewO1xm/7LOqUBOq2bo/3QVdZ/AuQ08pZu3d/dbeCu3MavUhurG
	 /1kQezOF9z98A==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 12/15] ibmveth: Expose per-queue buffer pool details via sysfs
Date: Tue, 14 Jul 2026 14:01:42 +0100
Message-ID: <20260714130142.1841365-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-13-mmc@linux.ibm.com>
References: <20260706193603.8039-13-mmc@linux.ibm.com>
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
Full review at: https://sashiko.dev
---
ibmveth: Expose per-queue buffer pool details via sysfs

This commit adds a read-only sysfs attribute buffer_pools to the VIO device
to expose per-queue buffer pool details dynamically. It outputs runtime per-queue
buffer pressure metrics like size, active, and available buffers.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 4e3f49b6346fd..ecc472ee8f71f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2896,6 +2896,52 @@ static const struct net_device_ops ibmveth_netdev_ops = {
[ ... ]
> +static ssize_t buffer_pools_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct net_device *netdev = dev_get_drvdata(dev);
> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +	int len = 0;
> +	int i, j;
> +
> +	len += scnprintf(buf + len, PAGE_SIZE - len,
> +			 "Queue  Pool  Size  BuffSize  Active  Available\n");
> +	len += scnprintf(buf + len, PAGE_SIZE - len,
> +			 "-----  ----  ----  --------  ------  ---------\n");

[Severity: Medium]
Does this buffer_pools_show() implementation violate the sysfs "one value
per file" design rule? 

The attribute appears to dump a complex, multi-line ASCII table with headers
and columns rather than exposing a single value per sysfs file.

[ ... ]
> @@ -3056,6 +3102,14 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	netdev_dbg(netdev, "registered\n");
>  
> +	rc = sysfs_create_group(&dev->dev.kobj, &ibmveth_attr_group);
> +	if (rc) {
> +		netdev_err(netdev, "failed to create sysfs attributes rc=%d\n", rc);
> +		unregister_netdev(netdev);
> +		free_netdev(netdev);
> +		return rc;
> +	}

[Severity: High]
If userspace brings up the interface immediately after register_netdev()
succeeds, could adapter->work be scheduled before sysfs_create_group() fails?

If this race occurs, unregister_netdev() does not synchronously cancel the
work. 

Could the global workqueue execute the pending adapter->work item on freed
memory after free_netdev() is called in this ibmveth_probe() error path?

[Severity: High]
This is a pre-existing issue in older error paths of ibmveth_probe(), but it
is duplicated here: does this error path leak the adapter->rx_buff_pool
kobjects?

Since kobject_put() is not called on the pool kobjects before free_netdev()
is executed, the kobjects remain attached to the VIO device with dangling
pointers to the freed adapter memory. 

Could subsequent sysfs accesses to those pool kobjects trigger a
use-after-free?

