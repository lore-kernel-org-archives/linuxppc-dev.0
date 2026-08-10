Return-Path: <linuxppc-dev+bounces-25706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F6EC5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 23:53:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJs6F4LYSz2yys;
	Tue, 11 Aug 2026 09:53:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786406037;
	cv=none; b=gA717qAlzsS+T5ATDvCXEaqFs5ICIUF6Qjd1vJA1zbjt4wllssBQNhPzbeBX+e88xm68u2e0DB8ax7srqh4RNAwsWHB0QFWzJsC8pakwDCro9FGEuKsmkolXAASrJ84o2qSTlotXjwnrCcdEXiWAOsy0aRCVRwvXR/s0sZQXUH0hJGBkj29i3VVbi6R0GVHqAuil5i+1lJlwvobPZCKTofBlQCvoNcKhbcaHm/bmO5yeOY3ZvTiIiUK3Jztxm7aClSNUc2njFUviWTToMtjIxG5xdV71YXTJjqYciDIsTcSDDPSmqhuwmpTDNOOGC2fnqLSWL3zR7YzUGGWvbai/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786406037; c=relaxed/relaxed;
	bh=V7k38V+9jPNBn3ruKclQzBy7GCZvcM+CLVXMgnFiGo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zf0schgMSWtzogC2wXrXQ39CbPaO9voob03VuDI3zJu7yFmFOU07ljdqM+RLraLa2d8l3fif/SGEIgDV4z/JmaMvxWEUHizhkl5sqvGZIy13sJqVaiFeOI8rEq1pjQOJU9V5DkJTAm9+OdGvBexV9sGN6ksIaiLnG/cHg4dO20haXH60cKI7dV/mX60+PXn7Pw/VAiK6Qa76dWkqKK2s8hYf0OX/Ro+ZkrwF7CYSwhSFjBz9ULX75BrjpJSQbYdwSkH7pIB+CgjJu7MPzwSycGV1yutFDmYs4bOy/nOYmDqWV5kE58hAijdELo7WNffHH9206jS7OM9BBTV7TBb6gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCiiQ58g; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCiiQ58g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJs6D3QTlz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 09:53:55 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1pE31102358;
	Mon, 10 Aug 2026 23:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V7k38V
	+9jPNBn3ruKclQzBy7GCZvcM+CLVXMgnFiGo8=; b=fCiiQ58gZcpjlVNkSJGCOx
	Aj1QgwCIh19ZlylzPE6ZZ03vtJVoyY9eGadFChUU/ZLBK1p6koiubUs8EgB9sSLi
	AK4aZ9PzCuDh2CtbPnWp9R2YqJmyXVUqja/AlhOZQaimanu9ejRwSpLXHjZ5cbcG
	wSwASOhGr9nlJT7rQ01/JS4m0oA4jLW8j8LE2XX5nxOPz0H+GbCfi7L59mRxJ2uB
	MHMDk7CrGhdqht1iHgUsmxi0IxVkl1r9lPnhjAkZ38jbnRTpkd1hJSO1kIjjO8SN
	xWA79tOf6OMuIyICJe9LKAEEuPJfjWfkv1hsWvrDUPGzA1FOA1q6eNeSDqBx2cgw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjytjxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:53:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ANfFVF016160;
	Mon, 10 Aug 2026 23:53:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxxnnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 23:53:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ANrgCn13959836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 23:53:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9794458061;
	Mon, 10 Aug 2026 23:53:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C609B5803F;
	Mon, 10 Aug 2026 23:53:40 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 23:53:40 +0000 (GMT)
