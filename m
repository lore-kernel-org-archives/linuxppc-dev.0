Return-Path: <linuxppc-dev+bounces-24476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB22BC44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:46:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ccK0pf9z2yYK;
	Mon, 20 Jul 2026 20:45:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544337;
	cv=none; b=N+gw4EiN44R2MF/n6+TNyRJOU7m46K8leE+FYfqJ98aBq7+PYQWvueb3UDti9ojrplIrtYRgFutjOXESOOw+1oAYW0Roz/FuVUaGn+2RHXSwfrH3fuCBE7Q2WUrS6g/s0W/dSFVjgvMvqWU65EbVc8WLkFdNC7HcwW9yQaclquwFYnAqd+IGlqovKt4t4lSGYE8x9AZPp0AOo7SkAW8OA17EhHka1EHM/y8vJV/ekBFRw+0mEAB3kQBbCtOz4eJYv3oUX7jeLtZSSUxIAiS1OpzGNNy/KHEfbZhTmwepZZ1lxj9C04jkwMtlC0jjfyqWN8Tbps5zCi4iAxVwbHqSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544337; c=relaxed/relaxed;
	bh=Gv+/g7SrsGXI1V8yGBiRVmIVtOiizCIur94gNwv7p9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR94EYyVrP7CARvFixOkGDovpz6TRWrsdKX/6kFKE1G9/jmmuG4mfo63GZizXeJdAiQJfUpe2nQ7r/RubDm2+RKfCyXvcJk2Wb7GmjDpa3mCC/cBnjUcjO86p9JVCHthrHdVX6r0glpW1eFa48LvfbCgyTuQNbgy/d2m5IYdpB5KtVKxJWMknHYkCmJ+eBntMt6HrFV7tyA1na83RluzeanFSEz/maN3Yc9wp0Rcv3hUPa9rTohMBhvnH+10DelbPWE+qZXOtneBOQ1r+c2Y0dLHKF1J9gSS265XLtzPz4CH411IJjlyRT/X9iENDw8DKIxAlenDyzx/4A328SNS2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Af4OF7iY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Af4OF7iY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ccH3jzWz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:35 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABmV1026683;
	Mon, 20 Jul 2026 10:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gv+/g7SrsGXI1V8yG
	BiRVmIVtOiizCIur94gNwv7p9I=; b=Af4OF7iYv6eaznnQF/O4hTYoMbznG8WNf
	HGHAiGIrRj8OQ2oZAYUhRzSAcQ0q4eg2URpCZ3+3PcU+kE436ezEsrDAdbNj/GUs
	svUNoystb5GSNIlBZ2G4pOmDkZ6F/4oQUGkft7ZIW1fUCbClzFeOKTe0WZpvGxzr
	9Ii1vIuXNlS21Y3PyI5WlN5OnwPxbSqbDFdtb1+JWZKqqFaTt3iE5V6VXuBg2bFa
	0Q/SOL/2UTJG2XEIxgsKl4J8hbK6pQskaLRZWArr8fWd99h9gW4Ro/mtDgC8S4ge
	WhKXYww9j7AsdDlbxvtvO2F1c78ick/js+QJ5lHE3GIKBKF9vOmqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a70ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYcJx012962;
	Mon, 20 Jul 2026 10:45:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g510w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjQTH45089078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D117A2004D;
	Mon, 20 Jul 2026 10:45:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F9D82004B;
	Mon, 20 Jul 2026 10:45:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:24 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 6/6] powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU
Date: Mon, 20 Jul 2026 16:14:47 +0530
Message-Id: <20260720104447.11843-7-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720104447.11843-1-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NMK2QXEIag3ySOXFeMY2e_6SpVz8II_S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX5v8hGQs1huxC
 oN3DJET+PFQOtR2fYPCpAWLqQLsq6ReTTG/qqHaWhgQfvpBqXtq2Zv2X5AKcXEB0pRYatLbDb2w
 KP+Z+6iMLSNyfrQeeltQSW/xHgkCd3Y=
X-Proofpoint-GUID: NMK2QXEIag3ySOXFeMY2e_6SpVz8II_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX0DbADXhT+Ps5
 g2zTZh3xrSY0ffMnNi/QomVp7VaDxZoIQDKaenVM2XvUrekRh/f6odydyvVtMYBcdHJBdZxDO5q
 RPU4NeYivTqnSbHqnWps+d5vxvcHmZCAApdGK0tb/XRnNCPEhySMQLhIz57bEdehhvZ/Ru6kIeo
 EkKrD+e/pnn62dw4DmPRs5WtCYWkcPZCXAw5lCd86g1gGjMWdFzLXb3U5f49VuP8TUW2mz12apq
 WZqx+r1bcCpuQqHLW+Y/iAg0ugkdROc0HAQxvkGphF8e12/AxIk/2BhwL/27WiEzQHgeJOWtunv
 1iBEkMyhffvD7oc7vRj2ZJK+HQ4Hm9VQC+u4SZ0rQGi7IurL92a/gaF8aRC66LNFsyQh5BwPFDR
 JhRD2+v25dwBUfiWQ5DIVmtBMdfkvcW/e6GYqiaT3UzlI4pmSiWUsQ1NkLhGqPGghTc+4gQEGiw
 yHYtslCk3tlLhPspr2g==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5dfc4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=s7G-bM8dSAMgO98M8CEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

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
    (-C N) and the one-event-per-target PMU restriction.

The existing debugfs interface documentation is retained unchanged.
A brief cross-reference is added at the top to point readers to the
new perf interface section.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Updated the usage with more examples
- Patch is now 6/6 instead of 5/5.

 Documentation/arch/powerpc/htm.rst | 137 ++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/powerpc/htm.rst b/Documentation/arch/powerpc/htm.rst
index fcb4eb6306b1..d574fd2225ea 100644
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
@@ -94,7 +95,137 @@ This trace file will contain the relevant instruction traces
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
+2) htmtype: specifies the type of HTM.
+
+Event Syntax
+------------
+
+The event configuration uses named parameters::
+
+   htm/nodeindex=N,nodalchipindex=C,coreindexonchip=R,htm_type=T/
+
+To open the event on a specific cpu can be specified using::
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
+- ``coreindexonchip=6``: Target code 6
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
+After running ``perf record``, the following files are generated:
+
+.. code-block:: sh
+
+   # ls htm.bin.*
+   htm.bin.n0.p2.c0 htm.bin.n1.p3.c0  # Binary trace files
+
+   # ls translation.*
+   translation.n0.p2.c0  translation.n1.p3.c0  # Memory configuration files
+
+These files contain:
+
+- **htm.bin.*** - Raw HTM trace data in binary format
+- **translation.*** - Memory address translation information for decoding
+
+Complete Workflow Example
+--------------------------
+
+Here's a complete example of collecting and analyzing HTM traces:
+
+.. code-block:: sh
+
+   # Step 1: Collect trace data
+   perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 5
+
+   # Step 2: Verify output files
+   perf report -D
+
+   ls htm.bin.*        # Binary trace files
+   ls translation.*    # Memory configuration files
+   ls perf.data        # Perf data file
+
+Benefits of using HTM interface
 =======================================
 
 It is now possible to collect traces for a particular core/chip
-- 
2.43.0


