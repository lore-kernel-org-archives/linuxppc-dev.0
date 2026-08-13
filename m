Return-Path: <linuxppc-dev+bounces-25806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38C1C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 07:37:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLHJC1grWz2yNj;
	Thu, 13 Aug 2026 17:37:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786606651;
	cv=none; b=XhNq4OqHSsQH7aZAlv1hIRI+GobAiisQFlQbcBHsZa7a9LcvqGYqR36vfN/f7eaRUlfrCHUsNz/D7rlsPGYt3XQTj38HnzvSJiTZA4D6WnzoZhz+dXcdWsqE9rmPYM51jZktE6CyMVgbbuCBIS7m2YhH7y/Q77PwoWueNhAgMzj13EFfLLsmd2smFLih5LcicSDnF8E8Bmne+NJIg9wb9jnAfMePiY+G2ibFguXNfVCiGQs4OmZHJB5z5Z80Xkdhylbr8+jfmbvhALQGi2mQQYxOkHtpkn8daWKtNOMwxQwObVWvX3znVhqFtZ8oWJB7nYTLT7ntq4bst+qVASaCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786606651; c=relaxed/relaxed;
	bh=2eSeeyKrtJs/wf/j8ZiBjRk56h/9tVnljpp+fNrPdO8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ve/C7BgT1BZOiDcpTKkKiOwyxuyRaOLM6Si3TkQhOtHdC+HTuFOUYYm1LcoWeH4Je+pChT7txr2868BWbXA5GDmV0wCPTbPNi9Rv0qOJQ+QQmJMPcPsUbxXk0s4WgOLoou/BXqEZ9bVj41GKcg8FtQPVH5UE3GtCR9oC7OlX1PgQkiqGPe7d6m9NE3BIbsyPfsUJw/Xh2aK939iYDV8P296fsWfmTx4rIrP39gcaXn6dDo7QaQGU06CUttevOE2YWcmKOtiAceCmn+M+wgiehns1Ce33CL7gSwh2aqX/aA2NX7xRFa6PrTKA7xvodb5++PoB6RktDqmyhNKHYxVhjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UcCaOVwW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UcCaOVwW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLHJ904K0z2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 17:37:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D621pf422828;
	Thu, 13 Aug 2026 07:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2eSeey
	KrtJs/wf/j8ZiBjRk56h/9tVnljpp+fNrPdO8=; b=UcCaOVwW+8UtoMHAewNzEC
	EtBTjtL1LHWQn1ChRwxG+inqp0x2MH7JhPSfp48cPuFFlIZHvnBnbdy2EnGJ87Z9
	g2E1EQd41a/E9NQ0saSeahywno/5XvG+pJTZwDmUNUgLdw4EhCq19rNZMkCiqPnQ
	9RYZ+NaFU2fRGLvCoSdKkMveoZw+HM8hOXj2cGgR7nK8SUU6I+ZmFAV7QTdbBo99
	bhmmf81YHU+l4SpDtM9rdYVZQyCopjIxjNfyMPD47IJkTwdLvj+QrSXFkJnGi3xm
	7lU3AH/csnd8f35Xhym49KrMmGFp9vjDgjz+OQ97oMUXOG5ZhRgtH5QOq2gxDD7A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23y71c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:37:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7QJLM012884;
	Thu, 13 Aug 2026 07:37:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9ha0jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:37:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7bBSr49676640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:37:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47A6620043;
	Thu, 13 Aug 2026 07:37:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26D7A20040;
	Thu, 13 Aug 2026 07:37:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.209.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 07:37:07 +0000 (GMT)
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
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
Date: Thu, 13 Aug 2026 13:06:55 +0530
Cc: acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <00D2E602-E43D-4D23-9304-133263424B3B@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
 <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7d742c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=QkD66j9Q0axDQaq0BDcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX6JPc2i7j0MqU
 VcSFklDSWqweEZOtJCL70KQYMtr02TDXM3z7YUERns6RlCQD/ag1ecfchdhsqdGe55b9o6Ym3Sh
 3be4sHOaR/Rul+lhlfNEHDQ/OJQUR4uFGvT/EmzeSXfQdHuYmdAFgrlHDmTTK9zvPYUY09RBI4A
 /U0Sko9yOsM4jPKJt/flOVQwsfdMjo6iCk1p42MI6VVfCFN0Rs3lzLAd67HCED1ZPXDPBw2wJT0
 Db4rrl5/gohRYfCWr99PCttJM0JPxT3ivia2Az5eJl/pL9bxfkr9gUvUwxqoXJrSbVOS2VXbnBK
 shhvrMU+RzD2gmwlhGfsAPNL3u7qnOuWJX9I7FmPsW3yBTdktzwlakFB+xHn7iJx8jZE9innMfo
 zLHppku2GaNrD99ydrm8+Q8uDYYd+ZlrF48/34SZu6ckOUYnrjtDSSqA0exqVwgnsWPygyMTkZI
 CkLoUAam+4n+hVtE6/A==
