Return-Path: <linuxppc-dev+bounces-18292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BF7F3381B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZm5t4f2Sz2yhX;
	Tue, 17 Mar 2026 19:56:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773737778;
	cv=none; b=gKllBjq1GM1BFaVEfPt8Z+Cyv0JlTALPSyzuSM4kPLXcejdeP3Dt5kUueGVKM04JGFiwD2sMumU+VRZhuEqXLjUcZHJjXzGGsHmXxidFrWUlQ7QLbrInXYWev0+gSdtEdKmqknly6vqDqctpvnLtPwkyrzhel9qQlHkagbxSQqFtgZCR0a4am6ItMWCSakuKJzREurR7EqMpH/SLL1uOGKULCQ4StQQwbxpuptq6jTN2onlimE7S66mf7yOO7tsGS7nvq4/4IXMSX3g/INMyD3W9y+YKO8I8/6RJoAhdeWI2g5QRakw7CX0j3JDtR5/B1Uu/Zz0WtGsrwQ8WZ3c3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773737778; c=relaxed/relaxed;
	bh=6Fz2vcVVnbioilRDd7DhZdEf++mvzXZJLFXf2r/waNI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n1K+5mAa4sKNynXZg4sjQRo+jstwdcPqDWtXQdpgsNt20zd86NDfXZuJgtolQ0ldO9V+4IgABJvGaC4Dx5U4kevzTUHQc9vLmQmv8PtwXifQKoI2xTpG7VCOBFBiJJ0/ycc6o4TF1EA2BfIJbMv0ln0e3t28EDH6srtCKb19KugEQz7C21MgnM0C4Ifr88FZ/nq1Bpfe9jf1vK9nVZUUfOJqJ+gBL68UxI1T2D1vpXLamNaVj1vXudq8ybj4jO7kQ2shBXsuK+XeZlBjeAvGtQU1Kn8NeDQ8zmGFDnxpJzVDcqHnET6O+FuswIp7/npUgajD0qeq59N9igJp6oT5aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wls9NSFB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wls9NSFB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZm5s3XsMz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 19:56:16 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7G0rK693890;
	Tue, 17 Mar 2026 08:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Fz2vc
	VVnbioilRDd7DhZdEf++mvzXZJLFXf2r/waNI=; b=Wls9NSFBrnp5JFSdDq+4zg
	Ql0qhXKQzHlqZ0vxUDsZ/hVizfwgofPtbNl9d9GPvBO/peOTFUzNJSYCSZ0MGMST
	cYv5nbm7qCN8SjoQbv5SurcRlWTXdbd8anxkZy0VH9b6Wd75kcLIfLlvDK9FVDhX
	WANJFlbrDNPAovRCxgL2cVCfkYSMKP7GVaWouwjyh3gyoRDX7ykTnzrr6JIDZEW4
	zf6TKVygWBrKml+5LL3ad6VCELdPzZV9U9w7Nj3nGvGxej93Spv8PZlMfqn1B0kp
	+Qp5dBJJPeMuIfmjfDfrjZyPoNodE89/6XgJM/D8tZ1zGPbYFcnvVnK94M0ojIZg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaubarb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:56:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7BYXm015601;
	Tue, 17 Mar 2026 08:56:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n8b7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:56:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H8u5j39175580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 08:56:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D166D58059;
	Tue, 17 Mar 2026 08:56:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30A658058;
	Tue, 17 Mar 2026 08:56:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.249.251])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Mar 2026 08:56:01 +0000 (GMT)
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
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260314083304.75321-1-atrajeev@linux.ibm.com>
Date: Tue, 17 Mar 2026 14:25:48 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3NiBTYWx0ZWRfX84cphwAzMc1W
 9n6KCclKOukRKA7FwNWjVsBKXojL/xio6/eviVPsczbHPlTnaxmDly2MJAruCAOlacK0jYySu/V
 2t4o+7ymYEES7MMzxaXup8/+Nurfib8w80LUsSbF/updIrV/A27ofmyLXVnloyV7Q0yd19CLsS3
 SLJ21TQkdf1qpJBCeUxG5jdKo0axH8nfGqVM0Kftv8tf4samNRrvA6WcguC2X2UiqSYhJU1SgqF
 OU8KQu8jfb0E2/tziy01t2iGOuBNZ24twB0p3QDNE2IqZE9Xsba/NssL1z1NbiHX7vX1RzjAXaR
 np5C5WdXQDXT9BNAgB6Am0iMcQqfmAxpax64LsOk+JhsaHc9AfDi5Fe954cM7S7HUs1xgbC1lPI
 T4N1h1bl7oeAUKfFDS/6f2xFCrCBtBOuKnoGH4LWvFFr3euv+uCZVAX8H1tuLuqoyF7LVm9C+p/
 t7j+QYVnaAMU4hwiN4w==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b91729 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=ASrTm7EkTYZRIX76TdgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S5lniLY7V9VraQks7iNPMWQemupHBGq5
X-Proofpoint-GUID: AchMjJ9DckEPfrOiPF-w2WZDd1Cw3_qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170076



> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =3D? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=3D?" in the alias->terms.
>=20
> Snippet of code:
>=20
>  /* Paramemterized events have the parameters shown. */
>        if (strstr(alias->terms, "=3D?")) {
>                /* No parameters. */
>                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, =
pmu->name, alias->name);
>=20
> if "strstr" contains the substring, it returns a pointer
> and hence enters the above check which is not the expected
> check. And hence "perf list" doesn't have the parameterized
> fields in the result.
>=20
> Fix this check to use:
>=20
> if (!strstr(alias->terms, "=3D?")) {
>=20
> With this change, perf list shows the events correctly with
> the strings showing parameters.
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> tools/perf/util/pmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..0b8d58543f17 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
>   skip_duplicate_pmus);
>=20
> /* Paramemterized events have the parameters shown. */
> - if (strstr(alias->terms, "=3D?")) {
> + if (!strstr(alias->terms, "=3D?")) {
> /* No parameters. */
> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, =
alias->name);
> return buf;
> --=20
> 2.47.3
>=20

Tested this patch, and its working as expected.

Before Patch:

./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
  hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU event]

After Patch:

./perf list hv_24x7 | grep -i CPM_EXT_INT_OS=20
 hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]


./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/


 Performance counter stats for 'system wide':

        2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/                     =
                      =20

     229.938231314 seconds time elapsed

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.



