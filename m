Return-Path: <linuxppc-dev+bounces-23286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AADC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:41:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtm43Rszz2ymb;
	Wed, 01 Jul 2026 18:41:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895300;
	cv=none; b=VV63hLfqmP2Np/uPNp9LVx6HXslp6khzrys9qWvrIcLu6GAKfB7uAMjuxK3mj52BQXjXA3RjN7lk59fLUNLtwZkpx9x4tYYNhn10Fce3mxJQlZU5wZZJuk5DTOMJ6Md+EsK3g0si98px5M7oYWSUVKDgaEPt0oQ4zqQIegDpVQTkwUQP2n5iPilEvC2lAcvs8LkK4rXAQ2bLwRsnfHICuIBzjCBJqwx5NZCCawQfq53483JqGpKxB9j4j+4ZYJEiLMBtxNuBQRFY8bVxhnnDptg8M3EBhXrvMPgZ8eaQKcKM3NUH2wmLJC8pKX12aOCGLkwCUIb8082yKy+dr6X5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895300; c=relaxed/relaxed;
	bh=vR8yhBMsQ31/5KG8UIkYqgOaSaeIW8MWWzqaQYbQIjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwVkCyEA32FBtfBe9ahYPG5OMEQ/2ZiQpaLf1CIGgF4PGigxDWnPX2+TWJOAML513VMQSLElQ77n1oJxhrkp5PwZNFmO3+NdLA+8iCCB2p//cQR+vW88lnOMFXp4uaIHDdKaOP/yqxoHctz+63J1iQmFGHpOcByMTIZl7UTWiMDctYo2jdPs62fTxbO5wvC0UWroGEqBSZDqVC7D6bCLt+Kj9Pdkhi3ebd1gJ7Mk7J6sQM+yWs8J60p1mf/8ESNZDn3XNkzuCcpclj2bqF3SxHFrxgG1LCFofjnrEmYmXlPI5rzvfrj8NpJQxNsXqh6CqeVx7EHMMr7WsjZSOy0oDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AnTl5fgf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AnTl5fgf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtm33Qdlz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:39 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IKE8238567;
	Wed, 1 Jul 2026 08:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vR8yhBMsQ31/5KG8UIkYqgOaSaeIW8MWWzqaQYbQI
	jA=; b=AnTl5fgfG8zfh6ZJVsNEX5AzBhwDYsB0gzpP+0xEyqRwNQWWYH/H7aeVr
	R1FWdl035NdlAF1PCX/+JYy7deV3A3wdOKWne0SgkZ2uto02rWLSpEX8JD802VTL
	Eb5Ob9+aXsPyfO5o7NqU5Vh95rymKQQ3vJf3Qvo3x7O+UilprAIfhg5rRGlXRnlq
	Mz0HDxNNkwPmXE5FlpoyXNbhkIiIjgRLtxhc7a6Wz2prV0jxTRFJVtCYFbaDEEye
	5+1kRU1rsPjexb4WBjKUSqWZ2t+WuMXdX3By62y8KkPFvRV7S32fsrIvxlLRENhQ
	1XUFt0oVdt0Ot1uXGImDKPZ37//9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf32qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YeNa026593;
	Wed, 1 Jul 2026 08:41:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w6hk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fMQA52101484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA5E2004B;
	Wed,  1 Jul 2026 08:41:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB7120040;
	Wed,  1 Jul 2026 08:41:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 0/9] tools/perf: Add interface to expose HTM trace data via perf
