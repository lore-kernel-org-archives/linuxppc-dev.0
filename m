Return-Path: <linuxppc-dev+bounces-22492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B122DCD98D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:54:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgzJ2kVXz3br5;
	Thu, 11 Jun 2026 21:54:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781178844;
	cv=none; b=FGeII4+5gFnc0JBoz4bBYa1qhmXAEvJRZ1Kohb0ZuoSpaYItdc6o+FPjjastXyU0b2yllDWbfaCIM488POFwCOQ30svxjWkyMeyakz0eDCg/oWvdpcdGoFeoXappPFuZaKByv9gg8o0yR4ANnD1QcYRxZxFgRa4YHGYrBqPgak6gECbf3nGteLpaxpMiwyY+gZs7kR3CcJL03P6I72Vpd43L1EHTcQEPnNw0ETd2fVZrltqEWIbyObS0//ySy33Zeu9vsXd2qD+DJw9nQhctGW6nIVt2jNB9y0hyy/t3+2JuXPVPOynMR6kWzMPRgcU+S1piNVbDT2IEhEIhFp76vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781178844; c=relaxed/relaxed;
	bh=0mWUxLz3p5Lpl1lpLK/0lFKKcDmXNFKzAdx41bNXCRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNacKTXvgX7W3GHKAmzzPp1XOOrbVMV9uqroMJ8AwOO4tczPrbbHLbKzI7ccbiUrcW/ibu8CyvS+SaLUsnhL4qq8AkVV9Buml+hhvHeEH7FI65371QUVJEgaJ4MqxkEpB5Pb+gvsFYWBIB0hUZ7k9nbGNHz7PFz8KMOYaCWmqz5KMcJ9tCNPa/502//4Z6lM38X9uIUGq4r+Vnj6k1YKBCD6qDFg/8Vl0uDawq2vbinmwulSBndj4vk29vf2pL8iojdzRdOTSXNp/ECDd34heE1wHWDUhtTjTHG0UjFOegKLkjs7X0jEgRWTFBw1p3IEnxnvmJY9e1J+VsqdFUsqiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B7v5jjct; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B7v5jjct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgzH2vylz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:54:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3tq1363798;
	Thu, 11 Jun 2026 11:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0mWUxL
	z3p5Lpl1lpLK/0lFKKcDmXNFKzAdx41bNXCRE=; b=B7v5jjctym4+/xpcA8/82y
	j0D+PdIac72gNgfckZTRhITfXciVbCEwNuezlTxSkC9QIYZZPRnCdv6vT4dLTT93
	vKG/HxexF0OC5WLLcRNuVSETxARXsyLSpT+tV6kJ9KG+xJXsxDEPKt2T/7kvN5BE
	CdrbUoCnarmxsO8h5eil+IKfqzg/GnNdJBZl4aYxpzF5Rlld7bYHtDdbvrMIbtKt
	wsNBfeQta5tnakyVYldSQLLZ+G2e3V76E1hYBgLylniLXuhlxXjWU8XOoE4R4fUg
	YZH9c3Rd+uv1qCeTVb3OOd93+U9olz2xeXXF1267RHdgnfQmOGTKRrP74t4k26Vw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8du4b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:53:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBnbw8024908;
	Thu, 11 Jun 2026 11:53:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09k0mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:53:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBrrsl29491878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:53:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1391058045;
	Thu, 11 Jun 2026 11:53:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F4758050;
	Thu, 11 Jun 2026 11:53:47 +0000 (GMT)
Received: from [9.39.28.34] (unknown [9.39.28.34])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:53:47 +0000 (GMT)
Message-ID: <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:23:45 +0530
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
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <aiHuIBAIgv3L6TI7@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HFFfAg-y1e4bC_HbkDjFY2jofZVlSSeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX3UEHUx1P7uit
 o88RUyCgNtqrsrkbsWmZrHGU9y8oCVs2/bpkAmBQkidIVWMJufZ60j/Oi9Zdi8KoYONJw82pXlv
 M41XJqvKqHdolFNBYCm90muS4BJxnwmUVnyNtMyZeDF8fpH4aBgCkWwAsjSQPN1FCXCKti13wLO
 GpTlm6L01ykdOdpztO9m2mbZGok+b1+vQ2PKg9zzEPsEtRMaYAeQYue7gGA/S0R+HVB/wTcklqS
 W79QlSRzuXTPL0AwQMoKft4Tb9OTqGgJdZF+3K7RBF5QTiGvbfLBQakMTtBznUK9fpm6LMXrE/l
 17THkaDdbua/zYR9mIQpIxxJlwvtODXqJ/IeATklQtbRf7fDu514DFgZWeNIJlJk+B4dyMJP/UE
 KQ3afRMC61lFU4KtOzJgNx/xrU9qO5mSlEaql7Q/zX+YFafSSNcWJjbdzTqZgMO9DyccBXqCDeq
 kg0lC4dIJKOO/qPwChg==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2aa1d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VGTbtgbnwzfKMrRC74UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX16jOb6CDhv3Z
 oLQO8hoossKh0UYExf1z1ALaHfYA7vk5BtaEpnKEb8xeXwlXwKz7szcpfV3q+AAUvMvwa87OZRT
 moWEriIouwr57PnmBBwFrLeK30ZD1AY=
X-Proofpoint-ORIG-GUID: dDcmPl3E-wVFw9sdNDjSp-Asfr27Zw3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

Hello Arnaldo

Thanks for checking the patch. I cannot see this patch applied on 
perf-tools-next yet.

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

Thanks.

On 05/06/26 02:59, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 04, 2026 at 12:25:19PM +0530, Tanushree Shah wrote:
>> Unlike the in-kernel trace_seq which uses a statically allocated buffer,
>> the userspace traceevent library's trace_seq uses a dynamically allocated
>> one. Therefore, every trace_seq_init() call must be paired with a
>> trace_seq_destroy(), otherwise it produces a memory leak.
>>
>> In process_sample_event(), a trace_seq is initialized for each field when
>> formatting tracepoint raw_data, but the matching trace_seq_destroy() is
>> never called, leaking memory for every field of every sample processed.
>>
>> Add the missing trace_seq_destroy() after using the trace_seq buffer to
>> properly free the allocated memory.
>>
>> Detected with Valgrind on a perf.data file with 2,729 tracepoint samples:
>>    Before: definitely lost: 55,537,664 bytes in 13,559 blocks
>>    After:  definitely lost: 0 bytes in 0 blocks
> 
> Thanks, applied to perf-tools-next, for v7.2.
> 
> - Arnaldo
>   
>> Fixes: 9d895e468429 ("perf data: Add tracepoint fields when converting to JSON")
>> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
>> ---
>>   tools/perf/util/data-convert-json.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
>> index d526c91312ed..6dd9349ab10f 100644
>> --- a/tools/perf/util/data-convert-json.c
>> +++ b/tools/perf/util/data-convert-json.c
>> @@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_tool *tool,
>>   				trace_seq_init(&s);
>>   				tep_print_field(&s, sample->raw_data, fields[i]);
>>   				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
>> +				trace_seq_destroy(&s);
>>   
>>   				i++;
>>   			}
>> -- 
>> 2.47.3


