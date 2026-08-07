Return-Path: <linuxppc-dev+bounces-25594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDC9C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwW4vZRz3c6c;
	Sat, 08 Aug 2026 00:38:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113499;
	cv=none; b=ZDfN3H7aQ7VKVdNRNPy7KWyaYJp0Y3uS1rIk1bF/mxEJYR69AEmwLCTAoUTZ32mxz5x3VKX5AVwtTPe0oickwAi0xMet/Aet24IRMASss0PPXdOEMmxzM4HEiuN2IVwNWHcRTpGPRlbZ5Gv/sk9mTMoil39ufe+GAc3t7ik6MsRGfNog1zYKV1c1vA/Ts/LA1uHKRERzIioClPqz033rUTZIii4DCC2Gw61+pWlJx1B/OyvpH5IRCOj/Ul/hJQZC0tplWF88/rudXQVHk9XnTiiKiOFw+0d/JJF2RNR6NvRoqzF9NrnSpt+6PtTiMryb3J+RllETEtXYIywTurvhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113499; c=relaxed/relaxed;
	bh=f1+uuI7eB3YtBcrV8BPGBNuMSiRxVs2CXQr+l1RsAWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9+JXspvg+7oXF3beTPMoT/VIQinG7sBlbiI1GRLSwJupicdv1SeUFT01FPQ/gosiCbUQlObWHie7LJ4UKOGqCAo1hqtfBqsw07p6xq3yQCDKDnS33lf8xphF0r0ZKowccWyE+yatlkN0UCRKLBf0ooemO8cTFFpPyEXjZO+otIIYkM04FqztesR6HnkKQZGfHz1vh9a/KZ6Capm2RDCiTdrUrpsAwyHxQWzDH41+KLVHwDNZzxGiiTsjA1638bbAYnGCPzdJlxmQsZzEeQgGo7O4pACJQIgt0wSArerKNoML7YcFxyhsAoBJzESC1mPgpT8ziSkqSQE+fh5M/sW7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ig9IW4GX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ig9IW4GX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwV2zltz3cPL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:17 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Clg1D1485123;
	Fri, 7 Aug 2026 14:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f1+uuI7eB3YtBcrV8
	BPGBNuMSiRxVs2CXQr+l1RsAWI=; b=Ig9IW4GXhrHYpmy8nqFyTDfEraDu62R+8
	9yVTKTz1aqQ8UQlElbsplTxIXxRZbIKbn+T7NLeYbxKPKAM165BhRwEzxyX7xoYQ
	LlZC80wkAY4CPxFg5rF3p+niJTXYjAZ5xjft09pmW8D3MkK9Vk0lAc69IHQ8jgS/
	mwJx5ClbfyQlTvzp9dS1eqOwOcHlVhQe66VPYzV4+qM8+7/AZU0WSCF1PLgvO7Ke
	669G13qM03LkdYcGIzhw+DsYbIPaohjeDsraanMTjrUyRWWi8p3FugIsOUEAHVrS
	6DEGY17lAdL8Hr2SmoyBLxvfuqktgSTwSc8Tf3IbI/hOloveW3uaQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy044bqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQKKI010865;
	Fri, 7 Aug 2026 14:38:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kg2sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ec9Pe42467626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:38:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E854A20043;
	Fri,  7 Aug 2026 14:38:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D7120040;
	Fri,  7 Aug 2026 14:38:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:38:06 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 6/6] powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU
Date: Fri,  7 Aug 2026 20:07:34 +0530
Message-Id: <20260807143734.1224-7-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807143734.1224-1-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX6NrS8+XmSbQG
 ZYE/BNx9C/HiI2HDafaLM54uvzJblZeTqU8oh+X4LSUxzhSlXJzGr9oN0HYkoJNzsPVoYypaeaK
 MY5BdHL20auAUvnYyEeNUUeb7v8fMKLEujc+cZGSfasT8xvIeVENeHW/09LbVlWTFQ8YN4xcB4B
 YopYVBcjy3gJaozTvt+0gFS1yookqcb3Z8S8q+kHtLkBXZMxQov+sSlWy4iKegbWhLzFQCInGQj
 F04f69BeKTJUdXqRaJ7z6HZyc0p3KDJNNrRyl8FzLCKCOCSXGf2JRvGLKwLgEN000naXADRnCZB
 2hjB2AU4/1mxUAEGiwAUg5ZZEAuern0JEQG9PLQm3QFVEnC7KJlySP5bhw06r9x+Dq1Ad7cfHU2
 vR6ReMBmJWlGBLRAZaOpBpE7B7+7c7XqU8QyZdXwf0WOIMPjTy09XztMyV8OjlVj9gZwj1mlx1r
 Ou/uxHAbneOTKHDyHRA==
