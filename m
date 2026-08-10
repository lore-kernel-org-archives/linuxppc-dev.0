Return-Path: <linuxppc-dev+bounces-25695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA60C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:07:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJplY6t0yz2xyl;
	Tue, 11 Aug 2026 08:07:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786399657;
	cv=none; b=ejlXAHGjmI9ynq4bVNbcr0yYAA8ugYyYtUsYkC8rvJ0ogmDWRKR1I5/Ko0xI4CCbfbOChW23uH7CYlH4DGrrMCvl1WmgF/P9mTGqKFKM0/T7+KDbJdcoeGTc2T5+pGxHz9lQiJ2EJZVcWyDFnQVxNh8w+rYAhuaB3VmrImsNur+zAQulPdPyD0+VcMNkC3qRmtOtybI3FuFpRSLnBe4DlAKwlRQ6ICZj0XA/kk/5Vyn533frFkhjzUGu742ha4joR38+EgucQ4xIm9OYgWSJMv3Epb0nYjKthvGsl78VunjjA6Og0G1AJqH/wX+eMN8bJ4ycGPg9RXVwJJI59oM07A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786399657; c=relaxed/relaxed;
	bh=HCGg9dQtBK1J4v8B+rNxzijmT3fe6DKkLNg/7X0AHio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6dTcg4xJ0HWfCs/1WpIxq0GlPOdkFoIh7PGAvC4IUItCkr2AiTAN+Z+OA0H770W1hZe30u2u6jdRPiv/nOXaimDV6wuOb9dNPZKB06Qwwl7X8K3Pi2AoKhiA8kXA0miuliuJFGQ6cUICImCUQmb0FscqdQJqdOJvFqQc/2H4v6vSzhMQXuh7Z3B/5CIesqHE2gexatqkseoGknbKngxrfoVpxs90MoCm7RjfPuG8QhnW9UMox0pmTaL29SpcsU692L8gTMOUVnozFm/nNCPqGQjyJmeeOAsLMgW0634PqzM5Uqpn0I5ARZPkizFxeZcMmGTTS3BaI2ZhHyC86K58w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MPZZ7xdw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MPZZ7xdw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJplX3683z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 08:07:35 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AK1i4x1504689;
	Mon, 10 Aug 2026 22:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HCGg9d
	QtBK1J4v8B+rNxzijmT3fe6DKkLNg/7X0AHio=; b=MPZZ7xdwjgdo2fBr/VPiKI
	V7djdEl/oGaO+rZEte3zpvdbx76RPvHkdd0q0XBr5/r7U15h1lqWaHOtKQSRGEXw
	vMxIdasPwLHhds+pLJVO7TOChIl0ZIdhjspkopuDIcUiPTrFwW8Co46szxFyGl7T
	ceETDLqykzzANRT/ACVdPK9Cx3ABUg1YldAFOCejkpBBMnQRQWPzZFhB99cO55Ye
	QjSoKy6lwS7jH/EII0tMp17+LYvTrONszJ9hFBpALVd8n3+dSzo8/skkG9BmT/LP
	BxTR0YdYn76DMpJso1qgglQd19mpsq5ipMI/DqU3bUNzas7JAnl73sKrkDdLTbww
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23k5f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:07:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ALuHNR032187;
	Mon, 10 Aug 2026 22:07:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vxqj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 22:07:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AM7ITY56230250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 22:07:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349A358063;
	Mon, 10 Aug 2026 22:07:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEB615804B;
	Mon, 10 Aug 2026 22:07:15 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 22:07:15 +0000 (GMT)
