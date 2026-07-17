Return-Path: <linuxppc-dev+bounces-24330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6CBC44512
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:40:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1XfJ5Cwrz2yVd;
	Fri, 17 Jul 2026 11:40:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784252408;
	cv=none; b=LoqS1jdEybVFrWgDF/Dz5MfvHonumpmfoIa2AOCwr/nTh3Vhl9dh2oSCyuJmAcybFVHUEprkj+7fIfpkLbTH9zo5/WzUpxGmqzaSsH6+qK5rdzKKM6s3Yb3huemaWskPvxRDzQ6AHzu93r2bNy3EYRVh4GRfYLjT0bUlgZuNj7FhMm2IhjZrMzQAurPC3ZS0AA0EraByOC/vHsWCo4vBKHF2YOim0FqMEB9fZteAntaHF8tmm/Zz5rk/rih77BDORo8J2G6UZhQ/7sVX6ui0OgDVVqms25f6bRFJXpRGom/hrzGaMdsUpHVYRXlJ80zICLm4PZl7v+VNIp5mHDZiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784252408; c=relaxed/relaxed;
	bh=htI1vhAg54Hdmwdem9Ea44wRJGWjtnUspphQJ40Xh1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPM00EM+o29LfvyCQHKMrcddMC5fQ7KrvjFUj7WMiMBGXHk427NSG3TqSY+DJ/7mNpu70bxTgg31Z9Phd1BC5VMjaSE0N/qAJtrfiAca+3zdZmyZaeDlfMJkCRAB6KBxNK6o4OEwjfVYlXeyJlIzkwMcUZkC2sDDUrs3TmT1+yAaUPNvc2ppS2Hsa/qEiAZd8gmmu1PAp6WoTML9n+SqXmz+MF2NF8FFtb2wYbs+fJs0KS7wLNHDj3xZtX9uCvVugWHBjcFjRpBK5G1VMFGRcWik8WmacBIRreFoUvN63ZORu5WmFfYMy3MkIE13NOStTSnNKQeIOsHI8i3grHP/CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ReTONol+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ReTONol+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1XfD3qyLz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 11:40:04 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNgBSr450029;
	Fri, 17 Jul 2026 01:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=htI1vh
	Ag54Hdmwdem9Ea44wRJGWjtnUspphQJ40Xh1M=; b=ReTONol+cd3+Kme5enI97z
	2LYBiExPD/yCZLodMcHFRIPGAmp6AX8Cc6BK7GEXkG3JhdCJWCGLNNmVKHCRUTW+
	r5rzTnsWkeTsYZ4tAJJsUlmcXQ5XBiTgqw20KHKdu/jriB6tuDYoowvrlfh6Ffk3
	nOu5qUWwdR1iOF1TPTQwwZDOah4Xw/uqwkEQnD+XNf2/PvtbCTPAQuq4Fvu5xGbI
	PuuSRnL9tVsFyV0pP8VZTUSKVajsDXQ8AY+ZcO2RtIZqJgCpAiziRdK79KuewPfF
	ng5ElNTuLcQ04Em7CTmYhIB+tZSn5+RVmOMgarR+XLJ9uifg6uSvuIBJMNTj/qKQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtm1pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:39:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H1YbWT007088;
	Fri, 17 Jul 2026 01:39:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyfbwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:39:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H1dqYu28967594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 01:39:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EC2B5804B;
	Fri, 17 Jul 2026 01:39:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0514A58055;
	Fri, 17 Jul 2026 01:39:51 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 01:39:50 +0000 (GMT)
