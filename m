Return-Path: <linuxppc-dev+bounces-22183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB7BCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 09:04:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYmM40jrcz2yR5;
	Mon, 08 Jun 2026 19:04:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780909472;
	cv=none; b=NNB19ff/4SLwqcCsfgSfquCEwWBFtinfbgGChnpy+rCYb1WZQC4ifjygjHpd+/+Rudb7t+TO+GlittkpresZF17WJk2n+a0Bo5NNlLyAX5zOnjZJUiWrqCJcFsKve5WYqd09zTJozP4jjTBoZK72EVHZWRsjV+0yjSQc41CAXNP49MjnGeR/q7A5eNHeMe48x6hD7gKAIv1aBzN/jHl/o/i4RMFSACAEZsZ7YTVVIj6nSQiOgbMykCUAKI+Yi736hATIcxG08SdDQVRW/syQImNrwKmtajAdYEg2XO2z36GVWCL66E/9GIlrCwXiKntO1kRYVNJa9u8JJUoSSh8j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780909472; c=relaxed/relaxed;
	bh=cHgup3axOMojWMulUtE7B/9JyHDSWEhW1MJrbppKeBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+s2fNoORkmc8xGOEakgMtw7W/wMI2MpE4RRcCB6wzFSZcOQI1BLbYgWrUCO2wU5N41AqDnNgHIqQtafkB+8tWi51NU90HovZ9HjSAYALUdeWwVOHFmExDvWdZa1l2nKjRIPCSq3XiUErGWm9w2wIkWpfb39iOj8vvj4YM44wmRTSy2tlE20J2/UGfuobXQjS7kmMgeF/FOq5C3n/zczqwxrpmcvU53h8jQ5lCu5/MeKUKfNfuNiCmpmZhkgOM9advGMP6/lPHZ4xkeeYHxElQ8Y/3rydauOYMfTaTSUGf+HvLKwd5R62EqN/LL62JfwkSvsnKCC8HizmyzEw6TT3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0ISW+Qx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0ISW+Qx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYmM26r5Mz2yCM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 19:04:30 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BN0HV3223957;
	Mon, 8 Jun 2026 09:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cHgup3
	axOMojWMulUtE7B/9JyHDSWEhW1MJrbppKeBg=; b=N0ISW+QxRY9OrWFRF0bv5Y
	sNgVZ63tep4g/sbf3Idwj4M3BRhRNhQ62SWk7fzj/6h/y6z+2mkfexFSwUwK0N53
	OSyHc8T9QM8uYzk6itFHkM/ItAd8HtZ+cGjxnoYLfHj34nhbDoiwtrrHGTc/eG88
	WQia/+3Gy9Xpf/u6ggZl58Khd0Fuv85Ypa3sqOVqc/3hC+qmV02Auj4eOCoFeCui
	AgXyFoGOG0rjKH65xCe2LaKvlNFpX04Ji4lyrA0+BEckIZLBfaTZhGa5ZFQ+rnhH
	YaGFwztBM6jIgn2yLXIYFLY6jOvXjsjEwbuMjqqaOIu/ArXvXpXXeEzz6lcSWprQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhpn8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 09:04:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588nqOv032223;
	Mon, 8 Jun 2026 09:04:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjmkh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 09:04:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65894BaZ63701290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 09:04:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E5F58055;
	Mon,  8 Jun 2026 09:04:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F2058054;
	Mon,  8 Jun 2026 09:04:05 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.211.219])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Mon,  8 Jun 2026 09:04:05 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 08 Jun 2026 14:34:04 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: David Gow <david@davidgow.net>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae
 Moar <raemoar63@gmail.com>
Subject: Re: [PATCH 1/2] kunit: Add ability to skip entire test suites
In-Reply-To: <758228d7-b555-447a-86f7-3c437ce92460@davidgow.net>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
 <20260604162805.556135-2-vaibhav@linux.ibm.com>
 <758228d7-b555-447a-86f7-3c437ce92460@davidgow.net>
