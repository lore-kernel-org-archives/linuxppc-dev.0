Return-Path: <linuxppc-dev+bounces-23752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C6C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 01:59:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw1VN6kFzz2yft;
	Wed, 08 Jul 2026 11:59:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783475948;
	cv=none; b=cB3TBZNd47CBkOqyEwtEYj8ghvapoQzEmFX0JzUgC02L+8hCn0WE4QbSpDzOk5fy6LlDuzwhrRt3e+VxV2dp85Wn0T4J6wfW/ZNmkZf9E3hXg90kPnLkE5k2Gxpzmi9wZP6Th9EoAuzk33uH+jGX+Pjujz/cpRjRIRHPR0X14ZExs54zNpShD7dM5sfkqw10wjeg7gto//Z1ybGOupYsTlgigK2tScrmI9mGNgDGHq0zskL7YcTuMzqLsVvpkduMr21vHm0xTuNVhsx3hcjQbC9kAxZ/CuGo+t6lHeINHuRmK+BTttA1obAcw6epg9a9YEzwpFeGuw/p3x03QFdwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783475948; c=relaxed/relaxed;
	bh=ukZp8O9c5u9nOWy80cEGVhcN83ILXR7TwnILsB+k1Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGlcnH/QX4Z+25rSU37hLZVgiiGtNBRahO9Ag1w/WJ70TEZACbyYPg3b17M1fzkzBiQBgRxgytna+N6gngfzP062/CJl6SuBSM+Mv+Kf4Iby00ohcpHBZrYtmxJToOUbFjDdC79JM9xpt7nD1To1bkxRQDiklT9Jx7/ggKmA4zb6cgox0ypM5fijBD2TAiOdKSGFNasOX/eEgW9YbvHXymZE9M2+Wf1TYnxfWpsz97GtRicoGNrps+DRkL0UlXqWydVE0hq/4bBYyVsgjsvCq2iBf5Wk8N9FpDdPbfBbVQ0Bg3X2yrkCsbM7nUF36pPNXrcGwP40HZBfe9QIUmOW5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSxMqQtZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSxMqQtZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw1VM637rz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 11:59:06 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MnCsU164878;
	Wed, 8 Jul 2026 01:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ukZp8O9c5u9nOWy80cEGVhcN83ILXR7TwnILsB+k1
	Ko=; b=oSxMqQtZU+kujV3j7DXa+Gc8fqiBB9rGApYzdwS90G0rfiS8+0jiYRky3
	ar7KGwM3qMuqEV6R6G0/cdfsuNWjWrrX84pRww/7tb8YJLEBCSi8+6FiJk2wjlEa
	YvETtxBax3Dc0NC0e8w93IU7tGNDJEb0iRSYGfE2D8YOiDgfmvZUotgA42HOIZh6
	1LySUEsaThI4eFM+HUMaSesSA24wsdxc25xzxfnTvR8CGyZJO7AnpG/xKgpM4fG2
	VV7Cj2fU+ZSC4ffppsGlElDCPpV+XTY3psjJWJOfVQsrRgjOhLy6OFtnxEPIknrV
	Yisjl2xYKU4XhZN+ydLFJwjfkL0mw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6ststjas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:58:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6681nbEu024083;
	Wed, 8 Jul 2026 01:58:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y55qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:58:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6681woi825559594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 01:58:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8CE5805B;
	Wed,  8 Jul 2026 01:58:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 556A158059;
	Wed,  8 Jul 2026 01:58:46 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.110.190])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  8 Jul 2026 01:58:45 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 08 Jul 2026 07:28:13 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/pseries: Ensure vpa,slb_shadow & dtl are unregistered during crash
Date: Wed,  8 Jul 2026 07:28:00 +0530
Message-ID: <20260708015802.274271-1-vaibhav@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pFXrABif-9Q53CpbG03yvDdr_vrZt_Kw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX8fxMZRpAHQTM
 rJdG3Tk8LpqPq8Gmqy0aYu7hKZM+cyMRp5b7EnQu/aYLXp5EB+rMfUekPEtHX9sxsPw6Lz2Cq1r
 fgQxTRvj6bDY+wK1uBN1oeNubp2m1LE=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4daedb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Z8IfMt24Ap6u_xdwUf8A:9
X-Proofpoint-GUID: pFXrABif-9Q53CpbG03yvDdr_vrZt_Kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX7+8VPUgGzaoQ
 WiIV6ERzTw1uZ4vyWUKov/bpm4fGx81JfuSzbgvnvM3mykH+wrAAcKzwbaoj0fbYRQ2tHBeDf5W
 uLZdyMD3rp2Hm8JK6bKcTsuCWEnUYEPPNswUMmLCwKTXmmG4Gf6V+7XybRxWK0J3u0pDfIdepyK
 zn08uOY6MMunhcPvyVGz9NzCL2ttPoxiWCvRaVUgBtbCu4rqnyOS8+WQNYMsAuzkSC/5NzK8XRa
 73d6LxbhWIMrH8o95YryWbmlDUeLAbPQWBJSveDpA/Mh1wk6NMhRn0KTvd/mPlO3/C/+FMVzx3m
 svsM8vmkW49QB8ddmg3/+/++uKV6JrWcd9dh0qswEzihu+WprBRrxpeSvrqjfhZ6dwg/zExNx/z
 Mayb2jJB4QxKIHOSymg72osTxqoix1zHt2lz4GrJzP5pphjDAsn4bfJq5O0vCUyZU82kraE3+wH
 fMubMQx1i08UWXmwckA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080015

Currently pseries_kexec_cpu_down() skips unregistering vpa, slb_shadow and
dtl areas during a crash and kexec shutdown path. It was done to avoid
doing an HCALL while crashing. However recently Anushree reported that
during kernel crash while the kdump kernel was coming up, Hypervisor
reported invalid values for 'vpa.yield_count' while it dispatching L2-KVM
Guest vcpus. The error manifested as debug build Hypervisor assert
triggering to indicate possible VPA corruption.

Looking at the kexec cpu offline path it was discovered that during crash
kernel doesn't unregister the VPA/SLB-Shadow/DTL area with
Hypervisor. Instead it re-allocates and re-registers these areas
for cpus during boot. During kexec boot the previously allocated areas
can get overwritten with new content without hypervisor knowledge. This
creates a small window where while kexec kernel boots and the L2-VCPUs are
being dispatched, Hypervisor may try to read/write to a wrong memory area
which previously belonged to older VPA.

Fix this possible race and memory corruption by updating
pseries_kexec_cpu_down() to also unregister vpa,slb_shadow & dtl areas
during a kernel crash.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/kexec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 431be156ca9b..29f7c97ff193 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -20,12 +20,15 @@
 void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	/*
-	 * Don't risk a hypervisor call if we're crashing
-	 * XXX: Why? The hypervisor is not crashing. It might be better
-	 * to at least attempt unregister to avoid the hypervisor stepping
-	 * on our memory.
+	 * Ensure vpa/slb_shadow/dtl cleanup even while we are crashing.
+	 * Why? The hypervisor is not crashing so at least attempt unregister to
+	 * avoid the hypervisor stepping on our memory. If hypervisor or kexec
+	 * kernel steps on the old memory allocated to these areas before the
+	 * new kexec-kernel happens to allocate and register new areas,
+	 * the hypervisor will see invalid content which may cause
+	 * unexpected behavior.
 	 */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
+	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		int ret;
 		int cpu = smp_processor_id();
 		int hwcpu = hard_smp_processor_id();
-- 
2.55.0