Message-ID: <601832dd-6960-4691-bd6f-e726c884ebd4@linux.ibm.com>
Date: Thu, 16 Jul 2026 18:39:50 -0700
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
Subject: Re: [PATCH net-next v3 11/15] ibmveth: Add per-queue RX and TX
 statistics collection and reporting
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-12-mmc@linux.ibm.com>
 <20260714125948.1841205-1-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714125948.1841205-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kyyOnUx4KifqxHssx-rsi9idxsXWjY73
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwOCBTYWx0ZWRfXy00gQ653fQOw
 PZnEC/77mYpBZmL8Qw6eoy+roYdSF/xv7ta0ino1ZwiUzJt9B7Vy3xTrl/gKHAZhDDILpYmu8TJ
 +7DHlbtS9r+DJbSowZAUYhcpyKQN4b4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwOCBTYWx0ZWRfX1hAhli4BTx0Y
 d0F6Mf9W1ERzdwr0jcZgT+iS51yRr91Vy5ODdsEnUNmtrYj6tOPU7hC0wyIUUbRf8cazSL74aWN
 YSyQiDgwHrH5sP6bN278ZBMdrlZHx66znqzX/P/uBwnTapgKr95ritbdTgtEUMtNn5JZ6lnL2J4
 DGIX2Z1t8Kr8tbmi+rd7sSnmvpb5GvroDmJk1kNsjGo1f+vXw9CvxEo8/cIl35SJn4chRkGbhwD
 jMXHa6yky+QjMCLO0Wrzx0n2QL+ETv9avozbFH+QpCpgQyALcRnyCf9yf/nxuFhYCGbYyG9gmck
 CtNSU5rF9tFNcdJ/bpm+su789exLDcWqQqTxhByfWOjrFFRcSHg/uJQcI7MeRVApFSFrrrRww6h
 HtpjztAMapGM319xkRHithDtmOdG79KMNMNQeL+cH9ep1Y5KnUDbtG1MpmGFb1iUQE5wYFW4Yui
 W/3rUlYjgedUzT+muww==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5987eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=ve7GfL1ZdkmVSfFjdIIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: LkUFsAyMn4_BoKpubeg4Dbp5LQ0RRtOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170008


On 7/14/26 5:59 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Add per-queue RX and TX statistics collection and reporting
>
> This commit introduces per-queue statistics tracking for both receive and
> transmit paths in the ibmveth driver. The counters are aggregated for legacy
> interfaces and exposed individually via ethtool stringsets.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 863e5c68b42c7..4e3f49b6346fd 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>> @@ -1655,6 +1655,10 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_cleanup_rx_interrupts;
>>   
>> +	rc = ibmveth_alloc_tx_qstats(adapter);
>> +	if (rc)
>> +		goto out_free_tx_resources;
>> +
>>   	netif_tx_start_all_queues(netdev);
>>   
>>   	netdev_dbg(netdev, "open complete\n");
> [ ... ]
>>   out_cleanup_rx_interrupts:
>>   	ibmveth_cleanup_rx_interrupts(adapter);
>>   out_free_tx_resources:
>>   	ibmveth_free_tx_resources(adapter);
> [Severity: High]
> Does the goto out_free_tx_resources on ibmveth_alloc_tx_qstats() failure
> bypass the cleanup for RX interrupts?
>
> Since out_free_tx_resources is physically below out_cleanup_rx_interrupts in
> ibmveth_open(), failing here leaves the IRQs requested and NAPI enabled. If
> an interrupt subsequently fires, could the handler access the freed RX queue
> memory and cause a kernel panic?
>
> [ ... ]
*

  Confirmed — that goto skips RX interrupt cleanup. Will fix the

  open() unwind order in v4 so TX-stat allocation failure still

  disables NAPI and frees IRQs before tearing down queues.