Date: Wed,  1 Jul 2026 14:11:06 +0530
Message-Id: <20260701084115.80383-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44d2b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aCfXrR22nqtEzcCBOqMA:9
X-Proofpoint-ORIG-GUID: VyPTxlcQZWjyzxI2T1-kXrqc5Q2WAhZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX6m23t2cc5wvw
 BPXFu+PAmKdFMtSZNCx6mrsb3cCaydZcqXzNkAx9ZMSuYo7cSJPokU/cSwn7sll30B17K8ccbL5
 E4rqf/7mx76VktYpBbtoPrbgCQD+X0/A+YyR9hOMHzS0oGOhhItBdfSAtGLBsE4b6L8NdeHrr3n
 Fx+qIpWGUOzA79ocnF/uGM9faS5D7ECWPGaaGn4vxKVlVhJkvwyuA9Oc3WVdHeMMCK8TgnEhoVR
 TOJRu03lF55mDXq5gr7GPivRFP3zOx9DT5FUMkCaW9kUZvO9ifVH2quLRkYkDEg4vewbLNLnw9c
 OauBUWOXHdV+8zi2OH1EmS9QcFMOrSzriFjPiu4Fu/ANysKrF8XjH2OHNGrkHZksQu16GBOOY0R
 7AfJUtknI+R8iyUXBxIlXpbYmkAJVwU3TmENmgSHDsy1f2AZ7prv3epIsoSQtwbJrlgq2LZPcof
 4YmOjd2hg4GtTjpBJQg==
X-Proofpoint-GUID: pLrrHUG0WSrrJUJAP845Tj--CmKadALa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9qxGAYEzMQMl
 geJKvXQselgNZy8KrehZihJ8OxvkXvBx/15mb0IqzUA0W5EoJNCGJ+LkmarMsA5m58EvNec5CL+
 VnkfPV7/wH3JbM/WXdQ67pWR0482CUE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

H_HTM (Hardware Trace Macro) hypervisor call is an HCALL to export data
from Hardware Trace Macro (HTM) function. Patchset adds support for setup,
configuration and control of HTM functions as well as trace data
collection via perf PMU interface.

H_HTM is used as an interface for executing Hardware Trace Macro (HTM)
functions, including setup, configuration, control and dumping of the
HTM trace data. HTM operations can be controlled using the H_HTM hcall.
The hcall can be invoked for any core/chip of the system from within a
partition itself.

HTM perf interface usage:
The HTM (Hardware Trace Macro) perf interface enables collection and
analysis of hardware trace data from PowerPC systems. This interface
allows users to capture detailed execution traces for performance
analysis and debugging. The interface uses AUX infrastructure for
capturing of trace data.

Patch 1: Move auxtrace_record__init for powerpc-vpadtl as separate
utility
 - Refactor VPA-DTL auxtrace initialization into arch/powerpc/util/vpa-dtl.c
   to allow multiple PMUs to use auxtrace

Patch 2: Add CONFIG_AUXTRACE support for HTM pmu on powerpc
 - Enable HTM PMU to use AUX buffers with recording options, info callbacks,
   and PERF_AUXTRACE_POWERPC_HTM type

Patch 3: Add arch_record__collect_final_data to collect additional data
before closing the event
 - Introduce callback mechanism to capture remaining data after
   evlist__disable but before event removal

Patch 4: Add powerpc callback support for arch_record__collect_final_data
 - Implement HTM-specific callback to read trace data until perf_evsel__read
   returns zero indicating completion

Patch 5: Process htm auxtrace events and display in perf report -D
 - Add PERF_RECORD_AUXTRACE_INFO processing and write HTM trace data
   to htm.bin.nXpXcX files

Patch 6: Add HTM trace data processing and decoding support
 - Extract system memory configuration, write translation files, and integrate
   htmdecode for trace analysis

Patch 7: Add physical to logical address mapping for HTM traces
 - Map physical addresses from HTM traces to logical addresses using LPAR
   memory configuration from /proc/powerpc/lparcfg

Patch 8: Add event name as htm of PERF_TYPE_SYNTH type to present htm samples
 - Create synthetic HTM event with PERF_SYNTH_POWERPC_HTM config to display
   logical addresses in perf report

Patch 9: Add logical address in decoded nest traces
  - Translate physical to logical addresses in decoded output and create
    .l files for source code correlation

Link to tools side changes:
https://lore.kernel.org/linux-perf-users/20260701083806.79358-1-atrajeev@linux.ibm.com/

