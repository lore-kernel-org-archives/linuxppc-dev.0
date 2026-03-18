Return-Path: <linuxppc-dev+bounces-18340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE167FCD0C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 06:35:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbJx92cmXz2xYk;
	Wed, 18 Mar 2026 17:35:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773815741;
	cv=none; b=noGqlnHYRVyhKyfFhNh5ay3e36mxA/L1djeb9qW2GJIfvltwodIaYlBIgk66ZKpCi7lpERdvSL12/ku/YUWFEos/RNXhwLrpg6VAT27A9JG/R3WjQlN9/fzAfgeZ3onwQa0c41APTs1dxp2Y253HM0zw0VcCXFMfYQYE2F5dxTZKahXDLDJTVSKaqMKYtTVIVnMg0r7ktoeDuNw/CrMHV2Zn2RQ5ygV49h0sXw4ogXVyLVD2giffpYxIltQThqir8n6qQPR4Y/d2L7fZYiFmVhrYDfjmbXZFuk4erxI19myoo1Kjat7+9EevRrdxuhjtFtIdueTSCniOkoifd4V+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773815741; c=relaxed/relaxed;
	bh=RVtABxUGyqYXtwHfN+JJOZD0Yp2Zot16jzhg+2+0tI8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TrfYCCjY4739DH/IiGRysSrbYI7XIU5jN055nPiTUz7EzZ5yRNQUfEMD61Fj3NpXULA5gIQyl0meLEXcwIzToz/Xuj+pjksp66fJH3u2EoN6k9z+yrP8DBpwuMbucU/E7ck+gfAHo+JNxp9Qm0chYmEL0ApLnChpIcQr9xQ0YySdH/8+dPo7FXu79M+BWVRTO0xkagstLc8515fi57oo+6YGMMdxAiSRsawWlMpb0xA9a4f2pgNZG21/P2S3SzaRaA3Aig6o7cTodbNlP5rGRcXKoyBL6SKLh15J1lwy/sq86HUUY8zi6041lxs7r00o7wfdkrmvcLU74PMAGrpmqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFVN1ta0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFVN1ta0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbJx815HDz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 17:35:39 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HMM7J81188759;
	Wed, 18 Mar 2026 06:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RVtABx
	UGyqYXtwHfN+JJOZD0Yp2Zot16jzhg+2+0tI8=; b=TFVN1ta0mXNUrUGxAwH9GA
	G2N5dTFo6ilyNM5wozXgLbmO2t2qoFSU049bPac/nAthjHWmOtKeal0eS/poZ/OS
	Mi3BOSRK4lCEe/6NZUE4mZ+7Lhl8NpjmMWtEjh/eTJ0PFlmslYxbIUCzHHwhft2z
	TyTU5EMcw21Pl0u9/fUkYGCZaE6cHC9LN5fSQUgFo4gaqrJrzhsUtR7IaTEfTyLy
	sroq6XOVmZqrS0PT9rsps6eENkmsHMBPlSrSa7VHaoYPomJJioYbLR5KMeaJkcCB
	HWeE7rIb3iZOBN+lkTaIoEEb6z5mJR5gwHbqEQ5guyK4VqzkB28K5+Ak/mZzozKQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfjt91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:35:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I6B2d5032333;
	Wed, 18 Mar 2026 06:35:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jvjsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:35:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I6ZVEl52822272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 06:35:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D9F2004B;
	Wed, 18 Mar 2026 06:35:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B9420040;
	Wed, 18 Mar 2026 06:35:28 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.25.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Mar 2026 06:35:28 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
Date: Wed, 18 Mar 2026 12:05:17 +0530
Cc: Venkat <venkat88@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, maddy@linux.ibm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com>
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
 <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
 <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Z-aEaTcRefxNRO5C2aDsWSrW_hl8NhUs
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba47b8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=9KTUCuxsr_UIN7oIV3gA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1MSBTYWx0ZWRfXwRJBvn7bb9ud
 z4cZWj+KhajCXZ46Z2rsnq2O/oPdfDXoJpBl35C1rgDv5QJOth7aTjG9d0N6WU8Peli8zEdenAJ
 OQOM0bU+onUz4xnf3G5dSg3/krfPFyyeTZf5jF6qnqRYuMoCnozphBS2ve+tNS1ShzPkHbGGGAh
 O0ePuKbqab0BY1jYfIMjrWBtKnxnzkXx88iO31j7ZRY2+Ywpiz1ktixmFdIaxsopTqD5iL1az0C
 E+GF4NS/lelSNF6Mn9DIm8kYoTHdPR9ht68A0C1JbCYi9w7/Xbxq+Ly+3COKmakxsetlXBR1R4q
 szGun39Xrz2yIOH1a9X7QZ2QnNpIYiy+1anyXxFjUjQo5+t8MdaFDdOFT8koiZYN6tEOxfHpGJR
 lTaeIYJJ9minW2izDHBsXdAIs2EAadR+vewpI2brbL7PV6SsNSy5DhD1a5s3PGLs1KJFX8jZobl
 Zp1zOaGIyxb1VDeuqJw==
