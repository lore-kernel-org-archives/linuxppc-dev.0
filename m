Return-Path: <linuxppc-dev+bounces-26339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10687C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:20:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYf3K4KkBz2xlv;
	Tue, 01 Sep 2026 05:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788204045;
	cv=none; b=m9C2WQWoo2sMaKVJ/9igBWf/I9bacTQOzTJRs1YjAmj/vtc7HLP6em4rQ9zMl+CP1NVDgkQRN3muxhvdONf65a9A2UjXdseea5f7MAOcTuf/sKkbRZCa8bsvZ8/+FrezYXQ8aZbAb5R0cC1tZxHp+uLqDE7Lg17HlttA0mSduvkp8mOpXpSxQvkbN8G8hK9VPSETh3V8dFaagUAew+XvNG+t16lFbkytg/O6ZIp51Une+svODyGC5A/4YddSIXVefhO+IfEtV1rejpFiDbRI3N9tNQRy5QTR8exvU29E6LDDn3vygKyIiXvbvl+Wx8HcdcsLi9Be9JsST5bw6OBoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788204045; c=relaxed/relaxed;
	bh=emMyfE+WgjTYPd2NzsHSKdI7oAPlqBenn5crC3Zv3iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCw2JrG8nNXpPoiiAxTavRHSOswy9jhmgcA18OG6N8eseg5pzUvG5cLN76LmU4mrdLdUGZlv1Zsce5IMoLThjhXuy4zK64y+23UoFuL1hwZ9i3Pdnogsqt6R3wNj7jPuB/Slt95DRVzUbOLDEasV0mrvsc2GM3qsJFjIORsAg/6I+65/nRPgmW6F6TFV1WW6JeIg1P7fAP/P/4Ut6A5SVq4ItP6fBMMiGq0vZ+8tvgBvJkksqTQqM7v4DKFUCkILf/StQXPFcFD/jOONB7jy5RRZW6PwzOQBItuHIrWmBQZRwerTzlKFyhdGnPic4B8u0WgM17XNy1kl+XjOzpnvNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hc3b0+rP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hc3b0+rP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYf3J54Sbz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:20:44 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVmEF1979944;
	Mon, 31 Aug 2026 19:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=emMyfE
	+WgjTYPd2NzsHSKdI7oAPlqBenn5crC3Zv3iQ=; b=hc3b0+rPOgQvV6hoUIyLCT
	eNFvTjjPQLW3m+oYqoiAfHtlkebuBsZ5+hpIewxMJIlGh3oFqawCw/AtdElcrYoS
	4fElZKSgz+BRO8iheZDMyrbIflxAq5aRGpq5f8lQkvE2D0FhrwQFXusGGgpPUQcf
	uiuJFNk88uLBvx0OFkdHq6xIVSVjHjQqS5g24tK5IiF3eTNXK/31M84tw65Pi6CO
	xvPhOzlzhejjPbo0m+OVbocYYD9J0cLrAGkXEYjpM1/HP/hQ6FjdHOJkntHTrNwQ
	DghJufuzQufBLMTWN1Fwtac+OGhDAzqgVYXtqCH+ehJcG3hzJ4eI6mASx5p771Cg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudkbqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:20:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJBVER029140;
	Mon, 31 Aug 2026 19:20:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjynxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:20:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJKR3928902016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:20:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5658B58056;
	Mon, 31 Aug 2026 19:20:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD715803F;
	Mon, 31 Aug 2026 19:20:24 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:20:24 +0000 (GMT)
