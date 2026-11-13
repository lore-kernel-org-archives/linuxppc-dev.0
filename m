Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3048606A327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EKrsvFtq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR6Fr3cZ5z2xP9;
	Sat, 14 Nov 2026 06:07:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794596848;
	cv=none; b=NxfTIisUUQb1OpwEEvODltJPxPVDYHvJjmIw7Jp2roSB7RZlwvaFrwBgHXOEku/lBySniTWElJgQXgWw9DMAET9yvNF6FnhOBY3Ae3F91SnlAjdNK0H7JMRBnRuJZzF0+mfh+VcsLBzyNhWJV2byoW8fah4lwrT8ICXR1Th3eHbDVLgAC0PIQNLSNQw7S8NOl3MUS5dfF0Jx09EwnNIX1+nWSfOlJVTgqamW6jQ0CyZgywD1NNw86h0DilhhhbJNQ6xu4X/HoI+6Y4ti6k0DXLCir4uXEUC81KwCBjHTEpyiBqANoPuU3t+vwoLgLaBWnpcKSoIqjiEioqnDQ3ztWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794596848; c=relaxed/relaxed;
	bh=GAsUCwQqONKDIWfF0xZg3jW0auGhQeLmRMmjwIeZSYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHvCZ7UKs/7MuTQd+XRbUOkNkk43L4J7M3DMjDUe1mv+ngX5TSayDpfTlAM1DlCJE6KksFY7LtVJ4fMe4JOvptuT/iQ103RKsDgr2EWH5dCdRfIPOx+fkBw0UfkH796cup02jlbNirmqZLQ4MLf54od2GYi6woKVC9lAoZxSlYbhl6Yfz7zr+e43xWEJdg8vVfroSjsZL00hAyZxUPqvBiGOGOxOX2SZ9Q+dlV0NhPHo5J5e+HU2qCywOXT1WiPwjCIXjpsgfwpq+lTgy8TOnfxW2pE0PFQGCG1efgYUJZHL+7jkWMBTZZ5XD+NlX5YZ6hJ6Vzggf8HWv30r+d7Sog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EKrsvFtq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EKrsvFtq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR6Fq3mYjz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 06:07:27 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIvcpw4124198;
	Fri, 13 Nov 2026 19:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GAsUCw
	QqONKDIWfF0xZg3jW0auGhQeLmRMmjwIeZSYg=; b=EKrsvFtqwevvvXf3uI6Z3s
	xDRsOm8MGxNcJp8wL/+tCs5fzHnzeuXw8s4ux1qeCJpDzuoqTYa2IJbXLgsWhkes
	PLnFGBDHVNMKBETkF4OATlxUu4mKsOlOG8GcIMwG4TDRO6p8UIvmH6SRu/VqwOYG
	jCv4nWweEEfp38yx6dAta7vAzw6r00/QQYcNVAPkSKwfpbok9fz/SEpSEbsoLjZS
	nZD42MgIgQzyQhyKwRgFf4/yUrBWzNE5xSMO9/9p5oHEsCaLUpsrQRRCih8kKMHR
	VXtf/x9WSKXyzcpaC5L9AddzcIW4Bh1hVm9IESTsDEWt4oGzIMzVc8Qs6JKoADlg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6nb8m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 19:07:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADJ51PT2722803;
	Fri, 13 Nov 2026 19:07:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85de2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 19:07:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADJ7ECQ61800926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 19:07:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 190C25805D;
	Fri, 13 Nov 2026 19:07:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AAAB58017;
	Fri, 13 Nov 2026 19:07:11 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 19:07:10 +0000 (GMT)
Message-ID: <ea18450c-bfc6-48f4-9b08-fad59c880807@linux.ibm.com>
Date: Fri, 13 Nov 2026 11:07:10 -0800
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
Subject: Re: [PATCH net-next v8 14/15] ibmveth: Implement incremental MQ RX
 queue resize
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-15-mmc@linux.ibm.com>
 <179452783301.2199510.7559323985625318822@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452783301.2199510.7559323985625318822@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9mJL50QWYoRXKIAGeA916XNcbsG2aENP
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af75fe5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=CLErgtDeiL7DLUOR4LsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z5URPQSP-djic6QwNf-qhUpg-56OH_ta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXzGGJdyFmL7Io
 V2K4pEEeWgDyxs/vfxfeSEBJPLH6uURrblnzmfXRB3n1dHmYxQdeOyTfx3DB9xCDJpK8tsNskpS
 f1YKVv1aJGwdSl6kdTYBjCvMCNPTz1kpsfG6djFimtnDbiYn9Tkehji0ehmlemnGEMtlMqXjW6Y
 XMBb88kkmVJthcZURvBs+dL9vlx3ERSbEB0L8F3b5eqYNohKN3wQkMpRHRXFRj40Ls2Vf3j9PEZ
 RyrnekreqAUGTcbnQqcRy92Z8PSh972TaahAV2OqtlRsPk00HP35SOok9WNGec8Z+qbRntzO9YN
 V+O8QiFju8PJy+LVFk+k1kAekM5SM0ILuJlZ4x1IRBcatvILlB56DHnnvJpO4voK+4iC/9BlzgC
 2PeWXObgmZc7ufOuodOWZF0raYWmTMo3ikVvZicKylzRevX0RGDXCZDQdv4UbHTPebyFgeqAhch
 xqpqWNMYSilbQZNsELw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX0NelG6oNgeEG
 Yp+QBzSLBWO3CxHzdkgVh2Z435iXP68q+DmxB2IbhOKz4PF9I5xTV4qK7qdoPCYOYENQzUuqbqn
 ok+v8OD6MgmCuoQb+4quP2YXRPusFRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] ibmveth_destroy_subordinate_rx_queue() is used for live
