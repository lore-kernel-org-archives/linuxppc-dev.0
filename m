Return-Path: <linuxppc-dev+bounces-25778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A4C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:06:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKsJf6HPJz303K;
	Thu, 13 Aug 2026 01:06:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786547186;
	cv=none; b=J+e21ylgpxQe+HjeOaF6DL5MWvdRo8uEeXJOp27D8YX9M70no/U/w1SlJcmv63cjMC9YWNrO6NHJGydOhjY/Xwj9LePdZRiuvoZ4PVWXS7ImJVAEehLB68DepYkcmdoxIDAo4gayUq1qQLbrX6H7LpF6qvArnEEoQQYQZnjwzGqppe+R0fWmhM7wgKOL0gB2BfvqxjoQvcONX3NqoaaNadS6Bkw1vTjE1AJuaQb1cbHR1kr35N/mN2WF3MZQ9AWPPZEOf2g4Fr2Do85N+h8YBaANFiuVwWUFr5Vy1AGxdDU8MCQvfOluxHaKEHdm3s8p4ltvrb1qY7PaR+vOlEyoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786547186; c=relaxed/relaxed;
	bh=YMu1emnauUCk9Q6apEdF9+Roz1AleoQ8zU3LjrE4i9k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DQ1/5vSWfRB/GYfR4DLnBP+riD9rypvQBrps3AoJkUxQN03okRCtrkf15o27UCCKds1pqVky8QX4J4tV8xL8xaIDoYKhSbm6jcdxJ8FDUCpqDrGZeiHXJt3b4KpgZHuIM4pYDzM2PtwA3P+p+S0jdsigQj1KO/CyqUWiDnQ0oeTJqc2XCf7vhsh0R5H83AR2BWTWKjgKa2zGqAUdx15Ens2DaeTQwsrOS6GDw/y7XXC73DsIpraYQacwBp0ekqcIdNc37+uuVJqtECi2JY4fZV+77EfzWOYkCaMhSRlFabNtdAr4cREHx6aNI9cI7pBVLu8XL+kB5f3uMzg51ZsPhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jvi9SzAz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jvi9SzAz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKsJd5jHwz302l
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 01:06:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1mmJ3640501;
	Wed, 12 Aug 2026 15:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YMu1em
	nauUCk9Q6apEdF9+Roz1AleoQ8zU3LjrE4i9k=; b=Jvi9SzAzrL9IcvB7cOHUj8
	4xCsDt5f6wZRbMTDupONLdj1QuY45dUis0oJrqfFADnBEF2otDJ0RiJsZnyHtzVs
	TgN4mg8X9wMMmYLwmPhEIgPDIUhJ3Ddl2/V9I5HRRrn59/ePPCgNSspQM1vqcA6E
	Dj2oDw/qbsr5rETBOVTOofzlm3WhoCcbmi8VcN4Uf/DZSHUnj3PiHoxESYDOPDf4
	OS6y325vla3D2Hd88o5CGLhb3kNy5S1/8Yz3cZQTZYAejjs84UQNXVbou9nMS1fE
	yKWBDOwT1euPp3faTiRwQ4FU2jxHbkvjC9kJiDGdSKnYcdOmVfip4ZMsYedtbx3A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9k2dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:06:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CEQYe6001447;
	Wed, 12 Aug 2026 15:06:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6qq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:06:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CF6DvH37749012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:06:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EC120043;
	Wed, 12 Aug 2026 15:06:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7448320040;
	Wed, 12 Aug 2026 15:06:10 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 15:06:10 +0000 (GMT)
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
Subject: Re: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <9e765036-6578-4832-9dd2-ab00e62dfacc@intel.com>
Date: Wed, 12 Aug 2026 20:35:58 +0530
Cc: acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA97CC8B-2EDA-49D7-9A9E-A58DEC88D54F@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-3-atrajeev@linux.ibm.com>
 <9e765036-6578-4832-9dd2-ab00e62dfacc@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZGrCFJMjDQgSZsW_XxEktWOlWzi76n77
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c8beb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=MGHkV_bKP0XlzYsNIzIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfXx2Eg1XaZk0Am
 KHZHisTawnUl/tUBxUcu4oMv7xc/FjE5AvmVjBj+1+gmTWXm2/BRqKepho37IN8n/IqNWdvgVdT
 EoDSQS6cmse0XuXt+vVLJBKD3ILhBNyE3Ub773GszJ4Raiyo+g381D6H4PqIWLMSmRLMZ85zh9M
 LJGPwLFnnQxhtOcd0WoFMQm6CBrCJF/Se7sv5NGHBBIj2+NJNjzY33aDD1inJeEY86IjKS9sSqM
 i9tyj4t3ngnvmyDV3OGutw/OBtVEuVM1uFXR81tV9e/i0SUiuyxmkA4WnoObqCyvvXTQF/xvi5d
 SC59SHPENyGRyyTV0v2bv4y7W0YqnfqPRKSl2E0qaPbZA1Z7s9VC79DMYuGJlfcZbJJnvQz3dWj
 lAlx0UzpJsNzNDFJR85+FjbyJjtSrvcAQoQnRXfJnDM/PyGarr5Gsyjakv9mmSfa+rTPNa9erSv
 21HEbkSna18gyTag3Xw==
