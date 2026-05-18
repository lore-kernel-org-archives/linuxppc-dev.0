Return-Path: <linuxppc-dev+bounces-21115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21083CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 12:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJyNC5szbz2xpn;
	Mon, 18 May 2026 22:51:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779108667;
	cv=none; b=TcAseQQcr0DdAwmeFDLRw5v7M1vHTS7B148H2Hj74ZXolcMcRCymtE0SyVfGdI0E83dkj0ZKY/Pa3G+BLWKRPFejnnovA31mB8iEpNxKUehH+NXpZRC8KqsoC2f3ZDQkrQRW5ldaTSBp5PWTmK9pjyPsHslBzjfZum0x1CRI9vU0SpTD92eeKHRWJ9YQwqj+2kqX8LK9enIg5P9IgOuarZmjWPb4zLmG43E7JSR0fRZCQau46laaa3sNaSJ+R7ZAgjDSxdJfV4a1DqihlIW1SlUfUA3fQlMvgooVg0YhaVb7jhWiHpimwT/HS0aGvTfnNtE93L/4f8x0pGYe5q+r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779108667; c=relaxed/relaxed;
	bh=5I+B7k/wq9Y1RLy/SJ9Ni645jAVmZXZq8+BIsyyoqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQNBCUldN3EHmZG3CaF/Uqm422OPq3DppjiPkLWYTQH2azKXfr9RkrDOmn1b+xFc6jdl/ti+9M01WLroA6KbSlAiqA2GT+OOWH7hItPP6o1HlXrF3j16NaTOZZMubv98YML+K5xGU8pI/XZAEOwCQjiJQtVI0MBdD6qht/MyHD4R1SzCMeDwrcWjbSOwiBQQ5S6QsjiXvKVZQgygBmuD5/gKbTrFQ+Q0Ou2bvWQrBihXg904iujBKLtYwA+vQ2sd4EdjZcsmYej/Vp/Xrr21vNQf2mW8Ug/WdXWRfQwVP8h0kGqLKLVYfkN4aVbw2PHhBUPPPA93nRSMs4N/GiP90A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fH7yEb59; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fH7yEb59;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJyNB5Cqyz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 22:51:06 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HMQFew1497610;
	Mon, 18 May 2026 12:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5I+B7k/wq9Y1RLy/SJ9Ni645jAVmZXZq8+BIsyyoq
	LU=; b=fH7yEb59IMvDWMaw60lg6+ypBhBc8mW/6b8uat4FyKMnYa+UdOJ5TsTtM
	W1ttSCzyZumaKK/I7EjuCQmP3GIusAHfWcVe4s13hZg+Y38PuS1r+OYbuk7n8TrH
	cxmWuBK8Xd+nUGVFl7BCN+u7nOQZH5Sr6pZxgSG57yP/LH4dAzSXUv4KzrwvAVim
	UTle66TmWMXUBtYF0cXXPfS7JjFPdPzZM4hrUYNuh0xivx0tincCcIzmXfXPlw7+
	GKrOK/5I5rT8n1hqplFpaWaNh3hBlJW8TlWzrR2igby/ELzn6hYxU/a4xn+KkZUf
	bWQ4WpjNd0eCMyG76fmDAnmvZTavQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xr4ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:50:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ICd7Cn016691;
	Mon, 18 May 2026 12:50:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vp1mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:50:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IColTh41681366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:50:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD3320043;
	Mon, 18 May 2026 12:50:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEAE520040;
	Mon, 18 May 2026 12:50:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 12:50:43 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm exit reasons
Date: Mon, 18 May 2026 18:20:38 +0530
Message-ID: <20260518125041.39286-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEyMiBTYWx0ZWRfX71z+J1ScWM0r
 0oF/hBJ5wUb0s+pBM+cjEkjLLSswqUBNYEmp2U5mlk/u/gdufj/a7zJegDXIUfjTJHwYz+FM0qI
 ck7UawDfcuRfQdGf3Vu8Ru7S5YtsspI4teq+Uhjbd9Ep8mIfmE+fcaDWpoZXrYvSaP/VaSmUVOq
 tfVXmjsRrh4I735l4Y+4KoP+TRr++9x68F8oTD5Pok79kTQ7vu12v6P5ig4G8fGoxVxTLhLr1p7
 yHIF8ptOlt+laWMqgB1/3ZewJBeal6TE2d3YRMkDMrYl15s45+wqoMe/JLhLdqBT01KLuOBOPBo
 nXmAolbqMgj+w6egRBE5hykt7vSasvcE6pfHZnF8aQGvxHnCrN7YhunLCO8MmbCFVBs/oOYoyjA
 /CmdahlN6N77QW4j2AxYGlQQV84W6SOjmZGt1ki81IWeCu7Ocju1nfII7EMPOPqlRiTy991xzpR
 79cE1sUDg+voRyW/hPg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b0b2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=el4MqSLvOoczSZ0XHlsA:9
X-Proofpoint-ORIG-GUID: xsC2vPiTFk-T6BhDwB98-HvXsW0Mw1sr
X-Proofpoint-GUID: wy86J7ddM2lOYHMDovAsaKX-5A8OmSCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180122

The macro kvm_trace_symbol_exit is used for providing the mappings
for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
and H_VIRT so that exit reasons are displayed as string instead of
vector numbers when using perf kvm stat.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Update the patch title and description to remove dependency on
another file trace_book3s.h

 tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
index 2011376c7ab5..2688ca7d0399 100644
--- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
+++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
@@ -26,8 +26,10 @@
 	{0xe00, "H_DATA_STORAGE"}, \
 	{0xe20, "H_INST_STORAGE"}, \
 	{0xe40, "H_EMUL_ASSIST"}, \
+	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.53.0