Date: Mon, 08 Jun 2026 14:34:04 +0530
Message-ID: <87a4t5mmij.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfXxwb0mWG3q74O
 WK7acvTZd/ZXpzsdiGr0JS7aj3cgaJSiht4kzNbbQcm/1YBWL7XZ1GkC1PTgX88uedkierYZbNh
 SXug70/CCM6RYXr7L0u6lyb03+ptcpk38rN/l5/QNNqR5Sxowpd68KQlxSjQ/GK6Vk1wRNmTQ+3
 yWwqS/LA4rpdZVT5Q4TqvDjBIYq3L0bFJq+ocha7Ko8++0sE0JD0NLD9m3ysLkG4Hy+YkWhyzhI
 KdLHSk0VVcfrjv6R1MfzhcuBMWt5QC2scxXl5xa/v0JNhHQzqB5B9zLT/F6p9vZtvwj+9J/+SMC
 XM1OWbD28UvGGDEdj5f/W5wM2wJNrfV/SIXldW+Ew8Ub6SB4Zv+H9czw+aZm45Cvuk+0feAwRFp
 aKuNZIisSKIzFaQSIOPhxmR1N+zw5S3Po6KEVBAvKtkjlxxCsNHou92wmX6YULAfAW5pk23vjVD
 gqMWEiw2pMSlUJQhM8w==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26858d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=nzuXsxulAAAA:8
 a=ZakwTqujU9vwe5Myu5gA:9 a=QEXdDO2ut3YA:10 a=Jn5cl5okm61iLnyvC_SE:22
X-Proofpoint-ORIG-GUID: vO5s46Ho2P0N--NGYYeSykMLWMhtzbUI
X-Proofpoint-GUID: iSKoQ4sYqJK8uqVxpLQLtAOIAi4GN-c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079

Hi David,

Thanks for looking into this patch. My responses inline below:


David Gow <david@davidgow.net> writes:

<snip>

>
> Thanks =E2=80=94 this is great! There are a few cases it's not handling
> properly, though, particularly with respect to the debugfs support.
>
> I think we need to:
> - Reset suite->status to KUNIT_SUCCESS in kunit_init_suite(), so that a
> suite which is re-run via debugfs isn't automatically skipped again.
> - Fix the result handling in debugfs to handle skipped suites.
Agree, and I have addressed this in v2 of the patch using the
code-snippets you have shared.

> - (Optional) Maybe we could get rid of kunit_suite::suite_init_err now
> that there's a specific status value. That'd have to be done carefully
> to preserve all of the semantics, though.
Yes fully agree that kunit_suite::suite_init_err will be redundant after
introduction of kunit_suite::status. I have started looking into this
and will post a different patch{series} for this.

>
> Here's a quick (and slightly hacky) patch to fix the first couple of issu=
es:
> ---
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 9c326f1837bd..23d34bfdba95 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -58,6 +58,22 @@ static void debugfs_print_result(struct seq_file
> *seq, struct string_stream *log
>  	spin_unlock(&log->lock);
>  }
>
> +/* Print the result line for a suite. */
> +static void debugfs_print_ok_not_ok(struct seq_file *seq,
> +				    enum kunit_status status,
> +				    size_t test_number,
> +				    const char *description,
> +				    const char *directive)
> +{
> +	const char *directive_header =3D (status =3D=3D KUNIT_SKIPPED) ? " # SK=
IP "
> : "";
> +	const char *directive_body =3D (status =3D=3D KUNIT_SKIPPED) ? directiv=
e : "";
> +
> +	seq_printf(seq, "%s %zd %s%s%s\n",
> +		   kunit_status_to_ok_not_ok(status),
> +		   test_number, description, directive_header,
> +		   directive_body);
> +}
> +
>  /*
>   * /sys/kernel/debug/kunit/<testsuite>/results shows all results for
> testsuite.
>   */
> @@ -77,17 +93,17 @@ static int debugfs_print_results(struct seq_file
> *seq, void *v)
>  	seq_puts(seq, "1..1\n");
>
>  	/* Print suite header because it is not stored in the test logs. */
> -	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> -	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
> -	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n",
> kunit_suite_num_test_cases(suite));
> -
> -	kunit_suite_for_each_test_case(suite, test_case)
> -		debugfs_print_result(seq, test_case->log);
> +	if (suite->status !=3D KUNIT_SKIPPED) {
> +		seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> +		seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
> +		seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n",
> kunit_suite_num_test_cases(suite));
>
> +		kunit_suite_for_each_test_case(suite, test_case)
> +			debugfs_print_result(seq, test_case->log);
> +	}
>  	debugfs_print_result(seq, suite->log);
>
> -	seq_printf(seq, "%s %d %s\n",
> -		   kunit_status_to_ok_not_ok(success), 1, suite->name);
> +	debugfs_print_ok_not_ok(seq, success, 1, suite->name,
> suite->status_comment);
>  	return 0;
>  }
Thanks, have modified these proposed changes a bit for v2

