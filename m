Return-Path: <linuxppc-dev+bounces-26318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C606EC61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 17:58:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYcDt5ZfLz2y2f;
	Tue, 01 Sep 2026 03:58:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788199134;
	cv=none; b=ZqHB9vFT8T3DqJVp0Wg3VMNcSy1Viyprw9c+mvIOnVjeIJZj5cUBA4N/iwzdUyyuQG7D38zhH+2Ulg+iIqfw7FTP9F49/nkcSsRfA2hqN21N7lEBnO9SIBJA1aXk9jF5k5Kcoyf0kax0vTBZ8/OudwpCIaLz7RhXPdhd6EdSXSpAEZHpv0uP2uiQy5Zq/MqPHWtKo/1VJJFog6kNL+Zc/CF1+E+6X28xRhNP5iJ/kMefKyB9u0JyhGkJjQGhOXQAAye3Vi4wTkGKfwVrvuCD/biCBqDQc6lSlMvpAwtwYYKGW6xXFhuWtuUMqFwGYndLGZXy8pLsNWudBICDIhLB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788199134; c=relaxed/relaxed;
	bh=BFzkAvK4B5NIvBtjMcthfPNkUY2fwwOCxqhgKC3xxWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afM7QcN2i8PN9BMDvh9CiM+IkIBarjXk3g83NZrzDFkwGHCVHltSILA/7uGhimO4FoN959aggLDXPatMslKxAFkf/csiwm+kmG4CzGPodWQAXsnEPT4FUj1nGMdk9ObuBGyHs6kw4j9zWMRgcWhUY3dRNDcswNwYwmnJASElUn9ILpN11k0E+k+/zMK8j3vyft4+roEOV1ObSDseX7QkatqVZcuRt0A6KlKU9OkpJqpYbCSVGhnPVWnNpTJgPBskG4G+udYitlZgP/GJV/KTUeXFf7CM9n9LwnSSdC/eAdf4nvIf9+rFGLH7xnQfgsV9FoW8phKk905+uKkdk1Udwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DRwJ4Vu8; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DRwJ4Vu8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYcDs2TDXz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 03:58:52 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1cwZ2743653;
	Mon, 31 Aug 2026 17:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BFzkAv
	K4B5NIvBtjMcthfPNkUY2fwwOCxqhgKC3xxWQ=; b=DRwJ4Vu8C7q8QGwqeVp3A+
	NcZOV2uZ+5+RwE/qpuIuFQ2nrXj3USVyfci2nqqc/BKsa2nJ1wFnIyuode11t281
	xjlSI+STVw60ShNN44RZzAH4njGDV6DjYYGUWaUTmC4l2PtbKR11M2jGouXw3c7l
	0RY9TWzK90LLl9Gw9MZjLEtQAdlCcsdGI6cOeZ4+pUsE81UBRVEGn/a93ZC+v6p9
	CvixMbZjN2UYfDIOQCWbNyaT1iEQ9b3/Xat/i1qfxoJbbsb2q+4bh/Hn5vsARfHG
	LUN/piHNm5BaIOXxshWAAHG+ADHl1bOR9efhNewUHQhdNg9WJplLH/6j81C22aVw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54k0bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:58:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHuKsg011276;
	Mon, 31 Aug 2026 17:58:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7871-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:58:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHwZ4c23200404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:58:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB685805E;
	Mon, 31 Aug 2026 17:58:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2422B58051;
	Mon, 31 Aug 2026 17:58:32 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:58:31 +0000 (GMT)
Message-ID: <98b8a2d9-e17b-4956-aeac-0f41029e6fbe@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:58:30 -0700
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
Subject: Re: [PATCH net-next v5 01/15] ibmveth: Add MQ RX hypercall wrappers
 and call definitions
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-2-mmc@linux.ibm.com>
 <20260818014710.3853684-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014710.3853684-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1MSBTYWx0ZWRfX5ze/Lnw6LN3A
 kIAVLBqbMhum4sIyRsFKcwBDKdwW9rmaapdxVxJniMDbrFTvgxrzbJUmJzJ5tT0T4BXlDznL2sx
 QjRwdF0ptf7j6yd2sxlaBuHQNbnM1fngBaL3wIjghO4XhzbSlCfEm4ogyeDEoQS9SNV0erx4nMp
 3vFmsxgWO9xUuYcLh8ZbgzwgIOb5LIekS9h7Yr4SGCmdF/nIlZ59d7H1K7+zcGFDi3Vo6zyAg02
 QV6vRfPf61Iy5Mpek63oDYK/GnQW3jFqGrY62Np5CcXgpNT7RAIlDgGeLwEciWR2XTAwDc2S12u
 SvyenTb82XKoFjI6qHpM2WqetodJcGQM4o1+IdzFdEwtIgMCAwbXCgWhR6wQVMBxG3X/yYBWfss
 m6+UoHOOWsGBvWByoVH/YAs2B5Z2qwXvtZtCa0636j/xTztVjtLikkyHoihDumEkEwKLvDLgDl9
 MXBO4NenHx9ZnlfngpQ==