Message-ID: <958906ee-534f-44b0-8060-f0131d136e20@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:20:23 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/15] ibmveth: Expose per-queue buffer pool
 details via debugfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-14-mmc@linux.ibm.com>
 <20260818014736.3854433-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014736.3854433-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -6aqaOUjYrUBaDWbDwhg7xDjpGXJDwMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX1Q34SEeg2nGN
 K+m2mcUd0074QUfEI4WiBfyZpydZ0iA/n+fIALdMCx6byY/KXxT4JiBpXNW9sEGo6J3nU08jDIB
 /507kVuOBSv8pY6Ywtl2zx+whBoAy6DlIuDf23ZyaL86JOvog16cX3OK27xv87B5ovjrqf1qoGX
 S0VGhwEJB9XcJtbPUEBHgp6nq3XWJswIPGaW9mXPs679cXZ8Smdy0Jk0GPXLlWeqpNGsgRM8X2m
 8hourAFXJDQhdoFpyBnUl/Zgx/1Fx0JS485v08Kn50QZyx+Zqcn8LufnFSXTWiQfD5ySOkb8Rkn
 c0g90adaBPHnSaidqzdsJgmWjAmq8dh3HY0OsYT3Yg2ecPDgZB7gvzoz/PiYULZn1y5AqLKbDHE
 9qWpFv4Cn55XNUGsAXIqlKiKY7s6dxOq/P+/n8EBNNPwGj/1uZ8twI+pfb30t5lsK2u5lYEufp4
 DihxSdm2UBpTgeBDJRg==
X-Proofpoint-ORIG-GUID: vB5mrBcxh7kbyZ628CiwM8y7r9wCrc9G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX5zMhIKrai6vp
 5URBE4EFYNTZRTrSk1iG+SGwUZ5v7pC18wM0QH+LYHAIYPNpMQr9YKf6M2e/sVLW8UgfcsfsFZx
 etfXmqj0PdyV1/TnJ7lyJpCDubEtw2Q=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95d400 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IVJOE9x0GOQlHws78pQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310164


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Expose per-queue buffer pool details via debugfs
>
> This adds a read-only buffer_pools file under
> /sys/kernel/debug/ibmveth/<dev_name>/ that dumps size, buff_size, active
> and available for every RX queue and buffer pool.  The per-adapter
> directory lives under a driver-owned root created lazily from
> ibmveth_probe(), and the historical queue-0 poolN sysfs attributes are
> left untouched.
>
> A few questions below about the dumped values and about the lazy creation
> of the driver root.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 5d4ca4b3d3d07..1b58a3c6ce77a 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -3421,6 +3422,68 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>>   #endif
>>   };
>>   
>> +static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
>> +{
>> +	struct ibmveth_adapter *adapter = m->private;
>> +	int i, j;
>> +
>> +	/*
>> +	 * Writers (veth_pool_store, open template copy, reset close/open)
>> +	 * update these fields under RTNL. Take the same lock so the dump
>> +	 * is not a torn scalar snapshot. Not required for
>> +	 * memory safety — embedded arrays only.
>> +	 */
>> +	rtnl_lock();
> [Severity: Low]
>
> Is this comment accurate for all of the dumped fields?  It says the
> writers of "these fields" run under RTNL, but pool->available is also
> printed here and is updated from the NAPI/softirq RX path:
>
> ibmveth_replenish_buffer_pool()
> 	atomic_add(buffers_added, &(pool->available));
>
> ibmveth_remove_buffer_from_pool()
> 	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);
>
> The second one runs under the per-queue replenish_lock, as its own
> kernel-doc describes, and neither takes RTNL.
>
> So rtnl_lock() does not serialize the Available column against the
> geometry columns; only atomic_read() keeps that value from tearing.
>
> Could the comment scope the RTNL claim to the geometry/active fields and
> say that available is merely read atomically?  As written, a later change
> that adds a non-atomic read of a NAPI-updated pool field under this
> rtnl_lock() would look safe when it is not.

Yes. Available is updated from NAPI/softirq; RTNL only covers
geometry and pool->active. The comment now says that; available is
atomic_read.

