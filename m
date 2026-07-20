Return-Path: <linuxppc-dev+bounces-24474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C6C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ccC0Hpyz30F0;
	Mon, 20 Jul 2026 20:45:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544331;
	cv=none; b=m5JdNQLuKfFxJGQd4fnv+0G3ObkVmXp/Q/yf0rJPoKNTfpMwy4bjQooNln0SijDkebQtSZYQdarIb8HwCQRBggEf7aRpQVtZVMeN5zCzbEjqwTrf/uoggNYNA6x0s5COaPlF5Fm4TZV/ELvQ4TmmWoxndC6kYPimeUXaqFyQc4TlHnaT1JiILeASYx2nWSmIvYtIq7JbMDOxAfTFCmk7jpvE4U93L82F1cCUGJd/U6LulfMVdaCgGCoCER0DH6ArmuTGaAPpIUrBkUEQCwukqoF7nhFTd8QxEcRugWI3+H7Zee+ymjQryV13ViJ+YKkgRSA3pInsmwEY5dJ9YTY85g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544331; c=relaxed/relaxed;
	bh=nPcODKq99gWQbliMM+FmWm/K14s3WEtk8c992vW07d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERd9miETz+e1IT1HsYGlMmekqBNucHMCtpdUBFUtrNP1/SnY1qf81mrn6Prv4GaZCnoYO2lbpwYNULMwOmkngSPb0ey3aiLPwWdU98dr7t+ggW/IEUQjCNLonU6HV+jrrSfAa/u9Xd0Edz00OIkdTcjTenBa+IeAleeRqn5J7joJOMMESKk1YIshuO/ik0VM1rDBnLBXf6i8hI+q9jsKBgoB2ezteMT3TRjaM/WWdVELv1ZSwtjGARLrM7QoTpMHWiTyptxLldmnX9DPSY0YK/NgHN+FNP0QyOAG/e7c/OAm4PUOXiGWCNEBkiWEbhoXvYBlG56DE0SMHpLzg0mrcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JsxV/u6q; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JsxV/u6q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ccB1Grpz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:29 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KADHMe1815064;
	Mon, 20 Jul 2026 10:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nPcODKq99gWQbliMM
	+FmWm/K14s3WEtk8c992vW07d4=; b=JsxV/u6qcVfUXsbFY5dbEW5y3QAqHeNut
	E/roHGQrpJQaJ14hhrw2t+0rp9+3ppmQQlOgIdRKjFqEa7uEG1CtyddBLHmnvh/N
	bi/4B4HkcYlYcpmuDJuNqyV73yf84nU3CfkhkodwR+sywv1OscL6d+8L2M2vduwQ
	RJ+aQIUG0XggNsWN4Cb+JTue+GBT15mryGbpoRZl5bDMcXfxFhKd5OTFPfpnaiii
	ypjXENVKDfhT4UVtMf8X3B7b1AMLDOvuzE7kishKMYnsvqvEFmsOFgyAfsybAZPo
	4DqBcm26mz1jY47P7vA1810YG4AhTSo3ekyi2ySw58VVC+lWueiPw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxrev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYeWq026309;
	Mon, 20 Jul 2026 10:45:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4wsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjLs057016720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4953E20040;
	Mon, 20 Jul 2026 10:45:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE9662004B;
	Mon, 20 Jul 2026 10:45:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 4/6] powerpc/perf: Capture the HTM memory configuration as part of perf data
Date: Mon, 20 Jul 2026 16:14:45 +0530
Message-Id: <20260720104447.11843-5-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXwkhD097CDwn6
 dtmYufX4o23VSHeKIzskthuUBrGM9+Vy3yL1xa94Pa5O++aYSgtfQsCa6TIakmCsU+nH7/r0QDR
 fHUYgC5gcRJlZfksS4MFUEWOalurJ6EtPHDce9W/jBpqNBi3FdGnCd+0idJmW4Vk5fsG1CPEjhC
 612MaSBqIaw4IkSudQMaoci8awqlePFuK/wGMM81WbpkO7a5HBU06QfVRGwF/o8FtwRNy8YyKEA
 /G1wix+DO6Qsq8IUW+WJvK1BTg02AN+6Eiv8Qj/1ILIeLujcWVePRt0ZgqbWIOg6oLFSEJahner
 pgLDTW1AKeAr6wOq5rcAb8y7RRui10kzi1HWXRiAUslfG6tV6/jGslX8oh4MkWLT6soRf3jxZEn
 2nS/jwasIlzBKONYdXGvu5YHEYeGu9CmU2Rwxyz/aqWA0JO7VMSHql/sUnG6KBxAUKcuMxKCGkt
 Y17boCIOLUqpmOcghcg==