X-Proofpoint-GUID: LMBiwWsHooIW3JtUqnTcNnoICyMEFBkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180051



> On 17 Mar 2026, at 9:39=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat =
<venkat88@linux.ibm.com> wrote:
>>=20
>>> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>=20
>>> The format_alias() function in util/pmu.c has a check to
>>> detect whether the event has parameterized field ( =3D? ).
>>> The string alias->terms contains the event and if the event
>>> has user configurable parameter, there will be presence of
>>> sub string "=3D?" in the alias->terms.
>>>=20
>>> Snippet of code:
>>>=20
>>> /* Paramemterized events have the parameters shown. */
>>>       if (strstr(alias->terms, "=3D?")) {
>>>               /* No parameters. */
>>>               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>>=20
>>> if "strstr" contains the substring, it returns a pointer
>>> and hence enters the above check which is not the expected
>>> check. And hence "perf list" doesn't have the parameterized
>>> fields in the result.
>>>=20
>>> Fix this check to use:
>>>=20
>>> if (!strstr(alias->terms, "=3D?")) {
>>>=20
>>> With this change, perf list shows the events correctly with
>>> the strings showing parameters.
>>>=20
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Thanks Athira, Sashiko is noting in its review:
> =
https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux.ibm=
.com

Thanks Ian for pointing this. Its interesting to see this review.
I will check through the review.

Thanks
Athira
>=20
> By inverting this check, parameterized events now proceed to
> parse_events_terms() and the rest of format_alias().
>=20
> If a parameterized event uses a built-in perf keyword for its =
parameter name
> (e.g., config=3D?), the lexer parses it as a predefined term token, =
which sets
> term->config to NULL.
>=20
> Does this cause a NULL pointer dereference in the term iteration loop?
>=20
> list_for_each_entry(term, &terms.terms, list) {
>  if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
>    used +=3D snprintf(buf + used, sub_non_neg(len, used),
>      ",%s=3D%s", term->config,
>      term->val.str);
> }
>=20
> Passing a NULL pointer to the %s format specifier for term->config =
might
> cause a segmentation fault or formatting corruption.
>=20
> Can this also lead to a stack buffer overflow due to how snprintf() =
return
> values are accumulated?
>=20
> snprintf() returns the number of characters that would have been =
written.
> If the event names and terms are long enough, the "used" variable can =
exceed
> "len" (which is typically 1024 bytes).
>=20
> When evaluating "buf + used" in the same loop:
>=20
>  used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);
>=20
> If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
> compilers can use this undefined behavior to infer that "used" <=3D =
1024
> must be true, which optimizes out the safety check inside =
sub_non_neg():
>=20
> static int sub_non_neg(int a, int b)
> {
>  if (b > a)
>    return 0;
>  return a - b;
> }
>=20
> The compiler can reduce this to simply "a - b" (or "len - used").
> If "used" is actually greater than 1024, "len - used" evaluates to a
> negative integer. This negative value is implicitly cast to size_t for
> snprintf(), resulting in a massive size limit.
>=20
> Would this cause snprintf() to write past the end of the stack buffer
> without bounds checking? Using scnprintf() might prevent "used" from
> exceeding "len".
>=20
> Thanks,
> Ian
>=20
>>> ---
>>> tools/perf/util/pmu.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 23337d2fa281..0b8d58543f17 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>>>  skip_duplicate_pmus);
>>>=20
>>> /* Paramemterized events have the parameters shown. */
>>> - if (strstr(alias->terms, "=3D?")) {
>>> + if (!strstr(alias->terms, "=3D?")) {
>>> /* No parameters. */
>>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>>> return buf;
>>> --
>>> 2.47.3
>>>=20
>>=20
>> Tested this patch, and its working as expected.
>>=20
>> Before Patch:
>>=20
>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>>  hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU =
event]
>>=20
>> After Patch:
>>=20
>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>> hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
>>=20
>>=20
>> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
>>=20
>>=20
>> Performance counter stats for 'system wide':
>>=20
>>        2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
>>=20
>>     229.938231314 seconds time elapsed
>>=20
>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>=20
>> Regards,
>> Venkat.



