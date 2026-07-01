Return-Path: <linuxppc-dev+bounces-23282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD9CC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthb2Lsrz2yQG;
	Wed, 01 Jul 2026 18:38:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895119;
	cv=none; b=Fhdxy+TNQ9Jd7XaLhRwKmFyRJYZ1xVtrOeKmxtH3aMDezdEsdVlkSHyJbFHusWraFS4btaCChE5PHKVm4jpFUsL0el70EChlvXg/nBbZWM2Vyb4kWmeE11KazCDGydkKC6gaKa+yVl+NONRM3qKzrE9xq1Mg2ApvH3ivLQU2UFboTrz9RWMl4A0MVLqHFWi4c0BHhvw1vROD4v4Whz+gOohQ6NT9eZ15YTZLBbg3IsW1PAITNmTjYbfp55Iwck/yXKo8qYJSFnWZSODZb4vAyVjhooCmpZbORhR8GYMjOygfWhW+7WVDrWWUPx8fWNhTxW77vGtXi0TVI4SD614Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895119; c=relaxed/relaxed;
	bh=BSgl7PLrr/JDH1QT/ir6QiMm/XUWSwjWttTLzKL2Vfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qyk+WiQCeeAL4fO7V2mhR6lFy59xMv/rei3TdKqXyEeL4XPyE2/7TuqoZ4iCKIKBUtH+kHSkNhro9WA2Jpfpi2Z5qmlhuqH/nZuGSRXiysqAAsX+dNjiHG9LBFYk9XI3p/PevpIEroSX7PgEXtRW5OCDOyqd1PoRB+TMxFMRwv411KlX/u2t49aDeC8P5zgvEtFTjdllzU82w3vLrnkZL44sSdgaH+YXp3uhNNtWyiNzloFjgHk5qB/ci0dR6aZEIPZ8ME3sXcNW31LMMz+xwJTJj2GQQ0okFyohCRuzs5whIpRVVhADd/b9NpZTlXEGvGHg39xu954mVihNVXHR2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LbwGJIso; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LbwGJIso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthZ3ScCz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:38 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618Ihkw236538;
	Wed, 1 Jul 2026 08:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BSgl7PLrr/JDH1QT/
	ir6QiMm/XUWSwjWttTLzKL2Vfw=; b=LbwGJIsobv+Gg4Ndh6dQghV1letpkoxdB
	JMaG6kNZ+od1Fz1pLQRSvFQ4gRH9kr87YaJgvuxEKyRQCg/iaagVFcwn45gKsD55
	p8cuL6u427Cu65vPGFE4zGXrGd86LtLSGdhDi9d9xWM+tVQf6MY8smbXHv85LLVd
	FIsyGv9HtC0MUxkCdxzrQacA5C+LMCmJDqOjLMR0BIx3cUjds266o71lHOrJ2kv6
	vqnLCugBzZfNeLjx5yW3K37rTtDRzZiwumRwtcC/a3WlhXWwKWrOOKsFTD3wT0pn
	kigFHihJdqA8ExJWbkiaJQJIVD6xa0AGPB1C/DLP6TOmkfxm8V1lA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa34y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YcRe001241;
	Wed, 1 Jul 2026 08:38:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhec77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cTRl15663430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AA020043;
	Wed,  1 Jul 2026 08:38:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 396B620040;
	Wed,  1 Jul 2026 08:38:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:26 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 5/5] powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU
Date: Wed,  1 Jul 2026 14:08:06 +0530
Message-Id: <20260701083806.79358-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701083806.79358-1-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX5R1sJn0lVzKp
 5eH1F5gf8AB8ALMz7TPCKBHsLADewpKdbWqVbCDuR8EfcCHWGIfBRPUPeuAsHMFicexIB7CrlR5
 I4/12Tzp6lHIgeSjxoXqZdA2CDwZQ/D7KsyjW97ZrYaTobGobJtUETiXRpOwD+cvlKGdaU96kCE
 Lo/u+8r0SCiPH/EX6j3zhniPfw94rQrN/H5hK63xpgIF8J/c0rcY7imIzWnavj18gfXQjgP5B08
 BTpRhdQmwAPfk0sUz6JywTBfi2xlwCRFVdhtfkZIWJPbvponPfosCFIalOgioQkyy5Jlm2m0Y2u
 1h0Zc5beN0a2Q5FlpW9HDqO558mfBtIZ1M3PYr24AwMczNbYWFbHSr/9H+KJ6hZsn8Id3SvV9QO
 p/ZLTaYmeFKDHL+Q6tu0XnCBQePZ+KRYXVQeRDwXOVXCnwYEGJTW4pgTFplmiRvF8y1lUISZI2p
 uSAz4DlWIMz0EGoFC9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX3z52JvPJ6PXR
 reI89e/1CBBUPXIhulmB2HLXYPk8tBfCrwFQki629gCuocjZRAGo0YrxCBs2upE6Eb8O00JbOea
 dZUuvbG2VK3qV50S5RpvDS7HaiFyN2Y=
X-Proofpoint-GUID: sdE5UUSvf7iofBAZtMokpIKSvU0T2Yi7
X-Proofpoint-ORIG-GUID: sdE5UUSvf7iofBAZtMokpIKSvU0T2Yi7
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d20b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3QFRbl6HKUXxl1ZSCyoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084

Documentation for htm (Hardware Trace Macro - HTM)
PMU interface. And how it can be used to collect the HTM traces
entries in perf data, how to process/report as part of perf report/perf
script.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 Documentation/arch/powerpc/htm.rst | 137 ++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/powerpc/htm.rst b/Documentation/arch/powerpc/htm.rst
index fcb4eb6306b1..f9dceffb93c6 100644
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
+Where:
+
+- N = node index
+- C = chip index within the node
+- R = core index on the chip
+- T = HTM type
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
+Trace Data Processing
+---------------------
+
+Process the collected trace data using perf script:
+
+.. code-block:: sh
+
+   # perf script -D
+
+This command:
+
+1. Reads the perf.data file
+2. Decodes HTM trace data using translation files
+3. Displays human-readable trace output
+4. Shows instruction addresses and execution flow
+
+The decoder automatically:
+
+- Translates physical addresses to logical addresses
+- Creates decoded output files for analysis
+- Correlates trace data with memory mappings
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
+   ls htm.bin.*        # Binary trace files
+   ls translation.*    # Memory configuration files
+   ls perf.data        # Perf data file
+
+   # Step 3: Decode and view traces
+   perf script -D > decoded_trace.txt
+
+   # Step 4: Analyze with perf report to see the hot logical address
+   perf report
+
+
+Benefits of using HTM interface
 =======================================
 
 It is now possible to collect traces for a particular core/chip
-- 
2.52.0


