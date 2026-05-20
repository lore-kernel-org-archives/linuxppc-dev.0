Return-Path: <linuxppc-dev+bounces-21202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526DBCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 04:00:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKyWK5ph3z2xy3;
	Wed, 20 May 2026 14:00:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779249645;
	cv=none; b=BFTbr91BLNwMQJ3+pbQMAp8S//Jh1iSDFc290pbYqJAf0HWXLnCF4IryQoEB9h3SKQPw9QZyD7PPhj0NZ0goo7zYeUXdEVv7+Lt7CoOfRWTRiuUCRhTCwF4iBeIVTYG3jzQDRi1+/xkxock18m+DWt29R0cpl0A0wCmHtSFsu1KEulGEZOnzZFk/Tk3Qs1S0PYjmx5KuL6WSYHZfZituCEKZyYvMMZTUX1a/jaMTOMQBBCt2UJrCKcCDz6VZkD8VP0h40aMsAG5kDTPaw1WsRqaZ8hxnMgIIgaGJ/naA2jWYot9uShglHcYCCY9r+fgPs63NbXloSMMyk7G0+iz8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779249645; c=relaxed/relaxed;
	bh=Sk4Ojn+O8JQ94NOA2Xkj/XkEcQNIEdQV7lv1/ODCFbQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Z959JwOdgXZE4ULttbHK2JiSmxxuFxlsIuDIMgtm1G2Uxp97pPyk5gQyDTFhbYvPSXiQka70J0UlhpUpRkEn1NMZY1oA0dsZxNOZ8pSHMZg3CH27g8q3nlLTVONVL1lVD7YeCMDnzZnePmVCBRw0N2J64/W9j/qxKYYIW6DqyNh0UAsD6tf0BItRIcYUhJ7xXrOKNqM/ekqIanfTGTUKsfe45cQNwAF22PV3wd2b144b27BzCO7ONWcz2snHzOdBnWVU4sFASvCqjOXMF4iqyicGZpgq1NKK9OW0G8hq+tpVUNXm9Xz3KXnv3KR7DK08KIlfbZOM4HTFOGpp4bhrjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=smL4fNaS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=smL4fNaS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKyWJ49LPz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 14:00:44 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JKlAX9151154;
	Wed, 20 May 2026 03:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Sk4Ojn+O8JQ94NOA2Xkj/XkEcQNIEd
	QV7lv1/ODCFbQ=; b=smL4fNaSd1xEqv2H/2OSDBbG9wXVOghqgvpqztidBBWXuc
	RUXCJ0dWjLPKhDfg8a9PO2ZeUcUyCqA8bZ9bObo4H8xlUPzbKIc1u0rQLUrMbzOV
	BqUOoOuwc5GjRyC2nZDUAsk6DZFRNkiX3DYWq4uVvr5I6QTdcmh4cx6+9dS+PyjJ
	d3JJ5zW5hY3XGsbXJIRpKziKDGG2U4XoylSkvxRJIRYWGmM54GKMJKVuzQORlW+0
	zRCMKDq+L+ut8k5uDEaQN4iLVn23VekzooLfvl563J1ODN2XQyk436QJ8jACBFcT
	8EwwQXg3GmyHHZRUEDLqbZCDjjwQh6fWQbsg9vAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw7a4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 03:55:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K3sP8c020698;
	Wed, 20 May 2026 03:55:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhnjwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 03:55:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K3tHE533161744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 03:55:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8E958045;
	Wed, 20 May 2026 03:55:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74F7758050;
	Wed, 20 May 2026 03:55:10 +0000 (GMT)
Received: from [9.39.31.114] (unknown [9.39.31.114])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 03:55:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------bZyL3bJ3ZAwpAuIdNnLsMiPc"
Message-ID: <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>
Date: Wed, 20 May 2026 09:25:08 +0530
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
Subject: Re: [PATCH] perf script powerpc: Update the hcall list with new
 hcalls
