Return-Path: <linuxppc-dev+bounces-20020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B3BFDEE2F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:51:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1kCr5Hmfz2yGX;
	Fri, 24 Apr 2026 03:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776966664;
	cv=none; b=JqBVKc+3sJER5cNjkeY6z9xNuD5bbpLsjxwXF7xc/JY4V5hExSoNMPBeM5fQqzVJL8okrg0hvTLOsVHjpk4YvKN34BqYHlqlZtbOorSvjrb/oZF18XEnIWJP4HXHGjOmhniVICfEM5R+G0Hd0JgyUD45k33lUV0y+0AjSWgT5d57HcMUZ9gow6wszP8kTTlb8Xh57rAItw1+sRQTaTjQUtWHuVnBa0FOepv4ZCC1eYQ1DHupw3xseKAzoBu48yGPKiQgGnHsmjrMUAHqQVGWQ4T2Tv6uqfEQYZDB7/lZy7/Dks7Vn9KTWfI0AOhY1VPVNNpv6DKtNBHZ342o8wLoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776966664; c=relaxed/relaxed;
	bh=RIE5IgQMeA4flYFcQpRXGd2GSu6nBWGTKiEkaZkxZxI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j2G+ltzTxvKXdHYDPMnzP5F/sRKowsnkJL48V7/bM050xugfXq5DGGR6i6/IYiG5wyt01cXd94441OpPz+4IcPhv5ui8R7s5cWk0VBDCAHgDKz2VspFPugO1Fd1++68wHpHrzEq0YzUPelWybOkm8SURenVg/sYOr8pFPY/Nbgx57KAYwE8UELsjT17DKIMIV3ZyJ4Pf3ZdjZ+TpnUK0Dk4SnnD6zTy1AQZpWD216938dURS/HfHzatOaMjlAgtjgiO+vAm19lkWFi5ylxIJJa8RU9ZjrdY/H0K+ksQRfytTPWgLzp+ZpmiFjsbZyQji/Ac8aXJtObHwYtsLsLe19A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=elwx7Z+U; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=elwx7Z+U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1kCq2Sklz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 03:51:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N81mft3108221
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RIE5Ig
	QMeA4flYFcQpRXGd2GSu6nBWGTKiEkaZkxZxI=; b=elwx7Z+UrXjWyQtV33uSGq
	bXAtb02RlE30QHmM9hJBbS2TymZYoAMVrb7H11iqR1qnUwwDmk0WCNAY31/7+bDq
	poQv4VGz67EP97/VZgUZkOFYGPk+4ywvn5wAmkfSpzO4dq7YwdUUpGWhpaah9pEL
	zE47Cog5ACMTprTqvoT5YuDvMD3j3+cpeKO3rDQ8zkV9wI4FTY5jxk7nWsfxfJgt
	5r81zbQbvg2r+vwSfRa+vuBPTv1Xgmm2RenYddjIOu6NKS/lioLOLlqeS3Xffq+L
	tUsOpDT32T0XuLaQvJY9E9LjyEWEueL46oLxr7BUjxtkYMSMvSqmthPZQQyJjkVA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6hev5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:51:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NHobJr014002
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:50:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyfnmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:50:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NHotMR27132390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 17:50:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF45A20040;
	Thu, 23 Apr 2026 17:50:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADA62004B;
	Thu, 23 Apr 2026 17:50:54 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.30.158])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 17:50:54 +0000 (GMT)
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
Subject: Re: [PATCH] powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC
 marked events
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260421150628.96500-1-shivani@linux.ibm.com>
Date: Thu, 23 Apr 2026 23:20:42 +0530
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <02211194-CC8D-496B-A701-41453A01FB48@linux.ibm.com>
References: <20260421150628.96500-1-shivani@linux.ibm.com>
To: Shivani Nittor <shivani@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfXyfa0rWF9vPOF
 WN0HsS7qvWXWK9rfuwnL7lAMaOr4kohqArC3hH3YDJ/fjfCuT+20776do7L5A+LU8HJJZjms5bu
 4PA97a7830lERabyL6DmlNRUO/wDxgXNUPSpG1JEmNL1ZUL/mNcHiScb6+UaUaEZYGg0hZgP3Gi
 bhvGEo9poxZfaQF9rW0n1d0iQjM2EBm/jepgkNRs838fWcun1tb7/ufqJFeHdNG84DQ8k1TpUEF
 bNjPBu9SqJSbybkj9L0W5d7cIP7j48hUJScc/Mb3xVWXGrkCFo1FxpJwvkigtPiH93FWRu1ThGi
 BDiQQGBIzCjp7zA/fQzdonSNuufoW2n2Tijrh/ibhDVNV1z4Yj0I1PD/gRDgZHJWu45sgcjnRxs
 xEMZY/8jGOV050jXsgVNuo9eWPWTmGJcxwSKZjmiGN/mD0tezDzaiD/3EkHA9bPZsSKgLLzNj8V
 +zfnuGadiwXzk32Oahw==
