Return-Path: <linuxppc-dev+bounces-23277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF57C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthK72Vkz2xKh;
	Wed, 01 Jul 2026 18:38:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895105;
	cv=none; b=lMf8FGTGIhb0/HWahPrfA+jvSfbIpylWbUudo1PsFloYCkRpRC1kk/3JreWRU2M7IkOQvJMxTFf2wppSV9a1NsBS/8Ao5wevpfi+WJgkFJNcGqQKwUiDYCzrsWezxTDHyk/aGlSV1dK7+b/JIbC8TpDP3iEypzJhuNlzK7t4US87rXKKKRWcMTAwkKBNuKlepdq188K1T3UUxUKwhgDUuDWE9lA9VHALARn3k2hVcA1PqLeyGJSxz7DpPpwmMkaEq3/1iIQkwdJCAFdPgCmfjzzFZLWXXEVTCNTvLyMZNOomJnW44PZOdIyrFsqdV0UQfkdMGKRZf1aFQdYNEihsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895105; c=relaxed/relaxed;
	bh=J+CvJdff2sWrtqDlFKMu8o+BVEcNouBdxeKYclfqCKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1x4bXaDfDJb4pUH5c03SmnB0Ulx7fgqv3devX7xT/XTx1GM3yH6Y5h3Fizy2GcaoaSJK2Y9mqA9LTzOCfEgINue0TJuUVL/+/p+MZ40V0/Pv8l/UcLX24/N+b2ONFATyPgXRZrPjwsXYlfRF91cTavCwd/hQ43FMnCiLVv8sT4g00enU7Mxd0OtU0BE2psSvsuxInMmuMwTz1rTxsySk51axNBEZ45anwZ7n9S9qPQeLjqEp+6FO+hHRAIpW6axGc3DdSLVJMMNoZFtAY54YcMDJnK/ju31tnOorNezw6dyYnOnZP4Jz3/OFg2tQZ+mEQEd3I02faH+8o8NhXS7+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nwUyiJ4N; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nwUyiJ4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthK0HN7z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IU7a194502;
	Wed, 1 Jul 2026 08:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J+CvJdff2sWrtqDlFKMu8o+BVEcNouBdxeKYclfqC
	Ks=; b=nwUyiJ4NA7ddr1715l6gV8sl4sbX7LO/QPXqVxS5BD2wXpN4zCct9+rl7
	B5mgKwbHLQV9G9l8a9BY/3N29dlaw3Sgy8jL4oaAUprGDtdDryaV9+oToOjsq7VG
	+YnWWe3lEt+qFT45QkuuQ8f56cYs9q/bjerCdz18wIUgtx7w5f2LZQPLK4PB5WiP
	5KCafyVCx9wI60cLZi9AaIDlqcNsVmBcTJ9ApuXcNSonPNHa4omj+ndX3Eqr+qfr
	cdoLsjeSxGEYBAst0lp+z6XJzDVkpCL6II9xSP2PBOfXeDGqTPtpW/LWFB8PK/J6
	bZBUZ1iSJf7GcxbGIakbNvc86z7mQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mju5k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Z12Q002752;
	Wed, 1 Jul 2026 08:38:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhec6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cF8728377798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B534D20040;
	Wed,  1 Jul 2026 08:38:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3D620043;
	Wed,  1 Jul 2026 08:38:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:13 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 0/5] powerpc/htm: Add interface to expose HTM trace data via perf
Date: Wed,  1 Jul 2026 14:08:01 +0530
Message-Id: <20260701083806.79358-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfXwpdU25//vHFG
 2LHf1/DnJd/w/pzzG5kbPO8m1OiDYOAz9gyjcd34TSiLsxdNPqshMHFRIbDwJJIbsdYavxDGOc7
 KdoCKMgtRKW9zXPN7UiF1s0hnwhCoq0UCVjizLX+WySuzidXgd8rdOJN3RNGMBvCxZaOsVi5z6s
 pbICaeofUDEFVrrybnLzoxwvrpZyNeXsgDj9ifscNLTN6OyW5miUu7zOZbhGGhs+vn1Ble0Daje
 rYzWsQw3Oi7uXREwTlpljgVrfAvWr/Tj6oIG99K8QB5malAZBxux+aIWSFaq1rnHrIFmBRV/6nM
 f8lzegVu1+XcDCpXIy3l8lRz5PEGtev1qYmmukeeFnOYfRbtoBqbQ82vVvLYXDwH6mBowpdVqUZ
 S9FxgMnT0UgYYnLY3Icpp/owvdsvqre3ZuJH0wjwg7BuhXPwUDi5Lo1F6VudSWrCUsOk+OmZClf
 BYBKLur5YUB060a7HQg==
X-Proofpoint-GUID: hyUxgpI7IEgnvCTGtVxFo5iZ16ISXHDK
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a44d1fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=nF1dRtf8y8upiNnS95YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX8INk33TB61TV
 zDK37tH5ARP8UG2lseeVu01KYOsiaoRx6oDFpchzKvNy3gBW/nc4KaAQtBgd0IrB4HRxfUL647f
 JeHoqM1ezlf43FY1AOfwI9B44w6msyM=
X-Proofpoint-ORIG-GUID: hyUxgpI7IEgnvCTGtVxFo5iZ16ISXHDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
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

Patchset includes powerpc kernel side changes.

Patch 1 introduces the HTM PMU interface with event configuration
support for specifying target hardware (node, chip, core) and trace
type. It integrates H_HTM hcall wrappers for starting, stopping, and
controlling HTM trace collection.

Patch 2 implements AUX buffer infrastructure by adding setup_aux and
free_aux callbacks, enabling perf to allocate and manage auxiliary
buffers for HTM data.

Patch 3 extends trace collection to capture system memory
configuration alongside trace data, using PERF_SAMPLE_RAW records to
mark data boundaries in the AUX buffer for post-processing.

Patches 4 and 5 provide comprehensive documentation for the HTM PMU
interface, including ABI documentation for sysfs attributes and
user-facing documentation with usage examples and workflows.

perf tools side patches will be posted separately in the linux-perf-users
mailing list.

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

Athira Rajeev (5):
  powerpc/htm: Add interface to expose HTM trace data via perf
  powerpc/htm: Add support to setup and free aux buffer for capturing
    HTM data
  powerpc/perf: Capture the HTM memory configuration as part of perf
    data
  docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event
    format entries for htm pmu
  powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU

 .../sysfs-bus-event_source-devices-htm        |  21 +
 Documentation/arch/powerpc/htm.rst            | 137 ++++-
 arch/powerpc/perf/Makefile                    |   2 +-
 arch/powerpc/perf/htm-perf.c                  | 571 ++++++++++++++++++
 4 files changed, 727 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
 create mode 100644 arch/powerpc/perf/htm-perf.c

-- 
2.52.0


