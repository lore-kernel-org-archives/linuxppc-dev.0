Return-Path: <linuxppc-dev+bounces-24447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA1BC44525
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 07:35:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3XP36NtGz2xm3;
	Mon, 20 Jul 2026 17:35:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784532935;
	cv=none; b=alGv1LUeImFn0ClF0EA01t1gFhlgAY06AasxsleDjBvuIFQNgf2HEs6A5b7IqG3VrTQmtnwecfZh2GXr4Nr53EDn3GDPn3Qhh7MPNmuWM8lQziSzmaIOnpOvwfnp+1vhvkJBKQOHbYTKeVA4dAWy3CuaM84a9DCyXkB4DlzWuvosuDxl+tc/bZ2Sr+OKfYP8krvJ3KtRMC4tG9l5xwSqV9UygUbjXXv/Q4rx3FzDpa46mD2WzlKfrqljwWSZkB6g831GO7qGGF6bITNpkGvs6QRPYinAuIVkygLWMckLNoxVDG750gSp4at6QS1GLgYcKfmtILJLN7lfRZMPaGuRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784532935; c=relaxed/relaxed;
	bh=1dd5BXJNx6IK185kgg7iBetV9iiR+8HQJxE0crLTrYE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EJrU9r/3SgA3a1ZSrUi93z9ivPAjs1QXYtL/snQkSx13GhrJibgYGCA+cnVPd4f1AWdwnRjtRB/IMnh9Zz+ZHqfYeosG0EvAChajF/BspUr/wGa6TFjlPW4WIlznkNHsPqPJRLoSaGCU09lMQWdll7dWK+aUuKGbqXIuH28kpdNwM/rzPc4WjqWuP8yq2z463p+UqlRe9ig0dKmn/s6tHrEFjoAm27ARxBGfzHi8DPCHX+J1HJLvqlD93wtgPN3AnMu3l0hK9+/IjKXU6oXYp8910T1nYrPSu7KPmIBTAbNLb2wr7X+s0oVHgFCT48oL5kHFqS3jUnA5pAW5aLx1Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qslAWDie; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qslAWDie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3XP13r4zz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 17:35:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6frR21368179;
	Mon, 20 Jul 2026 07:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1dd5BX
	JNx6IK185kgg7iBetV9iiR+8HQJxE0crLTrYE=; b=qslAWDieDwmIo3k4VHgc0v
	MujTl3GaZXuD+30VTvZ8fJ/zBRSt/Jydzmq0bkgKLEQ1bNUgUc+vxz+bS8QYPogU
	QqeQ2QLHJ5b9j03law7AJx3BRqtg90f/Sdx8v9Lg9aMcFmgK7sPCELjXbj6ngZrY
	+BcvHRxNiGEA4/xHoU5vMNEO+DTr+ucwkzNdG/vBwNBpTlG3VUZtk2g7x3F/XxQB
	ewX0+mTL/3NStcdHf1rkxTEFcbaliJAc6RyREF1YS7zdhgBB11shVW9au71Z7X7+
	Q7HfZTJ5mhSy7oJHp+xXOY+iSOQMi6InUupHdCnO5lxFM5ThF0Ftcun7c8aOViJg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fx2x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:35:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K7Yb3m019033;
	Mon, 20 Jul 2026 07:35:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4ct1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:35:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K7ZNTl14418378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 07:35:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 805BC2004D;
	Mon, 20 Jul 2026 07:35:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC3320043;
	Mon, 20 Jul 2026 07:35:22 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 07:35:22 +0000 (GMT)
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
Subject: Re: [PATCH 1/5] powerpc/htm: Add interface to expose HTM trace data
 via perf
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085047.1C2CE1F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 13:05:10 +0530
Cc: linux-perf-users@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADBD0626-25CA-4CE4-B93D-81FF96B28903@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-2-atrajeev@linux.ibm.com>
 <20260701085047.1C2CE1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfXxEtddxAUxHQX
 gY2uVa2gIYUk6oZFSPHpzl5BH9FcmBjPiedkVBh8FIdsp/0IbHFynmVKK8vxAhHqBjcu0TbiFI+
 Rqu4AUCyYzhgjqPiEhl+2/n56w85HBuUy43ubP3+Cero6kdtIsMadup5Kh9gAodN7OUfHQp8WV/
 ElX5kwQ/8zilk3FXx2U/HOAIUmD2CyJr71B/dXu9h5et0JSqWZ/C6NXO/3v0jYnH1wlmVk7kWn1
 IRYPIujSDXwsWdPBP2oYluZ9tjlbBXiBZNOgdzMuBK21jnCyC4BKpe3o86W2/NM0UU2DWUmtm3s
 gi1FEbSymtIV+zwQXWsBxJfZPRV7jwBbTbDTHFslldBBUpb0NOEpDabLpUq3IMGUFUBBwlk9PYX
 9iZIwEi2ggrZf5SS2pa1jhyjAfDK2VX1DpDxbWLOn8Zy/zMwWHYyEGYHPIgqmmxiF9SXzm4670I
 l+Y6PcJ7yYiKH+r5hXA==
