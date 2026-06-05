Return-Path: <linuxppc-dev+bounces-22112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AB9CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:47:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWtmy5nR2z2yR5;
	Fri, 05 Jun 2026 17:46:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780645618;
	cv=none; b=aLLzsc8QcGtwK0efYKIAsj27giYqhAcT5bJwjjMhwLqQH0/TKyCBwMskhVgCdKETkehx4AiyhIYtQfGHHdh2QZ0ERJa8cH9NFAib5l5lWijb0uOv5btUKXLqFBMWcxNvicQMma2N8MknjNOApRLcEfnQIeHwe78SyUX79SeE/yppJxd3jH37ju50PNQ8EC2WmUStqsi50ClXf1Z4HhME3MMmItkzKMVZ6a2uPs5Rfgq7cfU7x8SlIiIN0BHkCh2FU+g+ytuaHhGA2s5Q7kEQiNmN3wLF66f69ZfNrr2l4gAkADPayor3rEY30M7ca2TBmSDY5wJaRg9ukAURkhCojg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780645618; c=relaxed/relaxed;
	bh=kh2LWQvnirgYvuEUp61D9x5QzOqwwwAjq/1nda39ucc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSIY69y4W9LOPjrHlQnlkOO36IISqARnNijzjt4Sm9a0SnUH/m+1U4IE5WybB74lmdMf6qgbYxz65hfCoueLb7kYDpWCgjdfxfdtADqgJ2P2omAJH86EA/s96mFmNEZISf+p+de+sKBG3cStjO4fJph+8ff4p47gMFf/eBc42M5p0rnougrH+qbT3N1+kHZab6ivDJK+i0UX0zlBMg8+bGWpH1wTOFSt/9imrdz1TFJ4BN7LOaWe7rka38XNFo9ZcblUDvpi5VDp4MKVOsfk7fFPqiLB8vyjDFg+EV8IVq99Tqb7ROXX6NYK099gCwATqmaQBcYdK9FSVzTp2qKgPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RQXEV5Xh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RQXEV5Xh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWtmy0Z5vz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:46:57 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654JxhMa3621258;
	Fri, 5 Jun 2026 07:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kh2LWQvnirgYvuEUp61D9x5QzOqwww
	Ajq/1nda39ucc=; b=RQXEV5Xh9rG7rwHafvK1WUdRI5nKcffx3LIKXrU0+o4m5k
	BZRiERJFKns681uzGxOABSM+R1LDDo+bROJhzbQS5n4zltOiEki/67RvU308IGIy
	YCXyjIJctwc7pzBBbXgZo6xfBumCH0Q8CyDrvef3edP8B5+gsq7/1XAXKqlxOoAG
	/kuTUgYkhQd8ysUI0f0C+exgHnMFL6rNinmL5AaPeVpX4V2luBF8V9Kpex2GRK4s
	46lerJeH1yAfmbXvigTNL45tLCMWtDY36oOYe5H1L0VsMAUM7CwrRpVl/Lig2Y7U
	lk0RmYPPTrs+zNB8K0mj+x4hiQFl51hP5tAFVAsw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4kh0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:46:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6557d505018993;
	Fri, 5 Jun 2026 07:46:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhrm4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:46:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6557kkge15991506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 07:46:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9E258056;
	Fri,  5 Jun 2026 07:46:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F47D58065;
	Fri,  5 Jun 2026 07:46:42 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.210.197])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Jun 2026 07:46:41 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 05 Jun 2026 13:16:40 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] kvm powerpc/book3s-apiv2: Add suite initialization to
 skip GSB tests without APIv2 support
In-Reply-To: <20260604222102.70bbd95c-47-amachhiw@linux.ibm.com>
References: <20260604092931.344101-1-vaibhav@linux.ibm.com>
 <20260604222102.70bbd95c-47-amachhiw@linux.ibm.com>
Date: Fri, 05 Jun 2026 13:16:40 +0530
Message-ID: <87fr31mntr.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3MiBTYWx0ZWRfX40d8GgJjBEbs
 sooapRCWWHtt33vuJ2tRaO2QisHr+SC7GcPlD8ziJFyfp5FKekQ8ZcBrYAqXZ6kz0bEMCPnifiD
 3q90fq5jR4GL/rJXgLbNGB+xjNMCfl3xreFltQ0FaiEN1sLtEcAaYetCgq3XDvv5oLyhdcrhpPk
 PpxwrTMXVCYecTeaAeNeK04IYqwK7h2NH5c6OsJ6R2UAblBogzTExeKkAw7DCo7O1MoeTgTkclf
 6MeKDXOG90oWLLiRhrFxUZ28ZCHxH4DnF/JjPKMHiFcyUWjqhOTlpQwW3HHbbfz2eerZOvUIDGD
 cxJuiPSB2XvHGHbWgC0dTgoSfUPOR46E5U8SjUuBgdjxWPEuglDqWn1aVp4G2KF6J2JdRCF7MhG
 edbbBixxNTLUuaLBVW1YDT8XwrXt3aDHAcFvUjyUIjlNBMxMVg7KUSSHm80h9vAmhaxjL73VaoL
 eYvwQb2dfCDedAwTi4g==
