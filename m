Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47347606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AP/jkJTU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY02N12dcz2yhV;
	Mon, 23 Nov 2026 19:47:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795423676;
	cv=none; b=AeOx5Ak0Nwqfvzl6AY59v86QR6xHkREidOn1p01ptuZHX0x4BQsIDBjeZCloHNSpDR91yBr5gQCji+1CIPfMyYqlZwsaBR0Ld6mdAUYJ7c1Y5u+HYX2tLFJrcuHUKl5K1HILXMa4JWcCbnpFBqRbbhuk6VSw5npdXYmrYIlyk+s5Xyev/TqKSVvDhjyn0MXr8X8RUnB1LzPGKK21uZqXMbZwCuPM7zA6V9JnPiWKenWhPk0TJmHJUTX6flRWlBiGWUjD/9P6wz92Q3SXw7bOcEn7SAyBiy+yB3fJ8N2mEdiMIJwjXfTqo+Om56b3A22ogyEVxiCqegZEc1CGkiYGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795423676; c=relaxed/relaxed;
	bh=jtPmF+KNP7DwnoRQ+DopIkz1VDyOzRPcRfk8tIoDwYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2elDQLWDXR3mPpjH8JE7EY4tdAiFTN608v5W1LMA2Dd4aFW/4JKgP0YazgDlurp8P+FKevSylvkI5nik75QOSYVVPFvy1WH1AmUJyRhZ6DlPS0NQC6AJh4la7VXV57ZNcXaqE8ypPHKgFmlDL79gfuoF9IxDxFf7CyDcOQUm8hrBm5Sh7YaujbkBtYyuY3Y4HUnpYQbDZaxzATKZfHXPMklhHGt3X/xUHGLevLTaHADjEexLvObeYKZlhcn4AbBO85B3BlE7E3orYrE2DkNDzT9S2jr+m4KhQyC2oR34lvea5hTAXOXDB+wI/cO58/NhWjPp+d+5q/N1OMWrfdQZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AP/jkJTU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AP/jkJTU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY02M2VM9z2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 19:47:55 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54q4g1364721;
	Mon, 23 Nov 2026 08:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jtPmF+KNP7DwnoRQ+
	DopIkz1VDyOzRPcRfk8tIoDwYo=; b=AP/jkJTU6qwWdm3GDdkCBChVcblaOmqqw
	a/kvPplyrAPd97cpYcp3bsJe9psPxBAQqCBTu6Gxo+8KfbVUD8cSi7iP5eYOVNma
	7SSazqKVgsS6mGF3qMCvy0ZI10M1tPmQExq/RAIokZlz0Vbzo52g9hZUyaSEVfXu
	xEKaomQpGVFYiHeCx6DrXcnPIJn2+RHy8fZkl4XOMFzvfcIb7P7pq84L68B4oKEv
	eAK2gLbClYqeN2DtApRzdCPK1Avhz7S4jrsrCpgdPNga0mIFcXxDHw8NUZXvwLAl
	jeDhcwp9gU8l3Rwehv8IrO5TkXYjNNGS4jfZ0N+pNvTogxYJjtRzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p49v23-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54ORC2817259;
	Mon, 23 Nov 2026 08:47:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjx0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN8lT9M46334392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 08:47:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D08D2004D;
	Mon, 23 Nov 2026 08:47:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ACCE2005A;
	Mon, 23 Nov 2026 08:47:26 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 08:47:26 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v7 4/4] powerpc/powernv/eeh: Map generic EEH error types to OPAL
Date: Mon, 23 Nov 2026 14:17:02 +0530
Message-ID: <20261123084658.61330-8-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX6EbCewMDKnIb
 S13DcLgnublBt4ugEd0HKCx84mGoywPoMUVNyNz46uBS1UOE4t1lG2yYDdvd/IWF40Wh7h1+Nst
 5A0UUo1arkfnf3SoqyI+48X3Xv0D9HM=
X-Proofpoint-GUID: hNK09LV_UAt2WejEAoo1gY31wbRsnz8p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXxxjZfwbhCoHT
 emuGRu4UQavQOASBYOZtpj5WkuOdaJKzub0S3nkV7gUFTTqmMoisg331IBBmKmcwetcI/BMoDCF
 MsAUQhzCboH0CBrWwM3rH0GcYfydxlQR5lJDSw4vkVMSTiXxYtuznDoF0sjucOOVBA/aSfT6Apw
 Rjlk04S1tUuZuYpLgaZ8XCF0g6zMiuBcsHkWUdNP8NAkeInv9UX7d+z8jesKj/eCdk58JuPp5oa
 ondqBjjWDQ2UlwQM7nOMkXHxkmA41F/GZs+Ad/2qVJ8leCsSeeISieZggqChazy/LK9gixbH+JE
 c7mC4dRW50IQT68t53blkSLG3O8e3jROGj17WYpN7VzEZH5G+U8RDh/oGKneA+qIe8RgUbl1867
 vKMuEyJTueapKLxswCZmUJhVLb3dISmIu/D4VNFWNEijQIwZHM1m+E9XrhjdEigauw1KVQfRpWP
 p1gpmHFaDy/vJYYDk+w==
X-Proofpoint-ORIG-GUID: FSVLxOQlCIZa9g7jUmfE5BfrMw-LsBj6
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b03fda6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=6j_9x97VlVn643bU65YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
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


