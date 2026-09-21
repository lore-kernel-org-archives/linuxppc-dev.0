Return-Path: <linuxppc-dev+bounces-27797-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15BFC982DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:32:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hp81M1NVwz2yDc;
	Mon, 21 Sep 2026 13:32:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789961543;
	cv=none; b=i36DNGOgeeTj9Mrgm8FIJyEBExiH5lApHdwc5ARa+iqhFNkrY9yvknZZwiZxXLFzMl3KSKUp0u7uSyNRK8VL0Lpn7z6c78wriINPZ9ipz0LT7XLuDjXk18d+yx1c4L01Y15qadKfMtSakRk4Uhl6cBLdV53j8E6PWHsEV5bLG9Jmdog8cpm3lmGOL5kMo2K17PRBLMJ3ThnTq+QD9CZMMpts/BVgG0KTeyiaKq7KdS2AUL2HjnAc1eZ/ySBVejYjzXu8nLCyR1xX5iZczedrPBmdezEamdrD/F14CK66kZTBYpnuIjQoqwwathHbLOVsoXuGGtoz2GUYt40q02z+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789961543; c=relaxed/relaxed;
	bh=YZquQWjZGeAbplbdG5X5m8RzhCZUR63iLT9FGoWQXx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLGjqneKWYQCI3hsgq3Hh4LrHk9e4MMaW9lj0Q6UqsgN6zhK05G1W3nye7O3+Xa8OK9wvhmAi5Lr4xAzYz4twEvv+6/xAAUuk8OPtVDmDMHC/xi7YGeYYLlqnOkbH9pIcwHQsDscNLKCCeAImRSLz6VNPcFJoD0o1fIAVhQlTn6zEE+4VVkAW/5nfMAUdHx+idxXYIqkUQF2dvKOEYrYcLTCbUzZuPT+MT/bA2tOOuDxoDAnW4KfoZTro5hMZm6XOhB8Xz/bGge1MiiYdAEAsFNw2AdOxR1WFdjKvWzlEcM98UE4jO8QkSraTxCkKdaMiVPwOjJ1lggSAJ32g4Rmbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O49mI/D7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O49mI/D7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hp81K3c0jz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 13:32:20 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L15S5D4137288;
	Mon, 21 Sep 2026 03:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YZquQWjZGeAbplbdG5X5m8RzhCZUR63iLT9FGoWQX
	x0=; b=O49mI/D7aPrL/vmnmtn3XIoo5ga1ooMOaUaLfHSnoYjFvJQM5EHvqehrq
	uRfz+Msvhrj8TGUAB9un/ie/THHQSXXGXJl007FQ+YB3kjQVu9cHPGZYcCDNOwbl
	718LYR4PtAlVJRjd8yv/9azkwWq9FzHw2w+QI52VXcF2Te31bw8JcWtkguJCGviF
	mEU+VBKopfch1zFubZt2gmD7RIGVSaUICIQ47TBO5GkjoWTgalqytYufMEn2mewj
	EhvUjPUvdAuDS2Mbcm7yr5w8YUbbYCtCJLUsGyip/pOiKMEV3fb2vLtHG6+HJXh2
	shTy9vxNraBEIru9iq1hBhAwl5tuA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgrxk0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:32:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L0lcFb471371;
	Mon, 21 Sep 2026 03:32:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gkhvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 03:32:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L3W2st37093756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 03:32:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 385E15805A;
	Mon, 21 Sep 2026 03:32:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EDA558051;
	Mon, 21 Sep 2026 03:32:01 +0000 (GMT)
Received: from li-4c4c4544-0038-3410-8038-c4c04f423534.ibm.com (unknown [9.61.133.32])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 03:32:01 +0000 (GMT)
From: Haren Myneni <haren@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, maddy@linux.ibm.com, robh@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, saravanak@kernel.org,
        ritesh.list@gmail.com, tyreld@linux.ibm.com, hbabu@us.ibm.com,
        haren@linux.ibm.com
Subject: [PATCH v2 1/2] drivers/of: Add of_detach_node_no_notify()
Date: Sun, 20 Sep 2026 20:31:55 -0700
Message-ID: <20260921033156.991481-1-haren@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab0a535 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Yfu1lNDa6tetUWVIbbMA:9
X-Proofpoint-ORIG-GUID: ThzuiThGIny9TGCt26ANs60FMrGURNzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA0MSBTYWx0ZWRfX2BDKqicpedUU
 ALUFiTl+X9IMlhS6dMWsk8UrCltQW+6ZZfEKOEvn0ai1c/VPoipSIEnY9YhvmKF7uy5KQ/wF/di
 DrMIGXFNHisONHx2SmHqMVAfYlyXk1GAcdK9y5IEaGpPGCyhgIWNQpLsNskxpnY1sLXxjECmBbG
 syh8MZONS0VGn9XSoRW8SjvYkm9lRm6fYcUj3hLnvsD3hiyTcbI4RxC9X+tu7f5buuB1QUb2w+S
 rNNT6fdaNak7ZT36ss9OpLaXW+OqHc+6pbt+nK/XUK62B30m6b2bdNF0uHZUy5Tcn/bbFQZOLQm
 xfCXvUQRbrR6ILtKcrkR7VkMY9oQxsQa1OLM4qA3ImRfda1opRPhP7+mm3liHc6vDISiAyrq9Nr
 jqj9hWv8NjVsK/jtRa+cHwpihZSBWyMMGiLG3qLbeNvMhahIInjYSnhwC/J2ryhMeJEt7/1exuX
 nRf3VP62tJEfuEi5OcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA0MSBTYWx0ZWRfX5F6nDRVG6FrL
 ODDWwAw940jeixBm1ujScIClClE7JhKpeLSLhyXOQGsdatwwc0zeTh5NtW2BOrqc2pOvDOaDyUD
 WqVa5PuaZfzPctho6p1Y4NzkhERRNzE=
X-Proofpoint-GUID: mtxUVzCyxG28VfcbkTSaFwhXJp9TOZi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210041

of_changeset_apply() interface adds nodes for action
OF_RECONFIG_ATTACH_NODE and calls notifiers for each attached node.
Then the caller uses of_detach_node() to release each node and
also calls the corresponding notifier function. In the case of
failure from the add notifier for any node, of_changeset_apply()
returns failure after adding nodes. The current implementation
does not the provide any interface to the caller to remove nodes
from the DT without calling notifiers. It may end up having nodes
in DT even though ADD is not successful.

This patch introduces of_detach_node_no_notify() interface for the
caller to only remove node if it is not attached.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/of/dynamic.c | 16 ++++++++++++++++
 include/linux/of.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 744ce0e1eb24..fc6f22371a97 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -318,6 +318,22 @@ int of_detach_node(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_detach_node);
 
+/**
+ * of_detach_node_no_notify() - "Unplug" a node from the device
+ * and return without running notifiers.
+ * @np:	Pointer to the caller's Device Node
+ */
+int of_detach_node_no_notify(struct device_node *np)
+{
+	mutex_lock(&of_mutex);
+	if (!of_node_check_flag(np, OF_DETACHED))
+		__of_detach_node(np);
+	mutex_unlock(&of_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_detach_node_no_notify);
+
 void __of_prop_free(struct property *prop)
 {
 	kfree(prop->name);
diff --git a/include/linux/of.h b/include/linux/of.h
index b920aac6b975..7a509341e998 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -442,6 +442,7 @@ extern int of_update_property(struct device_node *np, struct property *newprop);
 
 extern int of_attach_node(struct device_node *);
 extern int of_detach_node(struct device_node *);
+extern int of_detach_node_no_notify(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-- 
2.55.0


