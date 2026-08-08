Return-Path: <linuxppc-dev+bounces-25635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DB5C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 05:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH8Jg2XGWz2xd2;
	Sat, 08 Aug 2026 15:12:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786165923;
	cv=none; b=Po5SbH1/NQNq5qbQN1phd5FeMA6cMGgGEOK0Ag4dL8LP1bvfJOftsloaQewR5NyTUpgZ9OgvRAcKUF/+EJIzJqa2cCeRVFbrvN0G7K2xhmrbbG7MWJJrhwdLDmFyRK9zWNi0SKI3udGL6vYhHm7FxNW3W6ETs6C5L2Kw8VvJBo9610N7RI7u4OTzRC9f245IDf1W9fPOVAf1mO+l0UExriQQjrkzenSgWmOD+F8SgizE+fsAAIsIOlTYOty+ShwoSzTglUpRQr6LYRfzZLoPYf6Gvcal4fdpRXLYQBVGUO1OlbuMzXKJliu4WUThe+LxcXSb+Eshrc0voNcL9cG8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786165923; c=relaxed/relaxed;
	bh=Tc6X9emPLl/jNG6oNrbBl52ybSnFgT7wpBv7QnTkr7o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CbMGwO16Fqi1ork6umgVnOxhzKa4Cb4bTA2bt2fN67S21QEgbhpJ1o0lQfpt/DBqRTeqXc1o9eUuMY0JJc7W6yN67G3W6l0kDqwTidtNw4C11jb9KNhFCFpepmtpMA7cfDkb40ZmMvg5ylzwLneDzhib2UfDYrOKlGjKGxvXkoXdRjkSR0skQjMgse7GE7dFkzzb0p+SGMm4/pZf0e8In+sw2pr9cLRMyUNuCRbu4DoZYVkRxr7AZYo7DBTn6PS6YDDqYL/M8ho0TZdmo8188knax4Un8SuGeqe7jUOvNvZkeM/MXWjh3VNDGf4a0ZDEgLeKYcAKb/rQtZ+D1ogQJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M/PBQ/P3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M/PBQ/P3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH8Jf3hJxz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 15:12:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67848Jrk3466772;
	Sat, 8 Aug 2026 05:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tc6X9e
	mPLl/jNG6oNrbBl52ybSnFgT7wpBv7QnTkr7o=; b=M/PBQ/P3ZIsPpRxgnxFz5z
	94hrb4U/JjY4R4xfqOWoK3Gtn7hDC8iGshS222U0tHlMbtDKjvqdk29oXa1l50Fi
	qjSBdXCbbwaCEHQbXgpDnV3FzZUf0dIrIFhru9pLb+vqmaRjXxFnm0KBMCsi+qqj
	FGKD1W6hneb2AoQQtreNQXDanKE80oqVcyu+fl/miuWtqu2O1NBveOO5M8N73NQr
	08ksK3e0WTtWlRwQIAST3EqkhbvLxfoYKmf1VJPweBsDn1lia+UjB9aKZztYb0pX
	/XMflLnItU5rs/beM05dq6XNnFZwWbWdkgc2MB8t5Kh+Od3huKtHpQkP0wZqgEeQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvr6fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 05:11:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6785BI5W030632;
	Sat, 8 Aug 2026 05:11:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu02cwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 05:11:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6785BpZs35651898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 05:11:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE3C720040;
	Sat,  8 Aug 2026 05:11:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 213A820043;
	Sat,  8 Aug 2026 05:11:48 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.45])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 05:11:47 +0000 (GMT)
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
Subject: Re: [PATCH V5 0/6] tools/perf: Add powerpc HTM auxtrace support
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260807144135.2607-1-atrajeev@linux.ibm.com>
Date: Sat, 8 Aug 2026 10:41:35 +0530
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        tshah@linux.ibm.com, venkat88@linux.ibm.com, usha.r2@ibm.com,
        maddy@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <083A4990-6158-4C25-B29C-78A8AF9ADCF3@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a76ba9c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pCsBzzXw6jkMmXqWeCkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -pSmrUBy3-pFA9sfETm_UfK_jT9owVLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAzNyBTYWx0ZWRfX7SQfccWd7qoG
 6UvM7bIvkvW8XBgcm8ACLNdyeWChjYmN89tGvSfIkxC0oeoTxDVulH/0jb7Cz4XMDxGMOVGMSUo
 CxADRrrCl5q8dRMBZjjeFwHyTBqpGeoK7x968gmNmA0v696Kg/XpLLl1aCC2U0wW7pFWoDJLK+t
 Xs2kMDihFj0Ef/8fkjtHQIqx3iJATvs+U2xW4MUzIQrYpAuvoMasS3G872FKU6MeasVoKMKa9JE
 eeNGExZdYK5W5iqkYmCl7drdVmQAh3UXp6N3RX555AvIBTSCNbDajf2gzhykrUfvHZz9oAP299G
 4UM88n2qk4+xSgpMHkH2av4oIvZmb3vASfLgN39TEW7Odwntldvtis6wmR8KgzpGmI8MHTLORNT
 AmVyJlKRUsvXIHvVgaWl2goDF2oUexP2vP+JbrJQebU/Ui8hhMTelUoYryEuCgWXkegJ4VoMGpM
 nzr5515jICg9AjC+/rg==
