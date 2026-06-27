Return-Path: <linuxppc-dev+bounces-23039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1003FC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 09:04:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnRRg2YSZz2xWP;
	Sat, 27 Jun 2026 19:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782551039;
	cv=none; b=ORU9EktLSTggGMvSXtMnmQHksnXDxrqB8wx9lQW0RZB+ks97CbQC66px+O+BfqXsGcKf3xzTUqbm169NHjEb6VwLWo9wCXStXzAjFesrPkokaXOlzC/ZGAFBs4XjJmsRp0WSw6HS22nPqyD4XXRlhlF3EPMt5OMGD9ejCyPc41otarIFjp3opboT1xllLDWrBJ0vSBnQtub5HY1hiv89jkZfyv5JAYsCR1KWZb3P2FUPCPGEaJtAgBcVEmO9cvxoWk68yG8I8CwDEoVYc/QupcMJYXD5lNlUxx4nyeYUovXAupK22lPMKB4IgAD9kBRxEIVbV12Bz+Z7AAVp8cP70w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782551039; c=relaxed/relaxed;
	bh=R3oxmrHEu3DxHUyIeRYPRcYft4luqjoeznjd6iV4xyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogScQ4crCiiN6utnmmHNRVxfSTRApSKYNJmYlB7ieX8N2NFNVEr21gZO7ESSKb3eWahREt/U69fuOHwRkUuJ+vztWanjqar3PStpzPph3qyX/rFxA8TWx7mzGwv7pdUYeLQIkUZ5riLP05r4OP2zStGSoPNBnHac7IC34Y/xw168oIrT6WAxvmufkeRGZPpoxKmYhWYt8IAUIxAy1g3LR+g5e8L6EjzMadqX94lr5dCxecc8DEfiRLQuV8WUnV7q+zwLzK191nwuLpAdsfmS6Ea9SkwbQXNqPHHmEKrKgLYD33408Fw59YcBTYP5HRRid5Jw7ssOA0XZT1e/dTT8Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oRkyWLZR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oRkyWLZR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivani@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnRRd3j1jz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 19:03:56 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65R3SgR4635123;
	Sat, 27 Jun 2026 09:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=R3oxmrHEu3DxHUyIeRYPRcYft4luqjoeznjd6iV4x
	yA=; b=oRkyWLZR5WsJvMRfEBVTu2+iaNORJneGe9+HS54d2kcKOoew3wm7An8hc
	Uyy40Y4HpfyLZ33wyG+s8+My9zCKXd9UCjjBOSwtXIX2ByooveNaY/8jFXLEvRTd
	P0PYH2MJwiy+xpQYp0jwvpGS9L3lsqJjGssH5ONbQgIUPjOaGkcJDPMP6Sf0bafn
	fPpJHnX6AVaiZeuboh/rhcpB+vf91FzB0YuclOnz1jqTdnMOOuWrbJYwiCmC3RGs
	Pz7Y0/2oGibTR+telA33oRCUpO+M8HdWh4HUAavnbhfL9SmoenzPsjN4mxY8jqN1
	kljxpL1HblJ3CNxVrh/LK1xWns1Tw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n590yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jun 2026 09:03:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65R8nj9w018731;
	Sat, 27 Jun 2026 09:03:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66kpn5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jun 2026 09:03:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65R93jAb28967370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jun 2026 09:03:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BE72004E;
	Sat, 27 Jun 2026 09:03:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B12FD20040;
	Sat, 27 Jun 2026 09:03:40 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.39.21.58])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 27 Jun 2026 09:03:40 +0000 (GMT)
From: Shivani Nittor <shivani@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH v3] perf scripts: Add configurable sorting option to powerpc-hcalls
Date: Sat, 27 Jun 2026 14:33:33 +0530
Message-ID: <20260627090334.67847-1-shivani@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDA3NSBTYWx0ZWRfX8GHrVINKo/rc
 82v3sE7H3b1ZbSB/zF4OQitqS9ST0S4mr63QAtAWWo/7ifOkCzqiKn55zRodV1MYJFPWOIxLUmF
 JvYYB5lkkG4kt41Y3txXR9y+DhgJGkMqBhqVqb2lU2PlVInjfcrEM/FNTAUtXP6OzltyY69P/Nk
 QZvUXPOalr2W2THhNSeiNqtPd0o5Xs7HnIE1K3jHi21o+pscyjH/Axn7g9Wx4neNVU9rRaVLXcX
 fpwig9JOGuIOv39TziwkuTPIih0QB1uaad9s82mQ+grlII9P6HgW8I78N5NyfD/2KibpCZUu0yh
 WhA+r8Z4CimSrXohc+iyURtPqwRxFDtEN3FI4FgrQl05FqNowlAh4Odtx2k7z7tHSF6JX7wByHq
 k2XJdsED3GQpuzF4G04u4H0CoPN+Q4/0XNCODiIR8/YRrStHioQNl+oPp6Gx5DbbMPlqMg/LQG/
 DVCeNbxBzUsGRFKiCBQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a3f91f6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-UTqftxNVshRFOYItwsA:9