Message-ID: <2e4871b5-366c-4dda-9f6e-c30cdee2064e@linux.ibm.com>
Date: Mon, 10 Aug 2026 16:53:40 -0700
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
Subject: Re: [PATCH net-next v4 11/14] ibmveth: Expose per-queue buffer pool
 details via debugfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <fa6f1b5f19acd2b54f6b2c19d27bd79f4ff60599.1785457143.git.mmc@linux.ibm.com>
 <20260806183710.3175754-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183710.3175754-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfX1BKDp3rSl2p5
 cK2WGMRHu714CpwjjTBjRkThH5XsfZvr/OTNQvMYgE+t6GlyHbw3o5G65yvMnNFyZBHpFKZg0tH
 tcMgk90kVPpPqz+nxQSJLHR7iRkPXjYjZVGwN08SabI/+FXTMvASOzdLt/3U+rUnqi8fmC+bzGy
 j2+zQQk1xXEysJw8zyqwpzwwp76iSiWVldZNjzGJS2rhKS4sN1R0A894qJ/32c3bLQzsESGD8hO
 Qxe4axodatr4lCHzCw0/oBMpbxMNTGKvZc5NWtaRtKjZcPUeOc+GvC2JjIR5vX7YfwS+3Ulp9ML
 5iFOW7kpi/CLKDEDZjc39BZNZ+E5hbrmYGh5V/knF+UhqIUnFq3N8m+k2wwy0tUQ2j1Fyf7NrHB
 NW1iIjWFvGGx95+ifqp69QPTlPRdkPEmXi7NA2dcDoqIbwaMSYaCb1VI3k/vHTimG7gQXMYsxh6
 dR9+wsNOG5tZwK9J78w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDIwMCBTYWx0ZWRfX2a/OMLUV0LNv
 RQj3KLu/BBb4+MwDvo266jKLfN+hVgvKR0+kCXN44f3DkDkkaq60wgYP1BTRMOa9f/tAgdKUxo6
 F1gTVgA0QDo5tzADWO4+O3CTH65REbc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a6489 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=WjwCMHg84dksKkLecc8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BzEKP3R4CAqQV91SBqEgA9pxKN40-67g
X-Proofpoint-ORIG-GUID: Z5bna1R5QPP-_VFX__ZU3vQp5Gmp-25F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100200


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> his is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Expose per-queue buffer pool details via debugfs
>
> This adds a read-only buffer_pools debugfs file that dumps size,
> buff_size, active and available for every RX queue and buffer pool, and
> wires creation into ibmveth_probe() and teardown into ibmveth_remove().
> The existing queue-0 poolN sysfs files are left unchanged.
>
> A few questions about the new code below.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index dbb47a42b4cb5..db13747466025 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -2985,6 +2986,44 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>>   #endif
>>   };
>>   
>> +static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
>> +{
>> +	struct ibmveth_adapter *adapter = m->private;
>> +	int i, j;
>> +
>> +	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
>> +	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
>> +			struct ibmveth_buff_pool *pool =
>> +				&adapter->rx_buff_pool[i][j];
> [Severity: Low]
> Should this dump be taken under rtnl_lock()?
>
> ibmveth_buffer_pools_show() reads adapter->num_rx_queues plus
> pool->size, pool->buff_size, pool->active and pool->available with no
> lock held, but every writer of those fields runs under RTNL:
>
> veth_pool_store() {
> 	...
> 	rtnl_lock();
> 	...
> 	pool->active = newactive;
> 	pool->buff_size = newbuff_size;
> 	pool->size = newsize;
> 	...
> 	/* on ibmveth_open() failure, the same three fields are
> 	 * written back with the old values */
> 			pool->active = oldactive;
> 			pool->buff_size = oldbuff_size;
> 			pool->size = oldsize;
> 	...
> }
>
> ibmveth_alloc_buffer_pools() likewise copies the queue-0 geometry into
> queues 1..N-1 field by field under RTNL from ibmveth_open(), and the
> reset path goes through dev_close()/dev_open() under rtnl_lock().
>
> Can a concurrent read of buffer_pools therefore print a torn snapshot,
> for example active=1 paired with the previous size/buff_size, or a
> half-copied per-queue template, or the transient rollback state that was
> never an actual configuration?
>
> There does not appear to be a memory-safety consequence here, since
> rx_buff_pool[] is a fixed-size array embedded in struct ibmveth_adapter
> and only scalar members are read, so the concern is limited to the
> values printed.
Yes. The writers already run under RTNL, so the dump can otherwise
print a torn snapshot.

I'm planning to take rtnl_lock() around
ibmveth_buffer_pools_show() so the output stays consistent.

>> +
>> +			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
>> +				   i, j, pool->size, pool->buff_size,
>> +				   pool->active,
>> +				   atomic_read(&pool->available));
> [Severity: Low]
> Are Active and Available meaningful while the interface is down?
>
> ibmveth_free_buffer_pool() frees free_map, unmaps and frees all
> skbuffs, and frees dma_addr/skbuff, but leaves pool->active set and
> never decrements pool->available:
>
> 	kfree(pool->free_map);
> 	pool->free_map = NULL;
> 	...
> 	if (pool->skbuff) {
> 		kfree(pool->skbuff);
> 		pool->skbuff = NULL;
> 	}
> 	/* pool->active and pool->available untouched */
>
> available is only cleared later, in ibmveth_alloc_buffer_pool() via
> atomic_set(&pool->available, 0) on the next open.
>
> So a read after ibmveth_close() -> ibmveth_free_buffer_pools() ->
> ibmveth_free_queue_buffer_pools() -> ibmveth_free_buffer_pool() reports
> every configured pool as Active=1 with the last non-zero Available,
> even though the skbuffs and DMA mappings are gone.
>
> Related: for queues 1..N-1 the table prints all-zero rows before the
> first open, because the queue-0 template is only copied into those
> queues inside ibmveth_alloc_buffer_pools() during open.
>
> The commit message says "Per-queue runtime pressure is what debugfs
> shows" - could the down/uninitialized cases be either reflected in the
> output or documented?