X-Proofpoint-ORIG-GUID: 1752-X3pWtpYLbqB8FWnHUTCsmYRUlTL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDAzNyBTYWx0ZWRfXxbtmIJdSW12U
 4PXZjm3T/PtB9KbcnxR35nS9ngBOom0b9sOgm3beH7tqNsH2/BOUEyzn1E1hc9gMp9J4DBQH5kF
 ipgkwy7JuzEkTWZAdgKFNhhRhTD0mzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080037



> On 7 Aug 2026, at 8:11=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> Overview:
> This series adds perf tool support for capturing and processing =
Hardware
> Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw =
bus-trace
> data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
> (submitted separately) streams this data into perf AUX buffers and =
emits
> memory configuration as PERF_SAMPLE_RAW records.
>=20
> This series wires up the record and report sides in the perf tool so =
that
> 'perf record' collects HTM data and 'perf report' writes the trace and
> memory configuration to files ready for post-processing with =
htmdecode.
>=20

Hi All,

I am currently working on addressing Sashiko's review comments for V5 of =
the patch series.
Before I proceed with posting V6, requesting for any feedback or =
suggestions that I should incorporate in V6, apart from Sashiko's =
comments.

Thanks
Athira

> Patch overview:
> Patch 1 refactors the existing powerpc auxtrace dispatch.  All VPA-DTL
> recording logic is moved from arch/powerpc/util/auxtrace.c into its =
own
> file, arch/powerpc/util/vpa-dtl.c, leaving auxtrace_record__init() as =
a
> thin per-PMU dispatcher.  This is a prerequisite for adding the HTM
> recording path cleanly.
>=20
> Patch 2 adds the HTM recording path (arch/powerpc/util/htm.c and
> util/powerpc-htm.h).  htm_recording_init() sets up the auxtrace_record
> callbacks.  htm_info_fill() stores the PMU type and a (cpu, =
attr.config)
> pair for each htm evsel into the PERF_RECORD_AUXTRACE_INFO priv[] =
area.
> The decode side reads these back to map each AUX buffer to its
> (node, chip, core) target using event->auxtrace.cpu.  PERF_SAMPLE_RAW =
is
> also enabled here so that memory configuration records are captured
> alongside the AUX stream.
>=20
> Patch 3 adds a generic weak arch_perf_record__need_read() hook in
> builtin-record.c.  When the hook returns non-zero, perf record =
performs
> an extra mmap-read pass before disabling events.  The drain loop runs
> until the hook returns 0 or no forward progress is made, then the =
events
> are disabled and closed normally.
>=20
> Patch 4 implements arch_perf_record__need_read() for powerpc.  It =
reads
> event->count for all open htm evsels via perf_evsel__read() and
> accumulates the values.  The kernel driver sets this count to the =
number
> of 128-byte HTM trace records written on a successful dump, 1 when the
> AUX buffer is temporarily full but the hypervisor stream is intact, =
and
> 0 once the stream is exhausted or a hard error occurs.  A non-zero =
total
> causes the recording loop to perform another read pass.
>=20
> Patch 5 adds PERF_AUXTRACE_POWERPC_HTM to the auxtrace_type enum and
> wires the dispatch in perf_event__process_auxtrace_info().  It also
> amends htm_info_fill() to set auxtrace_info->type now that the =
constant
> is available.
>=20
> Patch 6 adds the full HTM decode path in util/powerpc-htm.c.
> powerpc_htm_process_auxtrace_info() reads the (cpu, config) pairs from
> priv[] and builds a cpu_configs[] lookup table.  As each
> PERF_RECORD_AUXTRACE event arrives, process_auxtrace_event() maps it =
to
> the correct target and writes the data to htm.bin.nX.pX.cX.tX =
immediately.
> PERF_RECORD_SAMPLE RAW records are written to translation.nX.pX.cX.tX =
by
> process_event().  Per-run first-write tracking (htm_target_seen) =
ensures
> O_TRUNC on the first write and O_APPEND on subsequent writes.
>=20
> Patches not included in V2:
> Three patches present in V1 are intentionally dropped from this series
> and will be submitted as a follow-on once the core infrastructure gets
> integrated:
>=20
>  - htmdecode integration: V1 patch 6 invoked the external htmdecode
>    tool via fork/exec after writing htm.bin.* to decode the raw
>    bus-trace data in-process.  This is deferred because the interface
>    between perf and an external decode tool needs more discussion.
>=20
>  - Physical-to-logical address mapping: V1 patch 7 read the current
>    partition ID from /proc/powerpc/lparcfg, parsed the translation.*
>    memory map entries, and mapped physical addresses in the decoded
>    trace to logical addresses within the LPAR.
>=20
>  - Synthetic sample generation: V1 patches 8 and 9 created a
>    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples
>    with the translated logical addresses as sample IP, and wrote a
>    separate .out.l file with logical addresses alongside the decoded
>    trace.  The appropriate abstraction for synthetic HTM samples in =
the
>    perf tool requires further discussion.
>=20
> Usage example:
> Collect HTM trace data from a single chip target:
>=20
>  # perf record -C 9 -m,256 \
>      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ sleep 3
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 256.277 MB perf.data ]
>=20
>  # perf report
>=20
> Output files written by perf report:
>=20
>  htm.bin.n0.p2.c0.t1       raw HTM bus-trace data
>  translation.n0.p2.c0.t1   memory configuration records
>=20
> Multiple targets can be collected simultaneously:
>=20
>  # perf record -m,256 \
>      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1,cpu=3D8/ \
>      -e htm/nodalchipindex=3D1,nodeindex=3D0,htm_type=3D1,cpu=3D9/ \
>      -a sleep 10
>=20
> Testing:
> Tested on POWER11.  Both htm.bin.* and translation.* files are =
produced
> correctly for single and dual target collection.
>=20
> Note: Link to kernel patches:
> =
https://lore.kernel.org/linuxppc-dev/20260807143734.1224-1-atrajeev@linux.=
ibm.com/T/#t
>=20
> Athira Rajeev (6):
>  tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
>  tools/perf: Add AUXTRACE recording support for powerpc HTM
>  tools/perf: Add arch hook to drain remaining data before event close
>  tools/perf: Add powerpc callback support for
>    arch_perf_record__need_read
>  tools/perf: Add powerpc HTM auxtrace event processing support
>  tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
>    records
>=20
> tools/perf/arch/powerpc/util/Build      |   2 +
> tools/perf/arch/powerpc/util/auxtrace.c |  98 ++----
> tools/perf/arch/powerpc/util/evsel.c    |  77 ++++
> tools/perf/arch/powerpc/util/htm.c      | 185 ++++++++++
> tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++++
> tools/perf/builtin-record.c             |  65 ++++
> tools/perf/util/Build                   |   1 +
> tools/perf/util/auxtrace.c              |   4 +
> tools/perf/util/auxtrace.h              |   1 +
> tools/perf/util/powerpc-htm.c           | 447 ++++++++++++++++++++++++
> tools/perf/util/powerpc-htm.h           |  43 +++
> tools/perf/util/powerpc-vpadtl.h        |   3 +
> tools/perf/util/record.h                |   4 +
> 13 files changed, 954 insertions(+), 72 deletions(-)
> create mode 100644 tools/perf/arch/powerpc/util/htm.c
> create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
> create mode 100644 tools/perf/util/powerpc-htm.c
> create mode 100644 tools/perf/util/powerpc-htm.h
>=20
> --=20
> 2.53.0
>=20