To: Gautam Menghani <Gautam.Menghani@ibm.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        james.clark@linaro.org, atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
Content-Language: en-US
From: Tejas Manhas <tejas05@linux.ibm.com>
In-Reply-To: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAzMSBTYWx0ZWRfX0LRj+LZrQEUq
 fdkegeSfiThaI95TFQFOGL6QAR99BZOSTNGGVkM5Zx9pA8jb2Kx/hySpDP9MM/oaykTGiwcsghH
 6u+vhALNuSKPrRJBdeHD4nmUdasZnp4lgmi+yZcxTIO4mfjLV1FwqOlzZ9+jqPdQ6F8tUSZMRo1
 X4Ua+gK0EllZQiL8YIlmvlbg0zZEaWWctJnA+k1XbtQNVaGdv016tt6O00r4LFwfqxdW3MImOcB
 7/hu261gUarz5lj07KediDYkHHRYrPL5z7clm/34otv6jZOuNpJH+sYsiGCTDREu6QJFYXM1MDs
 bH90ZnzHCRoKATrcK/W8lprff+esVHRHBu58oASw81rjnC0OXw/uA2gLFh4jsl/vgpfnyklh/Et
 yT06z2G1zbYOztPVy4mFxS6eIVGPefN7LN0B8nUScnOQ4CBhTlMgvZeGiqBxr4F4RGWX5fe+AB1
 KcO4+WpGI99upcjpT7g==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0d30a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=dQQfcrzLAAAA:20
 a=VnNF1IyMAAAA:8 a=V4-D3R1yLBfaJkKo8a4A:9 a=QEXdDO2ut3YA:10
 a=FrXN0Z3dbsFagp4LdOwA:9 a=viehX6peVHZAgsep:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=dg9POvUeLKcNqmu5K3LL:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: orw5Y45jzqTDCAcn2wLlvBqnnzSX6cjg
X-Proofpoint-GUID: bbY4wGwDIvrm388eU_qY5UL8tRYMjLRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200031

