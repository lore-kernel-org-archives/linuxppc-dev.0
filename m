Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78760A2600
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nwl8C3gE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP8QQ2VLQz30V0;
	Wed, 11 Nov 2026 01:38:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794321486;
	cv=none; b=NDGufDaOs/dqHvGZW3PEwnPZojFfkyVvQJGYJHkjFMWknEYp/XSkDxN2S/KNMY1M9QjVL4SL7V3XM15Si2+7kNUlqKOWM04AGj7WEyoUgexk+B3wwUFmZKw7Yry1N9N/n0npzNY1UP2tPRmhlBLfvnigqw0yumOBKvMv0KFaaDNkGU+9xyxmyIDaKercu++M1dJY9hsblSxqXnV1bRCZnm3nT+poi1Ptep23HsyXERUoYSl0KqrSkqGP2GseA06+pVUdznbKMPFpUm3kS7bW7ZLhzXGD8CXlr1aKjuI7WksgUeN//ayQEikP2t4FxYdaW1sroXeOhSuE4jcwnmgUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794321486; c=relaxed/relaxed;
	bh=Ig5ZI+kd6iU35YUUwhpb1qxrXXHnmsZuId8llNh8eYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNFPutCAyMHTEgCgEEeAmikChtybGu9FNxv7aJSTDr/fN+41dBx1Zk5X9zW/oUHe58YnUre62a5aV58kHKf18KzmDfgkTvSKjTa0t2DSy0XYc3CzfjXtSFyeVWzF5bYXYNWGyM28Tz7IdNFGHc4ikIlOhnGdKr8JhuKB67kLCxunaxLvc28j2EK7HSSy3TsymniDIs2WxOKr/yeKKt/n+BzbO/5xdPUrnYThL3eVfM5jz/b1qVvpxeMfrklxyShBGVMxjeSNnIRKhTSOGGc4ff7XdswrQum3cuN464a5VdptC7kmL8nOPoiOfcdX9kdZtdEpkhvOLB/+sU2LQl5YIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nwl8C3gE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nwl8C3gE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP8QP2y0Wz2yCr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 01:38:04 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEddb2178313;
	Tue, 10 Nov 2026 14:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ig5ZI+
	kd6iU35YUUwhpb1qxrXXHnmsZuId8llNh8eYg=; b=Nwl8C3gEeSey0jJ+bLLbOg
	0IMzjJbvM25agPL5GyqTqpDgi9UDTJDFBaS8sl1lX5o366Qg1AFiezPV/ATtS8QR
	PKAyYwRWkv0XtHlTgvvCAR0e0/vHBH9aVPF8baQuLiCPfgokuC26/UKVYxu+qYyp
	MxkbKiZGyDaaR0TsYJfm/hBcVuWlATa0PQpRwaIOvG3wrkPL723q5JFOc8OJiYZp
	XSewjPD76a7f5GBkonb0qI9kGP3pDxtF5euSgLkIhaEQ44Gp60w5XkqJMyuWY9Ig
	oQRuf7G82BJ2cduNExV3H7wVkV/57MgIXK9Byr+ELVBT35IxxzGr0tW0YYgRW/aA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6wbst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:37:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAC74QA1731039;
	Tue, 10 Nov 2026 14:37:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309gf14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:37:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAEbovp52167108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 14:37:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030CB2004F;
	Tue, 10 Nov 2026 14:37:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E2C020040;
	Tue, 10 Nov 2026 14:37:47 +0000 (GMT)