Message-ID: <9ab40b36-8c2f-4207-b2a9-6bc280811781@linux.ibm.com>
Date: Mon, 10 Aug 2026 15:07:15 -0700
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
Subject: Re: [PATCH net-next v4 05/14] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <3375291b81496032d02dc769c962a2fa323fb20b.1785457143.git.mmc@linux.ibm.com>
 <20260806183703.3175289-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183703.3175289-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a4b98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=GFl9camyTlaIMoP0ujMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX8AFA6WqVVR4N
 DJB9Vq7l1+4GWncgQ1nXatiW4zC/tuaTDSFJPUIN6nqTO9KjwWSiBcPwN3WXgLKfKiPC8sqmmCr
 hYVj5xjjo1FvngJpGID5jB9JEURDZJ6/0k8Feacuapuj169+2Ka+qBxBFfvLI+jMuaGSwzTlO+6
 5pBLu98kJ3TAX5LcoeW/ZfAB0Tg5V+xy5OsT8ln+uyX2Nk0+Ma0jvNR/bpeOH1TTernxxMZTaBi
 yL1RnPRDoLSvtO7u15lKcIeMOCVNf1cfDcN1BHDrWeZNGrpNgZuKEK/+lpJq+LWRNrntcYMVPRn
 ZTbOxcUTGi+XK+icQy5B26GrLZu1DwDGfWtlPaxW5tduuTb1v8ojF3C3IBLa8w+Akxjsn/BR/F1
 srghT+7zuZDE8HL+rLiC6T7BatIc5NIxglcwLqcXhl85y4aE0oh3D8TTuEBLjAnQx7zmVDWSNeB
 ALL9KdZVhuhgSteiyKQ==
X-Proofpoint-ORIG-GUID: 9mAsuVNvRP-lTY6VU8TKG0s7TxI0g_Yv
X-Proofpoint-GUID: 4MoXPHthi6jUqR64mMIhQY3sRKp6jxsy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NyBTYWx0ZWRfX+CTLXv3QWm7B
 dzpmP7uLcTz+CoJsHQMtITvEU4d0MVNfp+X4QAv7GUEgIwQafKjw3oXSvEvUNbJmeaBLUrfZKQ8
 +vehdMGAhuBx5OoBsmR2dXZC5oYCiCk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100187


On 8/6/26 11:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor RX interrupt control for MQ RX queues
>
> This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
> disable, setup/cleanup, schedule) and wires them into open(), close(),
> poll(), the IRQ handler and the process-context RX kick paths. request_irq()
> now passes &adapter->napi[i] as the cookie so the handler can derive the
> queue index, and napi_enable()/napi_disable() move into the new setup and
> cleanup helpers. Runtime behaviour stays single-queue.
>
> A few questions below.
Hi Jakub,

