Return-Path: <linuxppc-dev+bounces-23292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtmX4TwXz2ywy;
	Wed, 01 Jul 2026 18:42:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895324;
	cv=none; b=PHpz5RO+Imt7On8JHraLwrNJwPGf9rOV+EC3EfQnabzX4Gd7F36A6HacgNDx556YpCOEOaJN8Ho5XK940zZKwauGjR6O8ITO+aGpDhv57X9bsVnKaRxbogICfsIX5bgIu9P7Oy8tiBe4FzxpgFjb3XCVVyGxqMO/aL1ghSsD1XZ40FFK75YzxaPjWVzrcGfvAsNed32tIqW52mlY216FEbT29lVhqSvD3VOFedmq/KFW6f7mI5k/47nQciQZxQ+oXO1S7HCwB+AN/CX7PHosye1ToLa9fNaV/3Cp0mwJb0TX9SGrKLDTeDtD8FrjJVw43SR25vOBXGrIHisgCaSlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895324; c=relaxed/relaxed;
	bh=RzeaNFvdBAWLunX/yVVDH77Cpxdi28XnoG+P+IGB4tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6W1EpOdq1MWxvFiumh5Q0yEcFn3M6+N4HLOLJcSI7MAkf5dhCcBLHnRmIsxiW0ch9muX8uDxIrKVJ0dA+mKa1M4yuHO3PecvRqhGIqkwBZoVpipyQbW627Bq8Bpm0ud1fKsV/SURkpDs6QaXbveZddVbXs8BEvOCDBvYuqtqmVuEL73Onj0lCbHYTmk5eXbwKAIikBTv8HLqina6hgxse5d6z2/yy0B040bsqnSOiHlflAQmUfUqriP3ccGrQx45arg0TbjRjLHJxE0M6IlK5Sd1vTYhuVz661Bkgwbbn41K5odSeH23/IMf548sMCTvhHi3e08opjszGYIgwvfBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PzKWbdwB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PzKWbdwB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtmW3NZYz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:42:03 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IBfL356282;
	Wed, 1 Jul 2026 08:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RzeaNFvdBAWLunX/y
	VVDH77Cpxdi28XnoG+P+IGB4tg=; b=PzKWbdwBndppGfXdVDFshx8Zo8otboMQJ
	mWTne/3CGAVOUjh53LEAw4OoxxeluXLfgkHCJ3SW6cxPUJfMc822bdYXvucnjmib
	OOuScZNJpkCfwLkbsqlmLO+mgq0iGVuOBa4d0rYjrMQ8x0nOEx3f6+kSnR9CVIyJ
	MzXCZg8G1r6h0rTf2fmoLJR+Qheg5dzmnfc3fs36aPgK8qx5q9JIbq4mC9sUUlxg
	f5xRLfZ6Erl+aBRathHMPoTu7rodCUIrBn6Xa/xUNWiUw4iG/Q2MXoT80ecQF/Hv
	gNmBcXXvCZn7vJs1KS+ocXMtzN4bWweSV3vB7erZcK0ph8mUuJOuQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3ggn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:42:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YjJH001905;
	Wed, 1 Jul 2026 08:41:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhecht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fs8q29557034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFEB020043;
	Wed,  1 Jul 2026 08:41:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36B8B20040;
	Wed,  1 Jul 2026 08:41:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:50 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 8/9] tools/perf/powerpc: Add event name as htm of PERF_TYPE_SYNTH type to present htm samples
