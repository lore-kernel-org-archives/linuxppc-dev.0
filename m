Return-Path: <linuxppc-dev+bounces-25003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46F9C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:38:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BhM12xLz2ygW;
	Wed, 29 Jul 2026 22:38:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328707;
	cv=none; b=Vwema7DI0m9wlOIETO/UHjwLZB+kYBJri9BmQOWQG40XNh+kdJ3XAZTitKFZ8ncD5QZ8pLIxX400A1f9UrNXWCZn1py/TVOOrKKfo2VgmJ7H9kL5hBgadwZAVE2kyMKosE5P+4Z89EqFaRGGiD69QfPAneO/v+2We4peOQIFaniCo92V4RZe8TAw48vQrfLvAXiOHUNltydGU2wpYiQYRKPqos4ygap2+tIYQ9QckA3teT0iK0w6FmGVwxqQ6ppW5mIZNjoWxN8XhSwHyisb9CCupJZWzji1IVIeIVl4Wj8tfSoSBSRiAC043rKrJh1QrDxrDcO7WkyIk2B8KAAIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328707; c=relaxed/relaxed;
	bh=f2gRGvKVH0c42GH9S74LGxVFaeYxyB7tH0BQ3Gbc+Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIDJV9lqSWvFjfgibWlMR7mTecmN/rr30Ad2X8mZdzgEeGtBKX4ltrqTcKLtKWlzqyBfO6Ix40DyKdrrB5S+t3Q4ZsZW08U98JOesL9u+dM8hKRHVxDgULdk2Bnk/dDSb7k9iMz2qd22wZCVCT+4hTi2wrQFIDJQ4p9Nd40K1wKZNMwWAd3QDEfgJGSdfV4iU+LskeeSkPTUZzt+AKMROoHzm3SDsf5Tr4/ybKTRgRaM2xFFf7I1Xmo0toZRT1n4fKu27XB0VCOFqzSwTXOVMkN8LwPmwC7+wQOli/WFXLyjb32ImIwshdjAv/0dFatniICgn+mFcWiYFS+O8DqleQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cP0p3R9V; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cP0p3R9V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BhL0BZQz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:38:25 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHk3Q4030240;
	Wed, 29 Jul 2026 12:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f2gRGvKVH0c42GH9S
	74LGxVFaeYxyB7tH0BQ3Gbc+Og=; b=cP0p3R9VVuuqQSvmy4ohG2jglQBAs6kjc
	1JtPpZ0XfUnnr+m/23BH+A9lzWioOKSj+UR+wuxoINhvA0XxwvVYdtqHXGib28WJ
	8vVyVusySBHhhuZL7vZYd+ic80vS+6Vf+YJM9mIvHVl/6jbyvTmZ4TuYGj4tq2Hl
	38yb6z7SAmElefPg5ZVw5KRK32oGyslh2AUE3YEKwROUn4trunnuFefuI+6tflf9
	fdSBnyM67wgftA8FmKTBy+j5hx5RgmOHA7kzSQeuWzmKxtVhOYcg3yQ40bgxc4/p
	WWCnRMCLkzKE6r7RjidNyKB5G/WuN3lrAf5RqcUj7JHgNHLDNRHiA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jmtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQI3x008868;
	Wed, 29 Jul 2026 12:38:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw6tb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCcHaI28901742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:38:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58E7420040;
	Wed, 29 Jul 2026 12:38:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4DC320043;
	Wed, 29 Jul 2026 12:38:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:38:14 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V4 5/6] docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format entries for htm pmu