X-Proofpoint-GUID: 31mbTliFCgHjtoqaHFaaNBhVgZAKrzNs
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dfc47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=De5M_SF8sF-WxBbd-0IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX8qV/FTxTKgcI
 dSEubPBsCEfDuHP68kbGW2ow6P9kVcLoSSvwZvgADAmGrumfNzYdy3+loztNlx2B37T07Jc8MrC
 eP87gt0zDyZ2AVzKJyPXmc993Jl3m2o=
X-Proofpoint-ORIG-GUID: 31mbTliFCgHjtoqaHFaaNBhVgZAKrzNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

The H_HTM hypervisor call can also return the system memory
configuration, which describes the physical to logical real address
mapping for logical partitions.

After dumping HTM trace data into the AUX buffer, capture the
corresponding HTM system memory configuration records and emit them as
raw perf sample data for userspace parsing.

Add AUX-private tracking for a hypervisor memory-configuration dump
buffer, a stable emit buffer, and iterator state. Once AUX trace dumping
completes, htm_event_read() switches to H_HTM_OP_DUMP_SYSMEM_CONF and
iterates over the returned records until the configuration stream is
exhausted.

Trace payload continues to be written to the AUX buffer, while memory
configuration records are emitted as raw perf samples. This keeps the
AUX stream focused on trace data and allows the configuration records to
be decoded separately in userspace.

Keep HTM tracing state in event->pmu_private via htm_target_id. AUX
private state is used only for dump progress and staging buffers.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Memory configuration records are now emitted as PERF_SAMPLE_RAW
  samples directly by htm_event_read() after the AUX trace dump
  completes, using H_HTM_OP_DUMP_SYSMEM_CONF.  V1 embedded the
  configuration data inside the AUX buffer itself and used two
  PERF_SAMPLE_RAW boundary markers (start/end) to delimit it.
- The two-marker boundary scheme is removed.  There is no longer any
  interleaving of memory configuration data inside the AUX stream;
  the AUX buffer carries only bus-trace data.
- Separate AUX-private fields for a hypervisor dump buffer, a stable
  emit buffer, and iterator state are introduced to manage the
  multi-call SYSMEM_CONF dump loop.
