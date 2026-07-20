Return-Path: <linuxppc-dev+bounces-24448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4336C44521
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 07:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3XQb5nXBz2yXj;
	Mon, 20 Jul 2026 17:36:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784533015;
	cv=none; b=Ev1bntNg1bjyTvzlzKD011IqOuzdjWqpbR1yGtCMxYvECfVrmZfda6aAZFcSmt8ws639fCPrRAHQlVBCHv+7Ef6LhkUJgzt4dJCin+mE6Pt918YoZjpAaSgT9euChEef7+osgCtb5IDXpFWA4q5SswL5PziWfSikHUS+7pl0K/2MpD2rYttlcjhaKx3LEoQoXolZU/BS3LobdL0f7uc04Q4BhiPLYV+exbE8FISQS7Cqs066yg6RcHlUHTcParM2TlVFQ6Xn+xGXfCmIakF8gZuXVKLtHXPJXavZNvTHwW0TuceA5kiNztgSLq6VO9CutpFixrVmeylauJgg16LiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784533015; c=relaxed/relaxed;
	bh=Gtm5Y82v8Aqtez13P6vktZYCfz+WXGFJpJiUqgFrWfM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MJCFVVAr4pB0XY4hMTcdY2uCgzepJX5wEQUW09fbozmToxveyv7rZr5hfLeZz5Pnot0Xu0m2bCdHc9D2DzKTx8AiBBlxxzHDKEUE7DPYhT5a39M+LpLAhhWFktqIG9Kg3B7NP5QGaaNndddKlTwQgCemZ9zcin+29pGvhFZgWMKajPRBfT32qc73VN3LDFXphorN5j1FmwHlWk3W0XHiL3kVEpvmYpcWJ/rB3TtOirlvdVKSXcq5qHCnKp4Ak8S3EvTcbahqPUX0Z6Q+61XpQ8yTVj2caM2U6V5PzoOoAU6ULFeFWPX7fsJSo40rjQd+mMD8JsAakQCzyfFAGQVCSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hUBpf9Ko; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hUBpf9Ko;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3XQZ6Ph8z2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 17:36:54 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fp5O1368017;
	Mon, 20 Jul 2026 07:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gtm5Y8
	2v8Aqtez13P6vktZYCfz+WXGFJpJiUqgFrWfM=; b=hUBpf9Ko3SvZBjlsy7vzEX
	5d0ImHtDlxt2TKyYuk7EOepqS6s9qpFcZOXhA+rMIob+T9XOCQ5p9FnWsOtgm0z4
	W+4BZFKjUEUDtCM3Gyay2Qw/7z4oL5qPhqA4MJW1gh88F3SV7Qeuk7WvookIw0gi
	1G44DePTsm48KLth+T9IomTV1KEE6HPcW0bbWZHeysvoOPn1GfjWT/1pfK8TTVKh
	V1RRjggKrbThnfAqVVJ1XMALdpjOLRjIn4q+XIZ8wYR9J1OCHWGT8oqQSrJhOFR1
	FYiKhisHAGpFGN7Tc0j0xxdImGe6OroXxTsRO1iR6SWYSU29xiYH/dQl9b/kZeHw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fx31y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:36:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K7Yij4019052;
	Mon, 20 Jul 2026 07:36:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4cwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:36:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K7aks248300322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 07:36:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743E620043;
	Mon, 20 Jul 2026 07:36:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A368720040;
	Mon, 20 Jul 2026 07:36:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 07:36:45 +0000 (GMT)
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
Subject: Re: [PATCH 2/5] powerpc/htm: Add support to setup and free aux buffer
 for capturing HTM data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085058.DEC851F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 13:06:33 +0530
Cc: linux-perf-users@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2B579A1-E13A-494F-BBB1-0B43DE4E0F12@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-3-atrajeev@linux.ibm.com>
 <20260701085058.DEC851F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX7+vKRLbovDQd
 BhbyYDnB7QJoi/oXPKB9GX2Rqt2h0r9QYxnU5k/r8XTNoQ+vnBrT71Ms2tV05MV+2TghTIU70hx
 e95mbZfb9uiHvnhwZkHYkD1RGK4dxflB1uj1qwWUUTzQn/dQDTxzHgi/F0wjzV4rMMV79R8hckM
 1/dirjS2s1JaSBizyB1/9SWpd+xVblt8MIkKNLYAzF53wTpcovrh/JP87S/9CAB7z8CGOyqBGxV
 yQQZKdnq4m/qrJL5kH9VSrpprIDpr1TtoQ4ffnl3thq3kvLXltRvwUFBRZYoa+vEhL4jSVYMpNm
 6s/Z089XH/o+pMEvC2WUjxn5dR6KKqb1Ty4x5aMhk2WAktBD77AjEGbtSraXbs+n6ZBjBiN2rFe
 nhieVoifp5TVRJ9GE3XeoRWKAU2tAtjQyMU1pkHoBFjbi0W5awybQ3iodC659UqPceXyqURXxJG
 UjeluhKdJe+aT35fdzA==
