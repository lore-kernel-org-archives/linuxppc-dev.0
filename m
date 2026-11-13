Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA05606A64E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVYioc1K
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5pH6D4Sz2xP9;
	Sat, 14 Nov 2026 05:47:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794595623;
	cv=none; b=U/gU+v9YyD+KvdNxaQbqKYLvl0bO3rYBCJor4m06ata6ZOZzcDcMd2uEc0VDWwDwQq0W7qEJRMxsRfKuyzUeCMe3xkxO9nt76DDzORx4pSu+GL8nNefzuBpUC1IeXsrdJqw0TxjihQjFf34JQV4VVUMdbGbilYENS1D9nrKNFG+K1qsNQbd24S95KENkmHUM7lA5G7MGotu6qyZXDugnQA0AlZtc5iUQMrLNWT9GndrDBod+QUapQunBWY9WcP/vclLYAPxF4aqLb+qGGFYJ+ZkNeKRKlT1j9sIJJScHCXPT6cVXq0DM68GlRUtxOy2wHnZsJRozg2PFNm6x4mrhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794595623; c=relaxed/relaxed;
	bh=Jal0E2Mnv0Z77Uatas4UWnyPfvwf7BXhd0FfO5WpX90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJp/DgUt89I0HtB7eDzIoPDAUpVs/ZbORMIJDknfli10F77GMcSBcgbv5NPBHwSUzunF5ywnw2R3J+vs74qMAWR51YZxdHpYJstvQbXu/UqxY+s4gqjXNgKSH9gwt/VSSAslBLKcV1cQnhQD9y2ksKgezmUWZKy+rCwOcHqlQkPvdXGoiyqq6tGh2q5tcrDkIe/3L22V5HeG1N0YI5tLROgZv+GmUMRfdHqd5fiYV3fTMZq3LkvaGiQXSbf31HLmE/15TyjF8KcxHmbFXeHW40gmcJ2pV0dh/30k5mOVFLSeTxlhWkUh9Ubuc0wzScmMLQeD+x+SmBfendU/+oHH2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVYioc1K; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVYioc1K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5pG3qpYz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:47:02 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFicZS2229943;
	Fri, 13 Nov 2026 18:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jal0E2
	Mnv0Z77Uatas4UWnyPfvwf7BXhd0FfO5WpX90=; b=tVYioc1KGR9qNbcZtKHrj0
	SaKq2oA8BFIEehQEreXeF/kevJZZ+shfB04BlDi+X8GKj1WlOnf48Sz/A4vD2iVD
	tLKiw+xtm+yQTCwUwL3CCfLenMmmLIRBxOTKMSCi6tsZQQSOY8Dox1tJ/IaOedZ4
	twTD1tvpSkZ9uAc7fvtQKnMaj/AHqu+2DnxXT8/hI5EHzMRZtHRRvyyeMZ+frsK7
	jFPQwlgbQ0tpf6xbS07Z9ut8aXicICxyHTPSzHDCucMngNJMwQormYT1QVk8k4Mk
	EQMYitca1UlsQjaVOtrXUBgHK2NlfSdE3XNrEsgmukoliI0RtD7+WqStUNPb188A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgm1y4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:46:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxLA2453165;
	Fri, 13 Nov 2026 18:46:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfd3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:46:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADIkQQg26936022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 18:46:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4919158017;
	Fri, 13 Nov 2026 18:46:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E0558028;
	Fri, 13 Nov 2026 18:46:23 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 18:46:23 +0000 (GMT)