Event Configuration:
Use "perf record" with the htm PMU event. The event is configured using
named parameters that specify the target hardware location and trace type:

   - htm_type
     - Type of HTM trace to collect (bits 0-3)
   - nodeindex
     - Node index in the system topology (bits 4-11)
   - nodalchipindex
     - Chip index within the specified node (bits 12-19)
   - coreindexonchip
     - Core index on the specified chip (bits 20-27)

event: "config:0-27"
htm_type: "config:0-3"
nodeindex: "config:4-11"
nodalchipindex: "config:12-19"
coreindexonchip: "config:20-27"

1) nodeindex, nodalchipindex, coreindexonchip: this specifies
   which partition to configure the HTM for.
2) htmtype: specifies the type of HTM.

Event Syntax:
The event configuration uses named parameters::

   htm/nodeindex=N,nodalchipindex=C,coreindexonchip=R,htm_type=T/

Where:

- N = node index
- C = chip index within the node
- R = core index on the chip
- T = HTM type

Basic Usage Example:
To collect HTM trace data for a specific chip:
 # perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ <workload>

In this example:

- nodeindex=0: Target node 0
- nodalchipindex=2: Target chip 2 within node 0
- htm_type=1: HTM trace type 1

Output Files:
After running "perf record", the following files are generated:

   # ls htm.bin.*
   htm.bin.n0.p2.c0 htm.bin.n1.p3.c0  # Binary trace files

   # ls translation.*
   translation.n0.p2.c0  translation.n1.p3.c0  # Memory configuration files

These files contain:

- **htm.bin.*** - Raw HTM trace data in binary format
- **translation.*** - Memory address translation information for decoding

Trace Data Processing:
Process the collected trace data using perf script:

   # perf script -D

This command:

1. Reads the perf.data file
2. Decodes HTM trace data using translation files
3. Displays human-readable trace output

The decoder automatically:

- Translates physical addresses to logical addresses
- Creates decoded output files for analysis
- Correlates trace data with memory mappings

Here's a complete example of collecting and analyzing HTM traces:

   # Step 1: Collect trace data
   perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 5

   # Step 2: Verify output files
   ls htm.bin.*        # Binary trace files
   ls translation.*    # Memory configuration files
   ls perf.data        # Perf data file

   # Step 3: Decode and view traces
   perf script -D > decoded_trace.txt

   # Step 4: Analyze with perf report to see the hot logical address
   perf report

Thanks
Athira

Athira Rajeev (8):
  tool/perf: Move auxtrace_record__init for powerpc-vpadtl as separate
    utility
  tools/perf: Add CONFIG_AUXTRACE support for HTM pmu on powerpc
  tools/perf: Add arch_record__collect_final_data to collect additional
    data before closing the event
  tools/perf: Add powerpc callback support for
    arch_record__collect_final_data
  tools/perf: process htm auxtrace events and display in perf report -D
  perf tools powerpc: Add HTM trace data processing and decoding support
  tools/perf/powerpc: Add event name as htm of PERF_TYPE_SYNTH type to
    present htm samples
  tools/perf/powerpc: Add logical address in decoded nest traces

Tanushree Shah (1):
  perf tools powerpc: Add physical to logical address mapping for HTM
    traces

 tools/perf/arch/powerpc/util/Build      |   2 +
 tools/perf/arch/powerpc/util/auxtrace.c |  87 +--
 tools/perf/arch/powerpc/util/htm.c      | 116 ++++
 tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++
 tools/perf/builtin-record.c             |  29 +
 tools/perf/util/Build                   |   1 +
 tools/perf/util/auxtrace.c              |   4 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/event.h                 |   1 +
 tools/perf/util/powerpc-htm.c           | 883 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  25 +
 tools/perf/util/powerpc-vpadtl.h        |   1 +
 tools/perf/util/record.h                |   4 +
 13 files changed, 1177 insertions(+), 73 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
 create mode 100644 tools/perf/util/powerpc-htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

-- 
2.52.0


