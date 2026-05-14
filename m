Return-Path: <linuxppc-dev+bounces-20936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF85CD4F39
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 05:20:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGJZc4P0pz2xlQ;
	Thu, 14 May 2026 15:20:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778736056;
	cv=none; b=bH0fN6fpaAoDwKRKYiIPoUez24/y//+SfvBxHq5Na57IPA/ApZIqy6thssHlaCWB6dY2XvPtnwjNXVkTVmIR6WLetf1lbPEuSc9wj1tdPu/sX7MSKwT667Vs6xSG2TeQlKNpPHHIQLNzyG4NXn9Z+O0h/zqHCaTrP77DiMzD4BcO+U7ezUc62OXzh9tP2SkQxS1TXMnJt8i8XcblKnDwlD0FavHGLh8+Y5ILySlXjDCH//D0eWHLCrJRKv1lNli+I5Nn7njcXENrMy32YY+FVJHLOesmx1RyFj9hVYzVk9dke2o7DsoElOiTTMgsoi/4WOBrs9z04k6nZjNF1296QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778736056; c=relaxed/relaxed;
	bh=Xs+gc8oHiRtJtpuJ5r3ZwnhSIkZoNNOBBQvfxrPAUiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTWUU3EgwOD43Dw9Kdg/5LWkAaM7sC1EUTpPaUiAOJ4Z/NwPdXn+KUj2qsEKRwQz9+aH8IOsFnJNWmDCtVWPAMgz1uF+3GsBu2fkD+ye7J6tMZoPyCnDUbfhKWiIIsO+bbUvYTnGD291FawUipeTEakoWEdSI5KxUoKBjnxtWFInSwdabtlnnh//ob90k1GJcdhMjtrYkH8fTDwxh6SGcy6/S1TUVnI/kxW/2AYq8e9LA+y2Q8TK2MCfkR5n4AGls23gOI0I8S6faM5vJRmKpKwcCuaDxaYB39Dno6XOcWs6pMrSUB9CwfHcVxUl6Xup62JrQHCwA9VlHy744LcTZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qah2XnCu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qah2XnCu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGJZb1VF0z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 15:20:54 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGWcqI3185041;
	Thu, 14 May 2026 05:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xs+gc8
	oHiRtJtpuJ5r3ZwnhSIkZoNNOBBQvfxrPAUiQ=; b=Qah2XnCu2aLufTZiN7SYg0
	oOKRxN2q5BUnem9KZ6Nqhw7mhlkitSjRQVyVVA38QsgCNChfwWlIc+uQLNPr419Q
	FP0dov/6ZL/rGhI/N6POCFAYcC77oTWYc0gaUh/gxAqK4KmuvDtr65nJBNbIDSlk
	MUi2eZ0eoRx83VTKEEYNZHxj23TEaBbtPzj1DsKrBDcgaYvapxe8WV0bxSHiDOb3
	TVvwBiBJoY7DC8d78MfDVn/7Cr1hOJuPIjsxkWsWvdsfmMmZ+Bh/aNtFjAiOOlP2
	Ao9AVTWxef9WUtOSMucA7LpBBdRSSV+oEF2FkyjF8L6lWbl5Dl8Zncr/sP46mcRA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5k0yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 05:20:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64E4sTNH015465;
	Thu, 14 May 2026 05:20:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgk1bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 05:20:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64E5Kk7M25690454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 05:20:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2440320040;
	Thu, 14 May 2026 05:20:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A939420043;
	Thu, 14 May 2026 05:20:44 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 05:20:44 +0000 (GMT)
Message-ID: <b0c4795c-ca1a-4a79-8615-d72c8387319b@linux.ibm.com>
Date: Thu, 14 May 2026 10:50:43 +0530
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
Subject: Re: [PATCH] powerpc/hv-gpci: fix preempt count leak in sysfs show
 paths
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <chleroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a055bb2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=e_YaPIxyqLnmE7SDhBMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ruJaby2itUsVsZaZDqckxJL9q-8Nymoy
X-Proofpoint-GUID: ruJaby2itUsVsZaZDqckxJL9q-8Nymoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0OCBTYWx0ZWRfX/AiY3djnxlEW
 jogmybowkqN69ENoMTm1mrlygIEJHuFjznIRa9nkAQee3D1OG68cBaY5PwCsFXRB2g3cAmSg9KK
 GwA3t/I7OQDi3Y8BR+DLrICnL4aFRKthePgiT0YxQz1s47Pi8aahfUkR1JljTXohUwyDW/h1ZzC
 HFI2j7asu5Rbj5WQfugDGXMDpzDb6wPJY3BKwecfIjCPX8t2L49Ff/NeAHC2WrUUOOIhtCHQlXr
 WNMlolbRlNPBBNvA166wIzUbaVt0qoWnig8GmZHXj0bI3teimd+95+CVf+stEP1Yk0X/wlTa97T
 SJvpZ4zpWd0j3SicH/r8SQ1mi5SacxkomTRa02VVTAX4OBNVDqOut9CizB63mJxzjGiFAc5RSdL
 J7knnIJrtkddK4hBokfSBpUVK++GmvuuaC3YnAya9Puc117xtb6INeR6YL+X4KjOhYfGhkR2O1z
 j382/iHPLvQrEzI1ung==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140048