X-Proofpoint-ORIG-GUID: kvWjB2UNsnMTTszObN6O66ttdD0hgUFM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX4verroOklJdh
 0zR8SkP1KPae/HESzAorolmIwvf8N2693TQ/tOwgq4uC0ZV712Ei1Dk5vm1xgyB9jAdt7LbB8C/
 Qkcc12ut3izvYuTl26kr6URVdf3Lc0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120122



> On 12 Aug 2026, at 3:57=E2=80=AFPM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
> On 07/08/2026 17:41, Athira Rajeev wrote:
>> Add powerpc perf tool support for the HTM PMU AUXTRACE recording =
path.
>>=20
>> Introduce htm_recording_init() and the associated auxtrace callbacks =
so
>> perf record can create PERF_RECORD_AUXTRACE records for HTM data.
>>=20
>> htm_info_fill() stores the PMU type, number of HTM evsels, and a
>> (cpu, attr.config) pair for each evsel into PERF_RECORD_AUXTRACE_INFO
>> priv[].  The decode side reads these back to map each AUX buffer
>> (identified by event->auxtrace.cpu) to the correct (node, chip, core)
>> target when writing htm.bin.* output files.
>>=20
>> Update auxtrace_record__init() to detect HTM events and dispatch to =
the
>> HTM-specific recording initializer.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> A couple of very minor comments.
>=20
> Nevertheless:
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Hi Adrian

Thanks for reviewing and sharing comments

I will include changes in the next version.
I will wait for feedback on the remaining patches and post a v6 =
incorporating all the changes together.

Thanks
Athira