X-Proofpoint-ORIG-GUID: IhY81iiyXh_2gIsl9o9cBr4NGCNIfBz9
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95c0d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=15AQF0vLuX4PtpEdo78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GOiXZRYp4t2b1FHawhO-YYPPoPQ1IyJR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1MSBTYWx0ZWRfX3fohUyI3MSgk
 0i/m+WSAHcQt0V4YXZx88VnP1nK9eTr7fVp7RCNa3I4XLiVDID3MIzaBbijvn7mV6+0CJRiBtQ2
 DqirX5z6lx3HZDt1q/mKoLKrnRdiNNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310151


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
Hi Jakub,

|Thanks for the v5 review. v6 is 
posted:https://lore.kernel.org/r/cover.1788102125.git.mmc@linux.ibm.com |

|Per-comment replies below.|

> ---
> ibmveth: Add MQ RX hypercall wrappers and call definitions
>
> This adds the PHYP call IDs for H_REG_LOGICAL_LAN_QUEUE,
> H_ADD_LOGICAL_LAN_BUFFERS_QUEUE and H_FREE_LOGICAL_LAN_QUEUE, raising
> MAX_HCALL_OPCODE accordingly, and adds matching static inline wrappers in
> ibmveth.h.  It is plumbing only, with no runtime behaviour change until a
> later commit enables multi_queue.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index d87713668ed30..c0ef03cad9b9a 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -66,6 +66,142 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
> [ ... ]
>
>> +/**
>> + * h_add_logical_lan_buffers_queue - Add buffers to subordinate queue
>> + * @unit_address: Device unit address
>> + * @queue_handle: Queue handle from h_register_logical_lan_queue()
> [Severity: Low]
> This isn't a bug, but do these two kernel-doc blocks in the same header
> contradict each other about which handles are valid here?
>
> h_add_logical_lan_buffers_queue() is documented as "Add buffers to
> subordinate queue" with "@queue_handle: Queue handle from
> h_register_logical_lan_queue()", while h_register_logical_lan_with_handle()
> below says its queue 0 handle:
>
>   * Registers the primary receive queue (queue 0) with the hypervisor and
>   * returns the queue handle. This is needed in multi-queue mode to use
>   * h_add_logical_lan_buffers_queue() for all queues including queue 0.
>
> By the end of the series the second wording is the one that matches the
> code: ibmveth_add_logical_lan_buffers() in
> drivers/net/ethernet/ibm/ibmveth.c passes
> adapter->queue_handle[queue_index] for every index, queue_index == 0
> included, and that handle comes from h_register_logical_lan_with_handle().
>
> Would it be clearer to widen the add-buffers kdoc to say the handle may
> come from either h_register_logical_lan_queue() or
> h_register_logical_lan_with_handle(), so a future caller doesn't conclude
> queue 0 must use the legacy buffer hcalls?
Agreed. v6 widens @queue_handle on both add-buffers and free-queue so
the handle may come from either register helper.

>> + * @buffersznum: Buffer size (upper 32 bits) | count (lower 32 bits)
>> + * @ioba12: Buffer addresses 1 and 2 packed ((addr1 << 32) | addr2)
>> + * @ioba34: Buffer addresses 3 and 4 packed
>> + * @ioba56: Buffer addresses 5 and 6 packed
>> + * @ioba78: Buffer addresses 7 and 8 packed
>> + * @ioba910: Buffer addresses 9 and 10 packed
>> + * @ioba1112: Buffer addresses 11 and 12 packed
>> + *
>> + * Return:
>> + *   H_SUCCESS - All buffers added successfully
>> + *   H_PARAMETER - Invalid parameters
>> + *   H_HARDWARE - Hardware error
>> + */
>> +static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
>> +						   unsigned long queue_handle,
> [ ... ]
>
>> +/**
>> + * h_register_logical_lan_with_handle - Register primary queue and get handle
>> + * @unit_address: Device unit address
>> + * @buffer_list: DMA address of buffer list
>> + * @rec_queue: Buffer descriptor of receive queue
>> + * @filter_list: DMA address of filter list
>> + * @mac_address: MAC address
>> + * @queue_handle: Output parameter for queue handle (may be NULL)
>> + *
>> + * Registers the primary receive queue (queue 0) with the hypervisor and
>> + * returns the queue handle. This is needed in multi-queue mode to use
>> + * h_add_logical_lan_buffers_queue() for all queues including queue 0.
>> + *
>> + * Return: H_SUCCESS (0) on success, error code otherwise
>> + */
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (34d1289184ae332db8c101e251d3dec96e9969f2e8dee8d98c3efff05039c9d0):
> [Severity: High]
> Calling plpar_hcall9() with missing arguments causes an out-of-bounds stack read, leaking uninitialized kernel stack memory to the hypervisor.

Yes. Fixed in v6. Both new registration wrappers use plpar_hcall().
h_add_logical_lan_buffers_queue() still needs all nine args. I left
the pre-existing h_send_logical_lan() underfill alone; happy to send
that separately.

Thanks

Mingming