On 5/8/26 9:42 AM, Aboorva Devarajan wrote:
> Four sysfs show() callbacks in hv-gpci take get_cpu_var(hv_gpci_reqb)
> (which calls preempt_disable()) but only call the matching put_cpu_var()
> on the error path under the 'out:' label. Every successful read leaks
> one preempt_disable():
> 
>    processor_bus_topology_show()
>    processor_config_show()
>    affinity_domain_via_virtual_processor_show()
>    affinity_domain_via_domain_show()
> 
> (affinity_domain_via_partition_show() was already correct.)
> 
> On a CONFIG_PREEMPT=y kernel, repeated reads raise preempt_count and
> eventually return to userspace with preemption still disabled. The
> next user-mode page fault then hits faulthandler_disabled() == 1,
> gets forced to SIGSEGV, and the resulting coredump trips
> 'BUG: scheduling while atomic' in call_usermodehelper_exec ->
> wait_for_completion_state -> schedule:
> 
>    BUG: scheduling while atomic: <task>/<pid>/0x00000004
>    ...
>    __schedule_bug+0x6c/0x90
>    __schedule+0x58c/0x13a0
>    schedule+0x48/0x1a0
>    schedule_timeout+0x104/0x170
>    wait_for_completion_state+0x16c/0x330
>    call_usermodehelper_exec+0x254/0x2d0
>    vfs_coredump+0x1050/0x2590
>    get_signal+0xb9c/0xc80
>    do_notify_resume+0xf8/0x470
> 
> Add an out_success label that calls put_cpu_var() before returning
> the byte count, mirroring affinity_domain_via_partition_show().
> 
> Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
> Fixes: 1a160c2a13c6 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor config information")
> Fixes: 71a7ccb478fc ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via virtual processor information")
> Fixes: a69a57cac1ec ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via domain information")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   arch/powerpc/perf/hv-gpci.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 5cac2cf3bd1e5..10c82cf8f5b39 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -210,7 +210,7 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
>   			0, 0, buf, &n, arg);
>   
>   	if (!ret)
> -		return n;
> +		goto out_success;
>   
>   	if (ret != H_PARAMETER)
>   		goto out;
> @@ -244,12 +244,14 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
>   				starting_index, 0, buf, &n, arg);
>   
>   		if (!ret)
> -			return n;
> +			goto out_success;
>   
>   		if (ret != H_PARAMETER)
>   			goto out;
>   	}
>   
> +out_success:
> +	put_cpu_var(hv_gpci_reqb);
>   	return n;
>   
>   out:
> @@ -278,7 +280,7 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
>   			0, 0, buf, &n, arg);
>   
>   	if (!ret)
> -		return n;
> +		goto out_success;
>   
>   	if (ret != H_PARAMETER)
>   		goto out;
> @@ -312,12 +314,14 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
>   				starting_index, 0, buf, &n, arg);
>   
>   		if (!ret)
> -			return n;
> +			goto out_success;
>   
>   		if (ret != H_PARAMETER)
>   			goto out;
>   	}
>   
> +out_success:
> +	put_cpu_var(hv_gpci_reqb);
>   	return n;
>   
>   out:
> @@ -346,7 +350,7 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
>   			0, 0, buf, &n, arg);
>   
>   	if (!ret)
> -		return n;
> +		goto out_success;
>   
>   	if (ret != H_PARAMETER)
>   		goto out;
> @@ -382,12 +386,14 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
>   				starting_index, secondary_index, buf, &n, arg);
>   
>   		if (!ret)
> -			return n;
> +			goto out_success;
>   
>   		if (ret != H_PARAMETER)
>   			goto out;
>   	}
>   
> +out_success:
> +	put_cpu_var(hv_gpci_reqb);
>   	return n;
>   
>   out:
> @@ -416,7 +422,7 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
>   			0, 0, buf, &n, arg);
>   
>   	if (!ret)
> -		return n;
> +		goto out_success;
>   
>   	if (ret != H_PARAMETER)
>   		goto out;
> @@ -448,12 +454,14 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
>   					starting_index, 0, buf, &n, arg);
>   
>   		if (!ret)
> -			return n;
> +			goto out_success;
>   
>   		if (ret != H_PARAMETER)
>   			goto out;
>   	}
>   
> +out_success:
> +	put_cpu_var(hv_gpci_reqb);
>   	return n;
>   
>   out:


Thanks for fixing this. This change per se, look good to me. So,
Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>


But, it would be good to move to scope based gaurds. That would
remove all the goto's and issues like this.

