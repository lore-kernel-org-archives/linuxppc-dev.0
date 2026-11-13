Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC3606B35E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3dST9qf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR66M2P7Cz2xP9;
	Sat, 14 Nov 2026 06:00:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794596459;
	cv=none; b=gf5zSHUknVFufx++GRhtqsC1nqoEJ0sOsKkBThGK2N3y6Oh5QVJqsEXe6FGpTbqdSMOgxgNjXRy+yY4ixPlaKqKAg2oImrK9EitoGFyvcYtY5CYW/QmkbheaTM1YmaWbg+XQ7dJTKKvKbeIPlBMhiFn5EDYrvw30fN+lb7KwsYo3V8l5HywoEohgcVatfP9J8dbNaXqJFcLU8GK2z5jXfITdV4kmOPGpJiQqau+7Epac0Pyk37k6MIy4drMRzSGWzkcrU65m1F+CKhFiAtsPaiIB4bsWTQSQKK3nf+gg4i1zFVnhBxqTUTtu1eDPITnfYJRDWEn1/YmshDxj/7lEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794596459; c=relaxed/relaxed;
	bh=fuewAPLlqIvqq2VHFaSIXpBbZE+s6t70GvF1/X1V2MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBUem3ootqx+O3EZLUgFVAeCKNRGhI3fXV4QM0DPa09Vpl2DFVUXzSs1rp3R8pBUFtMdlyo8wudrY7c0PClE65pWf8ynLEgAswVe40UGIicXDTo70OTolIJdW6DWPMU1ofrO/wKO8XFZyyUEaRczhEG6YSmgEl1IM6S1fRqdkbYx7HF3wwPB1t/cjXzSVFst3gZ7d0JbFHubURyMVLVV1sqNyUV1/xMEruhsHw/MegfkNYoHb8JSL7ij4uKnjDhVCPaY8obfCI7Z6G62agg+3Zg6A+6kuUJGft7LodS1mK7sHQKmN46G4fnd873CQzbYUqpBsDB7Hx6o5BK3RRAnjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3dST9qf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3dST9qf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR66L3q5qz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 06:00:58 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIvi5t2705793;
	Fri, 13 Nov 2026 19:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fuewAP
	LlqIvqq2VHFaSIXpBbZE+s6t70GvF1/X1V2MI=; b=k3dST9qfahmvoyhDfdMMTx
	nXZN+U4RCeWMiHRoqwqNPc429nqECawJHwmWyjFHuU4T4aFnOAQitU/qKshnshEt
	8+RCxdHW8MqYwETwNsfalYhnph3EIlF5ZxBi+pN2BfKjCcmba9cdqPNmnRDQ9RMB
	YJ7JDooQ/slwtxJmqOaa4HycS6zH5AgogB/G2CWTcymVnUHgmaKawNy0ov+mHwiS
	PZBCPmhME77kVCDqLhM5aUmjQPeNSqSv7MI5sS4eNgo+d33U/9g0FcVz3Cf36EBI
	HRyKCXkxv97Y8CehWAbc37xJMEysGv5tUdLUSi/bKR2yOPxk8Zkj7rvuy3IHECBw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgm3fb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 19:00:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxd22531475;
	Fri, 13 Nov 2026 19:00:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwjcf47ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 19:00:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADJ0hkJ16974510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 19:00:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FABF58028;
	Fri, 13 Nov 2026 19:00:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BBBD58017;
	Fri, 13 Nov 2026 19:00:40 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 19:00:40 +0000 (GMT)
Message-ID: <bb29cbf9-20dc-4574-b084-0c3832849645@linux.ibm.com>
Date: Fri, 13 Nov 2026 11:00:39 -0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 11/15] ibmveth: Add per-queue RX and TX
 statistics collection
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-12-mmc@linux.ibm.com>
 <179452783113.2199510.7647821675893385517@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452783113.2199510.7647821675893385517@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af75e5e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=cprOaneoDXahzPzRN7oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXy+UThZ55DPLP
 ys4aqRW5bQBAr4RAd6bEucztZGD00mfVj/BBJjXl1X/qFQG2TZH54EW5n0RgDh93dj77MXPpqCw
 uMT0LzGO17Q86ibVRfcDPU4YMNAKQnSBpXHbK1nXmHfoFOTxB6Nt+mSSuhEn9umK1hWG6K6WPH6
 NY/Oby31TZNc40fPNDpW81JYoXhupUfd0e7Rh2QalZM6Q7VU7g+Mq8PODje2JzJg5meaJz8t3PB
 5NBnQFw46gq9GZd++W7+zdP/2icFw8SXYH6xx4PMfaFZymDGaFeYF91B0gvlY0gLp1JoSTHGzID
 8MGYk1jrCK1wERdSl7FYt5fMWBH5cHhYYaj8hXHwrOTovdn7E79/b97groymGBABCK+zsKnT9mX
 UayW4pXbSZ4l5H00phBzyTuW8gFBuopNk+I11Lrvw6jpcV8GNRlHs8dQ97aATrPFqCOEQY2oT3c
 WJ26Wuf9dykkCIQ100A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX10IzPe0IsRmi
 zqNyBg0XN9slpEep4EmOM/64kbYaJLhbsmLI6ZhlElT21YrOPFvUyRBmFAULMXsY2MMEu+UcGod
 BwLqMqK6+sPD2nllor8PbA31TMf2QKo=