X-Proofpoint-GUID: vKAOJlaFKWlgdvaC-o70GPvFX3s6HRBR
X-Proofpoint-ORIG-GUID: vKAOJlaFKWlgdvaC-o70GPvFX3s6HRBR
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a227ee8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jzWXA_NfsZvr81g3n0QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050072

Hi Amit,

Thanks for looking into this patch. My responses to your review comments
inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Hi Vaibhav,
>
> Thanks for the patch. Please find my comments inline.
>
> On 2026/06/04 02:59 PM, Vaibhav Jain wrote:
>> The guest state buffer (GSB) test suite currently fails on systems that
>> do not support the PAPR APIv2 nested virtualization. This happens because
>> the tests attempt to use APIv2-specific functionality without first
>> checking if the host supports it. This was recently reported [1] when
>> test-guest-state-buffer kunit tests were being run on Qemu without enabling
>> Qemu capability 'cap-nested-papr' which enabled APIv2 nested virtualization
>> for PPC64 Pseries Qemu machine.
>> 
>> Add a suite_init callback that checks for APIv2 support by calling
>> plpar_guest_get_capabilities(). If the host does not support APIv2
>> (indicated by H_SUCCESS not being returned), mark all test cases in the
>> suite as KUNIT_SKIPPED. This prevents test failures on systems without
>> APIv2 support while still allowing the tests to run on capable systems.
>> 
>> [1] https://lore.kernel.org/all/20260603064225.GC18149@sol/
>> 
>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>> Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> Assisted-by: Bob:Claude-3.7-Sonnet Bob-Shell
>> ---
>>  arch/powerpc/kvm/test-guest-state-buffer.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
>> index 5ccca306997a..f84b40fa55db 100644
>> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
>> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c
>> @@ -521,6 +521,24 @@ static void test_gs_hostwide_counters(struct kunit *test)
>>  	kvmppc_gsb_free(gsb);
>>  }
>>  
>> +static int init_gs_test_suite(struct kunit_suite *suite)
>> +{
>> +	long rc;
>> +	unsigned long host_capabilities;
>> +	struct kunit_case *test_case;
>> +
>> +	/* Enable test suite only if APIv2 is supported */
>> +	rc = plpar_guest_get_capabilities(0, &host_capabilities);
>
> I believe we don't really need an hcall overhead to check the
> availability of APIv2. We could simply check:
>
> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
> index 5ccca306997a..a263e7f31e15 100644
> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c
> @@ -521,6 +521,18 @@ static void test_gs_hostwide_counters(struct kunit *test)
>         kvmppc_gsb_free(gsb);
>  }
>  
> +static int init_gs_test_suite(struct kunit_suite *suite)
> +{
> +       struct kunit_case *test_case;
> +
> +       if (!kvmhv_is_nestedv2()) {
kvmhv_is_nestedv2() depends on a static-key which is only set in
kvmhv_nested_init(). This kunit testcase however can be run before
kvmhv_nested_init() is called thereby rendering this check ineffective.

> +               kunit_suite_for_each_test_case(suite, test_case)
> +                       WRITE_ONCE(test_case->status, KUNIT_SKIPPED);
> +       }
> +
> +       return 0;
> +}
> +
>
> Also, I understand that these tests exercise gsb related tests specific
> to APIv2 but I see that only 'test_gs_hostwide_counters' relies on an
> APIv2 specific 'H_GUEST_GET_STATE' hcall but rest of the tests just
> operate on in-memory gsb. So, do we really want to skip all the tests
> when APIv2 is not available?

Fair point. However the GSB related code that these test-cases are
exercising will never be executed in a non nested-papr APIv2
environment. To properly validate the GSB management it should be
exercised with a hypervisor having support for nested-papr
APIv2. Hence it makes sense to only run these test cases with the
relevant support is available.

>
> If not, we could simply skip this one test as:
>
> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
> index 5ccca306997a..89999b80fdfc 100644
> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c
> @@ -462,7 +462,10 @@ static void test_gs_hostwide_counters(struct kunit *test)
>         int rc;
>  
>         if (!kvmhv_on_pseries())
> -               kunit_skip(test, "This test need a kmv-hv guest");
> +               kunit_skip(test, "This test need a kvm-hv guest");
> +
> +       if (!kvmhv_is_nestedv2())
> +               kunit_skip(test, "This test needs an spapr nested APIv2 support");
As mentioned previously test for 'kvmhv_is_nestedv2()' may not be
correct when this kunit test is being executed.

Also I have proposed a minor change to kunit at [1] to address
possibility of being able to skip a kunit-suite in its entirety. Will
rework this patch if the proposed kunit changes are accepted.

[1] https://lore.kernel.org/all/20260604162805.556135-1-vaibhav@linux.ibm.com/

<snip>

-- 
Cheers
~ Vaibhav