X-Proofpoint-ORIG-GUID: JIJWU4Cvd4U7xvVo8PimaXQKHatwDdaU
X-Proofpoint-GUID: ULOHHS3v-gxtIdbl7iJ6zO7amCMXDxG6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX4UYb7WFHYgf+
 AqO4E6u6feFOs91lV+83Z29owv2DAAnWdVb6wH5tFnoovzF0jBRDdVGmjIx1hiAtZ/9dQnRvPge
 2pcspfluoubBZfNoUQSale+iwTD3b/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130051



> On 13 Aug 2026, at 11:52=E2=80=AFAM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
> On 07/08/2026 17:41, Athira Rajeev wrote:
>> Implement the arch_perf_record__need_read() architecture-specific =
hook
>> for powerpc in arch/powerpc/util/evsel.c.
>>=20
>> The HTM kernel driver sets event->count to the number of records =
still
>> staged in its internal buffers (total_size / record_size), and to 0
>> once the stream is exhausted.  This hook reads that count for every =
open
>> htm evsel via perf_evsel__read() and accumulates the values into
>> total_pending_records.  A non-zero total means at least one HTM =
target
>> still has records pending; the recording loop added in the previous
>> patch will perform another mmap-read pass.
>>=20
>> The drain uses a two-layer safety check: event->count detects records
>> staged by the driver, and record__bytes_written() in the drain loop
>> confirms data was actually moved into perf.data.  This combination
>> handles the case where the driver count is briefly stale while =
hardware
>> is still flushing.
>>=20
>> The implementation scans the evlist using evsel__pmu_name() to =
identify
>> HTM events by their kernel-assigned PMU name rather than the
>> user-visible event name, preventing false matches.  It iterates the =
fd/
>> sample-id xyarray, and skips any evsel whose fd and sample-id arrays =
are
>> mismatched to avoid reading stale state.  When the accumulated record
>> count reaches zero the hook returns 0 and the recording loop proceeds =
to
>> disable and close the events.
>=20
> This looks like the proposed driver:
>=20
> =
https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/=


Hi Adrian,
Thank you for the review.

Could you please help clarify which specific aspect of the driver breaks =
the perf ABI? Is it the sysfs format ABI where encoding raw hardware =
topology identifiers (nodeindex, nodalchipindex, coreindexonchip) are =
used as perf_event_attr.config bit fields?
I am trying to confirm so that I get your feedback correctly for =
reworking on changes.

Thanks,
Athira