X-Proofpoint-ORIG-GUID: h6argQTvTZJXYt9Icqmtig88y55ksaE1
X-Proofpoint-GUID: DlSsYyZ3pXWg6XB8G7dzV5gTDXo4wjQa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDA3NSBTYWx0ZWRfX/n/fasDHopju
 ZGxzGydz4ssOlPu6+5ZW4JgHO1h+FftmZV52/aAGn9fZl7shyInPc68qWGvQihp7tyjFGsrwVdZ
 WSG6abys+wszEVLrEfKr6T/jZ73V/Ck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270075

The powerpc-hcalls.py script currently prints hypercall
statistics in a fixed sort order based on the number of
hcall occurrences, making it difficult to analyze hcalls
from different execution characteristics.

Add support for runtime-configurable sorting so users
can order hypercall statistics by count, minimum
latency, maximum latency, or average latency using
a --sort option.

Parse arguments through sys.argv to support perf script
argument passing semantics.

Example:

perf record -a -e powerpc* sleep 10

perf script -s ./powerpc-hcalls.py -i ./perf.data -- --sort=max

SORT KEY = max
hcall                            count   min(ns)   max(ns)   avg(ns)

H_SEND_LOGICAL_LAN                  47      7380     40148      8739
H_VIO_SIGNAL                       706       880     17454      1911
H_RANDOM                             1     15176     15176     15176
H_PUT_TCE_INDIRECT                   4      3032     10444      4956
H_ADD_LOGICAL_LAN_BUFFER           363      1250      8716      1534
H_SEND_CRQ                           8      2086      6846      3044
H_PUT_TCE                            9      1284      4932      2646
H_STUFF_TCE                         13      1620      3962      2358

This makes it easier to identify frequently occurring
or high-latency hypercalls depending on the analysis
being performed.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
---
Changelog:
v2 -> v3
- Add validation for supported sort keys
- Print valid sort options for invalid input

v1 -> v2
- Add bounds check for --sort argument handling
- Prevent IndexError when sort key is omitted

 tools/perf/scripts/python/powerpc-hcalls.py | 46 ++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 8b78dc790adb..bfa628d8c952 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -25,6 +25,7 @@ from Util import *
 #	} ...
 # }
 output = {}
+sort_key = 'count'
 
 # d_enter: {
 #	cpu: {
@@ -158,10 +159,53 @@ def hcall_table_lookup(opcode):
 
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
+def sort_output(opcode):
+	stats = output[opcode]
+
+	if sort_key == 'min':
+		return stats['min']
+	if sort_key == 'max':
+		return stats['max']
+	if sort_key == 'avg':
+		return stats['time'] // stats['cnt']
+
+	return stats['cnt']
+
+def trace_begin():
+	global sort_key
+
+	valid_sort_keys = ['count', 'min', 'max', 'avg']
+
+	i = 1
+	while i < len(sys.argv):
+		arg = sys.argv[i]
+
+		if arg == '-s' or arg == '--sort':
+			if i + 1 >= len(sys.argv):
+				print("Error: -s/--sort requires a sort key argument")
+				sys.exit(1)
+			sort_key = sys.argv[i + 1]
+			i += 2
+			continue
+
+		if arg.startswith('--sort='):
+			sort_key = arg.split('=', 1)[1]
+			i += 1
+			continue
+
+		i += 1
+
+	if sort_key not in valid_sort_keys:
+		print(f"Error: Invalid sort key '{sort_key}'. Valid options are: {', '.join(valid_sort_keys)}")
+		sys.exit(1)
+
+	print("SORT KEY =", sort_key)
+
 def trace_end():
 	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
 	print('-' * 68)
-	for opcode in output:
+	for opcode in sorted(output, key = sort_output,
+                            reverse=True):
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
 		cnt = output[opcode]['cnt']
-- 
2.54.0