>    ethtool -L scale-down, the scale-up enable_irq-failure branch and the…
> - [Low] When a scale-down hits the destroy-failure keep path,
>    ibmveth_scale_down_rx_queues() (drivers/net/ethernet/ibm/ibmveth.c)…
> - [Low] The kernel-doc of ibmveth_scale_up_rx_queues() says "A failure
>    unwinds only the queues this call added; a queue PHYP refuses to…
>
> --
>
> ibmveth: Implement incremental MQ RX queue resize
>
> This commit lets ethtool -L change the RX queue count on a live ibmveth
> adapter one queue at a time. It adds ibmveth_scale_up_rx_queues() and
> ibmveth_scale_down_rx_queues(), with unwind paths for hypervisor
> failures. It also factors ibmveth_desired_dma_for_rxqs() out of
> ibmveth_get_desired_dma(), and frees queues stranded above the live
> count after a successful H_FREE_LOGICAL_LAN.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index e805e7b1d2fe2..510d9d80e2df5 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -2028,6 +2315,644 @@ static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
>>   	ibmveth_free_filter_list(adapter);
>>   }
>>   
> [ ... ]
>
>> +/**
>> + * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @queue_idx: Queue index to destroy (1..N)
>> + *
>> + * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
>> + * ownership is released while queue metadata is still valid. After a
>> + * successful H_FREE, fold the last no_buffer sample into retired while
>> + * the page is still mapped. If the hcall fails, leave the queue mapped,
>> + * keep the handle, and skip retire.
>> + *
>> + * Return: 0 on success, -EIO if deregister failed
>> + */
>> +static int
>> +ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
>> +				     int queue_idx)
>> +{
>> +	int rc;
>> +
>> +	rc = ibmveth_deregister_single_rx_queue(adapter, queue_idx);
>> +	if (rc)
>> +		return rc;
>> +	ibmveth_retire_rx_no_buffer(adapter, queue_idx);
>> +	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
>> +	ibmveth_free_single_rx_queue(adapter, queue_idx);
>> +	return 0;
>> +}
> [Severity: Medium]
> Is the order of H_FREE_LOGICAL_LAN_QUEUE and the IRQ teardown safe here?
>
> ibmveth_deregister_single_rx_queue() issues H_FREE_LOGICAL_LAN_QUEUE
> first. Only after that does ibmveth_cleanup_single_rx_interrupt() run
> free_irq() and irq_dispose_mapping() on the queue's virq. That virq was
> created by irq_create_mapping(NULL, hwirq), using the hwirq returned by
> H_REG_LOGICAL_LAN_QUEUE. So the interrupt source belongs to the queue
> being freed.
>
> On pseries XIVE, free_irq() reaches xive_irq_shutdown(), which does an
> ESB access and an H_INT_SET_SOURCE_CONFIG hcall against that source:
>
> arch/powerpc/sysdev/xive/common.c:xive_irq_shutdown() {
>      ...
> 	xive_do_source_set_mask(xd, true);
> 	xive_ops->configure_irq(hw_irq,
> 				get_hard_smp_processor_id(xd->target),
> 				0xff, XIVE_BAD_IRQ);
>      ...
> }
>
> irq_dispose_mapping() then tears down the per-source XIVE data and its
> ESB mapping.
>
> If H_FREE_LOGICAL_LAN_QUEUE releases the LISN, these operations would
> run against a source the partition no longer owns. Could that produce
> failed hcalls, stale irq_desc state, or an ESB access to a page the
> hypervisor no longer backs?

Checked this with the PHYP team. H_FREE_LOGICAL_LAN and
H_FREE_LOGICAL_LAN_QUEUE don't release the interrupt source; the sources
stay allocated while the adapter is allocated, including while it's
down, and can be masked or unmasked during that time. Before this path
calls H_FREE_LOGICAL_LAN_QUEUE, scale-down has already masked the queue
in PHYP with H_VIOCTL and waited for the handler with synchronize_irq().

> The rest of this driver tears the IRQ down first:
>
>    - ibmveth_close() runs ibmveth_cleanup_rx_interrupts() before
>      ibmveth_free_all_queues().
>    - The open() error path disposes the mappings before
>      H_FREE_LOGICAL_LAN.
>    - The scale-up request_irq failure branch disposes before it
>      deregisters.
>
> ibmvnic's release_sub_crqs() also calls free_irq() and
> irq_dispose_mapping() before release_sub_crq_queue() issues
> H_FREE_SUB_CRQ.
>
> The commit message explains why deregister has to come before the DMA
> unmap, but not why it has to come before the IRQ teardown. Would it
> work to keep PHYP masked, call free_irq() (and dispose the mapping),
> then issue H_FREE_LOGICAL_LAN_QUEUE, and re-request the IRQ in the rare
> case the hcall fails?
The order is there for the rollback path, not the normal success path.
If H_FREE_LOGICAL_LAN_QUEUE fails with something other than busy, the
queue stays registered and PHYP may still DMA into it. Scale-down and
the scale-up unwind then put that same queue back in service by
enabling NAPI and unmasking the same virq. If we'd already freed the
IRQ and disposed the mapping before the H_FREE, the failure path would
have to rebuild the mapping and request the IRQ again in the middle of a
rollback that's already failing.

So destroy keeps the IRQ until H_FREE succeeds, or until H_PARAMETER
says the queue is already free. I'd rather not reorder just to match
close(): close() can free the IRQs first because it never has to put
the LAN back in service after a failed H_FREE_LOGICAL_LAN.


Thanks,
Mingming

