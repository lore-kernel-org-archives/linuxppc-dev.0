Return-Path: <linuxppc-dev+bounces-24327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE24BC4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Wqg1smFz2yVd;
	Fri, 17 Jul 2026 11:03:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784250191;
	cv=none; b=aHbn4uDm70/3nxWNjpuMLlueDhW+lYso0eJjonuxRhhqsFZBSQ3e9y8nsktwX17buX9NeRqVqHCfl6R/ZL24L+F4PDMqvjkEVmFgW2NRGR+SjeElL9NXpycICmahM4udsfnhPpc8LKYu6vHS3V/dclTa1195oy1GhL4UdjCuR9iGbRCMWq2r24BWNR/UXJLLjeAmb8tswymfhAgJwaYpwkitnNhv6fLKLPP9XPEgxEsSXIrjF9seJgb5rMNj5rKfIBJ1Nv/bjEyHsUL5aLoH9VAGvQAbI7rSKPjjEQCKbrR0GxkNlmuUjtQOgvOzhiYk1uUSFL94Ez18g5OeDvyz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784250191; c=relaxed/relaxed;
	bh=cXHOHWk2LbrwMJZNngI7oGJbD43tJaYbWSU3Rz7FsZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqrZ12i4hOXlEMgjPkCrSRSL83NzZD+G4ZPZLpqBcLOxBUGoIvR9cE3vHBnE5HXsCj8L4Annq/oH5ST5kB8ou7Udc6b2032hCPpmXuYGBBe1UC2NJj32G1lryZb2ykBU8RQH25YWQXJQfvctrZ47ItJnnVwFoWn3nYzdXB4TdqMCVfncnOCxxzX3ue3jzjGpGeC3GdHWvG0iWrWsBXbTcplgiLDTPhD1NP8OvMyhd76clFV0liCizUUYvbT2Ajkiz7HQO1J8tVixOsbHes59qx+80lYTIggfcreSxjIvlwtxNxbgizmb1F6dXNCgwyOMLGazHrmhAJMXA0LmHFXZJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f7hgjGDw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f7hgjGDw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Wqd5WJ0z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 11:03:09 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNgYau429971;
	Fri, 17 Jul 2026 01:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cXHOHW
	k2LbrwMJZNngI7oGJbD43tJaYbWSU3Rz7FsZs=; b=f7hgjGDwpYZdYFAGfjdZy4
	kut22wNzGSKYODfT8hlGxYj/AA4gA05e/HF6eU1U8eCqzFGZNw7j070EKq/ZDIMo
	Y9fv0FkIPM0XbYnwm4Leq4uFkhhd0S9ElBT1HegU7BXVktS12ExVxYMQax2eovZb
	C5w0CJLP6ATJBsp89HVSxVj0QJJUu4dVAKiVGNTqNJmST7Cb0FjXY2AC9pYkGGQZ
	4HVvc54XXRTodVvUVDCYs8x2PZ0iloD+yh+oSVB6UcoYtTnjBty/u/mjOfKf4AqX
	ylnMoCjb2teWWOye6SihzYpVU/A0oaDlAPoRfMf8qszrhB+AYRn12mSVBcbJ+L4g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc3125-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:02:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H0nlY7026485;
	Fri, 17 Jul 2026 01:02:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyf8ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:02:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H12tUf18350672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 01:02:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A844B58066;
	Fri, 17 Jul 2026 01:02:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690985804B;
	Fri, 17 Jul 2026 01:02:54 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 01:02:54 +0000 (GMT)
Message-ID: <ec9288ef-1ada-4634-ac3c-e61f5c7f62c6@linux.ibm.com>
Date: Thu, 16 Jul 2026 18:02:53 -0700
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
Subject: Re: [PATCH net-next v3 09/15] ibmveth: Add queue-aware RX buffer
 submit helper for MQ
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-10-mmc@linux.ibm.com>
 <20260714125019.1833862-2-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714125019.1833862-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a597f42 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=tabgTeRoll34nVhkzG4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMyBTYWx0ZWRfX254tCXNoxTgt
 NTjZwRYkEBRgrt813h+u4Oja3/gwwZm06eHdYb22fFBDiiLo1EeuBRZfBDh7ytFAudpZwxhVgnk
 TWq76DWH+0lvRaUG5mqb/8vasNuud7WB94QXpzYRjz1TK1hS2ycEl8P+kK9NdYeM0mHJY5NSodO
 JQIADouRNM1te+YUsUzSzTKZU6ldpxgTwBJIbHIuN1DGO2o4F2VJBwXFI3nOjue/XNzdvNQ/ZIg
 tPwSt6rD4TIDZ7897Imcbu58gwgtHUsGPcADeNilAEPckA40fPaS1H8bg5wa5YJrtF6+oEh/f5v
 zfKTQVto7F1S28Gp4N0YTkk3DkMWBoCW22edbYSexResULeyRMfCP++mL/AAyVQHXyvFbySfaBZ
 rZbO9/ug67lvUxsBUpvnQF5C+XrlEvN2/Iks7VIepnLxn/Hrd6HwIUuq19MKu2+pOOOp13fyEkm
 kdGUGAkB8K3DBf0iLTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMyBTYWx0ZWRfX5PFsF7ESqvbw
 n3UY1NJr1du7nZC3I1ys7ihuLfNZ5ILrtFDv6gf1uY82Nv7L5E9WClR9C8im+2AJuGfLT82GEdm
 yIpyrCdM8ukl4AYSCpwUxUOU3INZ9c8=
X-Proofpoint-GUID: 2FIN6M0Gp7FhkD3zSdCipAvc_TQzLbkS
X-Proofpoint-ORIG-GUID: ikg4Jx6__mu2JmwVHOXKglNF6x7T4lBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170003