>> +
>> +	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
>> +	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");
> [Severity: Low]
>
> This isn't a bug, but does the "Size" column name collide with the
> existing poolN sysfs naming, with the opposite meaning?
>
> The debugfs table prints pool->size (a buffer count) under "Size" and
> pool->buff_size (bytes per buffer) under "BuffSize", while veth_pool_show()
> maps the attributes the other way around:
>
> 	else if (attr == &veth_num_attr)
> 		return sprintf(buf, "%d\n", pool->size);
> 	else if (attr == &veth_size_attr)
> 		return sprintf(buf, "%d\n", pool->buff_size);
>
> veth_pool_store() confirms this by range checking the size attribute
> against IBMVETH_MAX_BUF_SIZE and num against IBMVETH_MAX_POOL_COUNT.
>
> So "size" means a count in debugfs and a byte length in sysfs for the same
> pool objects.  Would naming the column "Count" or "Num" avoid that?
Yes. The column is now Count. Sysfs size stays a byte length on the
same object.
>> +	if (!adapter->opened)
>> +		seq_puts(m, "# down: Active/Available 0 unless allocated\n");
>> +
>> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
>> +		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
>> +			struct ibmveth_buff_pool *pool =
>> +				&adapter->rx_buff_pool[i][j];
> [Severity: Low]
>
> Can the Size/BuffSize columns print zero or stale values for queues
> 1..N here?
>
> ibmveth_probe() publishes the queue count up front:
>
> 	ibmveth_publish_num_rx_queues(adapter,
> 				      min(num_online_cpus(),
> 					  IBMVETH_DEFAULT_QUEUES));
>
> but only initializes the queue-0 pools with
> ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], ...).  The copy to
> the other queues happens later, in ibmveth_alloc_buffer_pools():
>
> 	/* Initialize pool metadata for queues 1..N from queue 0 settings */
> 	for (q = 1; q < ibmveth_get_num_rx_queues(adapter); q++) {
>
> Reading buffer_pools before the first open therefore prints rows with
> i > 0 showing Size 0 and BuffSize 0.
>
> After an open/close cycle there is a second case: veth_pool_store() while
> the device is down updates only the queue-0 pool and skips the reopen:
>
> 		pool->active = newactive;
> 		pool->buff_size = newbuff_size;
> 		pool->size = newsize;
>
> 		if (netif_running(netdev)) {
> 			rc = ibmveth_open(netdev);
>
> so queues 1..N keep the old geometry and the dump disagrees with queue 0.
>
> The only hint emitted is "# down: Active/Available 0 unless allocated",
> which covers just those two columns.  Should the note also cover
> Size/BuffSize for not-yet-templated queues, or should untemplated rows be
> skipped?
Yes. Before the first open, queues 1..N can show Count/BuffSize 0, and
a down-path sysfs store still updates queue 0 only.

>> +			bool live = pool->skbuff && pool->free_map;
>> +			int active = live ? pool->active : 0;
> [Severity: Low]
>
> Does the "Active" column here report something different from the
> identically named sysfs attribute and ethtool statistic?
>
> ibmveth_free_buffer_pool() deliberately keeps pool->active set when the
> allocation goes away:
>
> 	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
> 	 * Clearing active here was a v3 ifdown/up regression: open skips
> 	 * !active pools, so reopen posted no RX buffers
>
> while both existing surfaces print the raw flag:
>
> veth_pool_show()
> 	if (attr == &veth_active_attr)
> 		return sprintf(buf, "%d\n", pool->active);
>
> ibmveth_get_ethtool_stats()
> 	data[i++] = adapter->rx_buff_pool[0][j].active;
>
> With the interface down, .../pool0/active and poolN_active read 1 while
> buffer_pools shows Active 0 for the same pool.  Would a separate column
> name such as "Alloc" or "Live" avoid overloading the existing meaning of
> "active"?
>
> The commit message says the file "lists size, buff_size, active, and
> available for every RX queue and buffer pool" without mentioning that the
> Active column is really an allocation indicator; only the stripped v5
> changelog notes it.  Could the commit message state that?
Yes. Dump Active is live alloc (skbuff && free_map), because
free_buffer_pool keeps the sysfs flag for ifdown/up. Sysfs and the
old ethtool pool keys printed the raw flag.

>> +			int available = live ? atomic_read(&pool->available)
>> +					     : 0;
>> +
>> +			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
>> +				   i, j, pool->size, pool->buff_size,
>> +				   active, available);
>> +		}
>> +	}
>> +
>> +	rtnl_unlock();
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
>> +
>> +/* Driver-owned root so per-adapter dirs use a stable vio name, not the
>> + * mutable netdev->name (avoids stale names / eth0 collisions after rename).
>> + */
>> +static struct dentry *ibmveth_dbg_root;
>> +
>> +static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
>> +{
>> +	if (!ibmveth_dbg_root)
>> +		ibmveth_dbg_root =
>> +			debugfs_create_dir(ibmveth_driver_name, NULL);
>> +
>> +	adapter->debugfs_dir =
>> +		debugfs_create_dir(dev_name(&adapter->vdev->dev),
>> +				   ibmveth_dbg_root);
>> +	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
>> +			    adapter, &ibmveth_buffer_pools_fops);
>> +}
> [Severity: Medium]
>
> Is this test-then-assign of ibmveth_dbg_root safe against concurrent
> probes?  ibmveth_debugfs_init() is called once per device from
> ibmveth_probe(), and probe of two different vio devices is serialized only
> by the per-device device_lock, so a DLPAR IO add racing with another add
> (or with driver_attach during module load) can have both threads observe
> NULL:
>
> CPU0                             CPU1
> if (!ibmveth_dbg_root)           if (!ibmveth_dbg_root)
>     debugfs_create_dir("ibmveth")    debugfs_create_dir("ibmveth")
>     -> valid dentry                  -> ERR_PTR(-EEXIST)
> ibmveth_dbg_root = dentry
>                                   ibmveth_dbg_root = ERR_PTR(-EEXIST)
>
> fs/debugfs/inode.c returns ERR_PTR(-EEXIST) for the duplicate name
> (debugfs_start_creating() -> simple_start_creating() with LOOKUP_EXCL,
> then the dentry == ERR_PTR(-EEXIST) branch), and an ERR_PTR parent is
> passed straight back out:
>
> 	if (IS_ERR(parent))
> 		return parent;
>
> So after the race, every later per-adapter directory and buffer_pools file
> is created with an ERR_PTR parent and silently fails, and the handle to the
> real "ibmveth" directory is gone.
>
> Would creating the root once in ibmveth_module_init(), before any probe can
> run, avoid this?
Yes. Concurrent probe could race the lazy create and leave an ERR_PTR
parent. The root is now created in module_init(), before any probe,
and unwound if vio_register_driver() fails.
>> +
>> +static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
>> +{
>> +	debugfs_remove_recursive(adapter->debugfs_dir);
>> +	adapter->debugfs_dir = NULL;
>> +}
>> +
>>   static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>>   				   int pools_ready)
>>   {
>> @@ -3647,6 +3710,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	netdev_dbg(netdev, "registered\n");
>>   
>> +	ibmveth_debugfs_init(adapter);
>> +
>>   	return 0;
>>   }
>>   
> [ ... ]
>
>> @@ -3891,6 +3958,8 @@ static int __init ibmveth_module_init(void)
>>   static void __exit ibmveth_module_exit(void)
>>   {
>>   	vio_unregister_driver(&ibmveth_driver);
>> +	debugfs_remove_recursive(ibmveth_dbg_root);
>> +	ibmveth_dbg_root = NULL;
>>   }
> [Severity: Medium]
>
> Following on from the probe race above, does this leak the "ibmveth"
> directory?  If ibmveth_dbg_root holds ERR_PTR(-EEXIST),
> debugfs_remove_recursive() returns immediately for IS_ERR_OR_NULL, so the
> real directory and the simple_pin_fs reference it holds survive module
> unload, and a later module load hits -EEXIST for the root every time.
Yes. An ERR_PTR root made remove a no-op and left the real directory
across unload. Creating the root once in module_init() closes that

too: module_exit always has the real dentry to remove.

Regards,

Mingming


