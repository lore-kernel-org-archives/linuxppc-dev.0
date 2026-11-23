Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0104606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=boYRQZiB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY29F034Gz2yR1;
	Mon, 23 Nov 2026 21:24:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795429440;
	cv=none; b=cbFTHOZ/mIi2F0XRCXUbPNru8AjCbfwYH31lRu8vipDQK2OGJGqTxoURGTEWkUFvl/UUS4Y4T2kacN49vKnTj3CoI3L3ZPZXGbSNdjKukZsCYfBrZ+Fu1WgMFwAkNj9L4tA3ODuxgvi/AhwpVphakzsm6BovifnAo4Hj/ZvqnK3ScfPPr2vpuRA9GV3W1sJZ95JInX8e4INoDixwq0dpn342XnmZOR/Og1lpXRcjJVHRJI7K7Oo1D1+sezoeGou4zW4YiXUaHV1vJHx5sHAahagT08Cu7Tnwcxo4KmJTJNlLhoIYPk4wbkTm0E0Gz2egvTS0k2K48T2Sff1yPK8EPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795429440; c=relaxed/relaxed;
	bh=jtPmF+KNP7DwnoRQ+DopIkz1VDyOzRPcRfk8tIoDwYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBP0JxA/4lIO284W+EezHMzy6S5NChwaaMEQ4X4esP8TYuHj4jNFWfVReTzzhdmwR8aScQvGKeO4EMrjeuwt7xgj/qW6GGbrv1MxDiDp+9tsrE9FdKkd3jgL2LjLgIxSdJk5G1w8320zydSYmjbm//NLZ8cdwe88hy9sEPyh1cnMGTMQbF/M98WYEu1luphetmWi6biK8d5scn7jiVwqyYjkjp/ewmdmBXGymWGP9QgyfFSkOLbeyIn4YoqZFdoOstctmmGA3YukNMLUPMlO4XCeXlTmQoYODIqs0JoaRh7fKKX2AHq8f0O9xtfQNkenLtPd3k1jyZtBLCeTrxiD5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=boYRQZiB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=boYRQZiB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY29D1x9yz30dj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:24:00 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Ys5K3194885;
	Mon, 23 Nov 2026 10:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jtPmF+KNP7DwnoRQ+
	DopIkz1VDyOzRPcRfk8tIoDwYo=; b=boYRQZiBje8iYLu3CRhdqZoL/FaD+to/e
	ITmjPE04YVBx3hdx/sNJrPDyMmT39xdlC3z39a1qW4bvEfwiDp19exAPloJXeUTD
	XZHd6/7C0hp0RHAjuhBEHAo5XxGZj47tSfldjC8yruMtXkkAf3+AQz7WnT1eTc3c
	6+6lNBNEF1x+MqWUmZiLhUftlPKMBVzGLvTMWfIEmth4EdC3auK0wyGMQyfSxZ+F
	ihTY9xWZstum5NYbMGVeQzbHPtH5kcFXyf6OcV1293WFamLLBkoTMz5TZOOGaRW4
	VGok5GHFS8ar2KNUlseFgA8dqmvQIRV+ypP14kAoiqDRiDe29UC8A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv2avc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JJCs537969;
	Mon, 23 Nov 2026 10:23:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufp4kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANYqb49807830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8CB2004F;
	Mon, 23 Nov 2026 10:23:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA572004B;
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:31 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>, sourabhjain@linux.ibm.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v7 4/4] powerpc/powernv/eeh: Map generic EEH error types to OPAL
Date: Mon, 23 Nov 2026 15:52:42 +0530
Message-ID: <20261123102237.95860-10-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
References: <20261123102237.95860-6-nnmlinux@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b04142d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6j_9x97VlVn643bU65YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfXwdjUZqs4vZYB
 BMK/hx0YONotOxcP9Ff8DjLRTOclbE0Jp+oWTbZlnrq0ZLuXSNIHxXrqLUnas9E/7ThV2GYwOde
 qiRfW/ChZye83YYqUNswzwoNbPnYdJ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfXwD6U1v1wL/Vo
 TIK40VamQC9l7jt82KS4sQNewCuTf0PBzp7y3q/Xj0ra485S/s++pCD+HmkrxLdIS3MoA/zaXI9
 u8IHkQWZ5VJmtFyg7dUsJiCOJKRr/0VRpNy9nUu2pMPyoSoEpzNqqm5YX+di/BhK3vhjRd9JZab
 vhynzIwS6Ixpw9BalMsx/wJeyi1lNOL1oV71GJNIvu3mzsmoXgus5iOXY1TtPKWuKlfqKEaSA1r
 4Xc51gNGZwYOg/r/mkobQtYZBKSS1/WtsJthokX3ANVhup/Sq0x+kNQWAJK/SzlHvgOhNCfVTF6
 C22qSpTA+PdwQgeUg41y0kCavM3Y9q5uUxs1T2PrsXDMZDSZCH2EMpT3BW7eZO1DUEigKGQ1OIc
 ZJ5Cy+yfSMPqGgb34JP6nRgNt0b3Ecte46IZD2a7ZuW0I9fHrLIrMZHEkSbcQyIJS6njg6AIOEp
 3wcAt0v+SRZZSOlO/ig==
X-Proofpoint-ORIG-GUID: paRPP-DI402auDZFI1P0G5zRdj-gVTQr
X-Proofpoint-GUID: tuj9zBvf19msDLUzhRQgPRqA_08rBzYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230040
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eeh_pe_inject_err() is called with generic EEH error types defined in
the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64). The
PowerNV backend previously compared these generic values directly against
OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).

This is fragile: it relies on the generic EEH ABI values being
numerically identical to OPAL-specific values, and would silently
misbehave if they ever diverged.

The preceding patches introduce RTAS-based error injection on pSeries,
mapping generic EEH error types to PAPR error-injection classes. Apply
the same explicit translation in the PowerNV backend, which uses OPAL
instead of RTAS.

Add an explicit mapping in pnv_eeh_err_inject() that translates:
EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64

Return -ERANGE for unsupported error types, preserving the behavior
of the original code. This decouples the VFIO/EEH interface from OPAL
implementation details.

No change to the existing userspace ABI or PowerNV behavior.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..01dae760cecb 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
+	int opal_err_type;
 	s64 rc;
 
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
-		pr_warn("%s: Invalid error type %d\n",
-			__func__, type);
+	/*
+	 * eeh_pe_inject_err() receives generic EEH error types from the
+	 * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
+	 * these generic values being numerically identical to OPAL firmware
+	 * values.  Translate to OPAL-specific types before calling firmware.
+	 */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
+		break;
+	case EEH_ERR_TYPE_64:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
+		break;
+	default:
+		pr_warn("%s: Invalid error type %d\n", __func__, type);
 		return -ERANGE;
 	}
 
@@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 
 	/* Do error injection */
 	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
-				 type, func, addr, mask);
+				 opal_err_type, func, addr, mask);
 	if (rc != OPAL_SUCCESS) {
 		pr_warn("%s: Failure %lld injecting error "
 			"%d-%d to PHB#%x-PE#%x\n",
-- 
2.54.0