Date: Wed,  1 Jul 2026 14:11:14 +0530
Message-Id: <20260701084115.80383-9-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701084115.80383-1-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: _JYhAfF-WqPF-ojp-RRJh1VCe1X9yKZo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX6uOyTwJafllR
 smjc2bJNhrVkhawde6m4fv7DukctcFvG4gYHssA+1o9TBE3RrPI5sCrLlFA/lW2vtTADP6u0JP+
 DAvMMWiQTd2pIcDJseiS8fH0FFEq6UM=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44d2d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0c5kpZ5o8VaU0JCb9dwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9lXj47uDJkC9
 x6rrVYAb0ZyV9AMplInBtAvb4fe/ymSxwDKkco0J29U172dksgXOhxEmoFOvinskaSoxYcV3ny2
 zABKcDOwfMLT6VNAF/RAHelRoeW5Hy0DWZfLUd5t9NU+vZdS+5BfoRkAz7mcKcCdRNNMDi3I7dR
 E9LZMAX804Q6qclrSKCm7L0sj9JZhlBqWA+T3pnPuWYj8g6+/8A3QxTDTVD1LVBuEP4IdKLdLwT
 J3i7PV9r3PyR3dm/KuCMkt/42EpIvptAq5EQ1qQWrHT5zf02ksw5U5TmjKnyJZwEhEeGBeOwyCE
 DV+X16vnLki8w4psPdg0lm3RxFo3bQFK1TrPkIDYs+27U93z54jnFXmuDKDFfqaGS9FdFZAGYuG
 Jq2ZsKFeUC815vFOSj25JBFvFjmagoPvayETclj+deauKt7PyaYx5gmprwAq9JxvzZBVSIgQi8Z
 wJU87cjhtfvQ4Pg2zUA==
X-Proofpoint-ORIG-GUID: d9JEXpZqt7TD4DNlHP808Teuj7iK-6B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

HTM trace details are captured as-is in PERF_RECORD_AUXTRACE
records. To present htm entries as samples, create an event
with name as "htm" and type PERF_TYPE_SYNTH.

Add perf_synth_id, "PERF_SYNTH_POWERPC_HTM" as config value for the
event. Create a sample id to be a fixed offset from evsel id.
Invoke powerpc_htm_create_sample() using the logical address
as sample ip.

This will help in understanding hot logical address from the
traces.

Usage:

 # perf record -C 1 -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ -o perf_1.data ls 1>out
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 257.504 MB perf_1.data ]

 # ./perf report -i perf_1.data

 # Samples: 8M of event 'htm'
 # Event count (approx.): 8515199
 #
 # Children      Self  Command  Shared Object     Symbol
 # ........  ........  .......  ................  ......................
 #
     0.61%     0.61%  swapper  [unknown]         [.] 0x00000006fd567fe0
     0.33%     0.33%  swapper  [unknown]         [.] 0x00000006fc194b20
     0.20%     0.20%  swapper  [unknown]         [.] 0x0000000066113f80
     0.18%     0.18%  swapper  [unknown]         [.] 0x00000007fd888f20
     0.15%     0.15%  swapper  [unknown]         [.] 0x00000006fd567fc0
     0.08%     0.08%  swapper  [unknown]         [.] 0x00000006fc194b00
     0.05%     0.05%  swapper  [unknown]         [.] 0x00000007fd888f00
     0.03%     0.03%  swapper  [unknown]         [.] 0x0000000422510700
     0.03%     0.03%  swapper  [unknown]         [.] 0x0000000422510820
     0.03%     0.03%  swapper  [unknown]         [.] 0x00000007fd888b80
     0.02%     0.02%  swapper  [unknown]         [.] 0x000000000a0ece40
     0.02%     0.02%  swapper  [unknown]         [.] 0x000000000a0ed2e0
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd888c40
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd889000
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd5bc200
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd61c200
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd28c200
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd22c200
     0.01%     0.01%  swapper  [unknown]         [.] 0x00000007fd1fc200

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/event.h       |   1 +
 tools/perf/util/powerpc-htm.c | 110 +++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 2ea83fdf8a03..f5aa7eb9f5b7 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -118,6 +118,7 @@ enum perf_synth_id {
 	PERF_SYNTH_INTEL_EVT,
 	PERF_SYNTH_INTEL_IFLAG_CHG,
 	PERF_SYNTH_POWERPC_VPA_DTL,
+	PERF_SYNTH_POWERPC_HTM,
 };
 
 /*
diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
index 83253850870c..050fbceac71e 100644
--- a/tools/perf/util/powerpc-htm.c
+++ b/tools/perf/util/powerpc-htm.c
@@ -42,6 +42,7 @@ struct powerpc_htm {
 	char				trans_file[64];
 	int				htm_mem_entries;
 	int				mem_maps;
+	u64				sample_id;
 };
 
 struct htm_mem {
@@ -128,6 +129,43 @@ static int run_htmdecode(const char *input_file, const char *output_file)
 	return 0;
 }
 
+static int powerpc_htm_create_sample(unsigned long addr, struct perf_session *session,
+		struct powerpc_htm *htm)
+{
+	struct perf_sample sample;
+	union perf_event event;
+
+	if (dump_trace)
+		return 0;
+
+	memset(&sample, 0, sizeof(sample));
+	sample.cpumode = PERF_RECORD_MISC_USER;
+
+	if (!addr)
+		return 0;
+
+	if (addr >= 0xc000000000000000)
+		sample.cpumode = PERF_RECORD_MISC_KERNEL;
+
+	sample.ip = addr;
+	sample.period = 1;
+	sample.cpu = 0;
+	sample.id = htm->sample_id;
+	sample.callchain = NULL;
+	sample.branch_stack = NULL;
+	memset(&event, 0, sizeof(event));
+	event.sample.header.type = PERF_RECORD_SAMPLE;
+	event.sample.header.misc = sample.cpumode;
+	event.sample.header.size = sizeof(struct perf_event_header);
+
+	if (perf_session__deliver_synth_event(session, &event, &sample)) {
+		pr_debug("Failed to create sample for htm entry\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static void *safe_realloc(void *ptr, size_t new_size)
 {
 	void *tmp = realloc(ptr, new_size);
@@ -309,7 +347,7 @@ static struct addr_map *process_trace_file(const char *trace_file,
 	return maps;
 }
 
-static int create_mem_maps(struct powerpc_htm *htm)
+static int create_mem_maps(struct perf_session *session, struct powerpc_htm *htm)
 {
 	off_t file_size;
 	void *htmdata, *mapped_data;
@@ -422,6 +460,7 @@ static int create_mem_maps(struct powerpc_htm *htm)
 			maps[i].event,
 			maps[i].phys_addr,
 			(unsigned long)maps[i].logical_addr);
+		powerpc_htm_create_sample(maps[i].logical_addr, session, htm);
 	}
 
 	free(maps);
@@ -581,7 +620,7 @@ static int powerpc_htm_process_event(struct perf_session *session __maybe_unused
 		}
 		/* Only for power bus traces, we decode traces */
 		if (config == 1)