X-Proofpoint-GUID: Iai_D2yEjCc3ivGtgRB6SpyVECBPCytn
X-Proofpoint-ORIG-GUID: EDDk7E4hx0onW7rFHgm0WFFocMd8dBDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Statistics readers now take every RX queue's replenish_lock
>    with spin_lock_bh().
>
> --
>
> ibmveth: Add per-queue RX and TX statistics collection
>
> This patch moves the adapter-wide RX and TX counters into per-queue
> ibmveth_rx_queue_stats and ibmveth_tx_queue_stats arrays allocated at
> probe. It exports packets, bytes and hardware drops through
> netdev_stat_ops, adds ndo_get_stats64(), and keeps the existing ethtool -S
> keys by summing the per-queue slots. It also adds a per-queue
> no_buffer_retired carry so that rx_no_buffer never goes backwards across a
> reopen.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index a0c3c06d2b9d9..45adf6e9be09b 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1063,7 +1197,45 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
>>   	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
>>   	drops = be64_to_cpup(p);
>>   
>> -	adapter->rx_no_buffer = drops;
>> +	qstats = &adapter->rx_qstats[queue_index];
>> +
>> +	if (drops < qstats->no_buffer_drops)
>> +		IBMVETH_STAT_ADD(qstats->no_buffer_retired,
>> +				 qstats->no_buffer_drops);
>> +	WRITE_ONCE(qstats->no_buffer_drops, drops);
>> +}
>> +
>> +/* Snapshot live+retired under replenish_lock; see retire_rx_no_buffer(). */
>> +static u64 ibmveth_rx_no_buffer_pair(struct ibmveth_adapter *adapter, int i)
>> +{
>> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[i];
>> +	struct ibmveth_rx_queue_stats *qstats = &adapter->rx_qstats[i];
>> +	u64 drops, retired;
>> +
>> +	spin_lock_bh(&rxq->replenish_lock);
>> +	drops = qstats->no_buffer_drops;
>> +	retired = qstats->no_buffer_retired;
>> +	spin_unlock_bh(&rxq->replenish_lock);
>> +	return drops + retired;
>> +}
> [Severity: Medium]
> Should the stats readers be taking replenish_lock here?
>
> This lock sits on the RX datapath. ibmveth_remove_buffer_from_pool() takes
> it from NAPI for every received frame. ibmveth_replenish_task() holds it
> for a whole multi-pool refill, which includes netdev_alloc_skb(),
> dma_map_single_attrs() and the h_add_logical_lan_buffers*() hcalls.
>
> The new ndo_get_stats64 calls this helper for every slot, whether the
> queue is live or not:
>
> ibmveth_get_stats64() {
> 	for (i = 0; i < IBMVETH_MAX_RX_QUEUES; i++) {
> 		...
> 		stats->rx_missed_errors +=
> 			ibmveth_rx_no_buffer_pair(adapter, i);
> 	}
> }
>
> The rx_no_buffer ethtool -S key, ibmveth_get_queue_stats_rx() and
> ibmveth_get_base_stats() also call it.
>
> As a result, every /proc/net/dev read, RTM_GETLINK dump or bonding/team
> stats poll takes up to 16 BH-disabling spinlocks. Unprivileged users can
> trigger these reads.
>
> Each acquisition pulls the lock cacheline away from the NAPI CPUs. A
> reader can also spin with BH disabled for as long as a refill takes, for
> example during the initial replenish in ibmveth_open().
>
> Before this patch the driver had no ndo_get_stats64, and netdev->stats was
> read without taking any lock.
>
> Writers already hold replenish_lock. Could they keep a single combined
> monotonic value (retired plus live drops) updated with WRITE_ONCE()? Then
> readers could use READ_ONCE() and skip the lock.
>
> This also looks unchanged at the end of the series, in "ibmveth: Complete
> set_channels down-path". There, ibmveth_rx_no_buffer_pair() still uses
> spin_lock_bh() and ibmveth_get_stats64() still calls it for every slot.
>
> [ ... ]
The lock is only there to get a consistent snapshot of the live and
retired no-buffer counts. The retire path moves the live count into the
retired one and clears it, so without the lock a reader could see a
mixed pair and report a transient double count or a lower
rx_missed_errors.

It's a cost on the stats readers, not a correctness problem in the RX
path. The reader holds each per-queue lock just for two loads, with no
allocation, DMA mapping or hcalls under it. It can still contend with a
refill that holds replenish_lock though, so I agree a lockless counter
is the better shape.

I don't think that should block the series. If there's a respin I'll
fold in a single combined monotonic value that the writers update and
readers load with READ_ONCE(); otherwise I'll send it as a follow-up
cleanup.

Thanks,
Mingming


