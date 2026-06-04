Return-Path: <linuxppc-dev+bounces-22058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CA4CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:10:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWWKL4KM8z2yT0;
	Fri, 05 Jun 2026 03:10:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780593014;
	cv=none; b=F9GV7bIwE0xsxpbDCFddiwiWKzjM5HCy5ibZtx+1vd9IyOdxN1AfrOltWs2S2bTZ9pwKJP5SI1juzR+GDBGpq5Ak9UrpLTfNgEdL4HuJkJ0hxZVzVioz/kllhxhPj2yQfod6tjn9n9puN1N5SqdXr7kys658TwuBcnTsfnoNaJo6wYyk2EUDmhfjpNI5F2maCZdamz9tV/JOFV9PI7l9I1E9FocsIDknb/CiX0ov8VhN/3PNNVuP/IwPb6ChIraTCvcfTOJDoZKdrgWsFb+bj4MZh2RMMuwhv6RQETDVTEcZPnRSwItdlWoYVEu/FEYdBxkt115fnz3kr3OD7OiZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780593014; c=relaxed/relaxed;
	bh=KYTck4dP190YFvJY5ermFy3I9VGWH8zerfMY91/E/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXhuxegNUx4I7XlDgg+7Tx/p25btc7SUWNhR+ahmp5PqY7cKxiRPEEyZcPUZoRko3pml6Hi44L/y9D/6naaCk1pQXkBNKRuiG7KLHoydYpAcRt9qf2JdWkkl+IHZK0o06khp+ZqAtyy5IhUEiz+MCKofwTovlLBBJ8mCTcshPFa13+nlpCWO3kACH3YtJLxrBVHbxFfVCGIbk1ohI0CxQ/2dEb1wzoY+pb1+30+Y2kiX5DZ/LJJR1sA2n6mQtpj5u3M5gpKiW/um2Mo2yhLmc1WxuvDPXno0iwzWRd3yB3hL3IhtzVh8W7o3M73+NS+3GBUf7vbFfyKylZFBow/XqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j8q/pMz+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j8q/pMz+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWWKK630Tz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 03:10:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654EieYc3089123;
	Thu, 4 Jun 2026 17:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KYTck4dP190YFvJY5ermFy3I9VGWH8
	zerfMY91/E/Wc=; b=j8q/pMz+rLyznjx9iVSUBVU8ACPs22zWkOKdsR5fe0MYzH
	CV1+f1cH85mvFtVRsRx+deoc9xekNjChNeKJYtys5SEhviAGMtb1PoESjC8yHfza
	oqs0lC6s2nr3aTEGbxKhuONpsZTkrloK15DnY+WRLx0jk8T4cWM0RX+eam/5h2e6
	flyQJCpNBtt3ctK5nNmYC9Zt2I58i2JLim+4nDoiwx8mLb6OLeJBo6G8V1dwEfhE
	WwtVNeqpi57fCha6UQ147SyajyGmCGUAIVrgXqF9j/9+ZwGvICNK0Th9PXBtwgAQ
	Cgbi7BPv11dNzNh4e7+6cMDNLp+myTOocjaZkZEg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm58vg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:10:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654H987o031242;
	Thu, 4 Jun 2026 17:10:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw65df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:10:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654H9x9V49676626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 17:09:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E655120040;
	Thu,  4 Jun 2026 17:09:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE3420043;
	Thu,  4 Jun 2026 17:09:57 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jun 2026 17:09:57 +0000 (GMT)
Date: Thu, 4 Jun 2026 22:39:54 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] kvm powerpc/book3s-apiv2: Add suite initialization to
 skip GSB tests without APIv2 support
Message-ID: <20260604222102.70bbd95c-47-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Eric Biggers <ebiggers@kernel.org>
References: <20260604092931.344101-1-vaibhav@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604092931.344101-1-vaibhav@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QpFYU00d70rGrrLz70yUcTNtWe8EaECE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2NyBTYWx0ZWRfX5IDwkM1MEmvD
 JzIdUAWwi7cbwJzxDcSh0cOVM1dOLL10/dx7n8qbIgU6A2Z+nmczg87O6LXHj1R8yKKg4f/+0yq
 Xg0GCpVRdCcc+EBkoqMxzH3jgVe3/vqB6hYfsPk5VlkqdjqEK8NxV3/tIaJTxubjDk/jUzpFwmN
 BBJCLgqSkHq32xqPGTymN122RZ22QlqtrLToOTxQBL+42wOpgYs4Tq2q3DFlK2+PQn3BNE2fs5b
 hOKsjArnio37D9cmjogkU6HSGa0Anb801HR8qjP/a+KGEZbieFhTtWjcnQ5yv8bXxVhW2Rluu/r
 5JDU0h2qaR3WGmW/soRiWaTXCGsQBe9PY/yaTr16L8ZYZfUhGZVcm5eShFk/ViZAz/lsdu892eJ
 VMBDqOpMYJtHYHrC/j0q9Yh97jACKkFar+0uYpeArj31qhFWZZYncKed5kwDpw1FWlbrDLgP4Kk
 FFZGfIibeOP3h9jmB9g==
