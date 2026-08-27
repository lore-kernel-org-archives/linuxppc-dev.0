Return-Path: <linuxppc-dev+bounces-26132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C32C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:24:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVs155qP4z2yYY;
	Thu, 27 Aug 2026 16:24:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787811849;
	cv=none; b=GkuyZ7amslSgux2f6IiUobMVA+ybc6VtwUts2QdfyIboRcuT25EY72PiiRaHfCNrJ26i1GSgLB0IRKtY9PHqQnx+B7/OoKsGpviZSncCk7/Tz8478KocaYT8A3UcgUlcWOfavOaO0nDa4Z0eporj4THjSnm6fVB94qUcgLM/QRy4sA0DhtiOl4JIRsJavdmWOh3oIU/kW7nipNER/RReYs53TeoBy4koPpdeJBewxQ946xSspwgPwUGOclV4Y6R+QnA2xIyk4HWIT/qIXUP2bt9Wi6UufD5MPMbOBQ08R6nytlfXfS/8om1b7dQQL8C/xcZcE+SPZ5WODT15qQSVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787811849; c=relaxed/relaxed;
	bh=fQoVl+C7ic20wFH9zMPu6rlMjpEI6FGSpNV3Fp23enI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS5GVscJH3fNpcXBRruTk9n3j5breGr7ZBirY6QToPSQkqs9eRhcE+/oqGikEDGlC/UorFa5ikvFxcuZySKCbE/eQkjJ638jtTHJdEymg3BZT5B1EUQgz84bmmyKvw1fWm3/+BpQ1Q34kNVeODUWDopUvghTMGev3c6NSohzcJRdIH1fMUpdys8vd6laPCEZAfzbLKrVGCLoFVCq+gi4ZjJDuAvIizl01BVyqnMB4JxZHn1a30cJLZyTPTiY3y5Rcow8K/LAK4VUufAP8tpb3pYpKnUzzsWoh6WY+0ZTB3Pt899RCXieoDVwnnrNs/Z662xf6664YBr2OAz5RcmTyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o93Dkd0w; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o93Dkd0w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVs146zJVz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:24:08 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3W8g41716516;
	Thu, 27 Aug 2026 06:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fQoVl+C7ic20wFH9z
	MPu6rlMjpEI6FGSpNV3Fp23enI=; b=o93Dkd0wygQ/vdvc9gveJ0XcTAEc+zzVP
	V9GSCNTBQRUhSSiVcQai4M5Wmh0G8QyeellhhlhfKiWFG0YxwMy7NEWqeoreEPp6
	QUsQrtTmq/STGbKFJ9wimSg3XPNHRrzWafGcunMybXsk1NY767K9b25wMzT31gbM
	QF0JopH6JIDtLm448fT93BNy9BqPZYyvfuaIaK2st3ilVqnHAhrRtgvS4u7etDVI
	+4M8iJQQ6Vrt7I8gGy3nTn7sV1lDUZwbfz0ud6MyC29MfbZwa71bwmoDDbuaw5Bg
	wQo3W33UkEWbM/ampFi+p0Adh0OfPrc9egX3XZb+FZD8t2M257HwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j3ner-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BIpP032039;
	Thu, 27 Aug 2026 06:23:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhedqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6NolG30933564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:23:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E36A20043;
	Thu, 27 Aug 2026 06:23:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB9A020040;
	Thu, 27 Aug 2026 06:23:38 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:23:38 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 2/8] pseries/plpks: fix error handling in plpks_read_var()
Date: Thu, 27 Aug 2026 11:53:02 +0530
Message-ID: <20260827062309.724808-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfXxi8KTWZeoPgA
 /+QFjhToOCvAPKV5K/4jQ/QPXXYTjGgpg71fpzhIkpwCKTCLyyGoYjYzTFwl0mcooaJq2fR1hg4
 I7vEE1JordkWRp6Ka3/6hv8hP6EoxsE=
X-Proofpoint-GUID: 1f6GFyNTOWhnaMUBssfemC4Dp3oSCBh-
X-Proofpoint-ORIG-GUID: yqtAB48qtqi5bYMVejs1M5ll1Kb3qjyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX1ab0m/hNCXjA
 1XrIzEaYLV/AVQqhulmcfYxbDEepZaSLsBAorWrGB4C7otEWh/23s9GWgFHNUo85hQR1JKxaied
 LGcUvMkQA2j9nwuD4SUcOju+3vnn1TNbBbzVwXEOpGdMVddYFNjywaUWrMw1A2w7Y10kWzKwzsW
 xVH1jkeuFwnEWhYTzP3eCbLlZMu7m/6ZnmT/ij29mI74AUrkaxQE+6vLipHxG9HFR8ygXgrnDib
 r0lz7fhRhPlWBCMegaJZxbDdtJ23Csw/Z1Y0pdSmeA14o/JsmtyLpv28KwNrbcuqMqMAD3a8PDI
 g6GKH26cFfYJ8jhyv6rbtXCAyw7vrR9Ww525+iDcspswDdz4DbWogj2YGfbmKUR3N+m+YTL3Nqn
 9zb+k/Wg39snVoD0BC19hLynDfl+MvS5b14bI8SjNus+OlAnM26Sxn+hITKkog8OoIiAiUN9UYM
 ILoi7xwtlwxAZtcIQKQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8fd7fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oL9t_hqQ2ej-tATgvj4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

When a plpks variable is initialized without a policy and used to read an
object with the 'wrapping key' policy set, the hypervisor returns
H_AUTHORITY along with the object's policy. However, plpks_read_var() at
present treats this the same as any other H_AUTHORITY failure and returns
an error without propagating the policy information to the caller.

Distinguish this case from other H_AUTHORITY failures and only propagate
policy information when it is returned alongside H_AUTHORITY by the
hypervisor. Remove the explicit assignment of rc to zero in the case of
H_SUCCESS as it is redundant.

Also return -EPERM instead of -EINVAL when the 'wrapping key' policy bit is
set by the caller, better reflecting the access restriction being enforced.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 23e4e2a922fc..7bd5c149dd09 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -826,7 +826,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		return -EINVAL;
 
 	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EINVAL;
+		return -EPERM;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
@@ -856,22 +856,21 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
 				 maxobjsize);
 
-
 	if (rc != H_SUCCESS) {
 		rc = pseries_status_to_err(rc);
-		goto out_free_output;
+		if (rc != -EPERM || !retbuf[1])
+			goto out_free_output;
+		goto out_copy_policy;
 	}
 
 	if (!var->data || var->datalen > retbuf[0])
 		var->datalen = retbuf[0];
 
-	var->policy = retbuf[1];
-
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
-	rc = 0;
-
+out_copy_policy:
+	var->policy = retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
-- 
2.52.0


