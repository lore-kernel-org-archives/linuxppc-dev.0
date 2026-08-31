Return-Path: <linuxppc-dev+bounces-26282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B600C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:18:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLl3p43z2yvS;
	Mon, 31 Aug 2026 21:18:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175103;
	cv=none; b=G3KUI5eleoGo8YAucymIs3xSoQjXEIEzpqK0ENFq5PL1rWyNxneEkb4ZwFGh603N9OTa7zjDIZggYyS+D+Wi/oLu7EPCMk5EhPYvEen9CkoK3myzZcVeCnjp3+D69GhQYnSzRt/1CgpvxTeJxcPmR6azGotxh7meKxP3+AYP2ltbHZCNDvptlKogNOYAxTL0c8Fu3q3vSwzUhzlU2qMaZ4tan1n0v/P/DE/8vH91fIU4wi04Ey3EphfN1lnFjMMw46Dam62Zr8Ut9eoK/b6Jl9AKIaQIHcAkPwpIpIs+aRODii1SECOZKK/rcYuPnB0G1hiaOHv1DPi5xtcc+jsGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175103; c=relaxed/relaxed;
	bh=w3Ht7jwaLfz5JWi1v2vUTqFscY0+qdcIxI1EC5n7pXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf9aiabNTH/fZr8yeOvJIYYZXHdQPw/IRmjPU8eX4bGJPdA5tSsM0NiMTHSHFjDAuMwP9TZlmNXgb6G9OSGPFxnLNLHA65jlcKJ1y/o0gn9m1FSkDJ9uMS7jsLnTgw4bpFs1GSHMmv+DNu5kVITbz5b7WrkVg5TTd2y6NQwf0gPLgOLOhW3mPYrEjNz0dXC+Jn18T3RE10f1QVCrb+54ITvI694XAqUNOxE6IBoV8QzdAiNkZmwe2WxVzTTsdLjiQrx2XQKsR2xqtkXp6bQb+nRxOQOz69/vjYJRsyIpnxKzSnRLyc4y3A4RQAfv51dJTFoRvUq/VXGyN8Sk/u6zjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YGmaxDqv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YGmaxDqv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLk2rNFz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:22 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82H561697480;
	Mon, 31 Aug 2026 11:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w3Ht7jwaLfz5JWi1v
	2vUTqFscY0+qdcIxI1EC5n7pXs=; b=YGmaxDqvt+df9YDMY1m54PVLhLnHji3i5
	xnpS/KfeAYf6PMINeQ7KCmTTeq+gUFbL9U8XJdj4R+zhO3XgzTU2B/TT4qXobRMG
	FYRTAVNfWlBbZfV5v1o+vv2KosMGmVbbOMSy4hdUb+tAB1eIm9okoOJWkGxxhTlo
	DCzAq0EbV5WcWOGd8QsiVOHW1IzyJWbawJjNnUeM+NUB4Cr4uulzN6wwjCvUwih3
	R8NoqDYz0gCJDJZVelnlNvzlZQ+QwuEWu+oGszRzLgZV42XOBpqtWRSGf7W5eMlx
	S85mdroAZYoK6pVpw5lM6vuk1nH8CoxlXrv5h+TPuMIhBHORM9Jjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0pq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDNon007646;
	Mon, 31 Aug 2026 11:18:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq5pw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBI54e39977416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:18:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542712004B;
	Mon, 31 Aug 2026 11:18:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036A020040;
	Mon, 31 Aug 2026 11:18:02 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:18:01 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 06/10] pseries/plpks: fix self-reference in plpks_var initializer
Date: Mon, 31 Aug 2026 16:47:34 +0530
Message-ID: <20260831111738.334857-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9562f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=yo0uri9pEEIi5ApSFXoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX0VTWcXKJcSo+
 Vb/0x8AzoGFca6UKjuLzbNWOOr3OgrjMyBIos7JZ9kjUaYxQntqJHIQGR206eT/JQbAHeu5WpnU
 3kocEYOWXwHMFHt/W9erT5+gK/0nzRI=
X-Proofpoint-ORIG-GUID: GwvuHEutnCeb4c21o8nvJVj8Mjp0s5H1
X-Proofpoint-GUID: w5ZmGw5Q36aGuR-2xXGTLi-eB92znNCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX1vJofBIIqFI3
 5l2rixZZqruGsrjYXv1MatQ+hx98UKzPHl4OtmJAtGkGm4nMh1weTlnCU+30kLKR9a3INL3nknk
 eyIMW/N3hbbF+7OM7vsjQYz9LkJJ1ypzOKTcFUmL79KhAvhWXkgAAb0NGYtQPEmkNhfylhUHnYX
 lIOvgdYEb9cD9FFcMKfcfQUeaJRYM6SW/PRIHgkGqr4CJI6kp5zk3gwLZcUHvE0ClRi+DzcMiWC
 6R0x0WLb5v0j0OruJwPSUrGTo2kgFNSi2XgWtcsUElY27DCPgMPbmkefc/T+MFZuLudH8toOFRg
 dfdMRO41weRqY6lyDzi/eCFH8DkxDTJDwtPdIETXap6dQxUhqT4jzMxffVUei+fuY6e7iTD5SUC
 S7qXaxokYDwgQf/Lp7ol2AhrDrzAiwDWlBBMNXWcTTpms6GrVKcYcZ+KKqclLndNTPOezNPN179
 3qYpMgOLTIcPrsI0b7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

In plpks_gen_wrapping_key() and plpks_wrap_object(), strlen(var.name) is
used to initialize var.namelen within the same struct initializer. This
references a member of var before initialization of var is complete.

Use the compile-time length of PLPKS_DEFAULT_WRAPKEY_LABEL instead.

Reported-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b553f7b130b6..d582c786ccad 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -939,7 +939,7 @@ int plpks_gen_wrapping_key(void)
 	int rc = 0, pseries_status = 0;
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.policy = PLPKS_WRAPPINGKEY,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
@@ -1034,7 +1034,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	bool sb_enforce_bit = wrap_flags & BIT(1);
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
-- 
2.52.0