X-Proofpoint-GUID: jZMhfFFKLhoFJ4PAnCZVXe5cxTHwwTRQ
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dcfbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=rnXohLmvZyVGqXXwKb4A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX3bVKitk69Z/W
 qiptoaygvWHpBSL25TDJD2JGZpPATpwx5DSlDH5DwRKySigOLJKzkLdC3LRCdjkov531rR/AFAK
 lprpVc967l3vR2OFlRlR2dnRFlf1UEU=
X-Proofpoint-ORIG-GUID: jZMhfFFKLhoFJ4PAnCZVXe5cxTHwwTRQ
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
> Thank you for your contribution! Sashiko AI review found 7 potential =
issue(s) to consider:
> - [High] Missing Firmware Feature Check allows PMU to register on =
bare-metal systems.
> - [High] Improper Error Handling treats unhandled hypervisor errors as =
success.
> - [High] Resource leak when `H_HTM_OP_START` fails.
> - [High] Missing cpumask attribute leads to concurrent identical =
hypercalls.
> - [Medium] Retry loops spin endlessly on deterministic errors.
> - [Medium] PMU API violation for start/stop operations.
> - [Medium] Improper handling of `sample_freq` corrupts the sampling =
logic.

Thanks for the valuable review comments.

I will be sending a V2 with changes to address:
- missing firmware feature check
- Error handling in status check
- Handling concurrent hupervisor calls
- Fixing retry loop
- Adding start/stop callbacks
- Remove the sample freq
- Resource leak in H_HTM_OP_START fail cases

