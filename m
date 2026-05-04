Return-Path: <linuxppc-dev+bounces-20396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05691CD3423
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 04:18:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g87fn3j9zz2yZ3;
	Mon, 04 May 2026 14:18:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777868289;
	cv=none; b=j4tFrMfaQ0TI0mn3CHK8zbkDwyu+1YGLeS0uUOUyf660wJW6d0IyCrmqCfnRRZaXY9hRFIyT99LUcLoWh48bdb3ry8mM5J0FFaqRg09fMjsVTkZN838bjSBLHn1Xj3DxZexI6HiC3sHL5zbzTscJqpkKSkuJDWk7X+gbpDz9x9Ki92gVavZhEZ/Xm+DfROCDu/qaUE6X3VFULRx+5d3vib7DmqAQTT4ZYknTVaY4JDs8dqBFGObUcSx2hpYuhmvWlq1GUNli0yf9vDgqT0SyZmC/H6o4afCXfoZG4trWNxZxPzqovxmfeQpva7Uyejiby2tZMI6rwNaIgnmfUPPiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777868289; c=relaxed/relaxed;
	bh=1D+8TS9vn2Xie8tvfTVhjRichzOTOHaOs5B2QhjLtrY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m/A6eq/mR9Xq6naxM0ZpXWxNC/5PkjnsAbejUexe2Y7evRDhsnZz+6JZqRmzGXDah0bUujZNWfIF4HOfctbGIf+OAavts/OfTeJwOIXi8Tz5qRVFs4Wnk39nVINai+9m0OIXm1nGjJ1LBeEzWMZoNfMhsIqq4fnx4sAc2rYCrWiu6liZGBXDNBFLrGOQHX7oDbJJ7gxw1EkOmjSxc88VGf2PjjW9ZNn0dT5qNpRn6ZfSJIjv5864fqhOs8+v9f4tntt/+x4snqYauZEu0kvaI0MX1fw1XhenQSomyqFtu1aGAQqhAfqJGu8z21SgHtHbYSunom54aky1id+hezGkMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VKjimKIH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VKjimKIH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g87fm5nzxz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 14:18:08 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643Iq4Hv2230519;
	Mon, 4 May 2026 04:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1D+8TS
	9vn2Xie8tvfTVhjRichzOTOHaOs5B2QhjLtrY=; b=VKjimKIH1gIQaX28u8azNe
	y9req0pda5+eX1sboiHaXvohFyp+2hjEP/wKwFWtZ1dDYthRP08VmyCceHdfdJ4P
	gEQZn5ck6y0cbdlvUExRk0hUQIyOIjPg41IfAC5kZUMJuCv97VgP64e9/T6uuazm
	RT0UAJwv683sDVMlk5pH/OJM6Rn9zIUpTEqRI1X32uyN3Zt/KSDHGx0HGYrYbhEm
	J8IIg7ppscz5oFgZeecg/ycQ+XlzOrV1k2niQqCHhrzWGCa1oCpErEUFltib1Xoe
	mIpWs4PWBNX315wodCl26N/d+z9dOU5b9kfEfepN/2UXFn+imRxDID1O6rTdZPMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y15ef9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 04:18:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64449bIA019857;
	Mon, 4 May 2026 04:18:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvuqxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 04:18:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6444HxpG61866470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 04:18:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F2F20043;
	Mon,  4 May 2026 04:17:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD04720040;
	Mon,  4 May 2026 04:17:55 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.20.162])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 May 2026 04:17:55 +0000 (GMT)
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
Subject: Re: [PATCH V3 1/2] tools/perf: Fix the check for parameterized field
 in event term
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aff7JnNuWpj4Mvss@z2>
Date: Mon, 4 May 2026 09:47:44 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3471B9C5-1CCC-4839-9390-10D28C3846C6@linux.ibm.com>
References: <20260502141258.17128-1-atrajeev@linux.ibm.com>
 <aff7JnNuWpj4Mvss@z2>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KqydUZevxfu1pqNJNRLHhtgPVgfI656X
X-Proofpoint-GUID: ddp9bYxKqmhgtErFhCulXLDckQlSHN7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA0MSBTYWx0ZWRfX+I4u6abBeW7J
 v1FIQOVThnxAeY7Zr/ZEKZbDzhHrvf+m256HRk8inkwXQgElj23JxYsJgWVGBIZKPguAnRTrb2K
 mBo5LFp/m7dDgph2fbF2uiKrf0HYJ1rS7Jsevdx7xJaCuDS4hISDgLZwzV0Kbci8pd2gel9//vG
 hZiDFON/6mrJarFSiulm27Gk9wzl+P9qkPk3m4lbgYlrqLplqs8a6ycQF+aShgXBUIRi+ReKNEx
 pK7mEsu9JDiXV/1X2TobcHe+jFQUwJQa0I9xFMCZp2zgK8oMTYicd69TR7KuV5mu3YKC2zRkcdc
 namU/7IxxYj5LsEuyNC23rOeULmdcwnu5AHh9k3598Oaud1mITiQDgA/Nar2TZDQwhziG7Q0h2A
 qPGZlltVFTPjUbGxJh3/ZI4B0KDi1JskuqjrX6aWk87tq107F9CzncRF0+iaNBaZgd3lcd4mPm0
 A8zqhECVSoXLjnmY/hg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f81dfd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=0L3saO9_ksFXIgiCiVEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040041



> On 4 May 2026, at 7:19=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Sat, May 02, 2026 at 07:42:57PM +0530, Athira Rajeev wrote:
>> The format_alias() function in util/pmu.c has a check to
>> detect whether the event has parameterized field ( =3D? ).
>> The string alias->terms contains the event and if the event
>> has user configurable parameter, there will be presence of
>> sub string "=3D?" in the alias->terms.
>>=20
>> Snippet of code:
>>=20
>> /* Paramemterized events have the parameters shown. */
>>       if (strstr(alias->terms, "=3D?")) {
>>               /* No parameters. */
>>               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
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
>=20
> Any real examples?

Sure, I will update the commit message

Thanks
Athira
>=20
> Thanks,
> Namhyung
>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> Changelog:
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
>>    skip_duplicate_pmus);
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