This is a multi-part message in MIME format.
--------------bZyL3bJ3ZAwpAuIdNnLsMiPc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> From: Gautam Menghani<gautam@linux.ibm.com>
>
> Update the hcall list with the hcalls in bcc's ppchcalls script [1].
>
> [1] :https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
>
> Signed-off-by: Gautam Menghani<gautam@linux.ibm.com>
> ---
>   tools/perf/scripts/python/powerpc-hcalls.py | 86 ++++++++++++++++++++-
>   1 file changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
> index 8b78dc790adb..f69a1d229526 100644
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py
> @@ -112,11 +112,12 @@ hcall_table = {
>   	420: 'H_CREATE_RPT',
>   	424: 'H_REMOVE_RPT',
>   	428: 'H_REGISTER_RPAGES',
> -	432: 'H_DISABLE_AND_GETC',
> +	432: 'H_DISABLE_AND_GET',
>   	436: 'H_ERROR_DATA',
>   	440: 'H_GET_HCA_INFO',
>   	444: 'H_GET_PERF_COUNT',
>   	448: 'H_MANAGE_TRACE',
> +	456: 'H_GET_CPU_CHARACTERISTICS',
>   	468: 'H_FREE_LOGICAL_LAN_BUFFER',
>   	472: 'H_POLL_PENDING',
>   	484: 'H_QUERY_INT_STATE',
> @@ -135,11 +136,17 @@ hcall_table = {
>   	644: 'H_ADD_CONN',
>   	648: 'H_DEL_CONN',
>   	664: 'H_JOIN',
> +	672: 'H_VASI_SIGNAL',
>   	676: 'H_VASI_STATE',
> +	680: 'H_VIOCTL',
>   	688: 'H_ENABLE_CRQ',
>   	696: 'H_GET_EM_PARMS',
>   	720: 'H_SET_MPP',
>   	724: 'H_GET_MPP',
> +	732: 'H_REG_SUB_CRQ',
> +	736: 'H_FREE_SUB_CRQ',
> +	740: 'H_SEND_SUB_CRQ',
> +	744: 'H_SEND_SUB_CRQ_INDIRECT',
>   	748: 'H_HOME_NODE_ASSOCIATIVITY',
>   	756: 'H_BEST_ENERGY',
>   	764: 'H_XIRR_X',
> @@ -147,7 +154,84 @@ hcall_table = {
>   	772: 'H_COP',
>   	788: 'H_GET_MPP_X',
>   	796: 'H_SET_MODE',
> +	808: 'H_BLOCK_REMOVE',
> +	856: 'H_CLEAR_HPT',
> +	864: 'H_REQUEST_VMC',
> +	876: 'H_RESIZE_HPT_PREPARE',
> +	880: 'H_RESIZE_HPT_COMMIT',
> +	892: 'H_REGISTER_PROC_TBL',
> +	896: 'H_SIGNAL_SYS_RESET',
> +	904: 'H_ALLOCATE_VAS_WINDOW',
> +	908: 'H_MODIFY_VAS_WINDOW',
> +	912: 'H_DEALLOCATE_VAS_WINDOW',
> +	916: 'H_QUERY_VAS_WINDOW',
> +	920: 'H_QUERY_VAS_CAPABILITIES',
> +	924: 'H_QUERY_NX_CAPABILITIES',
> +	928: 'H_GET_NX_FAULT',
> +	936: 'H_INT_GET_SOURCE_INFO',
> +	940: 'H_INT_SET_SOURCE_CONFIG',
> +	944: 'H_INT_GET_SOURCE_CONFIG',
> +	948: 'H_INT_GET_QUEUE_INFO',
> +	952: 'H_INT_SET_QUEUE_CONFIG',
> +	956: 'H_INT_GET_QUEUE_CONFIG',
> +	960: 'H_INT_SET_OS_REPORTING_LINE',
> +	964: 'H_INT_GET_OS_REPORTING_LINE',
> +	968: 'H_INT_ESB',
> +	972: 'H_INT_SYNC',
> +	976: 'H_INT_RESET',
> +	996: 'H_SCM_READ_METADATA',
> +	1000: 'H_SCM_WRITE_METADATA',
> +	1004: 'H_SCM_BIND_MEM',
> +	1008: 'H_SCM_UNBIND_MEM',
> +	1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
> +	1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
> +	1020: 'H_SCM_UNBIND_ALL',
> +	1024: 'H_SCM_HEALTH',
> +	1048: 'H_SCM_PERFORMANCE_STATS',
> +	1052: 'H_PKS_GET_CONFIG',
> +	1056: 'H_PKS_SET_PASSWORD',
> +	1060: 'H_PKS_GEN_PASSWORD',
> +	1068: 'H_PKS_WRITE_OBJECT',
> +	1072: 'H_PKS_GEN_KEY',
> +	1076: 'H_PKS_READ_OBJECT',
> +	1080: 'H_PKS_REMOVE_OBJECT',
> +	1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
> +	1096: 'H_RPT_INVALIDATE',
> +	1100: 'H_SCM_FLUSH',
> +	1104: 'H_GET_ENERGY_SCALE_INFO',
> +	1108: 'H_PKS_SIGNED_UPDATE',
> +	1116: 'H_WATCHDOG',
> +	# Platform specific hcalls used by KVM on PowerVM
> +	1120: 'H_GUEST_GET_CAPABILITIES',
> +	1124: 'H_GUEST_SET_CAPABILITIES',
> +	1136: 'H_GUEST_CREATE',
> +	1140: 'H_GUEST_CREATE_VCPU',
> +	1144: 'H_GUEST_GET_STATE',
> +	1148: 'H_GUEST_SET_STATE',
> +	1152: 'H_GUEST_RUN_VCPU',
> +	1156: 'H_GUEST_COPY_MEMORY',
> +	1160: 'H_GUEST_DELETE',
> +	# Platform-specific hcalls used by the Ultravisor
> +	61184: 'H_SVM_PAGE_IN',
> +	61188: 'H_SVM_PAGE_OUT',
> +	61192: 'H_SVM_INIT_START',
> +	61196: 'H_SVM_INIT_DONE',
> +	61204: 'H_SVM_INIT_ABORT',
> +	# Platform specific hcalls used by KVM
>   	61440: 'H_RTAS',
> +	# Platform specific hcalls used by QEMU/SLOF
> +	61441: 'H_LOGICAL_MEMOP',
> +	61442: 'H_CAS',
> +	61443: 'H_UPDATE_DT',
> +	# Platform specific hcalls provided by PHYP
> +	61560: 'H_GET_24X7_CATALOG_PAGE',
> +	61564: 'H_GET_24X7_DATA',
> +	61568: 'H_GET_PERF_COUNTER_INFO',
> +	# Platform-specific hcalls used for nested HV KVM
> +	63488: 'H_SET_PARTITION_TABLE',
> +	63492: 'H_ENTER_NESTED',
> +	63496: 'H_TLB_INVALIDATE',
> +	63500: 'H_COPY_TOFROM_GUEST',
>   }
>   
>   def hcall_table_lookup(opcode):

Hi Gautam,

This patch doesn't seem to resolve the issue where numbers are seen instead of hcalls.
I have applied to the latest upstream but the numbers are still visible in perf script.
Also the command doesn't recognise python-audit already present in the system.

Please find logs below for better understanding.

before patch
# perf record -a -e powerpc:hcall* sleep 10
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.343 MB perf.data (2388 samples) ]
[root@ltcden14-lp10 perf]# perf script  -s ./powerpc-hcalls.py -i ./perf.data
Install the python-audit package to get syscall names.
For example:
   # apt-get install python3-audit (Ubuntu)
   # yum install python3-audit (Fedora)
   etc.

hcall                            count   min(ns)   max(ns)   avg(ns)
--------------------------------------------------------------------
H_VIO_SIGNAL                       614       376     14068      1644
584                                 36      1094     16120      2839
H_ADD_LOGICAL_LAN_BUFFER             9       660      3572      1320
H_STUFF_TCE                        132       632     12530      1310
H_PUT_TCE                          236       466      5500       865
H_RANDOM                             4       446      3300      1168
H_PUT_TCE_INDIRECT                  53       648     14318      2066
H_SEND_CRQ                         108       848      7754      1983
after patch
# yum install python3-audit
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

rhe12_debug1                                    8.4 kB/s | 1.5 kB     00:00
rh102_base_upd                                   41 kB/s | 2.7 kB     00:00
rh102_app_upd                                    14 kB/s | 2.8 kB     00:00
rh102_crb                                        14 kB/s | 2.7 kB     00:00
rh102_srcbase                                   7.6 kB/s | 1.5 kB     00:00
rh102_srcas                                     6.9 kB/s | 1.5 kB     00:00
rh102_debug                                     7.1 kB/s | 1.5 kB     00:00
rhe102_debug1                                   7.1 kB/s | 1.5 kB     00:00
Package python3-audit-4.0.3-5.el10.ppc64le is already installed.
Dependencies resolved.
Nothing to do.
Complete!
# ./perf script -s scripts/python/powerpc-hcalls.py -i ./perf.data
Install the python-audit package to get syscall names.
For example:
   # apt-get install python3-audit (Ubuntu)
   # yum install python3-audit (Fedora)
   etc.

hcall                            count   min(ns)   max(ns)   avg(ns)
--------------------------------------------------------------------
H_VIO_SIGNAL                       533       404     13154      1638
584                                 37      1034     14722      3178
H_ADD_LOGICAL_LAN_BUFFER             8       802      2602      1217
H_SEND_CRQ                          11       926     17536      4105
H_STUFF_TCE                         13       658      5306      1974
H_PUT_TCE                           18       476      5034      1476
H_PUT_TCE_INDIRECT                   5      1698      8934      4370
[root@ltcden14-lp10 perf]#

Please add the tag below.
Reported-by: Tejas Manhas<tejas05@linux.ibm.com>

Thanks & Regards,
Tejas



--------------bZyL3bJ3ZAwpAuIdNnLsMiPc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>
</pre>
    <blockquote type="cite"
      cite="mid:20260512084654.57729-1-Gautam.Menghani@ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Gautam Menghani <a class="moz-txt-link-rfc2396E" href="mailto:gautam@linux.ibm.com">&lt;gautam@linux.ibm.com&gt;</a>

Update the hcall list with the hcalls in bcc's ppchcalls script [1].

[1] : <a class="moz-txt-link-freetext" href="https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py">https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py</a>

Signed-off-by: Gautam Menghani <a class="moz-txt-link-rfc2396E" href="mailto:gautam@linux.ibm.com">&lt;gautam@linux.ibm.com&gt;</a>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 86 ++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..f69a1d229526 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -112,11 +112,12 @@ hcall_table = {
 	420: 'H_CREATE_RPT',
 	424: 'H_REMOVE_RPT',
 	428: 'H_REGISTER_RPAGES',
-	432: 'H_DISABLE_AND_GETC',
+	432: 'H_DISABLE_AND_GET',
 	436: 'H_ERROR_DATA',
 	440: 'H_GET_HCA_INFO',
 	444: 'H_GET_PERF_COUNT',
 	448: 'H_MANAGE_TRACE',
+	456: 'H_GET_CPU_CHARACTERISTICS',
 	468: 'H_FREE_LOGICAL_LAN_BUFFER',
 	472: 'H_POLL_PENDING',
 	484: 'H_QUERY_INT_STATE',
@@ -135,11 +136,17 @@ hcall_table = {
 	644: 'H_ADD_CONN',
 	648: 'H_DEL_CONN',
 	664: 'H_JOIN',
+	672: 'H_VASI_SIGNAL',
 	676: 'H_VASI_STATE',
+	680: 'H_VIOCTL',
 	688: 'H_ENABLE_CRQ',
 	696: 'H_GET_EM_PARMS',
 	720: 'H_SET_MPP',
 	724: 'H_GET_MPP',
+	732: 'H_REG_SUB_CRQ',
+	736: 'H_FREE_SUB_CRQ',
+	740: 'H_SEND_SUB_CRQ',
+	744: 'H_SEND_SUB_CRQ_INDIRECT',
 	748: 'H_HOME_NODE_ASSOCIATIVITY',
 	756: 'H_BEST_ENERGY',
 	764: 'H_XIRR_X',
@@ -147,7 +154,84 @@ hcall_table = {
 	772: 'H_COP',
 	788: 'H_GET_MPP_X',
 	796: 'H_SET_MODE',
+	808: 'H_BLOCK_REMOVE',
+	856: 'H_CLEAR_HPT',
+	864: 'H_REQUEST_VMC',
+	876: 'H_RESIZE_HPT_PREPARE',
+	880: 'H_RESIZE_HPT_COMMIT',
+	892: 'H_REGISTER_PROC_TBL',
+	896: 'H_SIGNAL_SYS_RESET',
+	904: 'H_ALLOCATE_VAS_WINDOW',
+	908: 'H_MODIFY_VAS_WINDOW',
+	912: 'H_DEALLOCATE_VAS_WINDOW',
+	916: 'H_QUERY_VAS_WINDOW',
+	920: 'H_QUERY_VAS_CAPABILITIES',
+	924: 'H_QUERY_NX_CAPABILITIES',
+	928: 'H_GET_NX_FAULT',
+	936: 'H_INT_GET_SOURCE_INFO',
+	940: 'H_INT_SET_SOURCE_CONFIG',
+	944: 'H_INT_GET_SOURCE_CONFIG',
+	948: 'H_INT_GET_QUEUE_INFO',
+	952: 'H_INT_SET_QUEUE_CONFIG',
+	956: 'H_INT_GET_QUEUE_CONFIG',
+	960: 'H_INT_SET_OS_REPORTING_LINE',
+	964: 'H_INT_GET_OS_REPORTING_LINE',
+	968: 'H_INT_ESB',
+	972: 'H_INT_SYNC',
+	976: 'H_INT_RESET',
+	996: 'H_SCM_READ_METADATA',
+	1000: 'H_SCM_WRITE_METADATA',
+	1004: 'H_SCM_BIND_MEM',
+	1008: 'H_SCM_UNBIND_MEM',
+	1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
+	1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
+	1020: 'H_SCM_UNBIND_ALL',
+	1024: 'H_SCM_HEALTH',
+	1048: 'H_SCM_PERFORMANCE_STATS',
+	1052: 'H_PKS_GET_CONFIG',
+	1056: 'H_PKS_SET_PASSWORD',
+	1060: 'H_PKS_GEN_PASSWORD',
+	1068: 'H_PKS_WRITE_OBJECT',
+	1072: 'H_PKS_GEN_KEY',
+	1076: 'H_PKS_READ_OBJECT',
+	1080: 'H_PKS_REMOVE_OBJECT',
+	1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
+	1096: 'H_RPT_INVALIDATE',
+	1100: 'H_SCM_FLUSH',
+	1104: 'H_GET_ENERGY_SCALE_INFO',
+	1108: 'H_PKS_SIGNED_UPDATE',
+	1116: 'H_WATCHDOG',
+	# Platform specific hcalls used by KVM on PowerVM
+	1120: 'H_GUEST_GET_CAPABILITIES',
+	1124: 'H_GUEST_SET_CAPABILITIES',
+	1136: 'H_GUEST_CREATE',
+	1140: 'H_GUEST_CREATE_VCPU',
+	1144: 'H_GUEST_GET_STATE',
+	1148: 'H_GUEST_SET_STATE',
+	1152: 'H_GUEST_RUN_VCPU',
+	1156: 'H_GUEST_COPY_MEMORY',
+	1160: 'H_GUEST_DELETE',
+	# Platform-specific hcalls used by the Ultravisor
+	61184: 'H_SVM_PAGE_IN',
+	61188: 'H_SVM_PAGE_OUT',
+	61192: 'H_SVM_INIT_START',
+	61196: 'H_SVM_INIT_DONE',
+	61204: 'H_SVM_INIT_ABORT',
+	# Platform specific hcalls used by KVM
 	61440: 'H_RTAS',
+	# Platform specific hcalls used by QEMU/SLOF
+	61441: 'H_LOGICAL_MEMOP',
+	61442: 'H_CAS',
+	61443: 'H_UPDATE_DT',
+	# Platform specific hcalls provided by PHYP
+	61560: 'H_GET_24X7_CATALOG_PAGE',
+	61564: 'H_GET_24X7_DATA',
+	61568: 'H_GET_PERF_COUNTER_INFO',
+	# Platform-specific hcalls used for nested HV KVM
+	63488: 'H_SET_PARTITION_TABLE',
+	63492: 'H_ENTER_NESTED',
+	63496: 'H_TLB_INVALIDATE',
+	63500: 'H_COPY_TOFROM_GUEST',
 }
 
 def hcall_table_lookup(opcode):
</pre>
    </blockquote>
    <pre>Hi Gautam,

This patch doesn't seem to resolve the issue where numbers are seen instead of hcalls.
I have applied to the latest upstream but the numbers are still visible in perf script.
Also the command doesn't recognise python-audit already present in the system.

Please find logs below for better understanding.

before patch
# perf record -a -e powerpc:hcall* sleep 10
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.343 MB perf.data (2388 samples) ]
[root@ltcden14-lp10 perf]# perf script  -s ./powerpc-hcalls.py -i ./perf.data
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

hcall                            count   min(ns)   max(ns)   avg(ns)
--------------------------------------------------------------------
H_VIO_SIGNAL                       614       376     14068      1644
584                                 36      1094     16120      2839
H_ADD_LOGICAL_LAN_BUFFER             9       660      3572      1320
H_STUFF_TCE                        132       632     12530      1310
H_PUT_TCE                          236       466      5500       865
H_RANDOM                             4       446      3300      1168
H_PUT_TCE_INDIRECT                  53       648     14318      2066
H_SEND_CRQ                         108       848      7754      1983
after patch
# yum install python3-audit
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

rhe12_debug1                                    8.4 kB/s | 1.5 kB     00:00
rh102_base_upd                                   41 kB/s | 2.7 kB     00:00
rh102_app_upd                                    14 kB/s | 2.8 kB     00:00
rh102_crb                                        14 kB/s | 2.7 kB     00:00
rh102_srcbase                                   7.6 kB/s | 1.5 kB     00:00
rh102_srcas                                     6.9 kB/s | 1.5 kB     00:00
rh102_debug                                     7.1 kB/s | 1.5 kB     00:00
rhe102_debug1                                   7.1 kB/s | 1.5 kB     00:00
Package python3-audit-4.0.3-5.el10.ppc64le is already installed.
Dependencies resolved.
Nothing to do.
Complete!
# ./perf script -s scripts/python/powerpc-hcalls.py -i ./perf.data
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

hcall                            count   min(ns)   max(ns)   avg(ns)
--------------------------------------------------------------------
H_VIO_SIGNAL                       533       404     13154      1638
584                                 37      1034     14722      3178
H_ADD_LOGICAL_LAN_BUFFER             8       802      2602      1217
H_SEND_CRQ                          11       926     17536      4105
H_STUFF_TCE                         13       658      5306      1974
H_PUT_TCE                           18       476      5034      1476
H_PUT_TCE_INDIRECT                   5      1698      8934      4370
[root@ltcden14-lp10 perf]#

Please add the tag below.
Reported-by: Tejas Manhas <a class="moz-txt-link-rfc2396E"
    href="mailto:tejas05@linux.ibm.com">&lt;tejas05@linux.ibm.com&gt;</a>

Thanks &amp; Regards,
Tejas



</pre>
  </body>
</html>

--------------bZyL3bJ3ZAwpAuIdNnLsMiPc--