Message-ID: <e4ebac16-58e6-49cd-9ead-20506f562380@linux.ibm.com>
Date: Fri, 13 Nov 2026 10:46:22 -0800
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
Subject: Re: [PATCH net-next v8 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-6-mmc@linux.ibm.com>
 <179452782074.2199510.13462227035463955143@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452782074.2199510.13462227035463955143@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af75b1a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=-iyn0Ag8WSiOA7Qd_NoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfX5oyqXXKTmPNp
 XxLk2N+n3VWCE3aYyLKCGcocp0qSLHKwj2ircjT0tEilUU6g3xbyWkb9UdAJdQKM7RKx0Ru1Wmx
 ytQq63shqi7rqhdTz2VpMthB3QTiwmeSZjVkBR9kjQlNLXUtyEuIt1xcYZiNYXwQJAQPbhmicf4
 KshXFa1SoRtpilmZdTwcpvvpcPjUX3CEyqwl9X6UMbcKPP4bP+nBjPVsekEfOe/dsg4DfqPagGp
 nujRwpr3C4Pe++hfiV1PsUcRjKEUNHz1YbepVFJw2WCH/WWypn4/U9U6mbxh3ImRqWqlfImEBCL
 CBmi17PgZIiQU6vxlo0w2OQHzjG2bod9svPa14X3F8CGdCLsb95goOCUtJRHel4kpMeNMlsMPLa
 5l+atm4BHuS4RHnz4j25zW2pPIiiP0g/Ca3qSdG9HOTWJM336B2wa7AOewohL/i+dTud165j5Ec
 j4/SZAmZjDiZqk1TR3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfX8Dukv8Mrw5H7
 WeGKGZ+Dx8nj96X+0/V5E+CLpL8eZp/Ny91ooLL4GOpvJ1d9H1/PEsKvHCtRQHHnhqPZ2JelmKA
 54tEY6hlv9ISuGpxcfOpDq3ZLXi4iN4=
X-Proofpoint-GUID: -rADtgCQYTUDKWFSRry3bXqcOAEPGRdL
X-Proofpoint-ORIG-GUID: l7Wa3GyWDJkIswvdVmTOVrqpWhxGI8M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130073
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] This is speculative and latent.
> - [Low] For subordinate queues, ibmveth_toggle_irq()
>    (drivers/net/ethernet/ibm/ibmveth.c) treats an H_PARAMETER return from…
>
> --
>
> ibmveth: Refactor RX interrupt control for MQ RX queues
>
> This adds queue-indexed RX interrupt helpers that use h_vio_signal() for
> queue 0 and H_VIOCTL for subordinate queues. It wires them into
> open/close/poll/interrupt and the process-context RX kick sites. Runtime
> stays single-queue (num_rx_queues is still 1).
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 31fad7713dc70..62e6c9a9f5e91 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -347,6 +349,325 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
> [ ... ]
>
>> +static int
>> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
>> +		   bool enable)
>> +{
>> +	unsigned long h_rc;
>> +	unsigned long irq = adapter->queue_irq[queue_index];
>> +	const char *action = enable ? "enable" : "disable";
>> +
>> +	if (queue_index == 0) {
>> +		/* Primary queue: use h_vio_signal() */
>> +		h_rc = h_vio_signal(adapter->vdev->unit_address,
>> +				    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
>> +	} else {
>> +		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
>> +		struct irq_data *irq_data = irq_get_irq_data(irq);
>> +		irq_hw_number_t hwirq;
>> +		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
>> +			H_DISABLE_VIO_INTERRUPT;
>> +
> [ ... ]
>
>> +		hwirq = irqd_to_hwirq(irq_data);
>> +		h_rc = plpar_hcall_norets(H_VIOCTL,
>> +					  adapter->vdev->unit_address,
>> +					  vioctl_cmd,
>> +					  hwirq, 0, 0);
> [Severity: Medium]
> This one is speculative. Do subordinate queues need the post-migration
> EOI that ibmvnic issues for the same kind of H_VIOCTL-controlled queue
> interrupt?
>
> drivers/net/ethernet/ibm/ibmvnic.c:
>
> /* Due to a firmware bug, the hypervisor can send an interrupt to a
>   * transmit or receive queue just prior to a partition migration.
>   * Force an EOI after migration.
>   */
> static void ibmvnic_clear_pending_interrupt(struct device *dev,
> 					    struct ibmvnic_sub_crq_queue *scrq)
> {
> 	if (!xive_enabled())
> 		ibmvnic_xics_eoi(dev, scrq);
> }
>
> ibmveth_toggle_irq() is the only place that re-arms subordinate queues.
> At the end of the series, ibmveth.c has no H_EOI or xive_enabled()
> handling anywhere.
>
> Suppose ibmveth subordinate RX queues have the same firmware behaviour.
> On XICS, an interrupt pending across LPM would then never get an EOI.
> That queue would stop taking interrupts: NAPI idle, PHYP enabled, RX
> stalled on that queue.

Not reachable for now: the HMC blocks LPM while ILLAN multi-queue is
active, so a partition can't migrate with subordinate queues live.
ibmveth also doesn't get a firmware migration event like ibmvnic does,
so there's nowhere it could issue that EOI today.

On the Power11 LPAR I tested, XIVE is the default, but XICS is still
possible with xive=off, and the ibmvnic workaround is XICS-only. Once
PHYP and the HMC allow LPM with ILLAN multi-queue, I'll check whether
the same firmware issue applies to the subordinate RX queues and add
the post-migration H_EOI if it does.

Thanks,
Mingming

> Nothing would start recovery either. After LPM, ibmveth only schedules a
> reset if the MQ buffer hcalls return H_FUNCTION.
>
> Queue 0 has migrated over XICS for years without this EOI. It is
> controlled by h_vio_signal() rather than H_VIOCTL, though, so that does
> not answer the question for subordinate queues.
>
> This path is latent until the later "ibmveth: Enable multi-queue RX
> receive path" commit. Could it be checked against PAPR/PHYP behaviour
> before multi-queue is enabled?
>
>> +
>> +		/*
>> +		 * Fold H_PARAMETER only on disable (idempotent mask). On
>> +		 * enable it is not already-enabled: a trivial enable
>> +		 * returns success. H_PARAMETER means the interrupt
>> +		 * number was not in the valid range for that unit
>> +		 * address. Keep that an error so a missed LISN stays
>> +		 * visible to poll/resize recovery.
>> +		 */
>> +		if (h_rc == H_PARAMETER && !enable) {
>> +			dev_warn_ratelimited(&adapter->netdev->dev,
>> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
>> +					     action, queue_index, hwirq);
>> +			return 0;
>> +		}
> [Severity: Low]
> Does the comment above this fold actually support it? It says a trivial
> enable already returns success, and that H_PARAMETER means the interrupt
> number was not in the valid range for the unit address.
>
> That describes a bad hwirq argument, not an interrupt that is already
> masked. The same reading would seem to apply to H_DISABLE_VIO_INTERRUPT.
> The commit message calls this an "idempotent mask".
>
> ibmvnic makes the same hcall and treats any non-zero rc as a failure:
>
> drivers/net/ethernet/ibm/ibmvnic.c:disable_scrq_irq() {
>      ...
> 	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,
> 				H_DISABLE_VIO_INTERRUPT, scrq->hw_irq, 0, 0);
> 	if (rc)
> 		dev_err(dev, "Couldn't disable scrq irq 0x%lx. rc=%ld\n",
> 			scrq->hw_irq, rc);
> 	return rc;
> }
>
> Two teardown paths rely on the mask actually taking effect:
> ibmveth_cleanup_rx_interrupts() and the err_disable_napi rollback in
> ibmveth_setup_rx_interrupts(). Both run mask, synchronize_irq(),
> napi_disable(), synchronize_net(), remask, then free_irq(). With the
> fold, a disable that PHYP rejected looks like a successful mask there.
>
> No subordinate-queue caller of ibmveth_disable_irq() checks the return
> value. So today the visible effect is only the log level (dev_warn
> instead of dev_err) and the self-contradicting comment. The path is also
> only reachable once num_rx_queues > 1, after the later "ibmveth: Enable
> multi-queue RX receive path" commit. The fold is still there at the end
> of the series.
>
> Should H_PARAMETER on disable stay an error, as it does on enable?
> Alternatively, the comment and commit message could explain why disable
> is treated differently.
>
> [ ... ]
>

