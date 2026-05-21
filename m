Return-Path: <linuxppc-dev+bounces-21283-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F3ACD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 07:32:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLg8k02fsz2xS2;
	Thu, 21 May 2026 17:32:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779348725;
	cv=none; b=DRTwk4TPKZ4hhfOJ0S12+ZpytyPzRLSsUUSxBtlmkbZci8RwU8Kzikn6EeLjefiIqyi/KXCkphxLI3RYEo/aB9uDv/aUOpka+gvQh7vJIL5qUMgCJl/MwYMe0kkaVcOQIvdEKCCkBObdK9LfXeKigmBXgslrJw8CQORfjT4Z2ZyuKeTg0zS4y+bfogttOdLAHn66ngQq3M3Aq7vRgRj1lpTJ/BnIYVClIo/O41XXT8SAKiRYR+qSz0Y+QzGGYNt2sx2ib/2uexYJvKK1YvU/yezgunhNTYEeRw1QUDrNPRiALIbmkvmP3ByXPjpTXlNIik5ihNT73r8R6z1ugfmIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779348725; c=relaxed/relaxed;
	bh=AW/GCoe5m8FewCv0OMx2jYlfQuXa6110AAjFldL5Ooc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YsxgJGYTA3fxCuCPI+1n2am50uqxL/sJ7up2zheN5rJTbLtvVXaw77XsabnxDWjltPbsSSwc2rDaE/nLgr9hCWZwFQ24lkCqsiOcC3WAG91YowECxoXMDV2TxcQjUQ9pjYKg2kq7TReOhNJbTfXFy7FIl94TBII9ongW221DDorZsSMxJwVbpegPFs1Q9Y4knrOz1bDouGNTxI3TDOS9w2UcT7NySUv4EHbODkMaHArGGcj01oZ2cgiFy8GlDgI4beTiIuelgZFRqXTEbEFC7e8trOVkM9s3albQGVcyYPRI9974vENcGfh9b5QS4xR0aNgbfdwMPjh2fv35YSTFYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lR0p6kOZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lR0p6kOZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLg8h0G7xz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 17:32:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KNlXCA3300127;
	Thu, 21 May 2026 07:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AW/GCo
	e5m8FewCv0OMx2jYlfQuXa6110AAjFldL5Ooc=; b=lR0p6kOZnakghIqjfAXhg6
	/Mk34DBFkWRptwpZ1lb6kxYU3UxfpY/s8bSnIejUCelrayWFjNuMMsK+hnbFYhXy
	ByW/kyfCTLMtdSkfL0F0qPsauuo3IfQt1Oeeoozxd9sNDifvu8sxE5vc6OnDSHVO
	SG/+4WrNOkyrwj63NzRdoXKvPnm70qyS05QJPnAm9VDsYesDhLd3Ek4vQzNyWg7k
	10hM86kEM/ypMLVr59tK9aJde+5okGmp2Qm5pWx5FySugSKUCFPOdxGgEUB20CGH
	0BD14wiX+Pzl079LcSexP7qJ81Ka9eT585JdyuPlF8UtUWVfsp7ngSeVQSTRK3tg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mwnf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 07:31:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L7O6AL019550;
	Thu, 21 May 2026 07:31:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gjrr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 07:31:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L7Vssr45482342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 07:31:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D0720043;
	Thu, 21 May 2026 07:31:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CF220040;
	Thu, 21 May 2026 07:31:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.10.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 07:31:51 +0000 (GMT)
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
Subject: Re: [PATCH V5 1/2] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <afwtl1zodrSUpK7n@z2>
Date: Thu, 21 May 2026 13:01:39 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DDA8CC6-1804-4193-BA00-937F9781E6E3@linux.ibm.com>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
 <afwtl1zodrSUpK7n@z2>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KUJWTWSnrg3GiO07Bjn-oPRJnQ9WaA_r
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0eb4ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=vpzdRXRLc0xae2Kgd0cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TfoA6IYPIGHNZMloAqIqGjqDYb00_65-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2OCBTYWx0ZWRfX1VyylWIeEK22
 HCSmtRt73hQ5PS4K8qsMv5uWGeo6wMNkq7hcA1waBkiJ11IQjB2JXcrpwHDMJxO8HyR01sOs4v/
 rEr0pCEDPKS39PTyR1YdBBfTpNqvb1qkjE86PNU8QgylXlsySSV3KUj1Tfomi9HOY3oDfL7BDMi
 Is2/+QNou0KSj0Sx9m2mc9XM4K1gSNCv1qUdYDQU+gHGKrjeoTU1KXdU1hHyK0iBS2JdHvmFpTU
 EXNi5P5ySNX5vbshOIYSBBSZUdeILmx0BfduYRIuQwFjzt0QxsVEUbclQDfvKsnfnygAhNLaz+q
 qprcNBEUkJzXRT6LQpEJNnCHVgj2FnIi73LkTMNvvFrVsOrklCsxUW+Buwa619PlTAAbP7GQ4b/
 0AoW1sX/TCgiTg2xe9lYsgWcR1D9JHEA7FKd1BOnI5qQpi1SctNwWnf+4R2N1bmtDmjC3F7gg9E
 1l8Bj0FnOLniwLkUquw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210068



