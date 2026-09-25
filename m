Return-Path: <linuxppc-dev+bounces-28163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28DC98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 05:53:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrfy24TDhz2y2M;
	Fri, 25 Sep 2026 15:53:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790315594;
	cv=none; b=O8lFFHpk6ptszJ1yyNojf5OfmQbcXvLVtC/tC4/tLY3cLvVC//B2wseGfWgvk7A0AfUXY+tql3T0EDcvHoURd+gRQtwCvmzxcbGNeK0d+lEvVyfcjp1XbgZb5oUSZjAdZCg5So26eN73J2oIgpNsd85FQbhJLm++3Qg31/GpmJiJLCeHwd6yRHVzl5F6niqSFfUxdiAo4auKWt8spmNFi6MHbmpSA9AIGRLA9JHqVoC5GbTn+LIbye1XJ9OYb1wnAggNadjlMDQEP36neroClcbdEfBdpJabw+9yxmTxHZClF3prBPSYr0gYmf7IYF072TWIblIdSYhTq2An0C+X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790315594; c=relaxed/relaxed;
	bh=ns+mJ84QBWL8Ce4vet0vsgI7PEsIY4o/H4I4VN6kiao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSK4N38CNl+YSeSeDWJIWZRLqKbHYK29+QgObUnzi/Ao9tTjvD+8KofjZxzdfvOslrYszWyicMUabh6FggGRKjhie9hLmGNZ1ViWiC+p6P7Cob13sQ4tzwEo664CC2JAmbapcJ4/Mchv+ovL+N8KdZCWgvDTs0q1qETCV/jYQcOY+6M3iF688fcVikQjLRtCas/G547ABQsGkYv7atCPhMu0dcRL5hmm+oPtzJDsxQ1UOE+ItDLkaUHAAVi52A1qf5IwdcBFs+Rxo88ENM7GH56E+iM2XbywM/0brW/KIBGz941SBFchTUdp7d4sEaM6sVO7y3vKTgdaZLqMW2CYag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ga6++iCx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ga6++iCx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrfy12slcz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 15:53:13 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aOMq2393772;
	Fri, 25 Sep 2026 05:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ns+mJ8
	4QBWL8Ce4vet0vsgI7PEsIY4o/H4I4VN6kiao=; b=Ga6++iCxXfeZpuf6krvyTF
	d1CcXUxYRyHy5cz261gaMzsiPI4y/Ta5C4bD7TaKP3C+7Z7JGhR8NHsPr2855hpv
	cEVrG0ZpVoVlwAOjEituRwrV9zRN7SdvxSBqgnCFtXu59VEW55Gmm7cv/zGQEqiD
	4vxQT2m5V/E9XnHAol7n6njy5eCTS6SXicW7qXcu+0G+bXfG77XRpbH98U0irbjc
	naMyqMi03YrLCvetYWwSqFUkxbtft8VHtDuKDs+o60cqLISZPv33RCjhvbnTTt78
	w8rA5urmomNDopJL1VJ8nz5+J8RRWtMulehiRu8OuC3jPPGU1b6EVRlpcEpEDdPA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske25dbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 05:52:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lXIr3248862;
	Fri, 25 Sep 2026 05:52:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt314ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 05:52:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P5q8na918042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 05:52:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 426B858066;
	Fri, 25 Sep 2026 05:52:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D3E858055;
	Fri, 25 Sep 2026 05:52:49 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 05:52:49 +0000 (GMT)
Message-ID: <aa62b945-f5b4-48c1-8a57-967ef54bc375@linux.ibm.com>
Date: Thu, 24 Sep 2026 22:52:45 -0700
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
Subject: Re: [net-next,v6,01/15] ibmveth: Add MQ RX hypercall wrappers and
 call definitions
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <b87d16ce8e52934877234af6085e47a89571c9ae.1788102125.git.mmc@linux.ibm.com>
 <178845902960.3394541.10707165174722907578@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845902960.3394541.10707165174722907578@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3b-AsbafqAUo9MA4NJmRTcNQB3UQ6KnQ
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab60c37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=HEzLWsaOVrHECI4ESaEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyMiBTYWx0ZWRfX/PHhHT6fGfb9
 cFLXUA2ESacaUVp5rCuOzCw4q7FWD4ECylJrtwM1GdW5mRJeniUDHeJDRfKAon8FN074Rvamoe8
 S4ZG0551RCygGGOYGJE4RvrXiJU0VyY=