X-Proofpoint-ORIG-GUID: eTC_wuxD-wpudRi72oAZJIlJDYokCLRa
X-Proofpoint-GUID: eTC_wuxD-wpudRi72oAZJIlJDYokCLRa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX9AggmMV9JZfK
 6Ep+T4WfoUaez2rGeiFflRCowyysm3oky6teBIndPyG4S75ta2rguG0tuwRxPq0FmsLbgxtpxEe
 fn9fiMgTBnn8TEZq1KFFggw0H5k51DM=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75edd7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9lDVIUTEpXIqPQKb_LQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Extend Documentation/arch/powerpc/htm.rst with a new section covering
the HTM perf PMU interface.

The added documentation covers:

  - How to open HTM events using perf record, including the event
    syntax (nodalchipindex, nodeindex, htm_type, cpu=N) and the
    required AUX buffer size (-m,256).

  - The two output files produced by perf report:
      htm.bin.nX.pX.cX.tX     raw bus-trace AUX data
      translation.nX.pX.cX.tX memory-configuration records

  - How to pass the output files to htmdecode for trace decoding.

  - Notes on system-wide collection (-a) vs CPU-pinned collection
    (cpu=N in event config) and the one-event-per-target PMU
    restriction.

The existing debugfs interface documentation is retained unchanged.
A brief cross-reference is added at the top to point readers to the
new perf interface section.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Update all output filenames in examples to include the .tX trace-type
  suffix (e.g. htm.bin.n0.p2.c0.t1, translation.n0.p2.c0.t1) to match
  the new write_htm() naming scheme that disambiguates core HTM
  (htm_type=2) from nest HTM (htm_type=1) and HTM_LLAT (htm_type=3)
  targets that share the same node/chip/core coordinates.