-			create_mem_maps(htm);
+			create_mem_maps(session, htm);
 	}
 
 	return 0;
@@ -636,6 +675,69 @@ static void powerpc_htm_print_info(__u64 *arr)
 	fprintf(stdout, powerpc_htm_info_fmts[POWERPC_HTM_TYPE], arr[POWERPC_HTM_TYPE]);
 }
 
+static void set_event_name(struct evlist *evlist, u64 id,
+			const char *name)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.id && evsel->core.id[0] == id) {
+			if (evsel->name)
+				zfree(&evsel->name);
+			evsel->name = strdup(name);
+			if (!evsel->name) {
+				pr_err("Failed to allocate memory for event name\n");
+				return;
+			}
+			break;
+		}
+	}
+}
+
+static int
+powerpc_htm_synth_events(struct powerpc_htm *htm, struct perf_session *session)
+{
+	struct evlist *evlist = session->evlist;
+	struct evsel *evsel;
+	struct perf_event_attr attr;
+	bool found = false;
+	u64 id;
+	int err;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (strstarts(evsel->name, "htm")) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_debug("No selected events with HTM trace data\n");
+		return 0;
+	}
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.size = sizeof(struct perf_event_attr);
+	attr.sample_type = evsel->core.attr.sample_type;
+	attr.sample_id_all = evsel->core.attr.sample_id_all;
+	attr.type = PERF_TYPE_SYNTH;
+	attr.config = PERF_SYNTH_POWERPC_HTM;
+
+	/* create new id val to be a fixed offset from evsel id */
+	id = evsel->core.id[0] + 1000000000;
+	if (!id)
+		id = 1;
+
+	err = perf_session__deliver_synth_attr_event(session, &attr, id);
+	if (err)
+		return err;
+
+	htm->sample_id = id;
+	set_event_name(evlist, id, "htm");
+
+	return 0;
+}
+
 int powerpc_htm_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -698,6 +800,10 @@ int powerpc_htm_process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
+	err = powerpc_htm_synth_events(htm, session);
+	if (err)
+		goto err_free;
+
 	return 0;
 
 err_free_queues:
-- 
2.52.0


