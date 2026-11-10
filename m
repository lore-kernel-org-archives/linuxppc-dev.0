Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379F60A2615
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jkGcFe6W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPDDC0NxPz2xlY;
	Wed, 11 Nov 2026 04:29:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794331770;
	cv=none; b=HznE7kEFwtjWsSW4DRK7bsTbWH304HjSi9kTEdCaEdBlRbfizkI3KhrqJwvmykXKAy42RJJDOhmd45GE1M+/0vROxAw8Pqc3kTMLjTpFYb8X9/+fL8QTupCKjVuQdiXyrHgXmW6lTUh+rSlLAc7IRNDUbnOXJZNQFeTgE3PPCPPkk6gJwEvsjDZv+BkUxVNG/GfBdzSZHwnUgABLHf6j6WvuMcV/6dbKMeUncy2dyu8umWJRl2Ja/Tlf4eZxbmvzhGwXNsEplR3VO41o1dM9beA7uThFS+NEr/ASrBIlUwL6QnonbiEHFaDn2E68my/dp3sNrxBMhxkygLNDYIQ0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794331770; c=relaxed/relaxed;
	bh=BpV+K+p2ba6sXSUO+GYEB1VH/bpsjyQSMt5G6lPVDWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPKPGX8YDQSZQQtCvtHeoxMLTor0JeQdbnHBgIcnUJaGEnUVq1BdqegDB4LSPzSBjiQU7txyAywv6a8u/wz7E4e/ZWcxmMzYNG5PfaH1v5xyevS12DM8fiSju6JH1/xbDJg7bG1pegDtWSkZxyAYmOsdQPRU5NhRLdz2D8/D6KSBiMYruS022iKVd1yQ0v4p/oKpapZ0VQgFfRMFGldry4yjpin7dAoaEWW1WEpNnhmvTDVNuOniUM5nvR8BbM97UxJPUfq745EwSun+fn73ZQGOfaQSeBxsUia/H5VqLfYTsSi+k9VgmoQSx/7hGF7cKMAwQ30icu1aMWqw3EPqrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jkGcFe6W; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jkGcFe6W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPDDB01c6z2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 04:29:29 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFEXGd2865290;
	Tue, 10 Nov 2026 17:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BpV+K+
	p2ba6sXSUO+GYEB1VH/bpsjyQSMt5G6lPVDWM=; b=jkGcFe6WcLmEhrslyWM/jl
	fZ5q/c1fxsRrZd3qvfrwSLckaENeoKCA6ZgTQBzCPejPzqIbSuBja41bHRQ8OtIO
	tZDpRNIIRIJzP9roAzIqO2RGOLHvl4yVKH2jQ1RYUY/FmtBFprRDhruFNXHQ/Rp9
	cNFHTRkTEHvz+KD5Qm+1W9R6GBQVi9/YABGGlEnkwI2uLybPalIGU5c7HKdjAfhH
	Ek65yb07WEWZJ3RBaFXgKRgPFR8wCpXnCB3y7xq5xpLLVf9586CZzFhEco0djTwZ
	d23zQ6VEoQeg509GQ+cfM2vXNhqslXnaiKVcaBdbPV1LYM+/M0feNrvYlbHEKF9g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug66a48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 17:29:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF503N1925685;
	Tue, 10 Nov 2026 17:29:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309h3n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 17:29:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAHSxIU40960292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 17:28:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D92D20043;
	Tue, 10 Nov 2026 17:28:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1288920040;
	Tue, 10 Nov 2026 17:28:56 +0000 (GMT)