Changes in V3:
- Fixed "After running perf record, the following files are generated":
  htm.bin.* and translation.* are written by perf report (which runs
  powerpc_htm_process_auxtrace_info), not by perf record.  perf record
  produces only perf.data.  Corrected the Output Files section and the
  Complete Workflow example accordingly.  Note: powerpc_htm_process_-
  auxtrace_info() is implemented in the companion tools/perf patch series
  ("tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
  records"); the documentation is written against the complete two-series
  feature, which is standard practice for kernel+tools PMU submissions.
- Fixed "perf report -D" in the workflow: perf report -D only prints
  AUX buffer sizes; it does not produce htm.bin.* or translation.*.
  The output files are produced by plain "perf report".
- Added the missing htmdecode usage section (referenced in commit
  message and V2 changelog but absent from the doc body).
- Added the missing PMU restriction note: the HTM PMU uses
  PERF_PMU_CAP_EXCLUSIVE so only one event per target (node/chip/core)
  is allowed; a second event on the same target returns -EBUSY.  Also
  noted that cpu=N in the event config is the supported way to pin
  collection to a CPU, and -a without cpu=N causes -EBUSY from the
  kernel (HTM events require cpu=N since the PMU operates on physical
  hardware addresses, not per-task context).
- Fixed typo "htmtype" -> "htm_type" in the config description list.
- Fixed grammar "To open the event on a specific cpu can be specified
  using" -> "To specify a CPU, include the cpu= parameter".
- Fixed typo "Target code 6" -> "Target core 6".

Changes in V2:
- Added a new perf-interface section to Documentation/arch/powerpc/htm.rst
  describing perf record usage, required AUX buffer size (-m,256), the
  two output files (htm.bin.nX.pX.cX.tX and translation.nX.pX.cX.tX), and how
  to pass them to htmdecode.
- Added notes on system-wide (-a) vs CPU-pinned collection and
  the one-event-per-target PMU restriction introduced in patch 2.
- A cross-reference is added at the top of htm.rst pointing readers to
  the new perf interface section.
- The existing debugfs interface documentation is retained unchanged.
- Patch is now 6/6 instead of 5/5.

 Documentation/arch/powerpc/htm.rst | 158 ++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/powerpc/htm.rst b/Documentation/arch/powerpc/htm.rst
index fcb4eb6306b1..42ad9924a7f6 100644
--- a/Documentation/arch/powerpc/htm.rst
+++ b/Documentation/arch/powerpc/htm.rst
@@ -18,9 +18,10 @@ H_HTM is used as an interface for executing Hardware Trace Macro (HTM)
 functions, including setup, configuration, control and dumping of the HTM data.
 For using HTM, it is required to setup HTM buffers and HTM operations can
 be controlled using the H_HTM hcall. The hcall can be invoked for any core/chip
-of the system from within a partition itself. To use this feature, a debugfs
-folder called "htmdump" is present under /sys/kernel/debug/powerpc.
+of the system from within a partition itself.
 
+To use this feature, a debugfs folder called "htmdump" is present under
+/sys/kernel/debug/powerpc. Another interface is via perf.
 
 HTM debugfs example usage
 =========================
@@ -94,7 +95,158 @@ This trace file will contain the relevant instruction traces
 collected during the workload execution. And can be used as
 input file for trace decoders to understand data.
 
-Benefits of using HTM debugfs interface
+HTM perf interface usage
+========================
+
+The HTM (Hardware Trace Macro) perf interface enables collection and analysis
+of hardware trace data from PowerPC systems. This interface allows users to
+capture detailed execution traces for performance analysis and debugging.
+
+Event Configuration
+-------------------
+
+Use ``perf record`` with the htm PMU event. The event is configured using
+named parameters that specify the target hardware location and trace type:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 25 75
+
+   * - Parameter
+     - Description
+   * - htm_type
+     - Type of HTM trace to collect (bits 0-3)
+   * - nodeindex
+     - Node index in the system topology (bits 4-11)
+   * - nodalchipindex
+     - Chip index within the specified node (bits 12-19)
+   * - coreindexonchip
+     - Core index on the specified chip (bits 20-27)
+
+- event: "config:0-27"
+- htm_type: "config:0-3"
+- nodeindex: "config:4-11"
+- nodalchipindex: "config:12-19"
+- coreindexonchip: "config:20-27"
+
+1) nodeindex, nodalchipindex, coreindexonchip: this specifies
+   which partition to configure the HTM for.
+2) htm_type: specifies the type of HTM.
+
+Event Syntax
+------------
+
+The event configuration uses named parameters::
+
+   htm/nodeindex=N,nodalchipindex=C,coreindexonchip=R,htm_type=T/
+
+Opening the event on a specific CPU can be specified::
+
+   htm/nodeindex=N,nodalchipindex=C,coreindexonchip=R,htm_type=T,cpu=x/
+
+Where:
+
+- N = node index
+- C = chip index within the node
+- R = core index on the chip
+- T = HTM type
+- x = CPU number
+
+Basic Usage Example
+-------------------
+
+To collect HTM trace data for a specific chip:
+
+.. code-block:: sh
+
+   # perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ <workload>
+
+In this example:
+
+- ``-C 1``: Collect on CPU 1
+- ``nodeindex=0``: Target node 0
+- ``nodalchipindex=2``: Target chip 2 within node 0
+- ``htm_type=1``: HTM trace type 1
+
+.. code-block:: sh
+
+   # perf record -m,256 -e htm/coreindexonchip=6,nodalchipindex=0,nodeindex=0,htm_type=2,cpu=16/ -a sleep 1
+
+In this example:
+
+- ``cpu=16``: Collect on CPU 16
+- ``nodeindex=0``: Target node 0
+- ``nodalchipindex=0``: Target chip 0 within node 0
+- ``coreindexonchip=6``: Target core 6
+- ``htm_type=2``: HTM trace type 2
+- ``-m,256``: specifies number of mmap pages
+
+Running trace collection for multiple targets:
+
+.. code-block:: sh
+
+   # perf record -m,256 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=8/ -e htm/nodalchipindex=1,nodeindex=0,htm_type=1,cpu=9/ -a sleep 1
+
+
+In this example, trace is collected for two events on different target chips
+
+Output Files
+------------
+
+``perf record`` produces ``perf.data``.  Running ``perf report`` on that
+file invokes the HTM auxtrace handler, which writes the output files:
+
+- **htm.bin.nX.pX.cX**.tX** : raw bus-trace AUX data for node X, chip X, core X
+- **translation.nX.pX.cX**.tX** : memory-configuration records for the same target
+
+.. code-block:: sh
+
+   # perf report
+   # ls htm.bin.* translation.*
+   htm.bin.n0.p2.c0.t1  translation.n0.p2.c0.t1
+
+Note: ``perf report -D`` prints AUX buffer sizes but does not produce
+the output files.  Use plain ``perf report`` to extract trace data.
+
+Decoding Output Files
+---------------------
+
+Pass the generated files to htmdecode for trace decoding::
+
+   htmdecoder <decode_options> htm.bin.n0.p2.c0.t1
+
+PMU Restrictions
+----------------
+
+The HTM PMU uses ``PERF_PMU_CAP_EXCLUSIVE``, which enforces a limit of one
+active event per target (node/chip/core tuple) at a time.  Attempting to open
+a second event on the same target returns ``-EBUSY``.
+
+HTM events must be pinned to a CPU using the ``cpu=N`` parameter in the event
+config.  Using ``-a`` (system-wide) without ``cpu=N`` causes ``-EBUSY`` from
+the kernel because the HTM PMU operates on physical hardware addresses and
+requires an explicit CPU binding.
+
+Complete Workflow Example
+-------------------------
+
+.. code-block:: sh
+
+   # Step 1: Collect trace data
+   perf record -m,256 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=9/ -a sleep 5
+
+   # Step 2: Extract trace and memory-config files
+   perf report
+
+   # Step 3: Verify output files
+   ls htm.bin.*          # htm.bin.n0.p2.c0.t1
+   ls translation.*      # translation.n0.p2.c0.t1
+   ls perf.data
+
+   # Step 4: Decode the trace
+   htmdecoder <decode_options> htm.bin.n0.p2.c0.t1
+
+Benefits of using HTM interface
 =======================================
 
 It is now possible to collect traces for a particular core/chip
-- 
2.53.0