On 7/14/26 5:50 AM, Simon Horman wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Add queue-aware RX buffer submit helper for MQ
>
> This patch updates the ibmveth driver's buffer replenishment path to
> be queue-aware for multi-queue receive support. It adds a helper to select
> the correct hypervisor call and handles fallback to single-buffer mode if
> batch operations are unsupported.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index fa2d4777ffc7b..b3b3886c3eedb 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -597,11 +597,73 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
> [ ... ]
>
>> +static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
>> +					    union ibmveth_buf_desc *descs,
>> +					    int filled,
>> +					    unsigned long buff_size,
>> +					    int queue_index)
>> +{
>> +	struct vio_dev *vdev = adapter->vdev;
>> +	unsigned long rc;
>> +
>> +	if (adapter->multi_queue) {
>> +		unsigned long buffersznum = (buff_size << 32) | filled;
>> +		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
>> +		int i;
>> +
>> +		/* Pack descriptor addresses into ioba pairs.
>> +		 * Each ioba holds two 32-bit addresses packed into 64 bits:
>> +		 * - Even descriptors (0,2,4...) go in high 32 bits
>> +		 * - Odd descriptors (1,3,5...) go in low 32 bits
>> +		 */
>> +		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
>> +			int pair_idx = i / 2;           /* Which pair: 0-5 */
>> +			int is_high = (i % 2 == 0);     /* High or low 32 bits */
>> +
>> +			if (is_high)
>> +				ioba[pair_idx] = (unsigned long)descs[i].fields.address << 32;
>> +			else
>> +				ioba[pair_idx] |= descs[i].fields.address;
>> +		}
>> +
>> +		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
>> +						     adapter->queue_handle[queue_index],
>> +						     buffersznum,
>> +						     ioba[0], ioba[1], ioba[2],
>> +						     ioba[3], ioba[4], ioba[5]);
>> +		adapter->hcall_stats.add_bufs_queue++;
> [Severity: Medium]
> Will this counter increment lose updates when multiple NAPI poll routines run
> concurrently on different CPUs?
*

Thanks — these are informational ethtool/debug counters and can

race under concurrent NAPI, as with many driver stats. Datapath

correctness does not depend on them.

*
> Since multi-queue enables concurrent execution, it seems global statistic
> counters like hcall_stats.add_bufs_queue and replenish_add_buff_success might
> need atomic or per-CPU operations to avoid read-modify-write data races.
*

  I'm happy to harden selected counters with atomic64_t (or percpu counter)

in a follow-up; I don't think that needs to gate MQ...

*

>> +	} else if (filled == 1) {
>> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
>> +					      descs[0].desc);
>> +		adapter->hcall_stats.add_buf++;
>> +	} else {
>> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
>> +					       descs[0].desc, descs[1].desc,
>> +					       descs[2].desc, descs[3].desc,
>> +					       descs[4].desc, descs[5].desc,
>> +					       descs[6].desc, descs[7].desc);
>> +		adapter->hcall_stats.add_bufs++;
>> +	}
>> +
>> +	return rc;
>> +}
> [ ... ]
>
>> @@ -745,24 +798,19 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>   		}
>>   		adapter->replenish_add_buff_failure += filled;
>>   
>> -		/*
>> -		 * If multi rx buffers hcall is no longer supported by FW
>> -		 * e.g. in the case of Live Partition Migration
>> -		 */
>> -		if (batch > 1 && lpar_rc == H_FUNCTION) {
>> -			/*
> [ ... ]
>
>> +		if (lpar_rc == H_FUNCTION) {
>> +			if (adapter->multi_queue) {
>> +				netdev_err(adapter->netdev,
>> +					   "Unexpected H_FUNCTION from multi-queue buffer add (queue=%d, batch=%d)\n",
>> +					   queue_index, batch);
>> +				break;
>> +			} else if (batch > 1) {
>> +				netdev_warn(adapter->netdev,
>> +					    "H_FUNCTION from legacy batch buffer add (batch=%d), falling back to single buffer mode\n",
>> +					    batch);
>> +				adapter->rx_buffers_per_hcall = 1;
>> +				continue;
> [Severity: High]
> Does this continue statement cause an infinite loop?
*Good catch! yes.*
>
> Looking at ibmveth_replenish_buffer_pool(), the local batch variable is set
> before the while loop:
>
> 	batch = adapter->rx_buffers_per_hcall;
> 	while (remaining > 0) {
> 		...
>
> If the fallback updates adapter->rx_buffers_per_hcall to 1 and issues a continue,
> the loop will restart but the local batch variable will retain its original
> value.
>
> Would this lead to the loop repeatedly attempting the unsupported batch size
> and failing with H_FUNCTION forever?
You are correct, the MQ replenish rewrite accidentally used continue 
instead of break on the non-MQ multi-buffer path (!multi_queue && batch 
 > 1 && H_FUNCTION). The MQ H_FUNCTION arm already hard-fails and*

breaks — that wasn't the bug. I'll restore the pre-MQ break in v4.

*
>> +			}
>>   		}
>>   		break;
>>   	}
>> @@ -784,18 +832,24 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>>   }
>>   
>>   /* replenish routine */
>> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
>> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>> +				   int queue_index)
>>   {
>>   	int i;
>>   
>> +	if (queue_index >= adapter->num_rx_queues)
>> +		return;
>> +
>>   	adapter->replenish_task_cycles++;
> [Severity: Medium]
> Similar to the hcall_stats counters above, could this increment suffer from data
> races when multiple queues are processed concurrently across different CPUs?Ah yes
Ah yes, *

Same as the hcall_stats note — racy informational counter; optional

**

atomic/per-queue follow-up, not a functional MQ bug. (since this series 
is already large enough)

*

Thanks for your review again!
Mingming