>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c0ae45a22b2c..2ff145796450 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -798,9 +798,6 @@ int kunit_run_tests(struct kunit_suite *suite)
>  	/* Taint the kernel so we know we've run tests. */
>  	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
>
> -	if (suite->status =3D=3D KUNIT_SKIPPED)
> -		goto suite_end;
> -
>  	if (suite->suite_init) {
>  		suite->suite_init_err =3D suite->suite_init(suite);
>  		if (suite->suite_init_err) {
> @@ -836,6 +833,7 @@ static void kunit_init_suite(struct kunit_suite *suit=
e)
>  	kunit_debugfs_create_suite(suite);
>  	suite->status_comment[0] =3D '\0';
>  	suite->suite_init_err =3D 0;
> +	suite->status =3D KUNIT_SUCCESS;
Thanks, taken this change for v2.

>
>  	if (suite->log)
>  		string_stream_clear(suite->log);
> ---
>
>
>>  include/kunit/test.h |  1 +
>>  lib/kunit/test.c     | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>=20
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index ce0573e196ce..395221d623f7 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -285,6 +285,7 @@ struct kunit_suite {
>>  	struct string_stream *log;
>>  	int suite_init_err;
>>  	bool is_init;
>> +	enum kunit_status status;
>>  };
>>=20=20
>>  /* Stores an array of suites, end points one past the end */
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 99773e000e1b..989acc770265 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -214,6 +214,9 @@ enum kunit_status kunit_suite_has_succeeded(struct k=
unit_suite *suite)
>>  	const struct kunit_case *test_case;
>>  	enum kunit_status status =3D KUNIT_SKIPPED;
>>=20=20
>> +	if (suite->status =3D=3D KUNIT_SKIPPED)
>> +		return KUNIT_SKIPPED;
>> +
>>  	if (suite->suite_init_err)
>>  		return KUNIT_FAILURE;
>>=20=20
>> @@ -795,12 +798,20 @@ int kunit_run_tests(struct kunit_suite *suite)
>>  	/* Taint the kernel so we know we've run tests. */
>>  	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
>>=20=20
>> +	if (suite->status =3D=3D KUNIT_SKIPPED)
>> +		goto suite_end;
>> +
>
> Do we want this? If a test is run more than once, we probably want to
> re-run suite_init so that we can tell if we should still skip it.
This condition should prevent a 'kunit_suite' from running if its marked
skipped before suite_init() is called.=20

>
> While I don't think it's likely that a test which was previously skipped
> will suddenly become available, it's not impossible with, e.g., CPU hotpl=
ug.
Agree, I have updated kunit_init_suite() to set 'kunit_suite.status' =3D=3D
KUNIT_SUCCESS. This should force the suite_init() to be calledback again
when the suite is re-run.


--=20
Cheers
~ Vaibhav