Received: from [9.39.16.14] (unknown [9.39.16.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 14:37:47 +0000 (GMT)
Message-ID: <e6b47bd5-425d-4c8e-8c68-5a36d47bd977@linux.ibm.com>
Date: Tue, 10 Nov 2026 20:07:46 +0530
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
Subject: Re: [PATCH] powerpc/smp: Handle missing ibm,thread-groups in
 parse_thread_groups()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <kees@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, chleroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <39282c731de90f47678952e471236ef22e9d4b15.1794317777.git.ritesh.list@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <39282c731de90f47678952e471236ef22e9d4b15.1794317777.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX3wPolIrCKx3z
 eC2Is1llpoH8e7sHaXmTs8rRi6wggOnJG06b/y22Nqbl52ZrXe+U6G7W7le3/m9W7E5t7BEl/8b
 jzzam+vENMI9F1O01w37XNphHtC2ZBU=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af32c43 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=iURFBnzjbH8NQLE5tzsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wG7wu85JICT-yZNSefg2kHbwI79dMQJT
X-Proofpoint-GUID: 6LmSpO9jS-jUVEUuw8-Lx1LK0yyy9v_E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfXwFWcJGYgnnWk
 jzFuk0HNwal1lHhsduDMiDPjKxesny+xa3M87XOSPlRt4r4d+0xFoq/HPk/tiSKmWnJv3YQFfTk
 ukppsiI9BcdvfxRwZlO5vsIIp4zr1ozldRkpDhyHTk3Bbo01hnaVXznhi7QlRR5FnK6MPn+N8U2
 CMN0T0ZTdnhB7SxdNSJ3hZ5YvVwn3yNSKm5jVaFksr0rtrRKM9Y+6/ChiCQBWYfF2d4ygOBCCW9
 LRNz/6jYwI1lYZ3a4OjGOF6/lQUAh2VqkES5rO4RTLurXpVJTPD5qnSuWQ9aQLCXlu4/zd2J+ou
 sYY98z9ZIkjlOIE4KM9NU5G/WI5dVgGTVdx+nR1KRd9kkS6NsUHMpWHTdeGeAbfJIwDI9QATrQ7
 umsNTWzwDi+CioyHrlaZlm5mR2lV6zW0xIkgpt2Hg39e5QGRwcE0H0lE9DwKqt0nUuNF13UXq8n
 VuNMhul21JXkxCh3u0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100056
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

+cc nathan, Kees,

On 11/10/26 7:13 PM, Ritesh Harjani (IBM) wrote:
> Power systems can have ibm,thread-groups properly absent like in one of
> the PowerNV Power9 boxes where there was a warning splat reported on
> 7.4-rc2:
> 
>    WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1a0, CPU#124: swapper/124/1
>    ...
>    Call Trace:
>     __kmalloc_noprof+0x490/0x690
>     _kzalloc_noprof.constprop.0+0x1c/0x7c
>     init_thread_group_cache_map+0xd0/0x2d4
>     smp_prepare_cpus+0x2bc/0x484
>     kernel_init_freeable+0x168/0x3c4
>     kernel_init+0x34/0x1ac
> 
> This happens because today we don't check for whether the properly is
> present or not and directly pass the return value of
> of_property_count_u32_elems(), to the allocator.
> 
> This went unnoticed because earlier kcalloc() caught the overflow due to
> check_mul_overflow() check and returned NULL.
> But since commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
> conversions") switched this call to kzalloc_objs(), size_mul() saturates
> the size to SIZE_MAX instead and we now get a warning at boot.
> 
> Bail out early if the property is missing or empty. Follow the return
> value as documented in kernel doc of parse_thread_groups() function.
> 
> Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/kernel/smp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 7a25eaa59e62..9a0f63e43821 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -824,6 +824,10 @@ static int parse_thread_groups(struct device_node *dn,
>   	int i = 0;
> 
>   	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
> +	if (count < 0)
> +		return count;
> +	if (!count)
> +		return -ENODATA;

This zero count check is not necessary.

Code doesn;t dereference thread_group_array if the count is 0.

...
         while (i < count && property_idx < MAX_THREAD_GROUP_PROPERTIES) {
...
out_free:
         kfree(thread_group_array);
         return ret;

Which should naturally pass to kfree which is expected to handle ZERO_SIZE_PTR.

No?

>   	thread_group_array = kzalloc_objs(u32, count);
>   	if (!thread_group_array)
>   		return -ENOMEM;
> --
> 2.39.5
> 

Nathan reported the same issue on QEMU.The same symptoms.

https://lore.kernel.org/all/20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org/

