Return-Path: <linuxppc-dev+bounces-22180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E6CD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 08:41:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYlrh64Ddz2yCM;
	Mon, 08 Jun 2026 18:41:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780908100;
	cv=none; b=OlB6Cx1B8Ez0Rs16PDHqTiBWWWFb7QVqDvAgKd6GHKXPn7nj0creOEjdj4wwwjwhL3sSApQ9rFR8Gk+uw/lOMm9j9kE27yYycdYgFiKgC7k2N8Wss2vsqUKHLZ7T+TYOBs13uNG4+oMVV7vnZwvYaJ7s0XI2+fjMLk2Yp9bmIaiMylAUU5I05T5hlHq3yD7Qq9PD+9i8c4l0mzwizGN5h4DpugJQzKduubzRPChgYamV48x3/1aD2o018cJfCQZlSnNiewWCWkZb+PjHcxONXzH5sGWerM+a05rTcCx8/gLuxijz43UhPossX4LwXeBnhR58Le6rwzviGErH1Rv/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780908100; c=relaxed/relaxed;
	bh=qxP33tHTiH9JRoomvLUhpuOwBkNfYM6QqaMIbGu7vPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/mBK75DOHDV8gBHLYqcr8mbSUJbWMYZ4NhzdeEOOrbPYtsP4nKdN8Ie0fY39oUfR3QQrIVUmHKIsW9kRaME0sR/d7oJ3zrHjuoFpmvrQiphXqalCYdlGomKn8o+JbE91QU2llQdnwnCRXW3EhRSzZIK+aeIf+jflteZ8OMQwvR41alzNt3pfHrLVZ2znP3TxKuT8pFfnsrjhJq+wQM6s3NOmWBEGDdZYjXl9m9sa9nRSnTN1VefdDtCqXIfDni6Q/WC75eBNEXYQSSFcNGjeBOXg020VKkTGBarDxulUphyho4AFGYxLg72Vjh0Cj4+PBFJw+8xVneWsGVTXfz/0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tIk5t+1e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tIk5t+1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYlrg6jnxz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 18:41:39 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6584j6QG957566;
	Mon, 8 Jun 2026 08:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qxP33t
	HTiH9JRoomvLUhpuOwBkNfYM6QqaMIbGu7vPc=; b=tIk5t+1eoAzDAqSx/40T4P
	OMk5WT4blpsWTQVyo41eRa9X/2qyZIhTBjk8fhcOgjnyMOQL/PYfSRNXUgnZF7om
	89cdv5bfDiyz+8Wt6x4/jpuCGOKbjMqHsp2kleVjyWw9jVjgTU4OUgV0r2Wibx35
	Kr0NQ7p0lGQlGxN5QexqltvkLoNQkibmMdmRXRHACvLtAf2a4eOYZ9/iEZesd4fZ
	aBsZHxjeB6GDSedhDbpBsP6m1cmTXZwLle03vLASRwn+CR4bg/wvxyDthVvNy/8T
	ScH7BcRpqj5ukxDaGQDzUmVW95Lr0p/C3+1VUDnbtrIx7kUBtSUEaFfqTjLush+w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qed48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588YaT4029965;
	Mon, 8 Jun 2026 08:41:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvmph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6588fMKc5243466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:41:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB7E458055;
	Mon,  8 Jun 2026 08:41:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E8058054;
	Mon,  8 Jun 2026 08:41:17 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.211.219])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Mon,  8 Jun 2026 08:41:16 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 08 Jun 2026 14:11:15 +0530
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
Subject: Re: [PATCH 2/2] kunit: Add example of test suite that can be
 skipped at runtime
In-Reply-To: <d7b56622-6455-4e80-844f-086a0a3b1946@davidgow.net>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
 <20260604162805.556135-3-vaibhav@linux.ibm.com>
 <d7b56622-6455-4e80-844f-086a0a3b1946@davidgow.net>
Date: Mon, 08 Jun 2026 14:11:15 +0530
Message-ID: <87cxy1mnkk.fsf@vajain21.in.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a268035 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=nzuXsxulAAAA:8
 a=VnNF1IyMAAAA:8 a=eZglOl9lOmnXyWROEjUA:9 a=QEXdDO2ut3YA:10
 a=Jn5cl5okm61iLnyvC_SE:22
