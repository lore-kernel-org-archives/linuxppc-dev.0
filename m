Return-Path: <linuxppc-dev+bounces-24475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2011C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3ccF5F6Dz2yY0;
	Mon, 20 Jul 2026 20:45:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544333;
	cv=none; b=Mlkk3khKjxaa8/nS63Qg25ovSaJZLGV5aib9ORYCsbcBFbngoJQkz0bTuytnMIaJnrfxZIYa/7pgFS4gkgG7oP2AGmMPeuX1ioPvkc0Mpfxa+VllXvvP1pkCZUf00FylWmt0t+j7zZ2yodD6naX4eThFbAPAblBEendm87QvZyDA+kdDpuDu60LjvRZ1P1ZhwAD+fCnNRXZscvd++jDXQj43a2QzTuHuZoXwLYTKgkK5shuGY2r0FCOjIJFIbrJQ4P2tO1JYW3FcU8b1tPv47XuKuOCi4he1UycDPF7zNHlpjPbTHtA31oIErhpNxTILGmGf7RPVEUI3jasfna5S+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544333; c=relaxed/relaxed;
	bh=IEcaCKcFMrD2OQtcdqkAruYPhYiRxtg8Yh3ToBhu0so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b73DlUc6utUB33klC9PLgA2r6yS3eV0GXbBZ45+qoELwK0Ehg8qtL8swtE2MCZ8NdQqiMSni7js+dtzmzEVENS1qzmr9HbFPXlvcFRXhcQ5MEX3oUlm+5CNU1odlSGOHoBDNiCLjELVSGo4pgV65F6XgbjNuUubNGolYX6hK7mjMdF53/aXciAhXltl7oMu+UJpon7V4VDcThSHhI2MKk1AVkucYmqE37L9goAZ7FlPIgDpMPU3byJ0/c3PBghh9WBeajvABgo8582evXZ4gCy8UmaLxTuOm2dlFXEM2n6Hb7FfPTTe2pFWr1zxs1HCfBvL2h4cgc0lOufPckrLHvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MgdnY40P; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MgdnY40P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3ccD66Lpz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KACGYJ1812463;
	Mon, 20 Jul 2026 10:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IEcaCKcFMrD2OQtcd
	qkAruYPhYiRxtg8Yh3ToBhu0so=; b=MgdnY40PPNFZae5Ys5Fq/q1WL1PafkXVU
	Nz4rePwwS0+lqmb7VeELKuoqOlmzr+XcLeq8lGVemH2S9juyVW13VpUkDTPtMrvW
	7qwxZeSmfEZJwMMnxp69htPayZdWa7Nf+GV27LkXI6F1KkoP3UMvQzmTt+Z67Gt+
	jYHQunFZa8sRMuk/SS1GqGFNhkFVK+ZwRx+hD5quUUr9KTXMhtAreL6PSSXCqOeG
	0n0OvHo7GaLVuKUrmZwQcOyEe8vR7VP3ir0pNUH9ij7I6QZS6vh0p/gacHHqbFyA
	6nTT4lLnDcBKCvNSK+zlcBJTXQ27j+CZVWH91nKVwCCaieXrxUTDg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxrf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYcuL026250;
	Mon, 20 Jul 2026 10:45:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpwchk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjOCq48824654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19FFE2004B;
	Mon, 20 Jul 2026 10:45:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADC5020040;
	Mon, 20 Jul 2026 10:45:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:21 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 5/6] docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format entries for htm pmu
Date: Mon, 20 Jul 2026 16:14:46 +0530
Message-Id: <20260720104447.11843-6-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX6Clwu6t1B1A5
 XYwY3kvNzvmTPbo1zTgedgGCt168s5wQ6V+C9Yg4M4ii+R7ltJWg/3/PU61QH+91/2uaIU3iGCP
 sw5cwTNDk/lNBP8T3xbRWKANV/l2ZZUcAZKq1YBTCtqjWjN0FHZ0PvNIq8q2m8VrSQMzC5mM0rZ
 gknDenaP7LS0O/8tRuEq6+VU1JdT7naMAuSPBRzDJfgeL5qUbyLLvK3lp07MB/j9FAUUARdpx04
 zJgp8lw+LHxEvlWhzeIhG2qnAIyeKPfU3o1e1cKid0/s9XmUCkyF4y3QPViBoJE1DmQyoTNaYwZ
 io2NIN9QVUr0KIdHGZnn8KTV6rXYSkZPWvSGgt1SRkBbh50aV5LT/xuAt2kVO6Cd7lEzvIpZkdR
 U0nSzRWVQlxNd9FqHOzi4EI45dDCD/hiwsqPtKI4zI84GAIyYt/WLVyHgZvp+YeI2CcWzcguq8u
 tjLw215qgJW4fDfhTYQ==
X-Proofpoint-GUID: 4B6Gkl9caS4E-oJJsSU41s5dFAVCH2oE
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dfc4a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=MAjSfxlMfwhW9nvQlMAA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXyCZ75aKdu8W6
 bCqo/7tTgOvkeECjE8DLUyjjExm0labN5YEYCHS0vQOQ1d79GP4xJ3uAl+ZlNltOvaH2FV0oGo+
 xAASqQR26FhXmlVQdYuAUGAyhEG9ORQ=
X-Proofpoint-ORIG-GUID: 4B6Gkl9caS4E-oJJsSU41s5dFAVCH2oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

Add ABI documentation for the sysfs entries exposed by the "htm" PMU
under /sys/bus/event_source/devices/htm/.

Document the format attribute group, which describes the bit layout of
perf_event_attr.config accepted by the htm PMU:

  htm_type         config bits  0-3   (HTM_CORE=2, HTM_NEST=1)
  nodeindex        config bits  4-11
  nodalchipindex   config bits 12-19
  coreindexonchip  config bits 20-27

Document the events attribute group, which lists the named events
available on the PMU.  Users can pass these names directly to perf:

  # perf record -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ ...

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Updated the bit-range descriptions to match the V2 config layout:
  htm_type is bits 0-3 (was listed inconsistently in V1), nodeindex
  is bits 4-11, nodalchipindex is bits 12-19, coreindexonchip is
  bits 20-27.
- Added documentation for the events/ sysfs group which lists named
  events users can pass directly to perf (e.g.
  htm/nodalchipindex=2,nodeindex=0,htm_type=1/).  This group was not
  documented in V1.
- Patch is now 5/6 instead of 4/5.

 .../sysfs-bus-event_source-devices-htm        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
new file mode 100644
index 000000000000..784ba7c31b89
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
@@ -0,0 +1,21 @@
+What:           /sys/bus/event_source/devices/htm/format
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attribute are listed
+                below::
+
+				event  = "config:0-27"  - event ID
+
+What:           /sys/bus/event_source/devices/htm/events
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the Hardware Trace Macro (HTM) trace. Each attribute in
+		this group describes a single performance monitoring event
+		supported by htm pmu.  The name of the file is the name of
+		the event (See ABI/testing/sysfs-bus-event_source-devices-events).
-- 
2.43.0