>=20
> breaks the perf ABI.
>=20
> I am not going to review any more tools patches for now.
>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>> ---
>> Changes in V5:
>> - When an HTM evsel is a group sibling (evsel->core.leader !=3D
>>  &evsel->core), read through its group leader's struct perf_evsel
>>  instead of the sibling directly.  perf_evsel__read_size() uses
>>  evsel->nr_members to compute the read buffer size; nr_members is 0
>>  for siblings, so size=3D0 is passed to readn(), which returns <=3D0 =
and
>>  leaves count.val=3D0, causing the drain loop to terminate =
prematurely.
>>  Reading through the leader avoids the zero-size buffer and correctly
>>  accumulates the leader's pending count.  HTM events are always
>>  standalone or per-target leaders in practice; the leader redirect
>>  handles any grouped configuration without losing counts.
>>=20
>> Changes in V4:
>> - No changes from V3.
>>=20
>> Changes in V3:
>> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
>> to identify HTM events, matching by kernel-assigned PMU name rather
>> than user-visible event name.
>> - Remove the redundant two-pass loop (first pass to set found_htm,
>> second to accumulate counts); a single pass with evsel__pmu_name()
>> is sufficient. if no HTM event exists total_pending_records stays 0
>> and the function returns 0.
>> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
>> - evsel__pmu_name() will never return "htm" for a dummy:u software
>> event.
>> - Rename total_pending_bytes -> total_pending_records to match what
>> the driver actually reports (event->count =3D total_size / =
record_size,
>> a record count, not a byte count).
>> - Add #include <string.h> for musl compatibility (strcmp() without
>> it warns on some toolchains).
>>=20
>> Changes in V2:
>> - Implements the renamed arch_perf_record__need_read() hook (V1
>>  implemented arch_record__collect_final_data()).
>> - Skips evsels whose fd and sample-id xyarrays are mismatched, =
avoiding
>>  stale-state reads.  V1 had no such guard.
>> - evlist__enable cycling is removed; that responsibility now belongs =
to
>>  the drain loop in builtin-record.c added in patch 3.
>> - File location changed to arch/powerpc/util/evsel.c (V1 used
>>  arch/powerpc/util/powerpc-htm.c).
>> - Patch is now 4/6 instead of 4/9.
>>=20
>> tools/perf/arch/powerpc/util/evsel.c | 77 =
++++++++++++++++++++++++++++
>> 1 file changed, 77 insertions(+)
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/evsel.c =
b/tools/perf/arch/powerpc/util/evsel.c
>> index 2f733cdc8dbb..2b7851c70677 100644
>> --- a/tools/perf/arch/powerpc/util/evsel.c
>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>> @@ -1,8 +1,85 @@
>> // SPDX-License-Identifier: GPL-2.0
>> #include <stdio.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <linux/string.h>
>> #include "util/evsel.h"
>> +#include "util/record.h"
>> +#include "util/evlist.h"
>> +#include "util/debug.h"
>> +#include <internal/xyarray.h>
>> +#include <internal/lib.h>
>>=20
>> void arch_evsel__set_sample_weight(struct evsel *evsel)
>> {
>> evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>> }
>> +
>> +/*
>> + * powerpc implementation of arch_perf_record__need_read().
>> + *
>> + * Reads event->count for every open HTM evsel by issuing a direct
>> + * read() on the event fd with a plain u64 buffer, bypassing the
>> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel =
is
>> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its =
attr;
>> + * perf_evsel__read() would then call perf_evsel__read_group() which
>> + * sizes the buffer by evsel->nr_members (0 for siblings), causing =
the
>> + * kernel to return -ENOSPC.  Reading the fd directly with =
sizeof(u64)
>> + * retrieves the HTM driver's plain pending-record count regardless =
of
>> + * group membership.
>> + *
>> + * Returns: 1 if more data exists, 0 if collection is complete
>> + */
>> +int arch_perf_record__need_read(struct evlist *evlist)
>> +{
>> + struct evsel *evsel;
>> + u64 total_pending_records =3D 0;
>> + int x, y;
>> +
>> + /* there was an error during record__open */
>> + if (!evlist)
>> + return 0;
>> +
>> + /* Read HTM event counts to check if more data is available */
>> + evlist__for_each_entry(evlist, evsel) {
>> + struct perf_evsel *rd_evsel;
>> + struct xyarray *xy;
>> +
>> + if (strcmp(evsel__pmu_name(evsel), "htm"))
>> + continue;
>> +
>> + /*
>> + * For group siblings nr_members =3D=3D 0, which makes
>> + * perf_evsel__read_size() return 0 and readn() fail.
>> + * Read through the leader instead; perf_evsel__read_group()
>> + * extracts the leader's own count from the group buffer.
>> + */
>> + if (evsel->core.leader !=3D &evsel->core)
>> + rd_evsel =3D evsel->core.leader;
>> + else
>> + rd_evsel =3D &evsel->core;
>> +
>> + xy =3D rd_evsel->sample_id;
>> +
>> + if (xy =3D=3D NULL || rd_evsel->fd =3D=3D NULL)
>> + continue;
>> +
>> + if (xyarray__max_x(rd_evsel->fd) !=3D xyarray__max_x(xy) ||
>> +    xyarray__max_y(rd_evsel->fd) !=3D xyarray__max_y(xy)) {
>> + pr_debug("Unmatched FD vs sample ID array for HTM event\n");
>> + continue;
>> + }
>> +
>> + for (x =3D 0; x < xyarray__max_x(xy); x++) {
>> + for (y =3D 0; y < xyarray__max_y(xy); y++) {
>> + struct perf_counts_values count =3D { .val =3D 0 };
>> +
>> + if (perf_evsel__read(rd_evsel, x, y, &count) =3D=3D 0)
>> + total_pending_records +=3D count.val;
>> + }
>> + }
>> + }
>> +
>> + /* Collection is complete only when ALL hardware queues have no =
pending records */
>> + return (total_pending_records > 0) ? 1 : 0;
>> +}
>=20


