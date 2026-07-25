Return-Path: <linuxppc-dev+bounces-24810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB3FC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:00:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6bNN4rJzz2ygJ;
	Sat, 25 Jul 2026 17:00:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784962836;
	cv=none; b=cZVqvmHkWTDLxLmkb2zaeN1sNi5k8+rH1AlHxf3Knhe7rsEJifcHsbeKdYkJLKOoVBMZ1YwTatoBYOI4HSv2NkccatVMgZffEblRiM+QymvB5Ju9wd2kBfPJj7aAVMjJttHXrShkDVpxFeenjzwZH/w8zUGSIBuj034dsVdhvyE0ZXS0vZcLt7dvYtO7SgJgQR5q6EholMkVFGaVIKGmfFKwmns1nTgeV4XA1IvEUn6KMoP2VRw2TcOyfmr/UgtznVF2nPUGw98IyIPBJmGair1c9cU0tVCeO16E/CYZe+qnpX0TYQXHQH9ke3VZG2U0eeBM2GWarrX6nNSri5gXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784962836; c=relaxed/relaxed;
	bh=TAbc+0KUKMduW0G4Ws33F9oJtE6kKp6K3iXTwbxkt90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA+kzNyFFIdQgqaAJi5KRLAPOXmCcWvrYSnHULkfHD8rAqARSI7Teogeir10E39QBdfPGmwKdPeBlDxvXwZX7Biui/R6rLSUyGaZZTP/iBy5gRmo117XnDiaYpXmGs1qum4GnDX8W7e7OjvQSE9wRv+4/CGddMGOBk3qozJJQ+ATOv/0A5Q+0U4XEo0UrIh42zeN3ELnJi/357NhNLRPeKH00TRt4S4buggMXQ+KL5z4tM6Pov1a8pjtmzeh3hYAMpC2iYp/pTjMFhm/KTAWL9V2xu+w1fbbMCdhaSHQrZkscQiyfKIInPLU4vFgUYHabSfXbIASzUKTNhL4rdCMXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=msnhbJ5g; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=msnhbJ5g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6bNJ31fyz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:00:32 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5BwZ53980213;
	Sat, 25 Jul 2026 07:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TAbc+0KUKMduW0G4W
	s33F9oJtE6kKp6K3iXTwbxkt90=; b=msnhbJ5g7jRtxfvbcgyZD/LKH8shD23Wp
	UEftMkBZiA0fmuahwafaJH5yWNi2ULLXFGTa6e95hW5KiMVzO6OUuyaVSd0D1s5E
	XUKNek1yH2GBzkzEZo2vmG71KcTALjNnFxZ9jjNhCZMplUpirvGdK5pGDIeybiE2
	oOF51U3dDl2fa+Q9Xx+h25JN7/h+wPUTRpSPNrLLXq0FqaZQ+5ug0VY7h7MKVyzL
	pK0QQq+JXKHIxef7pFUO/p9QY5EEs0DWt9TQZHmsHDi7uGGPw8WJsFNiG0IomwEX
	+XqDrOOmmuOn7Df+GHOhUCZzhv+/1SF6b9rT7VRY2KzH5ybAXlqrg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmst0hgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:00:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P6uWxK015593;
	Sat, 25 Jul 2026 07:00:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn1u0grb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:00:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P70N3C44499410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:00:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195122012C;
	Sat, 25 Jul 2026 07:00:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7372011F;
	Sat, 25 Jul 2026 07:00:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:00:10 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V3 6/6] powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU
Date: Sat, 25 Jul 2026 12:29:42 +0530
Message-Id: <20260725065942.78839-7-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260725065942.78839-1-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=COgamxrD c=1 sm=1 tr=0 ts=6a645f0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9lDVIUTEpXIqPQKb_LQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX3WkKu4srnsys
 xMQ/Ato7eu5XKnmZ9wBna+1/5oirxgC7144Yf67ndgvIW15354ohhArbUMKZm3t/3ArCFu4rqjG
 3hm51Ltl0GVq77ZqeRo9rdKE10svlPk=
X-Proofpoint-ORIG-GUID: EX42MpXr4PsoNtMwF7-sb5YqH6n42x6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX1eAoD0Wiqy71
 Rxi/p/jTm2P3KqbigsrZKhJ/NMjS7M3msHBJK4QfMF+5Db0IRHTqucu3oKFEaxTkuO1zi8OiRv0
 46OpaYSKZODSHOYFGL/KMkT/GGRYivuJbirjBAV1G8mDCIiyHA+p2zZxHme4Bc4FFxg7m+6DZAT
 fYnyE7ODfH0GnnKJRewuDJ3HSB7N/WmZ5BXByAR+ijJb5Enu5ir6/0YqxW5ZMHmRBeX3P0fBuAt
 eIko12JjbsL6hAxpf/DZhtW+p6UGv4BB/zow11SDsFQKw2fjhjAokk83W0FyafTd/arUu96ww4Y
 H0umHqitgD+I76g8W6I94a/sPXS4jjoVvylRDAGVMAT++B1RaXPefoYKsaK2rNut1lUHdMKoX0f
 bqzT2OhyMebNKupQodxsDVPGaYZZgpCyHfh6Ju2x+2mq+2+aAPCUxKK1imLai8S1IocnDM03fYt
 hvKP2yV+cotc+OxbQdQ==
X-Proofpoint-GUID: EX42MpXr4PsoNtMwF7-sb5YqH6n42x6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250061

Extend Documentation/arch/powerpc/htm.rst with a new section covering
the HTM perf PMU interface.

The added documentation covers:

  - How to open HTM events using perf record, including the event
    syntax (nodalchipindex, nodeindex, htm_type, cpu=N) and the
    required AUX buffer size (-m,256).

  - The two output files produced by perf report:
      htm.bin.nX.pX.cX     raw bus-trace AUX data
      translation.nX.pX.cX memory-configuration records

  - How to pass the output files to htmdecode for trace decoding.

  - Notes on system-wide collection (-a) vs CPU-pinned collection
    (cpu=N in event config) and the one-event-per-target PMU
    restriction.

The existing debugfs interface documentation is retained unchanged.
A brief cross-reference is added at the top to point readers to the
new perf interface section.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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
  two output files (htm.bin.nX.pX.cX and translation.nX.pX.cX), and how
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
index fcb4eb6306b1..15e7484f2836 100644
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
+- **htm.bin.nX.pX.cX** : raw bus-trace AUX data for node X, chip X, core X
+- **translation.nX.pX.cX** : memory-configuration records for the same target
+
+.. code-block:: sh
+
+   # perf report
+   # ls htm.bin.* translation.*
+   htm.bin.n0.p2.c0  translation.n0.p2.c0
+
+Note: ``perf report -D`` prints AUX buffer sizes but does not produce
+the output files.  Use plain ``perf report`` to extract trace data.
+
+Decoding Output Files
+---------------------
+
+Pass the generated files to htmdecode for trace decoding::
+
+   htmdecode htm.bin.n0.p2.c0 translation.n0.p2.c0
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
+   ls htm.bin.*          # htm.bin.n0.p2.c0
+   ls translation.*      # translation.n0.p2.c0
+   ls perf.data
+
+   # Step 4: Decode the trace
+   htmdecode htm.bin.n0.p2.c0 translation.n0.p2.c0
+
+Benefits of using HTM interface
 =======================================
 
 It is now possible to collect traces for a particular core/chip
-- 
2.43.0