Thanks for the review.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 7a2ed49cad4f1..664169c4d27a4 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -329,6 +331,203 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
>>   	}
>>   }
>>   
>> +/**
>> + * ibmveth_toggle_irq - Common helper to enable/disable queue interrupts
>> + * @adapter: ibmveth adapter structure
>> + * @queue_index: Index of the queue (0 for primary, 1+ for subordinate)
>> + * @enable: true to enable, false to disable
>> + *
>> + * For queue 0 (primary), uses h_vio_signal() as it's registered via
>> + * h_register_logical_lan(). For subordinate queues (1+), uses H_VIOCTL
>> + * with H_ENABLE/DISABLE_VIO_INTERRUPT for per-queue interrupt control.
>> + *
>> + * Return: 0 on success, error code otherwise
>> + */
>> +static int
>> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
>> +		   bool enable)
>> +{
>> +	unsigned long rc;
>> +	unsigned long irq = adapter->queue_irq[queue_index];
>> +	const char *action = enable ? "enable" : "disable";
>> +
>> +	if (queue_index == 0) {
>> +		/* Primary queue: use h_vio_signal() */
>> +		rc = h_vio_signal(adapter->vdev->unit_address,
>> +				  enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
>> +	} else {
>> +		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
>> +		struct irq_data *irq_data = irq_get_irq_data(irq);
>> +		irq_hw_number_t hwirq;
>> +		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
>> +			H_DISABLE_VIO_INTERRUPT;
>> +
>> +		if (!irq_data) {
>> +			netdev_err(adapter->netdev,
>> +				   "Failed to get IRQ data for queue %d (virq=%lu)\n",
>> +				   queue_index, irq);
>> +			return -EINVAL;
>> +		}
>> +
>> +		hwirq = irqd_to_hwirq(irq_data);
>> +		rc = plpar_hcall_norets(H_VIOCTL,
>> +					adapter->vdev->unit_address,
>> +					vioctl_cmd,
>> +					hwirq, 0, 0);
>> +
>> +		if (rc == H_PARAMETER) {
>> +			/* H_PARAMETER is non-fatal when IRQ is already in
>> +			 * the requested state.
>> +			 */
>> +			netdev_warn_once(adapter->netdev,
>> +					 "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
>> +					 action, queue_index, hwirq);
>> +			return 0;
>> +		}
> [Severity: Medium]
> Is folding H_PARAMETER into success correct for both directions here?
>
> hvcall.h documents H_PARAMETER as "Parameter invalid, out-of-range or
> conflicting", and ibmveth_toggle_irq() cannot distinguish "already in the
> requested state" from a bad hwirq, wrong unit address, or a queue that is no
> longer registered.
>
> In the enable direction the swallowed status bypasses the recovery in
> ibmveth_poll():
>
> 	lpar_rc = ibmveth_enable_irq(adapter, 0);
> 	if (WARN_ON(lpar_rc != H_SUCCESS)) {
> 		schedule_work(&adapter->work);
> 		goto out;
> 	}
>
> so NAPI can complete with the queue still masked at the hypervisor and
> nothing left to reschedule it, i.e. that queue stops receiving, with a
> single warn_once as the only trace.
>
> In the disable direction, ibmveth_schedule_rx_queue() goes on to
> __napi_schedule() and ibmveth_cleanup_rx_interrupts() goes on to
> synchronize_irq()/free_irq() while believing delivery is masked.
>
> For comparison, ibmvnic treats any non-zero rc from the same hypercalls as
> an error in both directions, in disable_scrq_irq() and enable_scrq_irq().
>
> The branch is dead in this commit (num_rx_queues is 1), but it becomes live
> once the MQ patches land, where setup, resize and poll all depend on this
> return value. Would restricting the folding to the disable direction, plus a
> rate-limited per-queue message instead of netdev_warn_once(), be closer to
> the intent?
Agreed. Treating `H_PARAMETER` as success on the enable side is wrong.
For the disable side, I do not want to assume it is harmless without
firmer justification, so if any special handling remains there I will
make it explicit and better diagnosed rather than silently folding it
away.
>> +	}
>> +
>> +	if (rc)
>> +		netdev_err(adapter->netdev,
>> +			   "Failed to %s IRQ for queue %d, rc=%ld\n",
>> +			   action, queue_index, rc);
>> +	return rc;
>> +}
> [Severity: Medium]
> Does this mix two error domains in one int return?
>
> rc holds an unsigned long hypervisor status from h_vio_signal() or
> plpar_hcall_norets() (H_BUSY 1, H_HARDWARE -1, H_FUNCTION -2, H_PARAMETER
> -4), truncated to int on return, while the irq_get_irq_data() failure path
> returns -EINVAL.
>
> The callers then disagree about what they got. ibmveth_schedule_rx_queue()
> and ibmveth_poll() do:
>
> 	unsigned long lpar_rc;
> 	lpar_rc = ibmveth_disable_irq(adapter, qindex);
> 	WARN_ON(lpar_rc != H_SUCCESS);
>
> while ibmveth_setup_rx_interrupts()/ibmveth_open() treat the same value as
> an errno. One printk formats it with %ld, the other site logs it with %d.
>
> By the end of the series this reaches userspace: the scale-up loop in
> ibmveth_resize_rx_queues_incremental() does
>
> 	rc = ibmveth_enable_irq(adapter, i);
> 	if (rc) { ... goto cleanup_new_queues; }
>
> and cleanup_new_queues ends with return rc, which flows through
> ibmveth_resize_rx_channels() -> ibmveth_set_channels() to ethtool. H_PARAMETER
> (-4) then surfaces as -EINTR, and H_BUSY (1) or H_CLOSED (2) as a positive
> return that ethtool reads as success even though the queue count was rolled
> back.
>
> Since this commit establishes the helper API for the whole series, would it
> make sense to settle the convention now, either normalizing to errno or
> keeping the raw hcall status with a matching type, name, kernel-doc and
> format specifier?
>
> [ ... ]
Agreed. These helpers should return one error domain only. In v5 I will
keep the IRQ helper contract errno-based so later resize /
ethtool-facing paths do not have to interpret mixed H_*/errno returns.

>> +/**
>> + * ibmveth_setup_rx_interrupts - Register IRQs and enable NAPI
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Registers interrupt handlers for all RX queues and enables NAPI polling.
>> + * On error, cleans up any successfully registered IRQs before returning.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int
>> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
>> +{
>> +	struct net_device *netdev = adapter->netdev;
>> +	int i, rc;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (!adapter->queue_irq[i]) {
>> +			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
>> +			rc = -EINVAL;
>> +			goto err_free_irqs;
>> +		}
>> +
>> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
>> +				 0, netdev->name, &adapter->napi[i]);
>> +		if (rc) {
>> +			netdev_err(netdev,
>> +				   "request_irq() failed for irq 0x%x queue %d: %d\n",
>> +				   adapter->queue_irq[i], i, rc);
>> +			goto err_free_irqs;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		napi_enable(&adapter->napi[i]);
> [Severity: Medium]
> Can an interrupt arrive in the window between these two loops?
>
> request_irq() unmasks the virq via irq_startup(), and the LAN is already
> registered with the hypervisor by the time ibmveth_setup_rx_interrupts()
> runs, yet NAPI is only enabled in the second loop. Previously
> napi_enable(&adapter->napi[0]) was the first statement of ibmveth_open(), so
> this window did not exist.
>
> If an interrupt (including one latched at the controller while the line was
> shut down by the previous close's free_irq()) is delivered inside the
> window, ibmveth_interrupt() -> ibmveth_schedule_rx_queue() finds
> napi_schedule_prep() failing:
>
> 	if (napi_schedule_prep(napi)) {
> 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(lpar_rc != H_SUCCESS);
> 		__napi_schedule(napi);
> 	}
>
> so nothing is scheduled and nothing is masked, while the handler still
> returns IRQ_HANDLED. For a level-asserted hypervisor source that repeats
> until napi_enable() runs.
>
> This is also the inverse of the invariant the later scale-up path in this
> series states, "publish -> replenish -> napi_enable -> enable_irq ... so
> ibmveth_interrupt() cannot run on an unpublished, empty, or NAPI-disabled
> queue". Would enabling a queue's NAPI before installing its handler restore
> that ordering?
I agree the ordering needs to be coherent. Open and scale-up are not
identical cases, and the ordering here came from keeping the tested open
path with PHYP delivery still masked until `ibmveth_enable_irq()`. I
will clarify that invariant in the changelog and make sure the
open-path comments do not overstate it.

>> +
>> +	return 0;
>> +
>> +err_free_irqs:
>> +	while (--i >= 0)
>> +		free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	return rc;
>> +}
>> +
>> +/**
>> + * ibmveth_cleanup_rx_interrupts - Mask PHYP, disable NAPI, free IRQs
>> + * @adapter: ibmveth adapter structure
>> + *
>> + * Tears down RX interrupt delivery for all queues. Mask PHYP before
>> + * napi_disable so ibmveth_interrupt cannot return IRQ_HANDLED without
>> + * masking (same storm window as scale-down). Safe for close and for
>> + * open failure after setup_rx_interrupts() already unmasked PHYP.
>> + */
> [Severity: Low]
> Do these comments describe what the commit actually does?
>
> "Safe for close and for open failure after setup_rx_interrupts() already
> unmasked PHYP" - ibmveth_setup_rx_interrupts() only does request_irq() and
> napi_enable(), and the changelog agrees ("setup does not yet unmask PHYP").
> No ibmveth_open() failure path calls this helper either; setup rolls back
> through its own err_free_irqs label and open goes to
> out_free_buffer_pools/out_free_tx_ltb/out.
>
> "Mask PHYP before napi_disable so ibmveth_interrupt cannot return
> IRQ_HANDLED without masking" - see the question on the mask/napi_disable
> ordering below; an in-flight ibmveth_poll() can undo the mask.
>
> "Dispose IRQ mappings for subordinate queues (1-15)" sits above a loop that
> starts at 1, but ibmveth.h defines IBMVETH_MAX_RX_QUEUES as 1U and
> num_rx_queues is set to IBMVETH_DEFAULT_RX_QUEUES, so the loop cannot
> iterate in this commit.
>
> And ibmveth_toggle_irq()'s "Return: 0 on success, error code otherwise"
> conflicts with returning raw H_* codes that callers compare against
> H_SUCCESS.
>
> The first and third become accurate later in the series; the second and
> fourth remain as they are. Could the comments be trimmed to what this
> commit provides?
Agreed. I will trim the kerneldoc/comments so they match the actual
behavior in this patch rather than describing stronger later-series
guarantees.
>> +static void
>> +ibmveth_cleanup_rx_interrupts(struct ibmveth_adapter *adapter)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->queue_irq[i]) {
>> +			ibmveth_disable_irq(adapter, i);
>> +			synchronize_irq(adapter->queue_irq[i]);
>> +		}
>> +	}
> [Severity: Medium]
> Can a running poll undo this mask before free_irq()?
>
> synchronize_irq() waits for the hardirq handler only, not for an
> ibmveth_poll() already running in softirq context, and that poll
> unconditionally re-arms delivery on its completion path:
>
> 	lpar_rc = ibmveth_enable_irq(adapter, 0);
>
> Sequence with RX traffic flowing during "ip link set ethN down":
>
> CPU0 ibmveth_close() -> ibmveth_cleanup_rx_interrupts()
> 	ibmveth_disable_irq(adapter, 0);	/* PHYP masked */
> 	synchronize_irq(queue_irq[0]);		/* no hardirq running */
> 	napi_disable(&adapter->napi[0]);	/* blocks on the poll */
>
> CPU1 softirq ibmveth_poll()
> 	lpar_rc = ibmveth_enable_irq(adapter, 0);	/* PHYP unmasked */
> 	napi_complete_done(...)
>
> CPU0 then resumes and calls free_irq() with the source unmasked, and nothing
> re-checks or re-masks after napi_disable(). If an interrupt lands in that
> window, ibmveth_interrupt() -> ibmveth_schedule_rx_queue() takes the
> napi_schedule_prep() failure path, so no mask is applied while the handler
> still returns IRQ_HANDLED - the storm window the new kernel-doc says this
> ordering avoids. The window is bounded by the following free_irq(), but the
> teardown no longer reliably ends with the source masked.
>
> Should ibmveth_poll() avoid re-enabling while teardown is in progress, or
> should cleanup re-mask after napi_disable()?
Agreed. That teardown race is real. Later shutdown/quiesce fixes stop
poll from re-enabling delivery while teardown is in progress, and I
will fold that behavior back into the owning path rather than leaving it
as a tail fixup.
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +
>> +	for (i = 0; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->queue_irq[i])
>> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	}
> [Severity: High]
> This isn't a bug introduced by this patch, but the refactor makes the
> unbalanced teardown harder to see and hands the same invariant to the rest
> of the series, so it seems worth raising here.
>
> napi_disable() runs unconditionally for every queue, and free_irq() is gated
> only on queue_irq[i]. After a failed ibmveth_open() that leaves the
> interface administratively up, NAPI was never enabled and no handler was
> installed, yet both run on the next ndo_stop.
>
> napi_disable_locked() does:
>
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
> 		usleep_range(20, 200);
>
> and sets SCHED|NPSVC when it completes, so a second napi_disable() with no
> intervening napi_enable() loops forever, under rtnl_lock() plus the netdev
> lock. free_irq() on a never-requested IRQ additionally warns with "Trying to
> free already-free IRQ".
>
> Trigger in this tree: veth_pool_store() calls ibmveth_close() and then
> ibmveth_open() directly; if open fails (-ENOMEM from
> ibmveth_alloc_rx_queues(), -ENONET from ibmveth_register_logical_lan(), or
> request_irq() failure inside ibmveth_setup_rx_interrupts()) it restores the
> pool values and returns the error with the netdev still up. The same
> close()/open() pattern exists in ibmveth_set_csum_offload() and
> ibmveth_set_tso(). A later "ip link set dev ethN down" then reaches
> ibmveth_cleanup_rx_interrupts() and hangs.
>
> In the baseline, open() did napi_enable() at entry and napi_disable() at
> out:, and close() called free_irq(netdev->irq, netdev) unconditionally, so
> the same hang existed. What changes here is that queue_irq[0] is published
> in open() before request_irq() can succeed and is deliberately never
> cleared, so the new "if (adapter->queue_irq[i])" guard means "we have a virq
> number", not "a handler is installed". Could the helper track whether
> napi_enable()/request_irq() actually ran for each queue?
Agreed. This one is high priority. The close/cleanup path needs explicit
state tracking so a second teardown after close()+failed-open does not
walk partially initialized state as if it were live. In v5 I will keep
the `opened` / `rx_irq_setup` state tracking so cleanup is idempotent
and resize/open paths key off real setup state rather than bare
`IFF_UP`.
>> +
>> +	/* Dispose IRQ mappings for subordinate queues (1-15).
>> +	 * Queue 0 uses netdev->irq from device tree, not irq_create_mapping().
>> +	 */
>> +	for (i = 1; i < adapter->num_rx_queues; i++) {
>> +		if (adapter->queue_irq[i]) {
>> +			irq_dispose_mapping(adapter->queue_irq[i]);
>> +			adapter->queue_irq[i] = 0;
>> +		}
>> +	}
>> +
>> +	/* Queue 0 uses netdev->irq; leave queue_irq[0] for next open. */
>> +}
>> +
>> +/**
>> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @qindex: RX queue index
>> + *
>> + * Shared by the IRQ handler and process-context kick paths (open, resume,
>> + * pool sysfs, netpoll). Keep ibmveth_interrupt() as the IRQ-only wrapper.
>> + */
>> +static void ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>> +				      int qindex)
>> +{
>> +	struct napi_struct *napi = &adapter->napi[qindex];
>> +	unsigned long lpar_rc;
>> +
>> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
>> +		return;
>> +
>> +	if (napi_schedule_prep(napi)) {
>> +		lpar_rc = ibmveth_disable_irq(adapter, qindex);
>> +		WARN_ON(lpar_rc != H_SUCCESS);
>> +		__napi_schedule(napi);
>> +	}
>> +}
>> +
>>   /* setup the initial settings for a buffer pool */
>>   static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool,
>>   				     u32 pool_index, u32 pool_size,
>> @@ -947,8 +1146,6 @@ static int ibmveth_open(struct net_device *netdev)
>>   
>>   	netdev_dbg(netdev, "open starting\n");
>>   
>> -	napi_enable(&adapter->napi[0]);
>> -
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>>   		rxq_entries += adapter->rx_buff_pool[0][i].size;
>>   
>> @@ -972,7 +1169,8 @@ static int ibmveth_open(struct net_device *netdev)
>>   					adapter->rx_queue[0].queue_len;
>>   	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
>>   
>> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
>> +	adapter->queue_irq[0] = netdev->irq;
>> +	ibmveth_disable_irq(adapter, 0);
> Related to the teardown question above: queue_irq[0] is published here,
> before h_register_logical_lan(), the buffer pool allocation and
> request_irq(), and it is never cleared on any failure path.
>
>>   
>>   	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
>>   
>> @@ -993,21 +1191,16 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_free_tx_ltb;
>>   
>> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>> -			 netdev);
>> -	if (rc != 0) {
>> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>> -			   netdev->irq, rc);
>> +	rc = ibmveth_setup_rx_interrupts(adapter);
>> +	if (rc) {
>>   		do {
>>   			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>>   		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -
>>   		goto out_free_buffer_pools;
>>   	}
>>   
>>   	netdev_dbg(netdev, "initial replenish cycle\n");
>> -	ibmveth_interrupt(netdev->irq, netdev);
>> +	ibmveth_schedule_rx_queue(adapter, 0);
>>   
>>   	netif_tx_start_all_queues(netdev);
>>   
>> @@ -1024,7 +1217,6 @@ static int ibmveth_open(struct net_device *netdev)
>>   out_free_filter_list:
>>   	ibmveth_free_filter_list(adapter);
>>   out:
>> -	napi_disable(&adapter->napi[0]);
>>   	return rc;
>>   }
>>   
>> @@ -1036,11 +1228,10 @@ static int ibmveth_close(struct net_device *netdev)
>>   
>>   	netdev_dbg(netdev, "close starting\n");
>>   
>> -	napi_disable(&adapter->napi[0]);
>> -
>>   	netif_tx_stop_all_queues(netdev);
>>   
>> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
>> +	/* PHYP mask + napi_disable + free_irq live in cleanup_rx_interrupts */
>> +	ibmveth_cleanup_rx_interrupts(adapter);
>>   
>>   	do {
>>   		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>> @@ -1051,8 +1242,6 @@ static int ibmveth_close(struct net_device *netdev)
>>   			   "continuing with close\n", lpar_rc);
>>   	}
>>   
>> -	free_irq(netdev->irq, netdev);
>> -
> Also part of the teardown question: free_irq() now happens inside
> ibmveth_cleanup_rx_interrupts(), i.e. before h_free_logical_lan(), where the
> baseline order was napi_disable -> tx stop -> h_vio_signal(DISABLE) ->
> h_free_logical_lan -> free_irq. The changelog mentions the mask/napi_disable
> reordering but not this one. Was the free_irq/h_free_logical_lan inversion
> intended?
That ordering is intentional. Once PHYP delivery is masked, the Linux
handler is no longer needed for `h_free_logical_lan()`, and freeing the
IRQ first avoids leaving a handler around while the LAN handles are
being torn down. The separate `queue_irq[0]` point is the lifecycle
issue above: it can mean "have a virq number" before `request_irq()`
succeeds, which is why cleanup needs `rx_irq_setup` / `opened` rather
than `queue_irq[]` alone. I will call that ordering out in the
changelog.
>>   	ibmveth_update_rx_no_buffer(adapter);
>>   
>>   	ibmveth_free_buffer_pools(adapter);
>> @@ -1798,15 +1987,14 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	/* We think we are done - reenable interrupts,
>>   	 * then check once more to make sure we are done.
>>   	 */
>> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
>> +	lpar_rc = ibmveth_enable_irq(adapter, 0);
>>   	if (WARN_ON(lpar_rc != H_SUCCESS)) {
>>   		schedule_work(&adapter->work);
>>   		goto out;
>>   	}
>>   
>>   	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
>> -		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
>> -				       VIO_IRQ_DISABLE);
>> +		lpar_rc = ibmveth_disable_irq(adapter, 0);
>>   		goto restart_poll;
>>   	}
>>   
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (e3f4ca1fbf9d3f3114fde9e903e88e76f2f763bdede83ba454f20f9e157db105):
> [Severity: Medium]
> Incomplete Refactoring / Future Out-of-Bounds Access in ibmveth_poll
Agreed that the poll-side MQ wiring needed follow-up hardening, but I do
not want to overclaim that as fully owned by patch 5. The queue-index /
completion cleanup belongs with the later poll-path work, so I would
treat that as a follow-on fix rather than claim it is resolved here.

Thanks again for the detailed review,
Mingming