X-Proofpoint-GUID: Xb15iSG1DtOU57ekkDQMyfKBbt_TVW1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyMiBTYWx0ZWRfXzBR4SRy47uSQ
 74vnB44nAxFyw2Cvo1VgZ78taAEHKiHsm09UlchDBtbwfeQ+7WrTNaoFQi8OmMfX0h83dtUkxso
 3ujxU+j3okr1kvMRWy7tGVzU4aMiLmpyLkF+WB7ZovIaTKj5kXBP3QogKfKa0fNgf0mTJoJhCd6
 36iwNdbswQiRwLfktPopS8rgq4iT4To3wD6fvoBXMIlKxaR+5gbKGJKT1ZoEmCBi8ud4Swgylwm
 buPU/k6esrFRsy9AsZ4Yhk1cmThQ00UDwGp3woFrDr/holyrooYaGO5PFJHbJS5Uhj+gEuFax/G
 tFG7EkuDhvOFMFrd4P3E0lzm3NegARzbWfg2jp3ILpA9CsPLvtaCguBDCMLBXgBqjaRoSZicAV3
 px6chYNcHn7MdwjyA8tAqm3gF3DYSysYR91y/x5wno+4rbSxz9LB0dm8F1gH9MlzZ76Hd3nboyv
 2FPWVqc/MWhkEuCh5hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250022

Thanks for the review... I will response one by one. And addressing them 
in v7

On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> Critical: 0 · High: 0 · Medium: 0 · Low: 3
>
> - [Low] The commit message body contains a verbatim duplicated sentence.
> - [Low] kernel-doc for the three new MQ hcall wrappers added by this
>    patch is inconsistent about the H_FUNCTION (unsupported-hcall) return.
> - [Low] The in-tree perf hypercall decoder is not updated for the three
>    opcodes added by this patch.
>
> --
>
> ibmveth: Add MQ RX hypercall wrappers and call definitions
>
> This adds the PAPR 11.20.00 hcall IDs H_REG_LOGICAL_LAN_QUEUE (0x49C),
> H_ADD_LOGICAL_LAN_BUFFERS_QUEUE (0x4A0) and H_FREE_LOGICAL_LAN_QUEUE
> (0x4A8), raising MAX_HCALL_OPCODE, and adds matching static inline
> wrappers in ibmveth.h plus h_register_logical_lan_with_handle() so
> queue 0 can capture the PHYP queue handle.
>
> A few questions below, all on the changelog text and the kernel-doc.
>
>>      Add ibmveth.h wrapper helpers (h_register_logical_lan_queue(),
>>      h_add_logical_lan_buffers_queue(), h_free_logical_lan_queue()) with
>>      argument ordering and return semantics matching the existing ibmveth
>>      hcall wrappers. h_free_logical_lan_queue() uses plpar_hcall_norets()
>>      like h_free_logical_lan(). Also add h_register_logical_lan_with_handle()
>>      so queue 0 can capture the PHYP queue handle in MQ mode. Both new
>>      registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
>>      they do not read unwritten stack slots. Both new
>>      registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
>>      they do not read unwritten stack slots.
> [Severity: Low]
> This isn't a bug, but the sentence "Both new registration wrappers use
> plpar_hcall() rather than plpar_hcall9(), so they do not read unwritten
> stack slots." appears twice in a row here.  Was the second copy meant to
> be dropped when the v6 rationale was folded into the changelog body?
Yes. Paste glitch when that sentence was folded in. v7 drops the second 
copy.
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index dff90a7d7f70b..cb0ea53491e6c 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -362,7 +362,11 @@
>>   #define H_GUEST_DELETE		0x488
>>   #define H_PKS_WRAP_OBJECT	0x490
>>   #define H_PKS_UNWRAP_OBJECT	0x494
>> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
>> +/* 0x498 reserved; 0x4A4 = H_FREE_LOGICAL_LAN_BUFFER_QUEUE (unused here) */
>> +#define H_REG_LOGICAL_LAN_QUEUE 0x49C
>> +#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
>> +#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
>> +#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
> [Severity: Low]
> Should tools/perf/scripts/python/powerpc-hcalls.py get entries for these
> three opcodes too?
>
> Its hcall_table currently tracks hvcall.h up to the previous
> MAX_HCALL_OPCODE:
>
> 	1168: 'H_PKS_WRAP_OBJECT',
> 	1172: 'H_PKS_UNWRAP_OBJECT',
> 	# Platform-specific hcalls used by the Ultravisor
> 	61184: 'H_SVM_PAGE_IN',
>
> There is nothing for 1180 (0x49C), 1184 (0x4A0) or 1192 (0x4A8), so
> tracing the new MQ RX path with that script prints the raw numbers rather
> than the names.
Yes. v7 adds those three names. 0x498 and 0x4A4 stay unnamed; they
are the reserved holes already called out in hvcall.h.