Thanks
Athira
> --
>=20
> commit 400fb092e994f5871c30e25b796b6ab855238ea4
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/htm: Add interface to expose HTM trace data via perf
>=20
> H_HTM (Hardware Trace Macro) hypervisor call is an HCALL to export =
data
> from Hardware Trace Macro (HTM) function. Add support for setup,
> configuration and control of HTM function via PMU.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/arch/powerpc/perf/htm-perf.c
>=20
>> [ ... ]
>=20
>> +static ssize_t htm_return_check(int rc)
>> +{
>> + switch (rc) {
>> + case H_SUCCESS:
>> + break;
>=20
>> [ ... ]
>=20
>> + case H_AUTHORITY:
>> + return -EPERM;
>> + }
>> +
>> + /*
>> + * Return 1 for H_SUCCESS/H_PARTIAL
>> + */
>> + return 1;
>> +out:
>> + return -EINVAL;
>> +}
>=20
> [Severity: High]
> Will unhandled hypercall return codes fall through the switch =
statement
> and return 1 (success)? If the hypervisor returns an unhandled error =
code,
> this code might silently interpret critical failures as successes.
>=20
>> [ ... ]
>=20
>> +static int htm_event_init(struct perf_event *event)
>> +{
>> + struct hw_perf_event *hwc =3D &event->hw;
>> + u64 config =3D event->attr.config;
>> + u32 htmtype;
>=20
>> [ ... ]
>=20
>> + if (event->attr.freq) {
>> + hwc->sample_period =3D event->attr.sample_period;
>> + local64_set(&hwc->period_left, hwc->sample_period);
>> + hwc->last_period =3D hwc->sample_period;
>> + event->attr.freq =3D 0;
>> + }
>> +
>> + return 0;
>> +}
>=20
> [Severity: Medium]
> Does copying the target frequency into the sample period break the =
sampling
> logic? Since frequency-based sampling does not appear to be supported, =
should
> this return -EINVAL instead of disabling dynamic frequency adjustment?
>=20
>> [ ... ]
>=20
>> +static int htm_event_add(struct perf_event *event, int flags)
>> +{
>> + int rc, ret;
>> + unsigned long param1 =3D -1, param2 =3D -1;
>> + int retries =3D 0;
>> + u64 config =3D event->attr.config;
>> + u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
>> +
>> + /*
>> + * Invoke H_HTM call with:
>> + * operation as htm configure (H_HTM_OP_CONFIGURE)
>> + * last three values are unused, hence set to zero
>> + */
>> + htmtype =3D config & 0xf;
>> + nodeindex =3D (config >> 4) & 0xff;
>> + nodalchipindex =3D (config >> 12) & 0xff;
>> + coreindexonchip =3D (config >> 20) & 0xff;
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, =
coreindexonchip,
>> + htmtype, H_HTM_OP_CONFIGURE, param1, param2, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret <=3D 0 && ++retries < 100);
>=20
> [Severity: Medium]
> Does this loop retry 100 times for deterministic errors like -EINVAL =
and
> -EPERM? The condition ret <=3D 0 causes it to spin needlessly on =
errors that
> will not succeed on retry.
>=20
>> + if (ret <=3D 0)
>> + return -1;
>> +
>> + /* Reset retries */
>> + retries =3D 0;
>> +
>> + /*
>> + * Invoke H_HTM call with:
>> + * operation as htm  start (H_HTM_OP_START)
>> + * last three values are unused, hence set to zero
>> + */
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, =
coreindexonchip,
>> + htmtype, H_HTM_OP_START, 0, 0, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < 100);
>> +
>> + if (htm_return_check(rc) <=3D 0)
>> + return -1;
>=20
> [Severity: High]
> If H_HTM_OP_START fails, does this return without cleaning up the
> configuration? Because event_add fails, the perf core aborts event =
creation
> and won't call event_del, potentially leaving the hypervisor state =
permanently
> configured and leaking tracing resources.
>=20
> [Severity: Medium]
> Is it expected to execute the start operation unconditionally during =
event_add
> instead of using the standard pmu->start callback? If the event is =
created in
> a disabled state, it will immediately start tracing anyway.
>=20
>> + return 0;
>> +}
>> +
>> +static void htm_event_del(struct perf_event *event, int flags)
>> +{
>> + long rc;
>> + int ret;
>> + int retries =3D 0;
>> + u64 config =3D event->attr.config;
>> + u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
>=20
>> [ ... ]
>=20
>> + /* Reset retries */
>> + retries =3D 0;
>> +
>> + /*
>> + * Invoke H_HTM call with:
>> + * operation as htm configure (H_HTM_OP_DECONFIGURE)
>> + * last three values are unused, hence set to zero
>> + */
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, =
coreindexonchip,
>> + htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
>> + ret =3D htm_return_check(rc);
>> + } while (ret <=3D 0 && ++retries < 100);
>> +}
>=20
> [Severity: Medium]
> Similar to the configure path, does this loop needlessly spin on =
deterministic
> errors like -EINVAL and -EPERM?
>=20
>> [ ... ]
>=20
>> +static void htm_event_stop(struct perf_event *event, int flags)
>> +{
>> +}
>=20
> [Severity: Medium]
> Does providing an empty stop callback prevent users from disabling =
tracing via
> the standard perf API? ioctl(PERF_EVENT_IOC_DISABLE) relies on this =
callback
> to pause the hardware.
>=20
>> +static struct pmu htm_pmu =3D {
>> + .task_ctx_nr =3D perf_invalid_context,
>> +
>> + .name =3D "htm",
>> + .attr_groups =3D attr_groups,
>> + .event_init  =3D htm_event_init,
>> + .add         =3D htm_event_add,
>> + .del         =3D htm_event_del,
>> + .read        =3D htm_event_read,
>> + .start     =3D htm_event_start,
>> + .stop     =3D htm_event_stop,
>> + .capabilities =3D PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
>> +};
>=20
> [Severity: High]
> Does this system-wide PMU require a cpumask attribute to prevent =
concurrent
> access? Without a cpumask, running perf stat -a might attempt to open =
and
> start the HTM event on every CPU simultaneously, leading to race =
conditions
> on the hypervisor side for the same node/chip target.
>=20
>> +static int htm_init(void)
>> +{
>> + int r;
>> +
>> + /* This driver is intended only for L1 host. */
>> + if (is_kvm_guest()) {
>> + pr_debug("Only supported for L1 host system\n");
>> + return -ENODEV;
>> + }
>> +
>> + r =3D perf_pmu_register(&htm_pmu, htm_pmu.name, -1);
>=20
> [Severity: High]
> Can this PMU register on bare-metal systems (PowerNV/OPAL) where the =
PAPR
> hypervisor isn't present? It might be necessary to verify the presence =
of the
> hypervisor using firmware_has_feature(FW_FEATURE_LPAR) to prevent =
system
> traps or panics when executing H_HTM.
>=20
>> + if (r)
>> + return r;
>> +
>> + return 0;
>> +}
>> +
>> +device_initcall(htm_init);
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701083806.79358-1-atrajeev@linux.ibm.c=
om?part=3D1