X-Proofpoint-GUID: rfC8ms06TIeU5ii22Zv15VYqANjbnxZ_
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dd011 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=sFrnrRpp-hubtoQecV0A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX0C3/XAPCy+5X
 g4IWFGuhLcwK8iUnekZ7yU4Wkho4dX/vW0LH8TP39T+KJXZYeuy6fRfB1oAINc89NEmhAhtAQ3X
 w2wm4V0KAGu12TeYohbSweE+CBXdcnA=
X-Proofpoint-ORIG-GUID: rfC8ms06TIeU5ii22Zv15VYqANjbnxZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200078



> On 1 Jul 2026, at 2:20=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] The driver violates the perf AUX ring buffer API by writing =
trace data to independent offsets, ignoring the core perf ring buffer =
head.
> - [Medium] Signed integer overflow when calculating the AUX buffer =
size leads to a massive 64-bit value.

Thanks for catching this:

I will be sending a V2 with fix to:
- Handle the fragmented memory writes
- Fix the aux buffer size calculation

Thanks
Athira
> --
>=20
> commit 10ce4df3e9571041276c72fea1e10e3955d5eea1
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
> Subject: powerpc/htm: Add support to setup and free aux buffer for =
capturing HTM data
>=20
> This commit adds PMU callbacks for setup_aux and free_aux to enable=20
> capturing HTM trace data into a perf auxiliary buffer. It allocates=20
> memory and records trace data directly into the provided pages for=20
> later post-processing.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index e22a7fdce2f5d..ae7f469b6840d 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> @@ -126,6 +143,74 @@ static ssize_t htm_return_check(int rc)
>> return -EINVAL;
>> }
>>=20
>> +static int htm_dump_sample_data(struct perf_event *event)
>> +{
> [ ... ]
>> + /*
>> + * Invoke H_HTM call with:
>> + * - operation as htm dump (H_HTM_OP_DUMP_DATA)
>> + * - last three values are address, size and offset
>> + */
>> + if (aux_buf->collect_htm_trace) {
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, =
coreindexonchip,
>> + htmtype, H_HTM_OP_DUMP_DATA, virt_to_phys(aux_buf->base),
>> + (aux_buf->nr_pages * PAGE_SIZE), aux_buf->head);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < 100);
>> +
>> + if (ret > 0) {
>> + aux_buf->head +=3D (aux_buf->nr_pages * PAGE_SIZE);
>> + perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * =
PAGE_SIZE));
>=20
> [Severity: High]
> Does this code write trace data to independent offsets, ignoring the =
core=20
> perf ring buffer head?
>=20
> If the user does not consume data fast enough, perf_aux_output_end() =
will=20
> truncate the write to the available space. Because the driver ignores=20=

> htm_ctx->handle.head (the true write offset within the ring buffer) =
and=20
> tracks its own offsets via aux_buf->base and aux_buf->head, could any=20=

> truncation desynchronize the driver from the perf core?
>=20
> This could lead to subsequent writes going to the wrong offset while=20=

> userspace is told the data is at a different offset, resulting in =
silent=20
> corruption of the perf AUX trace data.
>=20
>> + } else {
>> + aux_buf->collect_htm_trace =3D 0;
>> + perf_aux_output_end(&htm_ctx->handle, 0);
>> + }
>> + }
>> +
>> + return ret;
>> +}
> [ ... ]
>> +static void *htm_setup_aux(struct perf_event *event, void **pages,
>> + int nr_pages, bool snapshot)
>> +{
>> + int cpu =3D event->cpu;
>> + struct htm_pmu_buf *buf;
>> +
>> + /* We need at least one page for this to work. */
>> + if (!nr_pages)
>> + return NULL;
>> +
>> + if (cpu =3D=3D -1)
>> + cpu =3D raw_smp_processor_id();
>> +
>> + buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
>> + if (!buf)
>> + return NULL;
>> +
>> + buf->base =3D pages[0];
>> +
>> + if (!buf->base) {
>> + kfree(buf);
>> + return NULL;
>> + }
>> +
>> + buf->nr_pages =3D nr_pages;
>> + buf->snapshot =3D false;
>> + buf->size =3D nr_pages << PAGE_SHIFT;
>=20
> [Severity: Medium]
> Can the size calculation overflow for large values of nr_pages?
>=20
> Since both nr_pages and PAGE_SHIFT evaluate as 32-bit signed integers,=20=

> a large AUX buffer allocation (e.g., nr_pages =3D 32768) could =
overflow into=20
> the sign bit. When assigned to the u64 size field, this would =
sign-extend=20
> to a massive 64-bit value.=20
>=20
> Could this result in bypassing internal bounds checks when the size is=20=

> later returned to the perf subsystem?
>=20
>> + buf->head =3D 0;
>> + buf->head_size =3D 0;
>> + buf->htm_stopped =3D 0;
>> + buf->collect_htm_trace =3D 1;
>> + return buf;
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701083806.79358-1-atrajeev@linux.ibm.c=
om?part=3D2