>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index d87713668ed30..08504d1cafd55 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -66,6 +66,145 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
>>   			    desc5, desc6, desc7, desc8);
>>   }
>>   
>> +/**
>> + * h_register_logical_lan_queue - Register a subordinate receive queue
>> + * @unit_address: Device unit address
>> + * @buffer_list: DMA address of 4KB page for tracking registered buffers
>> + * @rec_queue: Buffer descriptor of receive queue
>> + * @queue_handle: Output queue handle on success (may be NULL)
>> + * @irq: Output hypervisor IRQ number on success (may be NULL)
>> + *
>> + * Registers a subordinate receive queue with the hypervisor.
>> + *
>> + * Return:
>> + *   H_SUCCESS (0) on success
>> + *   H_PARAMETER if parameters are invalid
> [Severity: Low]
> Should H_FUNCTION be listed here as well?
>
> H_REG_LOGICAL_LAN_QUEUE (0x49C) is new in PAPR 11.20.00, so firmware
> predating it returns H_FUNCTION, and h_register_logical_lan_queue()
> passes the hypervisor status straight back.  The later commit in this
> series ("ibmveth: Add RX queue register helpers for MQ") does distinguish
> that case:
>
> 	if (lpar_rc == H_FUNCTION)
> 		netdev_err(adapter->netdev,
> 			   "h_register_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",
>
> so a caller reading only this Return: section has no documented way to
> tell "firmware has no MQ support, fall back to single queue" from a hard
> error.
Agreed. v7 lists H_FUNCTION on h_register_logical_lan_queue() and
h_free_logical_lan_queue() as well. h_add_logical_lan_buffers_queue()
already had it. All three opcodes are new; the wrappers return the
hypervisor status unchanged. Later patches map H_FUNCTION on register
to -EOPNOTSUPP / mq_fallback.
>> +static inline long
>> +h_register_logical_lan_queue(unsigned long unit_address,
>> +			     unsigned long buffer_list,
>> +			     unsigned long rec_queue,
>> +			     unsigned long *queue_handle,
>> +			     unsigned long *irq)
>> +{
> [ ... ]
>
>> + * Return:
>> + *   H_SUCCESS - All buffers added successfully
>> + *   H_PARAMETER - Invalid parameters
>> + *   H_HARDWARE - Hardware error
>> + *   H_FUNCTION - Firmware does not support this hcall
>> + */
>> +static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
> [ ... ]
>
>> + * Deregisters and frees all structures associated with the subordinate queue.
>> + *
>> + * Return:
>> + *   H_SUCCESS - Queue freed successfully
>> + *   H_PARAMETER - Invalid parameters
>> + *   H_HARDWARE - Hardware error
>> + *   H_STATE - VIOA not in valid state
>> + *   H_BUSY / H_LONG_BUSY_* - Resource busy, retry
>> + */
>> +static inline long h_free_logical_lan_queue(unsigned long unit_address,
>> +					    unsigned long queue_handle)
>> +{
>> +	return plpar_hcall_norets(H_FREE_LOGICAL_LAN_QUEUE,
>> +				  unit_address, queue_handle);
>> +}
> Same question for h_free_logical_lan_queue(): 0x4A8 is equally new, and
> plpar_hcall_norets() returns H_FUNCTION unchanged on firmware that lacks
> it, but only h_add_logical_lan_buffers_queue() documents that status.  Was
> the difference between the three Return: sections intentional?
No, not intentional. Same H_FUNCTION line on free-queue in v7.


Thanks,
Mingming