Yes. The down/pre-open view needs to be more honest.

As written, the dump can present stale pool state as if it were live
runtime state after close, and it can also show all-zero subordinate
queues before the first open even though that is not the eventual
runtime shape. I'm planning to make that state more explicit by
clearing the down-state availability, treating pools without live
backing state as not active runtime pools in the dump, and adding a
short note when the adapter is not opened.

>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
>> +
>> +static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
>> +{
>> +	adapter->debugfs_dir = debugfs_create_dir(adapter->netdev->name,
>> +						  NULL);
>> +	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
>> +			    adapter, &ibmveth_buffer_pools_fops);
>> +}
> [Severity: Medium]
> Is the mutable interface name a safe key for a directory created
> directly in the debugfs root?
>
> Three separate things follow from passing NULL as the parent and
> netdev->name as the name.
>
> First, the name goes stale. The directory is created once, as the last
> statement of ibmveth_probe(), and the driver installs no netdev
> notifier and never calls debugfs_rename(). After the udev/systemd
> predictable-name rename that happens right after register_netdev(), or
> after any later ip link set dev ethN name foo, does the debugfs
> directory keep the obsolete name for the lifetime of the device?
>
> Second, with the debugfs root as parent the name has to be globally
> unique there. Consider the sequence: first adapter probes as eth0, udev
> renames it to enP1p1s0, a second ibmveth adapter probes and
> alloc_etherdev_mqs() names it eth0 again because eth0 is free in the
> netdev namespace. debugfs_create_dir("eth0", NULL) then collides with
> the first adapter's stale directory:
>
> fs/debugfs/inode.c:debugfs_start_creating() {
> 	...
> 	dentry = simple_start_creating(parent, name);
> 	if (IS_ERR(dentry)) {
> 		if (dentry == ERR_PTR(-EEXIST))
> 			pr_err("'%s' already exists in '%pd'\n", name, parent);
> 	...
> }
>
> The ERR_PTR is stored in adapter->debugfs_dir and handed to
> debugfs_create_file() as the parent, which returns immediately:
>
> fs/debugfs/inode.c:debugfs_start_creating() {
> 	...
> 	if (IS_ERR(parent))
> 		return parent;
> 	...
> }
>
> Does the second and every subsequent adapter then end up with no
> buffer_pools file at all, with only that debugfs pr_err as an
> indication?
>
> Third, netdev->name is read here after register_netdev() has published
> the device, without rtnl_lock(), while dev_change_name() rewrites
> net_device->name under RTNL. Can the string handed to
> debugfs_create_dir() be a partially updated name?
>
> Would a driver-owned parent directory plus a stable identifier such as
> dev_name(&dev->dev) avoid all three?

Yes. This is the main design issue in the patch.

Using `netdev->name` at the debugfs root means the directory can go
stale after rename, collide with a later adapter that reuses the old
name, and race with rename while the name is being read. I'm planning
to move this under a driver-owned `ibmveth/` parent and key each
adapter directory off the stable VIO device name instead.

I agree that once the naming is fixed, leaving debugfs creation
best-effort is much easier to justify. The bigger problem here is the
choice of key and parent, not the lack of hard failure handling.

>> +
>> +static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
>> +{
>> +	debugfs_remove_recursive(adapter->debugfs_dir);
>> +	adapter->debugfs_dir = NULL;
>> +}
>> +
>>   static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>>   				  int pools_ready)
>>   {
>> @@ -3182,6 +3221,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	netdev_dbg(netdev, "registered\n");
>>   
>> +	ibmveth_debugfs_init(adapter);
>> +
>>   	return 0;
>>   }
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (b6bfc50872782421f7178a42615ea39fe861918e607d995ed830a5a2db8a4460):
> [Severity: Medium]
> Addition of driver-private ethtool -S strings for standard queue statistic

I agree with the underlying point, but that belongs with the patch-10
stats/interface cleanup rather than this debugfs patch.

So my updated view is that the main patch-11 issue is the debugfs
naming and lifetime design, while the RTNL and down/pre-open reporting
points are real but lower-severity cleanup. I'm planning to tighten
those pieces here, but I still think debugfs is the right place for the
all-queue dump.

Thanks,
Mingming

