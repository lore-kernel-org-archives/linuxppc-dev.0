Return-Path: <linuxppc-dev+bounces-26341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBFC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:25:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYf8S6ZPdz2yCv;
	Tue, 01 Sep 2026 05:25:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788204312;
	cv=none; b=Z0/Ui4S//xBweGAwf+8LxLwk8CKeO8a1AS+IguxDJy/2X0mefRyVj3PN8pR+uvDw4AfrDVYi3FH2sTLnUZDZ3nLeeqoXEhjttprtcQhsajafYtvA8CDGke18NaeLQ2KmsPiwbyf1gpJoDiK77Y0L52XlOgRQ+PPz7K4b8WM3WtGIi3OTgmHF0xGUOVCZBKoElqVKNSPFVZkjphYsGUUvnwA20mScUac+GbL9Qy+JpjboiwpXa/YVZwJi0ZpMYAS+xjEIDWokl5T22igMmTH9ktXevXM+gD63marpZ4w6C2hmPKs6t0KKXnl2X/4DxDfKYmH04co6xm7P/Qu7SWt/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788204312; c=relaxed/relaxed;
	bh=17+nTmei7hPKeNu5+KXf7T5PswAQFOpGhYvjvFW4kNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cx7+P4Ugec4nI0NXIJcnCiQ4oPGAdjIuOddzkSDlM39lAAv3sGO5RG26JN0rLsC24HAPW6KfPwrwRL1Ah/ZZzSYk+j4nJ+wE5fXMYUU9H/TB8l5QqQam2bLrXDUWh31cfLZMeGfI3gXvfKlPLquymIPDPCS75YoxNlu3FZ1AgE2IzgEY4uAstAgs4xjoDbKbEte62+B96eRltveBtxlJS8GB5qu1+58UH0l+TWsNaaw0T13KGx/aAl5jCgp4sfEz5x16L28QuWHrCqPdEXv/M6dOrxQ+0up0+sVJFMYKVEuGN2y2oEB9alfVGLySw8WCY7S9W5rHxVcnF767lR/AsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oCV1l1PZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oCV1l1PZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYf8R6FFvz2yCt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:25:11 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIVxx51980108;
	Mon, 31 Aug 2026 19:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=17+nTm
	ei7hPKeNu5+KXf7T5PswAQFOpGhYvjvFW4kNI=; b=oCV1l1PZfNYo8v5+pohagR
	RGLzqFhBRu1jKbrPRL+Q6TRShAw6Cvf3fnxOcXDok+mG9+FKMy7xJxt5sv3y96dp
	Re15AUz2kHGhqz09+Nq2yt8ttBdpYzi5FOSiuvLRvSfH2PI0qBB7161cV4eedJrU
	MUnY0dsxbM19im0D0IDYuKAuZMOz+Tbb33MiflNmB9UF+UJrsPG2UhqXDpB1OzwT
	qdKkrZPAA5Cg9Glgggnauixnp0PZSIQiqCa6aN48efKFMN/NXnxWorxSd1EmdeMW
	65X5sTSS8hxaFYx0//Ri5/1lIVsNFOl8UqM4+fAS1yzwe3UiqicaPcQwRyzjWrug
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudkc8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:24:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJBRr9022330;
	Mon, 31 Aug 2026 19:24:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexyf80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 19:24:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VJOs8j33358396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 19:24:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B7755805A;
	Mon, 31 Aug 2026 19:24:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884E65803F;
	Mon, 31 Aug 2026 19:24:51 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 19:24:51 +0000 (GMT)
