Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B707606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MpN/ngx1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzqh5fx5z2xlY;
	Wed, 18 Nov 2026 22:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795001296;
	cv=none; b=mUhYvkQ0cMfQUbPS2JUKOq0oAHDKNSwAji0K6tCqc5odUjNdgymiLXDjpVwGcWWDfGbpctp9DoAJdSgfn4Ws4F5qb+F9RXrRvoH4qoQqbpo/BkXSBZl4kz9RHaZLaCCTIQq4p2fBiHzl3F5Wk6sXda+t8id551V39NAfQuLcljQEWmcuMHPO9vA39LBkEXsEYyDPIMWx5jxDhGzQHA4sW7DQ8vBA106bzrENbz07ubh6aNP3TTTAGJzyIBd0gzSSeP5bZNkfCI08VttA2b0LAHJnwP+x9x69RC1QHh/gNbgLChPllFBllLK9c+Y7cH5bqTIQpEsxl/Z/rqfVEEvQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795001296; c=relaxed/relaxed;
	bh=IJC9KJmTrnmm/LU0ScPd6lIZJgRVI3dJDnY3i1kWIT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4D3waP++iZsplMMF0gDNox62SmUcIh2TkwV7s3cHZp5YXEmu1MS19n14z8tFU65ix5027FFnyCt4dwssqPDPjrddAz/W17+LgR4AYyUL1OJETQCV+Mi6UJ51Upxi08JKJerj96eJar+nqeqzbL6j4BDFaJjETYUyPY2z83KBOtpFcDbDkT+hZhKA52RqLskfdfyx4Px1X9hUDxHGcnGIx6iIJGCDX6yJaLqCWhAYT88KJ58NUjKIDuuKCCdkhs7zjTFuX+yt4LKt2u+p40SgmFlHg8HeFZ+SkS56enNn9dros00QlP4jJnnOsXhZM45rpc0H01SRCJZi2kJ5B2w0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MpN/ngx1; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MpN/ngx1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzqg68DGz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:28:15 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBQwmd3964612;
	Wed, 18 Nov 2026 11:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IJC9KJ
	mTrnmm/LU0ScPd6lIZJgRVI3dJDnY3i1kWIT8=; b=MpN/ngx100a1YoZ1TBmrDu
	xlZ6f7Fau81hNb5HUNS98DeChP7vzdp3K/9eU/f/rC13BRg8FpykIrJdzQfZF8ct
	/fIMsp94voegU2nH3U8M+0OsZOSt05IAVCi2lPkUdCGjxEGjD45kBA+ssBf/UPxg
	eF8H8Ch5piXt9hGwU2M0QgFhEa0DI+6wsJR6Jb4gVlU5remz91u8F2TFC+KfUOd6
	vyHHfNRAjLFpwNes2ynNrQmI8i50fcXDnBPI0SVMkqnbyyU13G0NBO8mIRUKjJu5
	geIwq3mcV+oapy1MUEdLBHJK56psqG8FRahoA1dqRms4Dmtv6b8ONV039MVmo8zg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vt3a6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 11:28:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBK5JX1928622;
	Wed, 18 Nov 2026 11:27:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4rp1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 11:27:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIBRvMi15991316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 11:27:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7FFA58064;
	Wed, 18 Nov 2026 11:27:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CAF958060;
	Wed, 18 Nov 2026 11:27:52 +0000 (GMT)
Received: from [9.43.57.33] (unknown [9.43.57.33])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 11:27:51 +0000 (GMT)
Message-ID: <11020f85-6e45-4a2f-bd72-b006e337623d@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:57:45 +0530
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
Subject: Re: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
To: Ian Rogers <irogers@google.com>, Nayna Jain <nayna@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar
 <zohar@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        driver-core@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-3-irogers@google.com>
 <CAP-5=fUQvqpny1CrYVUqg9SQo6VpOuUqfOK403BxK_vWCDU30w@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAP-5=fUQvqpny1CrYVUqg9SQo6VpOuUqfOK403BxK_vWCDU30w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vXKWCYIsO8QL_giJhdoQTN72NW1RHYq2
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd8bc0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=uPf0OYVXD692Dvb0MzEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h-je1vqzPwGpa6iH9pk9RsytTjhUVezA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfXwTGx+Eq+qFXW
 oes0I2T049kquvdD1aytGbD+9kVmQaqjQXodSLRxTDs/5+jLgiDeQKhaWOPtQ1ei735Pc3f4ZYm
 nJ8heTk3fUENtZS74FS8VGJyVjA+bEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX019265k+gXwI
 dmowQQGxK8g00xqzQJSVSiBKPXJ2DrO1kSEkITFPg3lKy67l12Gs/WL97ZOew48EaHDBvvtP8kJ
 nmhF2RXE0JTnNlQ0uJTVKTdndAAvyHJq1wKVuguvenc9GjlMDJ19QKSaJS/RP8CF11pXN0ZKjrb
 9mfgUaFvr9ZHGlmcRh4w85p8sgl6lvxwyikOeRBNipn470tyhLHCCVxa6BMvSsgaFyMpQmkL0Kp
 crNx4pIfbpwO4GzRNlHT0f2u52cDjlyJ8ytwvVI0U0DsQcdK0GXh1JZBcSOu9Fp+F6pEr+9Ij1/
 JSHqcChqck5xfbeeJdQqlvfWZXckM3EbLMkvaEltCsSxC/ql+TZ+KIdrEPoZ6URBOIkwsEkGlk3
 WxOPAptBzobfMEbJhLa0XA9mBw6AOO2+Dxb45sV42oX4Dki7S4CXajrwEW5fUXAoYSTGIrLWSAW
 IGp1pGjhM8eyEWi9mIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180045
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/18/26 1:55 AM, Ian Rogers wrote:
> On Sun, Nov 8, 2026 at 2:39 PM Ian Rogers <irogers@google.com> wrote:
>> In add_var(), a struct kobject is dynamically allocated with
>> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
>> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
>> However, secvar_ktype does not define a .release callback, which results
>> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
>> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>>
>> Provide a secvar_release() callback that calls kfree(kobj).
>>
>> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
>> Signed-off-by: Ian Rogers <irogers@google.com>
> Gentle ping on this patch (moving PowerPC maintainers to To: in case
> this got buried in Cc:).
>
> Danilo offered to take the full 9-patch kobj_type::release __must_init
> series through the driver-core tree with subsystem ACKs, and this is
> one of the last two patches awaiting an Acked-by. Does this look okay
> to go via driver-core?
Sure Ian

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

>
> Thanks,
> Ian
>
>> ---
>>   arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
>> index 395399bbab2c..f3f6ac25ea78 100644
>> --- a/arch/powerpc/kernel/secvar-sysfs.c
>> +++ b/arch/powerpc/kernel/secvar-sysfs.c
>> @@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
>>   };
>>   __ATTRIBUTE_GROUPS(secvar_attr);
>>
>> +static void secvar_release(struct kobject *kobj)
>> +{
>> +       kfree(kobj);
>> +}
>> +
>>   static const struct kobj_type secvar_ktype = {
>> +       .release        = secvar_release,
>>          .sysfs_ops      = &kobj_sysfs_ops,
>>          .default_groups = secvar_attr_groups,
>>   };
>> --
>> 2.56.0.455.g6c5a503b38-goog
>>

