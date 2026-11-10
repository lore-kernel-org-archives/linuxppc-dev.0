Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C51606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p5zCNWHN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNskL1wwxz2xfK;
	Tue, 10 Nov 2026 14:35:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794281754;
	cv=none; b=MEt6n1MJ+FLp+SImacrbPdXC+CeSG51tD9luvdRFXHa/efJYutcMKr5ZedYYbIt+JuS7n9X/T600NE0QGw3jpADcJHxqn4O35sCF+8jaLnBTxy2NhGfBFzLvOhm51iH5mrVGGC97ZApNoadLfdbPMRGSdEjg5meV73IB1uZehpOODgluCmVxJ9K89u/iJ3cq2yWRjdgy7Ut7AMP6mg8azXS3K0kG8K0QEbJ/CGsx5dGp0OrEelS0zXbmy2VgYOeksm6HwtmhXWlx3Rs8SZdtpG/riryMZCbzQt8SFsXVXhF3R4AZe4OaDvzow0U9pf4KNMkJVpldhS8+HTTLWt6T3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794281754; c=relaxed/relaxed;
	bh=lCplubZ3KW5IAPzFP2BWcswNJnUw6KB2HzBlQqEKJ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfB+B06MDXqadlwd5vkoEz158EFssEr7vDmgYsh0LRfaypiGwR2o5vlnMb338byzPgpdTAs++SXEIsE+UabwcV9JHLSyK4G7b2Cn+Zr+rDg8wkmRs+ZaNsf0yPknQkkQbDP58fH3ouaKFGzsRMPENa28BNaWD1a8HXS0rgYIu59iWlx5I2w7dVa+sBU126P0HOyqewdQlFiqVpzSZHihDl4KaNTgrJhZmDj+852/BySOuHHQApBXHMFhzByMkmCbYjAZsT0buktiGAiRthS1YCWzDNVCB5Wcd0xt2P189/5cz+uXU0ofdby2mmMbXuAw0LHwM44NhFPh7nY5WAOe4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p5zCNWHN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p5zCNWHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNskK10tqz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 14:35:52 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0iWMW3906794;
	Tue, 10 Nov 2026 03:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lCplub
	Z3KW5IAPzFP2BWcswNJnUw6KB2HzBlQqEKJ9c=; b=p5zCNWHNRKRKmx3b/mAjvM
	G59tZ19hSQvMODtcrLi/69iN7KAN5MIP/M8zBl9lwyoQkVXK5Yz6d+ND8i8RI5a7
	9wVXSoydj9d9ZQOu+iOA1k+cUiDEQJk3OnS1DirElu6CmtEX8j0caAMXOzmvTUnB
	yhb5i9DKmVSJL3OmvBlvg/aSF1Lwib8PVkSPQsIfLt353pdJEn6E6D1KAqufWXjd
	TKIwKRIVDBPQuKCekbN9gQIHnuHwbWuiSMqfxFomIUgtrp2RrvGnpxbm1BFonSE9
	sPixbEpc+cZc2QxBK213URYt6FV4CnbTV4dkjGwfjh8ep3uTrMyoqAObyyHZjuxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg2jwr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:35:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA14pZv1043053;
	Tue, 10 Nov 2026 03:35:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvw2uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:35:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA3Za5e30278160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 03:35:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7833558056;
	Tue, 10 Nov 2026 03:35:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10F4D5803F;
	Tue, 10 Nov 2026 03:35:31 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 03:35:30 +0000 (GMT)
Message-ID: <219b1f33-7bb8-43be-bbd1-7e7a5f805ad0@linux.ibm.com>
Date: Tue, 10 Nov 2026 09:05:29 +0530
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
Subject: Re: [PATCH v6 1/9] keys/trusted_keys: propagate wrapping key
 generation errors
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-2-ssrish@linux.ibm.com> <auy4vLV8CRJB2hKt@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <auy4vLV8CRJB2hKt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af2910a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=x0mFdGU97Ue3yh8tahEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfX5XELAtYD/6ZT
 wQfVNAWINDMlyr8XpqZOz7CDOEzV7Tss9lrXD8t+1/xXMSMsR21cdMQ1HsFXSNdCUkBuRhQwZjv
 kjzO7i+24zlcKUWng3TtT0IWzz6L0NLz4JxKx16QUAq4OqWqKvKrDLhBROtqYtfhi9VyDls5PRC
 nOAbedfvl3wTLZ7NjP4Er/YABoq4kTWK1RSx1SQxkyo5xoYIOuVdflrlu2pGnmE0iPTIEF8ctVo
 0ETxRjdzw4rPVEG7dK29zCse5hlnogzV2Uc/mk8vaVmr2qB/T8wy3u8zmlU/2tAleDU+3/an3fn
 epTzg0NPHOkPHL6mf70voQxXiXRynH2Bem9hQp95GZbjNFA7Y/B0bOrJR+g8MNAls2WU9F7woY6
 bUc8m295oVSvyHso7wzlfiZcXQcCumOPYommejBAUQ8NNxqcCBTZRzPuty8GAYYO25ZCpXy84cw
 9heh5pAWmlPI+pV7AQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfX8jDfyhclgVLd
 Cj0RxyVmt4od8yAh89vjeRlSJLgwW3QEPNpr7UWU6TO4VbSWDr52T6/Uc50vWDknIFq1Dr/4bBo
 DdzRHg10B6/ApTre8eHi44e18Th8xPE=
X-Proofpoint-GUID: vk_w2uHnWXnxc3jjNBFmR4eSdao1W_3T
X-Proofpoint-ORIG-GUID: bKv5OHUKM3cO6NFS6wbb7XorwYGzM8oY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100012
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jarkko,
Thanks for taking a look.

On 11/5/26 10:41 PM, Jarkko Sakkinen wrote:
> On Thu, Nov 05, 2026 at 08:13:12PM +0530, Srish Srinivasan wrote:
>> plpks_gen_wrapping_key() returns a negative errno when default wrapping key
>> generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
>> failures, discarding the original error.
>>
>> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>>
>> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
>> Cc: stable@vger.kernel.org # 7.0
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> Nit: I'd put the SOB as last.


Sure, I will make this change.


>
>> ---
>>   security/keys/trusted-keys/trusted_pkwm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
>> index bf42c6679245..422f752598e1 100644
>> --- a/security/keys/trusted-keys/trusted_pkwm.c
>> +++ b/security/keys/trusted-keys/trusted_pkwm.c
>> @@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
>>   	ret = plpks_gen_wrapping_key();
>>   	if (ret) {
>>   		pr_err("Failed to generate default wrapping key\n");
>> -		return -EINVAL;
>> +		return ret;
>>   	}
>>   
>>   	return register_key_type(&key_type_trusted);
>> -- 
>> 2.52.0
>>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


Thank you for the Rb.


>
> Br, Jarkko


Thanks,
Srish.