> On 7 May 2026, at 11:43=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Mon, May 04, 2026 at 08:43:20PM +0530, Athira Rajeev wrote:
>> perf trace record fails some cases in powerpc
>>=20
>> # ./perf test "perf trace record and replay"
>> 128: perf trace record and replay                                    =
: FAILED!
>>=20
>> # ./perf trace record sleep 1
>> # echo $?
>>   32
>>=20
>> This is happening because of non-zero err value from
>> auxtrace_record__init() function.
>>=20
>> static int record__auxtrace_init(struct record *rec)
>> {
>>        int err;
>>=20
>>        if ((rec->opts.auxtrace_snapshot_opts || =
rec->opts.auxtrace_sample_opts)
>>            && record__threads_enabled(rec)) {
>>                pr_err("AUX area tracing options are not available in =
parallel streaming mode.\n");
>>                return -EINVAL;
>>        }
>>=20
>>        if (!rec->itr) {
>>                rec->itr =3D auxtrace_record__init(rec->evlist, &err);
>>                if (err)
>>                        return err;
>>        }
>>=20
>> Here "int err" is not initialised. The code expects "err" to be set
>> from auxtrace_record__init() function.
>>=20
>> Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to =
clear
>> err value in the beginning.
>>=20
>> - Clear err value in beginning of function. Any fail later will
>> set appropriate return code to err.
>> - Even if we haven't found any event for auxtrace, perf record
>> should continue for other events. NULL return
>> will indicate that there is no auxtrace record initialized.
>> - Not having "err" set here will affect monitoring of other events
>> also because perf record will fail seeing random value in err.
>>=20
>> Set err to -EINVAL before invoking auxtrace_record__init() in
>> builtin-record.c
>>=20
>> With the fix,
>>=20
>> # ./perf trace record sleep 1
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]
>>=20
>> Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support =
for VPA pmu on powerpc")
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> For both patches,
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
> Thanks,
> Namhyung
>=20

Hi,

Can we please have this pulled in, if the patches looks fine ?

Thanks
Athira
>> ---
>> Changelog:
>> v4:
>> Added Reviewed-by from Adrian
>>=20
>> v1 -> v2
>> Addressed review comment from Adrian:
>> - Set err to -EINVAL before invoking auxtrace_record__init() in
>>  builtin-record.c
>> - Added kernel-doc to auxtrace_record__init() in =
tools/perf/util/auxtrace.c
>> Addressed review comment from Namhyung:
>> - Added fixes tag
>>=20
>> tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
>> tools/perf/builtin-record.c             | 1 +
>> 2 files changed, 7 insertions(+)
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c =
b/tools/perf/arch/powerpc/util/auxtrace.c
>> index e39deff6c857..4600a1661b4f 100644
>> --- a/tools/perf/arch/powerpc/util/auxtrace.c
>> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
>> @@ -71,6 +71,12 @@ struct auxtrace_record =
*auxtrace_record__init(struct evlist *evlist,
>> struct evsel *pos;
>> int found =3D 0;
>>=20
>> + /*
>> +  * Set err value to zero here. Any fail later
>> +  * will set appropriate return code to err.
>> +  */
>> + *err =3D 0;
>> +
>> evlist__for_each_entry(evlist, pos) {
>> if (strstarts(pos->name, "vpa_dtl")) {
>> found =3D 1;
>> diff --git a/tools/perf/builtin-record.c =
b/tools/perf/builtin-record.c
>> index 4a5eba498c02..708825747af5 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record =
*rec)
>> }
>>=20
>> if (!rec->itr) {
>> + err =3D -EINVAL;
>> rec->itr =3D auxtrace_record__init(rec->evlist, &err);
>> if (err)
>> return err;
>> --=20
>> 2.47.3