Message-ID: <9576ceac-04a7-4b43-99af-c2b390a3e02b@linux.ibm.com>
Date: Mon, 31 Aug 2026 12:24:50 -0700
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
Subject: Re: [PATCH net-next v5 15/15] ibmveth: Wire ethtool set_channels to
 MQ RX queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-16-mmc@linux.ibm.com>
 <20260818014739.3854502-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014739.3854502-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: kpD_wZPNsCjK4gl32oOhIiAYK_IWTbGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfX4bVvSZInT0lN
 wrv40scQFCG/xL2hk8opGlRKOWW2o9QKdK6NwsznX7Sy/+HDBMsFC1aY1M9ZKnkMESUGLeZdfa0
 szYNXkeyqjdr7uDL8O5H+I4hWkqoOGcK2S0IrmDpFp3y41NRN3TA7fqY6enFn6nT+9X3FkLSJxU
 OZ/wduXMekO+DDkdCAdMmQ3TouQXG4Lyt3j4Uz2avAIaCLw7vjsy30bYzewygps28sfZeleL6MZ
 tQokfFd5mIecaRXbDrIo+C8ptij5OTDOGKq+PNT7GJHRtPD4w1So5RUqTSDgetkzWfbwNrtJY7j
 3kdq+f/cNHiJbKIpZBBxCaE9h/m3X9TVDLLr6BIb0MXAYNgqfEr4goqgtDL5JsMIBJJWpzKKitm
 Hg/Dki/zH5oEe/yQykMYaUAJ+cIPSe2xGYvuQFKp7gMjgggEleslKKmjUST3PBHKX3K1KVbQg0S
 l3YtOyGQOYXvPuXUw/Q==