X-Proofpoint-ORIG-GUID: tqLDWfuDlpvydnFx8mkAdyB2uZPZwDK-
X-Proofpoint-GUID: tqLDWfuDlpvydnFx8mkAdyB2uZPZwDK-
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ea5c04 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=b0JcJouLdBaXTkySTX0A:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230173



> On 21 Apr 2026, at 8:36=E2=80=AFPM, Shivani Nittor =
<shivani@linux.ibm.com> wrote:
>=20
> The core-book3s PMU sampling code validates the SIER TYPE field
> when PERF_SAMPLE_DATA_SRC is requested. The SIER TYPE field
> indicates the instruction type and is only valid for
> random sampling (marked events). To handle cases observed where
> SIER TYPE could be zero even for marked events,validation was
> added to drop such samples and increment event->lost_samples.
>=20
> However, this validation was applied to all samples,
> including continuous sampling. In continuous sampling mode,
> the PMU does not set the SIER TYPE field, so it remains zero.
> As a result, valid continuous samples were incorrectly
> treated as invalid and dropped. Fixed this by gating the
> SIER TYPE validation with mark_event, so the check runs only
> for marked (random) events. Continuous samples now skip this
> check and are recorded normally in the final data recording path.
>=20
> Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type =
before creating sample with perf_mem_data_src")
> Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>

The changes looks good to me.

Reviewed-by : Athira Rajeev <atrajeev@linux.ibm.com =
<mailto:atrajeev@linux.ibm.com>>

Thanks
Athira
> ---
>=20
> arch/powerpc/perf/core-book3s.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/core-book3s.c =
b/arch/powerpc/perf/core-book3s.c
> index 8b0081441f85..2e6adf5b95c4 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2242,6 +2242,7 @@ static void record_and_restart(struct perf_event =
*event, unsigned long val,
> const u64 last_period =3D event->hw.last_period;
> s64 prev, delta, left;
> int record =3D 0;
> + int mark_event =3D regs->dsisr & MMCRA_SAMPLE_ENABLE;
>=20
> if (event->hw.state & PERF_HES_STOPPED) {
> write_pmc(event->hw.idx, 0);
> @@ -2304,9 +2305,9 @@ static void record_and_restart(struct perf_event =
*event, unsigned long val,
> * In ISA v3.0 and before values "0" and "7" are considered reserved.
> * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
> * Drop the sample if "type" has reserved values for this field with a
> - * ISA version check.
> + * ISA version check for marked events.
> */
> - if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> + if (mark_event && event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> ppmu->get_mem_data_src) {
> val =3D (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
> if (val =3D=3D 0 || (val =3D=3D 7 && =
!cpu_has_feature(CPU_FTR_ARCH_31))) {
> --=20
> 2.47.3
>=20