Date: Wed, 29 Jul 2026 18:07:51 +0530
Message-Id: <20260729123752.63010-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729123752.63010-1-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: WyDiJwGFB0DU-7gychNfL3w-yPR6at1J
X-Proofpoint-ORIG-GUID: WyDiJwGFB0DU-7gychNfL3w-yPR6at1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX2uRMkeOIK3VJ
 mDtsHsM8x0QZzVe1rslGRJb5+/D6d5iGdff7RfN+boMofN5I2KluTrbiVCB6gCEnj/54Bl9eqZU
 PBxVByvZv5CXfORQWdznaOPqH42xJYVZ8RcY6aBpN0GSQU/QXA8Rsnni3VZioZAtsJvCa6Z/LzZ
 yr+i6bdJFt2j9xXVc5XnOd6nBrW/wfQNGeMzQwlB2ryx3i/MmL4aMIl5DamndUJMdUSiEupd9eJ
 B+YPWo+k71XyRTsi6lGYc8ubRz64/SukYki32ACxUxq3PiJ4b2MDSRgLvOse6+0qsUI+dI78N8Z
 SBvSLvThpsRQYromIpOGy+NlOaTdKvLRjjnM5KYRJjjxZpSUGjfQGKZNnzugSxtLwqJmA4XNW8X
 WJ3ZnZO+TBNf0eXQddmqOGrsFOXsFZjWP/ZeSZ9hBdXPcG/VNSItXYloiNXerG4RTZT8Zq7ZC36
 oUBSltP+6ozr4LrfJeA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a69f440 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=c-k_eesrf3A5jvSTi5IA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfXxT+kXnShraNH
 WP8moH+aX1KmX70JpPZ9q1LZLRmEqVzn+VNPm5fZ8GUlbS2MrL5DjSHrjvC7xZjqyUq4br9QeHr
 9QGw6+8/P9AqTla2WZjGjHP8yXdRhog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290102

Add ABI documentation for the sysfs entries exposed by the "htm" PMU
under /sys/bus/event_source/devices/htm/.

Document the format attribute group, which describes the bit layout of
perf_event_attr.config accepted by the htm PMU:

  event            config bits  0-27  (composite: all fields combined)
  htm_type         config bits  0-3   (HTM_CORE=2, HTM_NEST=1)
  nodeindex        config bits  4-11
  nodalchipindex   config bits 12-19
  coreindexonchip  config bits 20-27

Document the events attribute group, which provides named aliases for
the two supported HTM event types.  Users can pass these names directly
to perf:

  # perf record -e htm/htm_core/ ...
  # perf record -e htm/htm_nest/ ...

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V3:
- Fixed the format/ attribute table: the doc listed only the composite
  'event' attribute (config:0-27) but omitted the four individual
  format attributes (htm_type, nodeindex, nodalchipindex,
  coreindexonchip) that the commit message described and the driver
  exposes.  Added all four with their correct bit ranges and a
  'For example::' block showing htm_core and htm_nest mappings.
- Fixed the events/ example in the commit message: the previous example
  used format-group key=value syntax
  (htm/nodalchipindex=2,nodeindex=0,htm_type=1/) which conflates the
  format group with the events group.  The events group provides named
  aliases; the correct examples are 'htm/htm_core/' and 'htm/htm_nest/'.
- Fixed grammar: "Supported attribute are" -> "Supported attributes are".

Changes in V2:
- Updated the bit-range descriptions to match the V2 config layout:
  htm_type is bits 0-3 (was listed inconsistently in V1), nodeindex
  is bits 4:11, nodalchipindex is bits 12:19, coreindexonchip is
  bits 20-27.
- Added documentation for the events/ sysfs group which lists named
  events users can pass directly to perf.  This group was not
  documented in V1.
- Patch is now 5/6 instead of 4/5.

 .../sysfs-bus-event_source-devices-htm        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
new file mode 100644
index 000000000000..1c3e17cb124c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
@@ -0,0 +1,34 @@
+What:           /sys/bus/event_source/devices/htm/format
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attributes are listed
+                below::
+
+                  event           = "config:0-27"  - composite event ID
+                  htm_type        = "config:0-3"   - HTM type (HTM_CORE=2, HTM_NEST=1)
+                  nodeindex       = "config:4-11"  - node index
+                  nodalchipindex  = "config:12-19" - nodal chip index
+                  coreindexonchip = "config:20-27" - core index on chip
+
+                For example::
+
+                  htm_core = "htm_type=2"
+                  htm_nest = "htm_type=1"
+
+What:           /sys/bus/event_source/devices/htm/events
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe performance monitoring
+                events for the Hardware Trace Macro (HTM) trace. Each attribute
+                in this group describes a single performance monitoring event
+                supported by htm pmu.  The name of the file is the name of
+                the event (See ABI/testing/sysfs-bus-event_source-devices-events).
+
+                For example::
+			# perf record -e htm/htm_core/
+			# perf record -e htm/htm_nest/
-- 
2.43.0