*
>> @@ -1699,6 +1699,7 @@ static int ibmveth_close(struct net_device *netdev)
>>   		}
>>   	}
>>   
>> +	ibmveth_free_tx_qstats(adapter);
>>   	ibmveth_free_tx_resources(adapter);
>>   	ibmveth_cleanup_rx_interrupts(adapter);
>>   	ibmveth_update_rx_no_buffer(adapter);
> [ ... ]
>>   	ibmveth_free_rx_qstats(adapter);
> [Severity: High]
> If ibmveth_close() is called to bring down the interface, does this
> unconditionally free adapter->tx_qstats and adapter->rx_qstats without a
> grace period?
Confirmed.
>
> Since ibmveth_get_stats64() can be called concurrently under RCU, and
> ibmveth_start_xmit() can run concurrently if the datapath is not completely
> synchronized, could this lead to a use-after-free or NULL pointer dereference
> when these functions access the freed arrays?
>
> [ ... ]
*

  Good point. ndo_get_stats64 can run without RTNL. In v4 I’ll give

  the qstat arrays adapter lifetime (probe/remove) instead of

  open/close, so close cannot free them under concurrent readers.

*
>> @@ -1967,22 +1967,107 @@ static int ibmveth_set_features(struct net_device *dev,
> [ ... ]
>> +static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
>> +{
>> +	u64 total_invalid = 0;
>> +	u64 total_large = 0;
>> +	int i;
>> +
>> +	if (!adapter->rx_qstats)
>> +		return;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		total_invalid += adapter->rx_qstats[i].invalid_buffers;
>> +		total_large += adapter->rx_qstats[i].large_packets;
>> +	}
>> +
>> +	adapter->rx_invalid_buffer = total_invalid;
>> +	adapter->rx_large_packets = total_large;
>> +}
> [Severity: High]
> Does overwriting adapter->rx_invalid_buffer and other persistent global
> counters with the dynamically allocated adapter->rx_qstats values cause a
> permanent loss of interface statistics?
yes
> When the interface is brought down and back up, ibmveth_close() frees the
> queue stats arrays and ibmveth_open() reallocates them as zeroed. Will this
> cause all historical statistics to be wiped out on every interface reset,
> breaking standard persistence behavior?
>
> [ ... ]
*

  Agreed this regresses persistence vs pre-MQ.

**

In v4 per-queue qstats will stay for the adapter lifetime, and adapter-level

ethtool strings are summed on read (ibmvnic-style). No dual-updating

globals on the hot path, and no aggregate_* that wipes history on reopen.

*

>> +static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>> +{
> [ ... ]
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		ethtool_sprintf(&p, "rx%d_packets", i);
>> +		ethtool_sprintf(&p, "rx%d_bytes", i);
> [Severity: Low]
> Are these private ethtool stringsets duplicating standard kernel statistics?
>
> According to the subsystem guidelines, per-queue packet and byte statistics
> that have a standard UAPI representation (like struct netdev_queue_stats_rx
> exported via netlink) should not be duplicated as private ethtool strings.
*

  Thanks — **

*I can move those to standard*

*

netdev queue stats and drop the ethtool duplicates in a follow-up. For

now I'll keep device-specific counters (interrupts, polls, invalid, …)

as private ethtool strings.

*


*
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index f7b20fd01acb5..390c660af979e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -316,9 +316,21 @@ struct ibmveth_rx_queue_stats {
>>   	u64 no_buffer_drops;
>>   };
>>   
>> +struct ibmveth_tx_queue_stats {
>> +	u64 packets;
>> +	u64 bytes;
>> +	u64 large_packets;
>> +	u64 dropped_packets;
>> +	u64 send_failures;
>> +	u64 checksum_offload;
>> +};
> [Severity: Medium]
> Will this structure layout prevent cache line false sharing?
>
> The commit message mentions tracking transmit counters per TX queue to avoid
> cache line contention, but struct ibmveth_tx_queue_stats appears to be
> exactly 48 bytes and lacks cacheline alignment annotations like
> ____cacheline_aligned. When allocated as a contiguous array, will multiple
> CPUs processing different queues end up writing to the same hardware
> cacheline?


*Will add cacheline alignment for the per-queue stats structs in v4*

*Thanks again for your valuable feedback!*

*Mingming*