- Tracing state remains in event->pmu_private (htm_target_id); AUX
  private state is used only for dump progress and staging buffers,
  consistent with the restructuring in patches 1 and 3.

 arch/powerpc/perf/htm-perf.c | 124 ++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index edfca63e1e9b..7e6a67485800 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -104,6 +104,10 @@ struct htm_pmu_buf {
 	u64     size;
 	int     collect_htm_trace;
 	u64	trace_records;
+	void    *htm_mem_buf;	/* Staging bounce area allocated node-locally */
+	void	*emit_buf;	/* Stable buffer for perf raw sample emission */
+	u64     mem_start;	/* Hypervisor offset state iterator tracker */
+	int     collect_htm_mem;	/* State flag tracking whether memory logging is ongoing */
 };
 
 struct htm_pmu_ctx {
@@ -173,6 +177,99 @@ static ssize_t htm_return_check(int rc)
 #define HTM_TRACING_ACTIVE	1
 #define HTM_TRACING_INACTIVE	0
 
+#define HTM_MEM_MAX_ENTRIES	2013U
+#define HTM_MEM_BUF_SIZE	(32 + HTM_MEM_MAX_ENTRIES * 32)
+
+static int htm_collect_memory_config(struct perf_event *event,
+				      struct htm_pmu_buf *aux_buf)
+{
+	struct perf_sample_data data;
+	struct perf_raw_record raw;
+	struct pt_regs regs;
+	u8 *htm_mem_buf = aux_buf->htm_mem_buf;
+	__be64 *num_entries;
+	u64 next_start;
+	u64 to_copy;
+	void *emit_buf = aux_buf->emit_buf;
+	long rc;
+	int ret = 0;
+	int retries;
+	int emitted = 0;
+
+	/*
+	 * htm_mem_buf is the hcall memory buffer target reused each iteration.
+	 * emit_buf is a preallocated stable buffer used for perf raw
+	 * sample emission, so raw.frag.data remains valid during
+	 * perf_event_overflow().
+	 * Size: 32-byte header + HTM_MEM_MAX_ENTRIES * 32-byte entries.
+	 */
+	while (true) {
+		retries = 0;
+		do {
+			rc = htm_hcall_wrapper(htmflags, 0, 0, 0,
+					       0, H_HTM_OP_DUMP_SYSMEM_CONF,
+					       virt_to_phys(aux_buf->htm_mem_buf),
+					       HTM_MEM_BUF_SIZE, aux_buf->mem_start);
+			ret = htm_return_check(rc);
+		} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+		/* H_NOT_AVAILABLE or error: no more data */
+		if (ret <= 0) {
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+
+		/*
+		 * Read next iterator value from the hcall response BEFORE
+		 * emitting, but only commit it to mem_start after a
+		 * successful writing of raw data/
+		 */
+		next_start = be64_to_cpu(*((__be64 *)(htm_mem_buf + 0x8)));
+
+		/*
+		 * The hcall was given HTM_MEM_BUF_SIZE bytes of buffer space,
+		 * so num_entries is already bounded to HTM_MEM_MAX_ENTRIES.
+		 * The response is a complete hcall data:
+		 *   [32-byte header][num_entries * 32-byte entries]
+		 * Userspace can validate and parse it directly.
+		 */
+		num_entries = (__be64 *)(htm_mem_buf + 0x10);
+		to_copy = 32 + (be64_to_cpu(*num_entries) * 32);
+		if (WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE)) {
+			ret = -EIO;
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+
+		memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
+
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+		memset(&raw, 0, sizeof(raw));
+		raw.frag.data = emit_buf;
+		raw.frag.size = to_copy;
+		perf_sample_save_raw_data(&data, event, &raw);
+
+		if (perf_event_overflow(event, &data, &regs)) {
+			ret = 0;
+			break;
+		}
+
+		/* Record written: advance next read iterator */
+		aux_buf->mem_start = next_start;
+		emitted = 1;
+
+		if (!next_start) {
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+	}
+
+	if (emitted)
+		return 1;
+
+	return ret;
+}
+
 static void reset_htm_active(struct perf_event *event)
 {
 	struct htm_target_id *target = event->pmu_private;
@@ -407,7 +504,7 @@ static int htm_dump_sample_data(struct perf_event *event)
 	if (!aux_buf)
 		return 0;
 
-	if (!aux_buf->collect_htm_trace) {
+	if (!aux_buf->collect_htm_trace && !aux_buf->collect_htm_mem) {
 		perf_aux_output_end(&htm_ctx->handle, 0);
 		return 0;
 	}
@@ -420,6 +517,11 @@ static int htm_dump_sample_data(struct perf_event *event)
 		}
 	}
 
+	if (!aux_buf->collect_htm_trace) {
+		ret = htm_collect_memory_config(event, aux_buf);
+		goto out;
+	}
+
 	/* Derive the exact target destination point directly out of active ring pointers */
 	dump_offset = htm_ctx->handle.head & (aux_buf->size - 1);
 	page_index = dump_offset >> PAGE_SHIFT;
@@ -506,6 +608,8 @@ static int htm_dump_sample_data(struct perf_event *event)
 	}
 
 	aux_buf->collect_htm_trace = 0;
+	ret = htm_collect_memory_config(event, aux_buf);
+out:
 	perf_aux_output_end(&htm_ctx->handle, 0);
 	return ret;
 }
@@ -568,7 +672,23 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	}
 
+	buf->htm_mem_buf = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf->htm_mem_buf) {
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->emit_buf = kmalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL,
+			cpu_to_node(cpu));
+	if (!buf->emit_buf) {
+		kfree(buf->htm_mem_buf);
+		kfree(buf);
+		return NULL;
+	}
+
 	buf->collect_htm_trace = 1;
+	buf->collect_htm_mem = 1;
+	buf->mem_start = 0;
 	buf->trace_records = 0;
 	buf->head = 0;
 	return buf;
@@ -584,6 +704,8 @@ static void htm_free_aux(void *aux)
 	if (!buf)
 		return;
 
+	kfree(buf->emit_buf);
+	kfree(buf->htm_mem_buf);
 	kfree(buf);
 }
 
-- 
2.43.0