X-Proofpoint-ORIG-GUID: QpFYU00d70rGrrLz70yUcTNtWe8EaECE
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a21b16c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n1BL4Hg_4__LmREFjH0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040167

Hi Vaibhav,

Thanks for the patch. Please find my comments inline.

On 2026/06/04 02:59 PM, Vaibhav Jain wrote:
> The guest state buffer (GSB) test suite currently fails on systems that
> do not support the PAPR APIv2 nested virtualization. This happens because
> the tests attempt to use APIv2-specific functionality without first
> checking if the host supports it. This was recently reported [1] when
> test-guest-state-buffer kunit tests were being run on Qemu without enabling
> Qemu capability 'cap-nested-papr' which enabled APIv2 nested virtualization
> for PPC64 Pseries Qemu machine.
> 
> Add a suite_init callback that checks for APIv2 support by calling
> plpar_guest_get_capabilities(). If the host does not support APIv2
> (indicated by H_SUCCESS not being returned), mark all test cases in the
> suite as KUNIT_SKIPPED. This prevents test failures on systems without
> APIv2 support while still allowing the tests to run on capable systems.
> 
> [1] https://lore.kernel.org/all/20260603064225.GC18149@sol/
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Assisted-by: Bob:Claude-3.7-Sonnet Bob-Shell
> ---
>  arch/powerpc/kvm/test-guest-state-buffer.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
> index 5ccca306997a..f84b40fa55db 100644
> --- a/arch/powerpc/kvm/test-guest-state-buffer.c
> +++ b/arch/powerpc/kvm/test-guest-state-buffer.c
> @@ -521,6 +521,24 @@ static void test_gs_hostwide_counters(struct kunit *test)
>  	kvmppc_gsb_free(gsb);
>  }
>  
> +static int init_gs_test_suite(struct kunit_suite *suite)
> +{
> +	long rc;
> +	unsigned long host_capabilities;
> +	struct kunit_case *test_case;
> +
> +	/* Enable test suite only if APIv2 is supported */
> +	rc = plpar_guest_get_capabilities(0, &host_capabilities);

I believe we don't really need an hcall overhead to check the
availability of APIv2. We could simply check:

diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
index 5ccca306997a..a263e7f31e15 100644
--- a/arch/powerpc/kvm/test-guest-state-buffer.c
+++ b/arch/powerpc/kvm/test-guest-state-buffer.c
@@ -521,6 +521,18 @@ static void test_gs_hostwide_counters(struct kunit *test)
        kvmppc_gsb_free(gsb);
 }
 
+static int init_gs_test_suite(struct kunit_suite *suite)
+{
+       struct kunit_case *test_case;
+
+       if (!kvmhv_is_nestedv2()) {
+               kunit_suite_for_each_test_case(suite, test_case)
+                       WRITE_ONCE(test_case->status, KUNIT_SKIPPED);
+       }
+
+       return 0;
+}
+

Also, I understand that these tests exercise gsb related tests specific
to APIv2 but I see that only 'test_gs_hostwide_counters' relies on an
APIv2 specific 'H_GUEST_GET_STATE' hcall but rest of the tests just
operate on in-memory gsb. So, do we really want to skip all the tests
when APIv2 is not available?

If not, we could simply skip this one test as:

diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
index 5ccca306997a..89999b80fdfc 100644
--- a/arch/powerpc/kvm/test-guest-state-buffer.c
+++ b/arch/powerpc/kvm/test-guest-state-buffer.c
@@ -462,7 +462,10 @@ static void test_gs_hostwide_counters(struct kunit *test)
        int rc;
 
        if (!kvmhv_on_pseries())
-               kunit_skip(test, "This test need a kmv-hv guest");
+               kunit_skip(test, "This test need a kvm-hv guest");
+
+       if (!kvmhv_is_nestedv2())
+               kunit_skip(test, "This test needs an spapr nested APIv2 support");
 
        gsm = kvmppc_gsm_new(&gs_msg_test_hostwide_ops, &test_data, GSM_SEND,
                             GFP_KERNEL);

Please let me know your views.

Thanks,
Amit

> +
> +	if (rc != H_SUCCESS) {
> +		/* Skip all testcases if no APIv2 support */
> +		kunit_suite_for_each_test_case(suite, test_case)
> +			WRITE_ONCE(test_case->status, KUNIT_SKIPPED);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct kunit_case guest_state_buffer_testcases[] = {
>  	KUNIT_CASE(test_creating_buffer),
>  	KUNIT_CASE(test_adding_element),
> @@ -535,6 +553,7 @@ static struct kunit_case guest_state_buffer_testcases[] = {
>  static struct kunit_suite guest_state_buffer_test_suite = {
>  	.name = "guest_state_buffer_test",
>  	.test_cases = guest_state_buffer_testcases,
> +	.suite_init = init_gs_test_suite,
>  };
>  
>  kunit_test_suites(&guest_state_buffer_test_suite);
> -- 
> 2.54.0
> 