X-Proofpoint-ORIG-GUID: cyVXZjvoyOeUjDRLUdyMdrJ1s0aXoHGO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2NCBTYWx0ZWRfXwoovtAAIhWhd
 Xzz+nKzlj0TRLRccXNGYuvzNu31yC6JQnZQ4WCakLT/EfFrdxgXJbHRV9uCLPKr4C5LaSvNuy3m
 Sk/lv1tQwQHmDuNNMI1AE14AP00v4jk=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95d50c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QYSiNEhSMYtYGmkakyMA:9
 a=QEXdDO2ut3YA:10
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
> ibmveth: Wire ethtool set_channels to MQ RX queue resize
>
> This completes the RX side of ibmveth_set_channels(): while the device is
> down the desired RX count is stashed, and while it is up RX is resized
> first and the TX LTB stop/alloc/set_real_num_tx/free/wake path runs
> afterwards.  It also adds up-front TX range validation and an RX rollback
> when TX cannot reach the requested count.
>
> A few questions on the new paths below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 84f4a0deb0c55..35cbd2553e867 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -3175,28 +3176,75 @@ static int ibmveth_set_channels(struct net_device *netdev,
>>   				struct ethtool_channels *channels)
>>   {
>>   	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> -	unsigned int old = netdev->real_num_tx_queues,
>> -		     goal = channels->tx_count;
>> +	unsigned int old_rx = ibmveth_get_num_rx_queues(adapter);
>> +	unsigned int goal_rx = channels->rx_count;
>> +	unsigned int old_tx = netdev->real_num_tx_queues;
>> +	unsigned int goal_tx = channels->tx_count;
>> +	unsigned int want_tx = goal_tx;
>> +	int rxq_entries = adapter->rx_queue[0].num_slots;
>> +	bool rx_changed = false;
>>   	int rc, i;
>>   
>> -	/* Validate RX (and resize when opened) before the down-path early
>> -	 * return so MQ/range errors are not deferred to the wiring patch.
>> -	 * RX stash + CMO while down still lands with that patch.
>> -	 */
>> -	rc = ibmveth_resize_rx_channels(adapter, channels->rx_count);
>> +	if (goal_tx < 1 || goal_tx > ibmveth_real_max_tx_queues()) {
>> +		netdev_err(netdev,
>> +			   "Invalid TX queue count %u (must be 1-%u)\n",
>> +			   goal_tx, ibmveth_real_max_tx_queues());
>> +		return -EINVAL;
>> +	}
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the bound used here is
> CPU-count dependent while the reported current value is not, so the two can
> disagree.
>
> ibmveth_get_channels() fills the reply from two different sources:
>
> 	channels->max_tx = ibmveth_real_max_tx_queues();
> 	channels->tx_count = netdev->real_num_tx_queues;
>
> and ibmveth_real_max_tx_queues() is min(num_online_cpus(),
> IBMVETH_MAX_QUEUES).  After configuring N TX queues and then offlining CPUs
> so that num_online_cpus() < N, the reply advertises tx_count > max_tx.
>
> Both ethtool entry points reject a request whose tx_count exceeds the
> driver-advertised max_tx:
>
> net/ethtool/ioctl.c:ethtool_set_channels() {
> 	...
> 	if (channels.rx_count > curr.max_rx ||
> 	    channels.tx_count > curr.max_tx || ...)
> 		return -EINVAL;
> 	...
> }
>
> so even an RX-only change (which resubmits the current tx_count) fails with
> -EINVAL until the CPUs come back online.  Should max_tx be latched from the
> configured count instead, or should the new range check be against
> IBMVETH_MAX_QUEUES?
Yes, the pair can disagree after CPU hotplug. Pre-existing TX; left
alone here. On the cover leftovers list.
>
>> +
>> +	/* RX range / MQ checks live in ibmveth_resize_rx_channels(). */
>> +	rc = ibmveth_resize_rx_channels(adapter, goal_rx);
>>   	if (rc)
>>   		return rc;
>>   
>> -	if (!adapter->opened)
>> -		return netif_set_real_num_tx_queues(netdev, goal);
>> +	/* If RX resources are not live (never opened, or close+open failed
>> +	 * while IFF_UP stayed set), only stash desired queue counts.
>> +	 */
>> +	if (!adapter->opened) {
>> +		/* Apply TX first so a failure leaves RX stash unchanged. */
>> +		rc = netif_set_real_num_tx_queues(netdev, goal_tx);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/* Stash desired RX count; open() publishes it via
>> +		 * netif_set_real_num_rx_queues() after queue registration.
>> +		 * Refresh CMO now so open() can map the larger footprint;
>> +		 * open itself does not call vio_cmo_set_dev_desired.
>> +		 */
> [Severity: Low]
> Is this comment describing what the code does?  The block right below
> publishes immediately rather than deferring to open():
> ibmveth_publish_num_rx_queues() updates adapter->num_rx_queues and
> netif_set_real_num_rx_queues() updates netdev->real_num_rx_queues, which
> creates or removes the /sys/class/net/*/queues/rx-N entries while the
> interface is down.  ibmveth_open() only re-applies the same value later:
>
> 	rc = netif_set_real_num_rx_queues(netdev,
> 					  ibmveth_get_num_rx_queues(adapter));
>
> The commit message says the same thing:
>
>      - When down: set TX queues first, then stash the desired RX count
>        in adapter->num_rx_queues for the next open() (open publishes via
>        netif_set_real_num_rx_queues).
>
> Could the comment and the changelog mention that real_num_rx_queues, the
> rx-N sysfs entries and (below) the CMO entitlement all change immediately
> on a down interface?
Yes. The comment said stash; the code publishes immediately. The commit
message now says that: real_num_rx_queues, rx-N sysfs and CMO desired
all change while down.
>
>> +		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
>> +			ibmveth_publish_num_rx_queues(adapter, goal_rx);
> [Severity: Medium]
> Can publishing a count with no allocated queues behind it let a lockless
> reader take an uninitialized spinlock?
>
> adapter->num_rx_queues is the only validity bound the RX readers use, and
> rx_queue[i].replenish_lock is only spin_lock_init()'ed for queues that are
> actually allocated (ibmveth_alloc_rx_queues() and
> ibmveth_alloc_single_rx_queue()).
>
> ibmveth_replenish_task() checks nothing else before locking:
>
> 	if (queue_index >= ibmveth_get_num_rx_queues(adapter)) {
> 		...
> 		return;
> 	}
> 	...
> 	spin_lock_irqsave(&rxq->replenish_lock, flags);
>
> and ibmveth_poll_controller() has no adapter->opened check:
>
> 	unsigned int num = ibmveth_get_num_rx_queues(adapter);
>
> 	for (i = 0; i < num; i++)
> 		ibmveth_replenish_task(adapter, i);
>
> That is reachable in the state this branch targets: pool_store and
> change_mtu call ibmveth_close()+ibmveth_open() directly, so IFF_UP can stay
> set (netif_running() true, netpoll still attached) with adapter->opened
> false.  An "ethtool -L ethX rx N" with N above any previously allocated
> count then publishes N here, and the window stays open for as long as the
> device is down.
>
> ibmveth_publish_num_rx_queues() itself states the invariant:
>
> 	/* Per-queue state must be visible before readers observe num. */
> 	smp_wmb();
> 	WRITE_ONCE(adapter->num_rx_queues, num);
>
> Does this call site break it, given the per-queue state does not exist yet?
The locks are initialised in probe for every slot (patch 8). The hole
was walking rings that alloc_rx_queues() has not created. v6 returns
from poll_controller() unless adapter->opened.
>> +			rc = netif_set_real_num_rx_queues(netdev, goal_rx);
>> +			if (rc) {
>> +				ibmveth_publish_num_rx_queues(adapter, old_rx);
>> +				return rc;
>> +			}
> [Severity: Medium]
> On this failure path, netdev->real_num_tx_queues was already moved to
> goal_tx by the netif_set_real_num_tx_queues() call above, and only the RX
> publish is undone.
>
> netif_set_real_num_rx_queues() has a real failure path:
>
> net/core/dev.c:netif_set_real_num_rx_queues() {
> 	...
> 	rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues, rxq);
> 	if (rc)
> 		return rc;
> 	...
> }
>
> so ethtool can report failure while the TX count has permanently changed.
> Should netif_set_real_num_tx_queues(netdev, old_tx) run here before
> returning rc, and does the current code match the commit message claim
> "Make TX/RX updates fail atomically"?
It did leave TX moved. v6 restores the old TX real_num if down-path RX
set_real fails. The commit message no longer says fail atomically.

>> +			if (firmware_has_feature(FW_FEATURE_CMO)) {
>> +				unsigned long dma;
>> +
>> +				dma = ibmveth_get_desired_dma(adapter->vdev);
>> +				vio_cmo_set_dev_desired(adapter->vdev, dma);
>> +			}
> [Severity: Medium]
> Is the entitlement raised here ever lowered again if the stashed count is
> never realized?  The desired value is sized for goal_rx RX queues, but no
> buffer lists, queue DMA or pools are mapped while down.
>
> If the next open() fails for the larger count, or if it applies the MQ
> fallback and drops the count back to 1, neither ibmveth_open(),
> ibmveth_close() nor ibmveth_apply_mq_fallback() recomputes desired DMA, so
> the partition keeps CMO entitlement reserved for RX resources that do not
> exist until a later successful set_channels or change_mtu.
No. Desired is a ceiling, not consumed pages, but it is still wrong.
Same CMO leftover as TX still sizing one LTB. Cover leftovers.
>> +		}
>> +		return 0;
>> +	}
> [Severity: Medium]
> Can a request that returns 0 from this branch be silently discarded on the
> next open()?
>
> If firmware rejected MQ during a previous ibmveth_register_rx_queues(),
> adapter->mq_fallback is latched while adapter->multi_queue is still
> non-zero, so "ethtool -L ethX rx 8" passes the MQ check in
> ibmveth_resize_rx_channels(), takes this !opened branch, publishes 8, sets
> real_num_rx_queues = 8, raises CMO desired and returns success.
>
> ibmveth_apply_mq_fallback() then runs first in ibmveth_open():
>
> 	adapter->multi_queue = 0;
> 	ibmveth_publish_num_rx_queues(adapter, 1);
>
> with no error back to the user and no entitlement recompute, and
> ibmveth_get_channels() afterwards reports:
>
> 	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>
> which is 1, contradicting the request that returned 0.  Should the down
> path reject (or at least warn about) goal_rx > 1 when mq_fallback is
> latched?
Yes. Patch 14 rejects rx > 1 with -EOPNOTSUPP once mq_fallback is set.
This patch keeps reporting the live rx_count and caps max_rx at that
count, so a TX-only -L is not a silent shrink and the core blocks
growth.
>> +
>> +	if (goal_rx != old_rx)
>> +		rx_changed = true;
>>   
>>   	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>>   	 * but we may need to alloc/free the ltb's.
>>   	 */
>> +	if (goal_tx == old_tx)
>> +		return 0;
>> +
>>   	netif_tx_stop_all_queues(netdev);
>>   
>> -	/* Allocate any queue that we need */
>> -	for (i = old; i < goal; i++) {
>> +	/* Allocate any new TX LTBs. i starts at old_tx for the free walk
>> +	 * below when this loop body never runs (goal_tx == old_tx already
>> +	 * returned; goal_tx < old_tx is scale-down).
>> +	 */
>> +	i = old_tx;
>> +	for (; i < goal_tx; i++) {
> [Severity: Low]
> The commit message says:
>
>      Initialize the TX alloc loop bound so a scale-down path that never
>      allocates still has defined cleanup if set_real_num_tx_queues() fails.
>
> Was there anything undefined before?  The removed line is:
>
> 	for (i = old; i < goal; i++) {
>
> whose initializer runs even when the body does not (old >= goal), so i was
> already defined for the later "for (i = old; i > goal; i--)" free walk.
> Could this be described as a readability change rather than a fix?
Yes. i was already defined. The commit message now calls it
readability.
>>   		if (adapter->tx_ltb_ptr[i])
>>   			continue;
>>   
>> @@ -3205,28 +3253,43 @@ static int ibmveth_set_channels(struct net_device *netdev,
> [ ... ]
>
>>   	netif_tx_wake_all_queues(netdev);
>>   
>> -	return rc;
>> +	if (netdev->real_num_tx_queues != want_tx) {
>> +		if (rx_changed) {
>> +			int rb;
>> +
>> +			rb = ibmveth_resize_rx_queues_incremental(adapter,
>> +								  old_rx,
>> +								  rxq_entries);
>> +			if (rb)
>> +				netdev_err(netdev,
>> +					   "Failed to roll back RX queues to %u after TX failure: %d\n",
>> +					   old_rx, rb);
>> +		}
>> +		return rc ? rc : -ENOMEM;
>> +	}
> [Severity: Medium]
> This rollback is best effort only, so the same "fail atomically" question
> applies to the up path.  For "ethtool -L ethX rx <smaller> tx <larger>",
> the RX scale-down has already destroyed queues; if
> ibmveth_allocate_tx_ltb() then fails, the rollback here is a scale-up whose
> own steps can fail too:
>
> 	rc = ibmveth_alloc_single_rx_queue(adapter, i, rxq_entries);
> 	if (rc) { ... goto cleanup_new_queues; }
>
> and the same for ibmveth_register_single_rx_queue(),
> ibmveth_setup_single_rx_interrupt(), ibmveth_enable_irq() and
> netif_set_real_num_rx_queues().  Its cleanup path leaves RX at the reduced
> count, and here that is only logged before returning an error.
>
> Is there a way to order this so the destructive RX change happens only
> after the TX LTB allocations have succeeded, so no partial state can be
> left behind when the call reports failure?
Not without holding both sets. Live path stays teardown-first with
best-effort rollback. The commit message no longer says fail
atomically.


Regards,

Mingming