>=20
>> ---
>> Changes in V5:
>> - htm_recording_options(): clamp aux_watermark with min_t(size_t, wm,
>>  UINT_MAX) before assigning to pos->core.attr.aux_watermark (u32).
>>  On a system with large auxtrace_mmap_pages the unclamped product can
>>  exceed UINT_MAX and silently truncate on 32-bit platforms.
>> - htm_info_fill(): iterate all CPUs in each evsel's CPU map and write
>>  one (cpu, config) entry per CPU instead of only the first CPU.  An
>>  evsel opened with -C 0,1,2 now contributes three priv[] entries, one
>>  per CPU, each carrying the same attr.config.  The decode side
>>  (powerpc_htm_process_auxtrace_event) uses event->auxtrace.cpu to =
look
>>  up the matching entry, so every CPU's AUX buffer is correctly mapped
>>  to its (node, chip, core, type) target and written to the right =
output
>>  file.  An evsel with no CPU map records cpu=3D-1 as before.
>>=20
>> Changes in V4:
>> - Add explicit mutual-exclusion check in auxtrace_record__init(): if
>>  both vpa_dtl_evsel and htm_evsel are set after scanning the evlist,
>>  print an error, set *err =3D -EINVAL, and return NULL.  V3 silently
>>  fell through to prefer VPA-DTL when both PMU types were present,
>>  leaving HTM AUX buffers collected without a
>>  PERF_RECORD_AUXTRACE_INFO record and the trace undecodable.
>> - Drop the superfluous pos->name && null-guard from the HTM detection
>>  condition in auxtrace_record__init(): the condition becomes
>>  !strcmp(evsel__pmu_name(pos), "htm") without the leading check.
>>  evsel__pmu_name() handles a NULL name internally so the guard is
>>  redundant.
>> - Apply the same simplification in htm_recording_options() and
>>  htm_nr_events() in htm.c: remove the !pos->name || prefix from
>>  the evsel__pmu_name() comparisons, consistent with the dispatcher
>>  change above.
>> - Set pos->core.attr.sample_period =3D 1 for each HTM evsel inside
>>  htm_recording_options().  V3 set freq=3D0 and aux_watermark but did
>>  not set sample_period, leaving the kernel to use whatever default
>>  value was in the attr, which could cause the HTM event to fire at
>>  an unintended rate.
>>=20
>> Changes in V3:
>> - Switch HTM event detection in auxtrace_record__init() from
>> strstarts(pos->name, "htm") to !strcmp(evsel__pmu_name(pos), "htm"),
>> matching the kernel-assigned PMU name and preventing false
>> matches on user-named events.
>> - Switch htm_recording_options(), htm_nr_events(), and the
>> loop in htm_info_fill() from strstarts(pos->name, "htm")
>> to evsel__pmu_name(), consistent with the above and with
>> patches 4 and 6.
>> - Add #include <linux/zalloc.h> to htm.c for zalloc().
>> - Set auxtrace_info->type =3D PERF_AUXTRACE_POWERPC_HTM directly
>> in htm_info_fill(), removing the placeholder comment. (V2
>> deferred this to patch 5; it is cleaner to set it in the same
>> patch that defines the enum.)
>> - Set aux_watermark to half the AUX ring-buffer size
>> (auxtrace_mmap_pages * page_size / 2) so there is always
>> headroom for hardware to write while userspace drains. V2 set
>> it to the full buffer size, risking data loss under back-pressure.
>> - Add PERF_AUXTRACE_POWERPC_HTM to the enum auxtrace_type in
>> util/auxtrace.h and add #include "powerpc-htm.h" plus a stub
>> case PERF_AUXTRACE_POWERPC_HTM: (falls through to
>> PERF_AUXTRACE_UNKNOWN) in util/auxtrace.c in this patch, so
>> the enum is defined before it is used in htm_info_fill().
>> (V2 did this in patch 5.)
>>=20
>> Changes in V2:
>> - htm_info_fill() now stores a (cpu, attr.config) pair for every HTM
>>  evsel into PERF_RECORD_AUXTRACE_INFO priv[].  V1 stored only the PMU
>>  type and a single config value; there was no per-CPU mapping.
>> - The priv[] layout is formalised in util/powerpc-htm.h with enum
>>  constants POWERPC_HTM_PMU_TYPE, POWERPC_HTM_NUM_EVENTS, and
>>  POWERPC_HTM_EVENT_DATA and the helper macros HTM_AUXTRACE_PRIV_FIXED
>>  and HTM_AUXTRACE_PRIV_SIZE(n).  V1 used bare numeric offsets.
>> - PERF_SAMPLE_RAW is enabled in the recording options so that memory
>>  configuration records emitted by the kernel driver are captured
>>  alongside the AUX stream.  V1 added this in a later patch.
>> - PERF_AUXTRACE_POWERPC_HTM type constant is set in htm_info_fill()
>>  (wired up in patch 5 once the enum is defined).
>> - Patch is now 2/6 instead of 2/9.
>>=20
>> tools/perf/arch/powerpc/util/Build      |   1 +
>> tools/perf/arch/powerpc/util/auxtrace.c |  22 +++
>> tools/perf/arch/powerpc/util/htm.c      | 185 =
++++++++++++++++++++++++
>> tools/perf/util/auxtrace.c              |   2 +
>> tools/perf/util/auxtrace.h              |   1 +
>> tools/perf/util/powerpc-htm.h           |  43 ++++++
>> 6 files changed, 254 insertions(+)
>> create mode 100644 tools/perf/arch/powerpc/util/htm.c
>> create mode 100644 tools/perf/util/powerpc-htm.h
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/Build =
b/tools/perf/arch/powerpc/util/Build
>> index 7819c8f5af2d..297152591046 100644
>> --- a/tools/perf/arch/powerpc/util/Build
>> +++ b/tools/perf/arch/powerpc/util/Build
>> @@ -8,3 +8,4 @@ perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
>>=20
>> perf-util-y +=3D auxtrace.o
>> perf-util-y +=3D vpa-dtl.o
>> +perf-util-y +=3D htm.o
>> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c =
b/tools/perf/arch/powerpc/util/auxtrace.c
>> index e04a0bd61755..9936d1910256 100644
>> --- a/tools/perf/arch/powerpc/util/auxtrace.c
>> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
>> @@ -12,13 +12,16 @@
>> #include "../../util/debug.h"
>> #include "../../util/auxtrace.h"
>> #include "../../util/powerpc-vpadtl.h"
>> +#include "../../util/powerpc-htm.h"
>> #include "../../util/record.h"
>> +#include <string.h>
>=20
> There is "#include <errno.h>" further up.  Maybe nicer to put them
> together as standard library includes
>=20
>>=20
>> struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>> int *err)
>> {
>> struct evsel *pos;
>> struct evsel *vpa_dtl_evsel =3D NULL;
>> + struct evsel *htm_evsel =3D NULL;
>>=20
>> /*
>>  * Set err value to zero here. Any fail later
>> @@ -32,11 +35,30 @@ struct auxtrace_record =
*auxtrace_record__init(struct evlist *evlist,
>> /* Remember the first matching VPA DTL event */
>> if (!vpa_dtl_evsel)
>> vpa_dtl_evsel =3D pos;
>> + } else if (!strcmp(evsel__pmu_name(pos), "htm")) {
>> + pos->needs_auxtrace_mmap =3D true;
>> + /* Remember the first matching HTM event */
>> + if (!htm_evsel)
>> + htm_evsel =3D pos;
>> }
>> }
>>=20
>> + /*
>> +  * Only one auxtrace PMU can be initialised per session.  Reject
>> +  * concurrent VPA DTL and HTM events: HTM AUX buffers would be
>> +  * collected without a PERF_RECORD_AUXTRACE_INFO record, making
>> +  * the trace undecodable.
>> +  */
>> + if (vpa_dtl_evsel && htm_evsel) {
>> + pr_err("Cannot record VPA DTL and HTM auxtrace events =
simultaneously\n");
>> + *err =3D -EINVAL;
>> + return NULL;
>> + }
>> +
>> if (vpa_dtl_evsel)
>> return vpa_dtl_recording_init(vpa_dtl_evsel, err);
>> + else if (htm_evsel)
>> + return htm_recording_init(htm_evsel, err);
>>=20
>> return NULL;
>> }
>> diff --git a/tools/perf/arch/powerpc/util/htm.c =
b/tools/perf/arch/powerpc/util/htm.c
>> new file mode 100644
>> index 000000000000..d2fdef488032
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/htm.c
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HTM AUX tracing support
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +#include <linux/zalloc.h>
>> +#include <stdlib.h>
>> +#include <limits.h>
>> +#include "../../util/evsel.h"
>> +#include "../../util/evlist.h"
>> +#include "../../util/session.h"
>> +#include "../../util/debug.h"
>> +#include "../../util/auxtrace.h"
>> +#include "../../util/powerpc-htm.h"
>> +#include "../../util/record.h"
>> +#include <internal/lib.h> /* page_size */
>> +#include <errno.h>
>> +
>> +#define KiB(x) ((x) * 1024)
>> +
>> +struct htm_recording {
>> + struct auxtrace_record itr;
>> + struct evsel *evsel;
>> +};
>> +
>> +static int
>> +htm_recording_options(struct auxtrace_record *itr __maybe_unused,
>> +       struct evlist *evlist,
>> +       struct record_opts *opts)
>> +{
>> + struct evsel *pos;
>> +
>> + opts->full_auxtrace =3D true;
>> +
>> + if (!opts->auxtrace_mmap_pages) {
>> + opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
>> + if (opts->mmap_pages =3D=3D UINT_MAX)
>> + opts->mmap_pages =3D KiB(256) / page_size;
>> + }
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + size_t wm;
>> +
>> + if (strcmp(evsel__pmu_name(pos), "htm"))
>> + continue;
>> + wm =3D opts->auxtrace_mmap_pages * (size_t)page_size / 2;
>> + pos->core.attr.aux_watermark =3D min_t(size_t, wm, UINT_MAX);
>> + pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
>> + pos->core.attr.freq =3D 0;
>> + pos->core.attr.sample_period =3D 1;
>> + pos->needs_auxtrace_mmap =3D true;
>> + }
>> +
>> + return 0;
>> +}
>> +
>> +/* Count htm evsels in the evlist */
>> +static int htm_nr_events(struct evlist *evlist)
>> +{
>> + struct evsel *pos;
>> + int n =3D 0;
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + if (!strcmp(evsel__pmu_name(pos), "htm"))
>> + n++;
>> + }
>> + return n;
>> +}
>> +
>> +static size_t htm_info_priv_size(struct auxtrace_record *itr =
__maybe_unused,
>> +  struct evlist *evlist)
>> +{
>> + return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
>> +}
>> +
>> +/*
>> + * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
>> + *   priv[POWERPC_HTM_PMU_TYPE]   =3D pmu->type of the first htm =
evsel
>> + *   priv[POWERPC_HTM_NUM_EVENTS] =3D total number of HTM CPU =
entries
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2]     =3D CPU number for nth =
entry
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] =3D attr.config for nth =
entry
>> + *
>> + * One entry is written per CPU in each evsel's cpu map.  An evsel =
opened
>> + * with -C 0,1,2 contributes three entries (one per CPU), each =
carrying
>> + * the same attr.config.  The decode side uses event->auxtrace.cpu =
to look
>> + * up the matching config and derive (node, chip, core) for the =
output
>> + * file name.
>> + */
>> +static int
>> +htm_info_fill(struct auxtrace_record *itr,
>> +       struct perf_session *session,
>> +       struct perf_record_auxtrace_info *auxtrace_info,
>> +       size_t priv_size)
>> +{
>> + struct htm_recording *htm_r =3D container_of(itr, struct =
htm_recording, itr);
>> + struct evlist *evlist =3D session->evlist;
>> + struct evsel *pos;
>> + int n =3D 0;
>> + int expected_n =3D htm_nr_events(evlist);
>> +
>> + if (priv_size !=3D HTM_AUXTRACE_PRIV_SIZE(expected_n))
>> + return -EINVAL;
>> +
>> + auxtrace_info->type =3D PERF_AUXTRACE_POWERPC_HTM;
>> + auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] =3D =
htm_r->evsel->core.attr.type;
>> + auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] =3D expected_n;
>> +
>> + evlist__for_each_entry(evlist, pos) {
>> + struct perf_cpu_map *cpus;
>> + int i, nr;
>> +
>> + if (strcmp(evsel__pmu_name(pos), "htm"))
>> + continue;
>> +
>> + /*
>> +  * Emit one (cpu, config) entry for every CPU in this evsel's
>> +  * map.  perf record -C 0,1,2 creates one evsel with a
>> +  * three-entry cpu map; each CPU gets its own AUX buffer and
>> +  * must be individually mapped so the decoder can match
>> +  * event->auxtrace.cpu to the correct (node, chip, core).
>> +  */
>> + cpus =3D evsel__cpus(pos);
>> + nr =3D cpus ? perf_cpu_map__nr(cpus) : 0;
>> +
>> + if (nr > 0) {
>> + for (i =3D 0; i < nr; i++) {
>> + int cpu =3D perf_cpu_map__cpu(cpus, i).cpu;
>> +
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D cpu;
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
>> + pos->core.attr.config;
>> + n++;
>> + }
>> + } else {
>> + /* cpu-agnostic evsel: record cpu =3D -1 */
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D =
(u64)-1;
>> + auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
>> + pos->core.attr.config;
>> + n++;
>> + }
>> + }
>> +
>> + return 0;
>> +}
>> +
>> +static u64 htm_reference(struct auxtrace_record *itr __maybe_unused)
>> +{
>> + return 0;
>> +}
>> +
>> +static void htm_free(struct auxtrace_record *itr)
>> +{
>> + struct htm_recording *htm_r =3D container_of(itr, struct =
htm_recording, itr);
>> +
>> + free(htm_r);
>> +}
>> +
>> +struct auxtrace_record *htm_recording_init(struct evsel *pos, int =
*err)
>> +{
>> + struct htm_recording *htm_r;
>> +
>> + /*
>> +  * To obtain the auxtrace buffer file descriptor, the auxtrace =
event
>> +  * must come first.
>> +  */
>> + evlist__to_front(pos->evlist, pos);
>> +
>> + htm_r =3D zalloc(sizeof(*htm_r));
>> + if (!htm_r) {
>> + pr_debug("htm_recording allocation failed (-ENOMEM)\n");
>> + *err =3D -ENOMEM;
>> + return NULL;
>> + }
>> +
>> + htm_r->evsel =3D pos;
>> + htm_r->itr.recording_options =3D htm_recording_options;
>> + htm_r->itr.info_priv_size    =3D htm_info_priv_size;
>> + htm_r->itr.info_fill         =3D htm_info_fill;
>> + htm_r->itr.free              =3D htm_free;
>> + htm_r->itr.reference         =3D htm_reference;
>> + return &htm_r->itr;
>> +}
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index aa749e1c3036..bf08f41d623f 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -56,6 +56,7 @@
>> #include "s390-cpumsf.h"
>> #include "util/mmap.h"
>> #include "powerpc-vpadtl.h"
>> +#include "powerpc-htm.h"
>>=20
>> #include <linux/ctype.h>
>> #include "symbol/kallsyms.h"
>> @@ -1432,6 +1433,7 @@ int perf_event__process_auxtrace_info(const =
struct perf_tool *tool __maybe_unuse
>> case PERF_AUXTRACE_VPA_DTL:
>> err =3D powerpc_vpadtl_process_auxtrace_info(event, session);
>> break;
>> + case PERF_AUXTRACE_POWERPC_HTM:
>> case PERF_AUXTRACE_UNKNOWN:
>> default:
>> return -EINVAL;
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index 6947f3f284c0..68b17802a419 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -46,6 +46,7 @@ enum auxtrace_type {
>> PERF_AUXTRACE_S390_CPUMSF,
>> PERF_AUXTRACE_HISI_PTT,
>> PERF_AUXTRACE_VPA_DTL,
>> + PERF_AUXTRACE_POWERPC_HTM,
>> };
>>=20
>> enum itrace_period_type {
>> diff --git a/tools/perf/util/powerpc-htm.h =
b/tools/perf/util/powerpc-htm.h
>> new file mode 100644
>> index 000000000000..18e39417d556
>> --- /dev/null
>> +++ b/tools/perf/util/powerpc-htm.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __POWERPC_HTM_H
>> +#define __POWERPC_HTM_H
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * Layout of the private data in PERF_RECORD_AUXTRACE_INFO for HTM.
>> + *
>> + * priv[POWERPC_HTM_PMU_TYPE]   =3D htm PMU type ID (pmu->type from =
kernel)
>> + * priv[POWERPC_HTM_NUM_EVENTS] =3D number of htm evsels recorded =
(N)
>> + *
>> + * Followed by N pairs (2 u64 each):
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 0] =3D CPU number for nth =
htm evsel
>> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] =3D attr.config for nth =
htm evsel
>> + *
>> + * Total priv entries: POWERPC_HTM_EVENT_DATA + N * 2
>> + */
>> +enum {
>> + POWERPC_HTM_PMU_TYPE  =3D 0,
>> + POWERPC_HTM_NUM_EVENTS,
>> + POWERPC_HTM_EVENT_DATA, /* variable-length: 2 u64 per event */
>> +};
>> +
>> +/* Fixed header size (everything before the per-event data) */
>> +#define HTM_AUXTRACE_PRIV_FIXED  (POWERPC_HTM_EVENT_DATA * =
sizeof(u64))
>> +
>> +/* Total priv size for N htm evsels */
>> +#define HTM_AUXTRACE_PRIV_SIZE(n) \
>> + (HTM_AUXTRACE_PRIV_FIXED + (n) * 2 * sizeof(u64))
>> +
>> +struct evsel;
>> +struct evlist;
>> +union perf_event;
>> +struct perf_session;
>> +struct auxtrace_record;
>> +
>> +struct auxtrace_record *htm_recording_init(struct evsel *pos, int =
*err);
>> +
>> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
>> +       struct perf_session *session);
>=20
> Ideally, should only add a declaration for =
powerpc_htm_process_auxtrace_info()
> when it actually exists
>=20
>> +
>> +#endif /* __POWERPC_HTM_H */