X-Proofpoint-GUID: aXiHbFCGrTpdFmLR4XCt0b5SxYL4d2cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfXzgGIihzmkVp+
 iWWSRd+NzIi486csjavDAU9XzDadgm2jN4OPdlb/G94I/pylAtRBcOOryZP1pwh0aTukHg/5q/D
 zkAdau3KWEjv9itAVlaKJImkVzvQE4G0yeIeqM2Fo6o8iJBd6v/j6JRtmiz8sEydS7QseCymY6v
 /+QwpU0vM/fmgnbLs61hSjvq0YIUFAAuex38t9LC0sP5CFmSu07ZUAQh8rHylD8MnmxHdO2Z/ul
 SPSh3rN7nzxq+ksFwDJUNZy1bwj+NpdfUgDXT7uthC96/SxlyFoT5IlMprSCLhHeYLoDWS+TUkx
 wZkAEspwG6lzzhPHN7awXTuHDq/eodGG8YrgWFfA7LjfI93jVvgw7HImYVTJT4lg6BuwpmPLu+k
 OcEB5mtv8MTMjVlcBSuvIDacTJzQiCwlxP+F5dp3gMopaun15TiyA6U2dSOdNh867sjzZNLPViC
 UL4Kz0r1HSWwfzXSqlg==
X-Proofpoint-ORIG-GUID: a1oXeeK40NWarEqBZjBv0pXROhUpAoLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079

David Gow <david@davidgow.net> writes:

> Le 05/06/2026 =C3=A0 12:28 AM, Vaibhav Jain a =C3=A9crit=C2=A0:
>> Add an example test suite name 'example_test_skip_suite' to
>> 'kunit-example-test.c' that shows how to skip an entire test suite based=
 on
>> runtime conditions.
>>=20
>> The example suite 'example_skip_suite' provides a 'suite_init' callback
>> named example_skip_suite_init() which marks the entire suite as skipped
>> using kunit_mark_skipped().
>>=20
>> This demonstrates a way for conditionally skipping test suites when any
>> prerequisites for kunit_suite execution are not met. The 'suite_init'
>> callback can perform any necessary checks and mark the suite as skipped,
>> preventing all test cases from executing while also indicating why the
>> suite was skipped.
>>=20
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>
> Thanks!
>
> Reviewed-by: David Gow <david@davidgow.net>
Awesome, thanks
Will add your RB to v2 of the patch series
>
> Cheers,
> -- David
>
>>  lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>=20
>> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-te=
st.c
>> index 0bae7b7ca0b0..b8ded54fa46d 100644
>> --- a/lib/kunit/kunit-example-test.c
>> +++ b/lib/kunit/kunit-example-test.c
>> @@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite =
=3D {
>>   */
>>  kunit_test_init_section_suites(&example_init_test_suite);
>>=20=20
>> +/*
>> + * This test should always be skipped.
>> + */
>> +static void example_skip_suite_test(struct kunit *test)
>> +{
>> +	/* This line should never be seen */
>> +	KUNIT_FAIL(test, "You should not see a this.");
>> +}
>> +
>> +static struct kunit_case  example_skip_suite_test_cases[] =3D {
>> +	KUNIT_CASE(example_skip_suite_test),
>> +	{}
>> +};
>> +
>> +static int example_skip_suite_init(struct kunit_suite *suite)
>> +{
>> +	kunit_mark_skipped(suite, "Test suite expected to be skipped");
>> +	return 0;
>> +}
>> +
>> +static struct kunit_suite example_test_skip_suite =3D {
>> +	.name =3D "example_skip_suite",
>> +	.suite_init =3D example_skip_suite_init,
>> +	.test_cases =3D example_skip_suite_test_cases,
>> +};
>> +
>> +/* This registers a test suite that will be skipped */
>> +kunit_test_suite(example_test_skip_suite);
>> +
>>  MODULE_DESCRIPTION("Example KUnit test suite");
>>  MODULE_LICENSE("GPL v2");
>

--=20
Cheers
~ Vaibhav

