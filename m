Return-Path: <linuxppc-dev+bounces-20848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74FACD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 10:09:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFq1c1VRSz2yGv;
	Wed, 13 May 2026 20:09:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778666948;
	cv=none; b=HDYgm1PB113CPVL6dNuZn/XnMHBy20Mvoj0s6BDfIponIPxRYJvhYR0V2p5XBr5RjXITgnwi20T2eOtbhXwep6NN6HZon77uBdTV2cyxTJ+s4nnTLCPWgh3mEsy1FzQrdCjudpCLoDdmJZVAWUisQPSvFAQPjlL/zcq3hgD2SRLHd+KkRB5qTnTqvo8YnDIH7Mkbk0wVQJTEEm2QIaReksKG0Bh25GLiBSNE3x2oWNRZDShXNEj+91OLbqNXPhPe45f5iwflqbhFn0eWWLND8wpAYqVSNzhUnkhfpUBdpQXQfo35EYwJx6E6swSQmmCOtWeybJDPit+YJb7vr0whDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778666948; c=relaxed/relaxed;
	bh=eYTK6cAUBtTFuzy/O8wptvb61XPJ8NVqXjyj9UPi/yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0HS+owbOp0pAtEy82rnU7LL5MODAzTU5rzmbU1wEexxm3j84rNpcFQgwC3XeT3At2wgtmORimAg4BASefeOoQl9Tgcg+TsAegSxXc5yo4pZE7UjARLnvYkrsM3fORNnbIhdbyW/7nypUFVuifra5lyuXYXZcVp9fB8ym8eU1f+5RjEdw1vWXnQzDZK2SO694r7+Ij4esGpOAr+XpWHfEv1Ea2O+S3fgpRYtPJoslYWET3M752CHlpekFOzdm2xyDPK9eLyyNOqmNXl03SKO9Yt6yYD4QbnMyMWwKlsk3DVpQPIJOFTV3eOZrUsBS9q1aOwm3FxcA7CK7BsnRP1dMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iV9KPDGq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iV9KPDGq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFq1b1s76z2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 20:09:07 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3KUiG2608088;
	Wed, 13 May 2026 10:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eYTK6cAUBtTFuzy/O
	8wptvb61XPJ8NVqXjyj9UPi/yA=; b=iV9KPDGqX7ZDOs+6UhqLxbe2bktFBhjL2
	G0O2vitUvsQlp03PXW0POXOzCIVZnFCLMh3EsNyBR9uIcag9NvOvLtktmJeS+WL2
	Y6bMP/gggl5R8RLGoK3WDBAzrFRY09jpnKTTqxZo3g2YMED0yGvmg5MRoLntbXUT
	gmxH+HQAkLgBAqkNQWvmCvcz76/60B8MHUZd0ayCgq6b3hHrNbWwTCCFd+gkFcTH
	9WsGgSeUcDKBvH7/TAzoZQ0OHyFiUPHdgSg4I6v70a/1/KY8KZaQ08KCdt5cpReu
	hFeBYreIgUaDm0QPj5OOpdGZ+hSSBgv8RPgu4YJOrBFPYBDQVrcbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5751y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:09:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9dU8V024778;
	Wed, 13 May 2026 10:09:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgq8wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:09:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA8w3v61276538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3FDB20063;
	Wed, 13 May 2026 10:08:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80FC20065;
	Wed, 13 May 2026 10:08:56 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:56 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 5/5] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Wed, 13 May 2026 15:37:54 +0530
Message-ID: <20260513100755.83215-6-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfX/TNKQD8ZsDEq
 xnf+us/AasQaZDvdyetolHyfkMKPryjrhC9INEb9alHAsRdYW6FzzQM+rWooowm9ofLyWurNlCa
 CHhjVRfSG4jMOwl6HmjjIyinEaGBnmUyIxvdgebYCOefNx9O77dvKC1pdDY95o9OeZzrBsZ5uEX
 aDjGbx/Cjm+l7EuSIUM6kgXqVkNQ4wKJ7OA2D6NefbQmxm+Pl8m9tlDPa+XrKkzZ9b62awUqVJp
 EpF6UpaKh3mCtaXQEdTnYEa8j56jEeQvW73u4lPRK7cQN4+MXjJdqYEBh2LLfs8CLiXXED2P7Wy
 RTbd+tRqBPkO3v7n/sy+1kTRO48J9FuKPU84yyr5z+/M5TiwI/drQLLyxoouNTis91qQRcCFRqy
 Z1GGIAYewrT98zZUmc0T7ymsJ1YG0De4FRey+7fnvSOwmD4HmivHb0mz+kYpKRCVf478lBU6ekG
 FNVtV6uxmFXqCE+CFjw==
X-Proofpoint-ORIG-GUID: GHcvUbvyi9sBzj_5vVZaIPGnRCxtENJ-
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a044dbf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FhmJ5nnsb20HCo8Rnz4A:9
X-Proofpoint-GUID: GHcvUbvyi9sBzj_5vVZaIPGnRCxtENJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130105

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation.

The ioctl exposes host processor compatibility modes supported for
nested KVM guests on PowerPC systems.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..1b533f674a09 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
 
 .. _kvm_run:
 
+4.145 KVM_PPC_GET_COMPAT_CAPS
+-----------------------------
+:Capability: KVM_CAP_PPC_COMPAT_CAPS
+:Architectures: powerpc
+:Type: vm ioctl
+:Parameters: struct kvm_ppc_compat_caps (out)
+:Returns:
+	0 on successful completion,
+	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written
+
+IBM POWER system server-based processors provide a compatibility mode feature
+where an Nth generation processor can operate in modes consistent with earlier
+generations such as (N-1) and (N-2).
+
+This ioctl provides userspace with information about the CPU compatibility modes
+supported by the current host processor for booting the nested KVM guests on
+PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
+
+::
+
+  struct kvm_ppc_compat_caps {
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+  };
+
+The ``compat_capabilities`` bit field describes the processor compatibility
+modes supported by the host. For example, the following bits indicate support
+for specific processor modes.
+
+::
+
+H_GUEST_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
+H_GUEST_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
+H_GUEST_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
+
 5. The kvm_run structure
 ========================
 
-- 
2.50.1 (Apple Git-155)


