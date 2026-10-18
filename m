Return-Path: <linuxppc-dev+bounces-29661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82353CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:09:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j74t20XnMz2y8f;
	Mon, 19 Oct 2026 04:09:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792343386;
	cv=none; b=my3R864EG8r1sNDGqoDAvVbW8iXSCQQiqXXFPDuQaNZxrWNHcCAKdkMYxlgJtv9ZmZ4ep+OwJYvyrILLZPiB/dStxKvJMAfgJrVpJwpc9CxfMH0aQxyRx5Nw/PIDuYVPTeDxCKV9SHpNW91CWxqSj23RF1OZ28UX4JuYRnD1tOW5EVUKlntpNlKYSSQ5g/J1wKQtBR75IlMjWCacEo3Om3f0nc0qfmC6h5fvqAOpTF4LfjlTCQfJF30ebr1cH7fgOBM/kU03NQRpNTwOJt5nsha8/Lwz1SGrHv+i6eeuIsGvtqmQphsAfPjZVe9Mywdnp3bslgK62LajOqSUCvHEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792343386; c=relaxed/relaxed;
	bh=FOmFE1eAy1JYG1JSZWLrqiHrDucGdCxWhppEPzq+Sg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN2VSQWJ+2reKEW5iVwEczJzjrHqOv2UedHfJp+vUUoKobttcNtQRQ8SZFub4vXP8dh6ofdIP70o6B93xtZLfI3g9U6HSnD465kSk2E2hXR5bTADeYAgC9bgZD0J7DuwVUBs1bVohlHoOQSSyJW0szv0R745QSSj4kzUwCsGHGdK4Tw8Pukt5Wac4Zi+O3rB2/HCbimt3yJNktqi6ldYAcRM1sRJrMejxqNMtsfdaXUfR2vUgfqR3XgkIS1tisOHrbgKNjgN1vFaOgz7MzF+nx5oUAY2kdGj5bEA8zI9MLqzczpSs62HC0eP2zdiwh8zxe+fE2KLQRTPlcpxXqKgeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XezsjkiA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XezsjkiA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j74t104G6z2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:09:44 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFEqCI130978;
	Sun, 18 Oct 2026 17:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FOmFE1eAy1JYG1JSZ
	WLrqiHrDucGdCxWhppEPzq+Sg4=; b=XezsjkiAfkZtEL4cYUrChWDYk1HhLsuuF
	9ea15aM8GUTdEu95zGiSwGKJYZmf3+Z84iMlhKlRP899rwUWDcp0z9yGmgFlw4rQ
	jMu4JlvBK4SYA1Drr6PKn15+jlyORXnqhInM4+/dTAjoR2YuXhByZmD2WncG5rYl
	CBtLAoBjU/fzesmHbcqO57ICZEfctt8MlUtQ7HNaPIFX6/TeBZpZFDz5dmeyyI9J
	RYkdL0aA81N8RE6dD7l/4XOMRDF1+JXwPmkNFXDi2vaEVymy4ojOYwRoT8gUStqA
	anWOlKqetyZb5TDlffvHXTin5QnJMfI7GOYEIRcb5eN6dDSXRfRhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepp98c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFJwGx1540993;
	Sun, 18 Oct 2026 17:09:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgt0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH9Krb31195578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7369E20043;
	Sun, 18 Oct 2026 17:09:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2309220040;
	Sun, 18 Oct 2026 17:09:13 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:12 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 2/9] pseries/plpks: fix double conversion of wrapping key flush errors
Date: Sun, 18 Oct 2026 22:38:37 +0530
Message-ID: <20261018170844.491252-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX5dLv8DmpYqw5
 SfI+YARpZV3fM/BcdpQCGCs+PfKNnMd0NiCYzmghHvrULJBFS5gu+mY1KOEkNZep2Aa8otJVbsn
 t2alIdpR89FR4mKio4nv/lhwkRH3LXU=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad4fd45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7zoujJ_n9ZNfRkIbun4A:9
X-Proofpoint-ORIG-GUID: j_gULLcBvTv_mfpfU7PaRVoj1Q9Smn0O
X-Proofpoint-GUID: 3Tp-dujEcJFTflYdZdmQO9fYbuOS9W3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX9egTMbZ4rlMX
 a/39g29YMQbRyfP7XXMNz/SMkXQzGVHUo+8nyOLrQqhzxpPOMS659sMsrPTg42eBKoNlOu6qfDD
 I7yPUXpaNlfyPzbubGP/R7BZM01IwKNAFyVHRMI0i1YQJT0rl+MPhkKk9U0ysE+P/ycvBm/Ivxb
 JMmYrUbwMwdcQy5aQctdwfXcvZaOqpSeppzeJOukNvxm/RATlpN622aQ25Hx6NZeBrWXYkH7Fd/
 lhkoiN+nCqpAe9fQcGnMqjoT3nnriVjLwczgox7lJc8Ey6dOjQIr3etgyc1Z7f5l1TRWtMNXgZq
 V5bIzFeUwFYBi6QBmLI6LlHPPBk3pm+JqQe986H22KCOtCZ16zmOBWIi30JQTZVEj7nxoj49rvJ
 xLtwF7bJTbWn0npG5l1QkCTdokXKkX6WfA1ihh5lHfLynm/t+r+bMBO7REhAj+cfMxSAKbPS13O
 SmGIlMlIBUkFXpG8OmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180066

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_gen_wrapping_key() passes this return value through
pseries_status_to_err(), which treats it as a raw hypervisor status and
converts it again.

Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
plpks_confirm_object_flushed() unchanged.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index c86960f102dc..584091f9aa08 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -938,7 +938,7 @@ int plpks_gen_wrapping_key(void)
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
 	struct label *label;
-	int rc = 0, pseries_status = 0;
+	int rc, pseries_status;
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
 		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
@@ -962,17 +962,17 @@ int plpks_gen_wrapping_key(void)
 			 label->size, var.policy,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
-	if (!rc)
+	if (!rc) {
 		rc = plpks_confirm_object_flushed(label, auth);
-
-	pseries_status = rc;
-	rc = pseries_status_to_err(rc);
-
-	if (rc && rc != -EEXIST) {
-		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
-		       pseries_status, rc);
 	} else {
-		rc = 0;
+		pseries_status = rc;
+		rc = pseries_status_to_err(rc);
+
+		if (rc != -EEXIST)
+			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
+			       pseries_status, rc);
+		else
+			rc = 0;
 	}
 
 	kfree(label);
-- 
2.52.0