Received: from [9.39.16.14] (unknown [9.39.16.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 17:28:55 +0000 (GMT)
Message-ID: <77f21080-06cc-46ed-a125-d9859792ff3a@linux.ibm.com>
Date: Tue, 10 Nov 2026 22:58:55 +0530
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
Subject: Re: [PATCH v2 1/4] powerpc/topology: Introduce llc_override kernel
 parameter
To: Chen Yu <yu.c.chen@intel.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
References: <20261023131646.2907938-1-sshegde@linux.ibm.com>
 <20261023131646.2907938-2-sshegde@linux.ibm.com>
 <atuAaE4Y-_2CLA37@chenyu-dev>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <atuAaE4Y-_2CLA37@chenyu-dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 40IffSw--BjgpATlTgbsaJykScVbMuk1
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af35460 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0_ZDYW1gR2TTHSzkmfcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MGXdlJTINTHCq1qJQsHm9525lZQ5KhBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2OCBTYWx0ZWRfXyR1QyJgTICqX
 LXCiAJIRWJzPqVGyLs8w0uzfOjlS7cy+Jt77PZhYhNzDUvoMufNR+vNCavGhZ4OXA+bCtN8/j4g
 Wj24ZOS5PxdcQLndZXh7Xd2YePn4dSTS929Fyf5Q1DJ8Q7A/Zgy1YHo5SHs5//cNVmXMN/yav6T
 l6vUF2F7N6b+XPNoWD6KHB3j+zx8Okzlz6XoXeB0zNIbl7SCpH1qFjyxlkXSfYSMsRCAEo0EkZM
 9n4d97urm2Jgjl92sn4vJTzoqAyHhTUQPrQqWYsg1VbviMitLrh3ddmRvhrHYEnArnW8f9koimy
 M0aHwWjzIaJdxfnFY+QNcf7G/CKbUMxqV4N0rQcMHH9TIBvv5IMzCO3s6945rSYKL5wwNfyS1Ln
 /7usC1xIL7nPJXs/FuY4GTDSSwbzfZE5zk7kCQMLBGiMJWdKExr1QpWV4d6TyKFZKmMnethonwr
 i4kmn4oONVop6TVu/jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2OCBTYWx0ZWRfX7W5EJGjTBLd4
 y8GKVP6jhQLts9Z2Loz7brOIPr657hYeOwuBWJjyazJrA/m3yz6EjotX+uYdwFP5KQpSzAjEmiJ
 7Wk8fsSUSF0ukHiJ0Aqkbrk5RUqEOks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100068
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen Yu, Thanks for taking a look.

On 10/23/26 9:12 PM, Chen Yu wrote:
> Hi Shrikanth,
> 
> On Fri, Oct 23, 2026 at 06:46:43PM +0530, Shrikanth Hegde wrote:
> 
> [ ... ]
> 
>> ---
>>   arch/powerpc/kernel/smp.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 6a5a5469aaae..6b1201ea3572 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1059,6 +1059,29 @@ static bool has_coregroup_support(void)
>>   	return coregroup_enabled;
>>   }
>>   
>> +enum llc_override_values {
>> +	LLC_OVERRIDE_MC		= 1,
>> +	LLC_OVERRIDE_PKG	= 2,
>> +};
>> +
>> +static int llc_override;
>> +
>> +static int __init set_llc_override(char *str)
>> +{
>> +	if (!strcasecmp(str, "mc") && has_coregroup_support())
>> +		WRITE_ONCE(llc_override, LLC_OVERRIDE_MC);
> 
> There is only 1 booting CPU at the moment, maybe WRITE_ONCE() is not needed.

Yes.

> 
>> +	else if (!strcasecmp(str, "pkg"))
>> +		WRITE_ONCE(llc_override, LLC_OVERRIDE_PKG);
>> +	else {
>> +		pr_warn("Unsupported llc_override=%s\n", str);
>> +		return 1;
>> +	}
>> +
>> +	pr_info("llc_override set at domain: %s\n", str);
>> +	return 1;
>> +}
>> +__setup("llc_override=", set_llc_override);
>> +
>>   static int __init init_big_cores(void)
>>   {
>>   	int cpu;
> 
> On PowerPC, it seems that get_effective_llc_bytes() always returns 0,
> which makes exceed_llc_capacity() return true, so cache-aware scheduling
> is disabled on PowerPC. We might need to provide an arch_llc_bytes() that
> is adjusted based on llc_override - sometimes calculate the sum of L2 across
> several cores.
> 
> thanks,
> Chenyu

Ah!. I hadn't checked that. Thanks for pointing out.

I am thinking right path would be to move powerpc cacheinfo into a generic one.
I see there was an effort a while ago. Need to look into how to pull it off
if it is possible.

We could think of arch_llc_bytes if above is not possible.

