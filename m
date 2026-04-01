Return-Path: <linuxppc-dev+bounces-19142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5CD35162
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 11:21:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2cY435Pz2ygY;
	Wed, 01 Apr 2026 22:21:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775042493;
	cv=none; b=XcqjyX8ZqNamocT38jOt5sh1Tx8qo+th+pi5UV71KGd6pmnsBP0ch8YjgWDa3I91aLwXE8FwAAlUj3m/52j5+2CAFSOWWqaSzaj3dkyk5O8E+5BlrLcqrq/jzASWfhCJlO3Qpq/ESwVD1TjUjJIozESMQj2HrRyUBPowBxFCxOHW/rVbXzX/5ZUNQEaQo9I7iNCNqrZ9AOUIKmmIWiObf9z858oQe1I+Tkz3wzgAbpwXioHlMS75UAiQXgcoIpDMxQBZq+Jg1Ot53YcdrwakarHXoE1pUCmVQNIe4RpXLChCUgRUX9hsWBOZf4UJETIS6944jGhApF4WXmUrhuc71w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775042493; c=relaxed/relaxed;
	bh=VJjTbq4YncHhXwFfYbGc3aDQVETLzdOAb2F35qDqNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA/kF/+nXujUQIjTAdCwfEEMzc1KPfCifnwAOlZqE8xQx3gYL7EOYcYQ8E5Ki2ynHXv05+axF5WRPnPnphJtt1Iy1mRrk4NtVwfzRgzzhwAA90VVpX4YFFt5rIXiK0LO+ZoW3fTL5RKE1yEWL0LaoVY/T86mMESo4PXaXRA1QGi2m9/BV0kXaiDjoE46VdDmNNsPyLMt2QFupn5zNIa7ZUgaWS/HQZzCn/3uSNOjMzbEG3JRx7tymh241GmIjqSUHI7oRzAQvQGuyPrUboXkg35qW8BRn7DO1FyOAv5DkH+Y3P5k74itzvftShrOEaJ5r41SDc2dDP+vhNx2QefwUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XzQMbPXZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XzQMbPXZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2cW3GHmz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 22:21:30 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319HAd7202727;
	Wed, 1 Apr 2026 11:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VJjTbq4YncHhXwFfY
	bGc3aDQVETLzdOAb2F35qDqNEI=; b=XzQMbPXZyokTcC8I/UgfPom/Dpv0CnFxq
	6A0yiDSgGP22bU0alCgCrir22Rwt0J3mTIcjnJvk9TqY0Fbw3b2oiEMOkg73D65A
	xUZ7VrEt6/Eoc8mKIBJQ7Uhc2+sDdqRfr6NP8bDL1yBKQgij3bDl3O6nDzVeYHAQ
	nrmg6AI5XIxARArjvBtG/JGKwdYpQC5P3PV0jQJI2hbeVX09VcOphktxe2bWaLnS
	oGQiO9TR3aFd3m5jvuqpQz1ctKIF88nKh26mF/lekDwQRyn/4V1zCRqfpSKlrzy9
	QWfUXVyBq4HtsAC2ArVxm+3lKIanV5AfyUznW1tyrK03Xs+gXq8yQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnqsh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63182bZs030955;
	Wed, 1 Apr 2026 11:21:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjw4ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLLEX21954936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B2C20043;
	Wed,  1 Apr 2026 11:21:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ADA520040;
	Wed,  1 Apr 2026 11:21:19 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:18 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 1/4] powerpc/bpf: Add support for instruction array
Date: Wed,  1 Apr 2026 11:21:30 -0400
Message-ID: <20260401152133.42544-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: 02IQjd_29Lu66KduikJlQsx7Ysk3_nts
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ccffb5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6tkAVXMqj22fOBSrVA8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX/woH+zO7pPzu
 Awe+/Peb1bmdH4E0a5XD1EN2qXUVTALCwdh0znvc6+uoiLj7VrVrayyz3Czyg8B/QPylnyjZZ75
 h+IJUPGZu37M2mkQS5BX4To3FKNwwgGvgvZ4/CtM/aOWjevO4+ZBQvxp1VoD0cKTnV6hQchxyIs
 mdn3t4qJqNyuLruYdKKmGawepJlXUuU/428PzTpaQ+AqKZsV9K+2sGcRk8iQlR1PpXWl5OQOD6r
 wJ6C69+HZsxTmUnMLpmKjOEgpOhJYy9Bnzb/xYrgVj9pZgav6qWR0AKQfIuAC4zwihN2aC7nRn7
 8bxyKzKY3D5Wqi5wIVZpqZCOR93ioA6A+bBkCGTAAj7hwsOpFTSUhnXFFFj66nJKuVADXX265wh
 RN8sPFAchcvUr6ZPj4DfMEMSVgTL1pyEBHNT8RIYAFK4FGdFLo/PrtF/BHTxhFODG/WiXfNx1bh
 RQ+/StVfeI0uht5qVJg==
X-Proofpoint-ORIG-GUID: 02IQjd_29Lu66KduikJlQsx7Ysk3_nts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

On loading the BPF program, the verifier might adjust/omit some
instructions. The adjusted instruction offset is accounted in the
map containing original instruction -> xlated mapping. This patch
add ppc64 JIT support to additionally build the xlated->jitted
mapping for every instruction present in instruction array. This
change is needed to enable support for indirect jumps, added in a
subsequent patch.

Invoke bpf_prog_update_insn_ptrs() with offset pair of xlated_offset
and jited_offset. The offset mapping is already available, which is
being used for bpf_prog_fill_jited_linfo() and can be directly used
for bpf_prog_update_insn_ptrs() as well.

Additional details present at:

commit b4ce5923e780 ("bpf, x86: add new map type: instructions array")

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index b2fdf8ff9c60..50103b3794fb 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -373,6 +373,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			goto out_addrs;
 		}
 		bpf_prog_fill_jited_linfo(fp, addrs);
+		/*
+		 * On ABI V1, executable code starts after the function
+		 * descriptor, so adjust base accordingly.
+		 */
+		bpf_prog_update_insn_ptrs(fp, addrs,
+				(void *)fimage + FUNCTION_DESCR_SIZE);
+
 out_addrs:
 		if (!image && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
-- 
2.52.0


