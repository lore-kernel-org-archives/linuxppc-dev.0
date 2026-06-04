Return-Path: <linuxppc-dev+bounces-22049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69014CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:12:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWSjq0MdQz3brM;
	Fri, 05 Jun 2026 01:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585967;
	cv=none; b=j0h5KuLPFZac6LQ0Mjw/v/xWn4JlfMHMZ39eTkqLLIvLfLRZFVeU0/6cHjTdS4Nllbz9gby1bPF5ZLa1osekxJUjQ/HsyWNbJL3d4RaXSey9wrTzUmsXGpt1qhvkW+rH74E6iYd0wlI1krqJIE8A1cCd6kpnSjmY2XM0j1NNmz5J2YqqpLAgM0Kfoy3Az2X2tslTndbJ9dKoeviX1nmKNIjYVBwlIRdqfbWuJw1ebSBFil6W1U2g845CqwNALWckxz7bBQlOozOzb6FDb+LcK17O6867+sCQL7ttCaOlpvmsvN/N4pJAnLBTVLHHaTwsoHW2eSDr3WNqgwjWKeqlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585967; c=relaxed/relaxed;
	bh=ujALd+bemsEF7GB7Nhbc95tI6DY8IYQNKN5kKSeEqR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VhNJuR4y7alPtBGQYvr3ECvYFFzl+WMKTCthGmVjKm5FsuAzSb3p81PImcWSW2FKrGuP6kHqLkrfHeNDYJf3J5Q0dkTduWfd/O8FSWhkl45MCTV0/3O+qKgE+KTSzI7YksnxMUijCQKDMunklnZ4uJvKcr71stlMJKfqJi6oLgZGkealF4xWJ5jM9utIHeNRBOxLmRwMnG3/SyOi/BdetkIAsX06ZoZ0tPnbXMb5nksRUZIgKnYuX0in2DI9BeN/95Up1TrZx8sWHPBdfeehgHOL72qd1ahvWwkBl+thWsjwQEV42mYetAi1H2CfE8HqdXTl04QNqRH8vF1555cNXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0/cy8+I; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0/cy8+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSjp1hKHz3brL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:12:46 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654BsDeS1445229;
	Thu, 4 Jun 2026 15:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ujALd+
	bemsEF7GB7Nhbc95tI6DY8IYQNKN5kKSeEqR8=; b=N0/cy8+IMoCcIwmMUD0GhQ
	XMFkv7hXYLk3Ff96NSwglnB3WFEMFyVgDh2ai6uRF5XfL6d0VjG+ZDbxPOCXb0x6
	q/qyucWE05NFisdmy4wIBjSu8h9DPer/wA6fhf/wh9HRvTkGQiu/RhxkUmOhq43i
	mD/IPlx0GUBqfce+9SvFaSshHndcFqSdUa3kamBt4hmjstAE3yhROshcrHw1SWkD
	9x5ywY25XgMIYqOEH2Zg4GPHw/K1fawvL05T/ZbTAzqHHLbemluuneKcbLI/2ZQM
	oj28u8vj10CXEY3uR+kVPmZD77S6yKYr+vMmC3CXtd1t/o6YxBNzBzL0/Ss/36yw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtfs5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 15:12:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654F96Lp030877;
	Thu, 4 Jun 2026 15:12:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw5ps6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 15:12:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654FCZYv41615826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 15:12:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F6D20043;
	Thu,  4 Jun 2026 15:12:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649F220040;
	Thu,  4 Jun 2026 15:12:32 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.24.150])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jun 2026 15:12:32 +0000 (GMT)
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
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <4D09EA54-8065-48C2-B1DF-95D2AA15C6B6@linux.ibm.com>
Date: Thu, 4 Jun 2026 20:42:20 +0530
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, mpetlan@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <96BC6514-0D0E-4806-A0C5-DFE2CA09392E@linux.ibm.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
 <4D09EA54-8065-48C2-B1DF-95D2AA15C6B6@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tMWHI-skVlgbx-5oR0axEwB-V9tVcvCQ
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a2195e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=Cg9LiEkykyIr4wkDzIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0NyBTYWx0ZWRfX40s4g6nEXhNs
 AKRDpuHnQKoszozJlkTrysYmHZTX/9Y+qksMgpGu979YwOJYrgopPNymLOEZ3xGKnKCd8diGi0c
 Pnt16sNcdhrXBRef74XAwPRGOYKT5FqRTIvFqqOhWHgKO7iCjTNsEgOrNs04rchgLdlN91QTQRz
 ypoyJnmvCU+Fof2mei766i5jJXkXA4XsqeSqjgwmqWciUSmRPjvgF93SfJ/gffWcTiq89c4Ud3e
 O+hHHOulPNt6VDDKyckYThWAjCi2vgPCX4yKbUIzsHAgX5OwYxjymUn3wZrOEYMcHpAp7gYiWSh
 3nOGjaBdFDK625HnNbVkPI4865vz4kYFUo4Dex4NBWTvoBrENxj/jvUYV3j2oNxNjm6E0IAbOPi
 G/vwx+d/eyv5WwQ459weGOSQp8yhme3+ufDMqPbxqWH+0NCL5U4TpH5Z2HfVLBqSpeZlARMCv3N
 vm2zgOTh+1Eo0AWB7Tg==
X-Proofpoint-ORIG-GUID: RChJIf19xSHBEKC5wZlJX8WYM-QZyg5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040147



> On 21 May 2026, at 12:07=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
>=20
>=20
>> On 4 May 2026, at 9:12=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>> The format_alias() function in util/pmu.c has a check to
>> detect whether the event has parameterized field ( =3D? ).
>> The string alias->terms contains the event and if the event
>> has user configurable parameter, there will be presence of
>> sub string "=3D?" in the alias->terms.
>>=20
>> Snippet of code:
>>=20
>> /* Paramemterized events have the parameters shown. */
>>      if (strstr(alias->terms, "=3D?")) {
>>              /* No parameters. */
>>              snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>>=20
>> if "strstr" contains the substring, it returns a pointer
>> and hence enters the above check which is not the expected
>> check. And hence "perf list" doesn't have the parameterized
>> fields in the result.
>>=20
>> Fix this check to use:
>>=20
>> if (!strstr(alias->terms, "=3D?")) {
>>=20
>> With this change, perf list shows the events correctly with
>> the strings showing parameters.
>>=20
>> Before the fix:
>>=20
>> # ./perf list|grep -w PM_PAU_CYC
>> hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
>>=20
>> With this fix:
>>=20
>> # ./perf list|grep -w PM_PAU_CYC
>> hv_24x7/PM_PAU_CYC,chip=3D?/                         [Kernel PMU =
event]
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Hi,
>=20
> Can we please have this pulled in, if the changes looks fine.
>=20
> Thanks
> Athira

Hi,

Looking for any further review comments on this patchset. Please suggest =
if any changes needs to be addressed.

Thanks
Athira

>> ---
>> Changelog:
>> v3 -> v4:
>> Updated commit message to show real example
>> addressing review comment from Namhyung.
>>=20
>> v2 -> v3:
>> Split the strstr correction in a single patch
>>=20
>> tools/perf/util/pmu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 23337d2fa281..0b8d58543f17 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>>  skip_duplicate_pmus);
>>=20
>> /* Paramemterized events have the parameters shown. */
>> - if (strstr(alias->terms, "=3D?")) {
>> + if (!strstr(alias->terms, "=3D?")) {
>> /* No parameters. */
>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
>> return buf;
>> --=20
>> 2.47.3



