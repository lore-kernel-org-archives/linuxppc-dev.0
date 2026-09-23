Return-Path: <linuxppc-dev+bounces-28056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7DC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:30:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlr73mL5z30VV;
	Thu, 24 Sep 2026 04:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188199;
	cv=none; b=mj9sGj85rg5VsEkCHkQaLGj+BOJL9EEAvYCxAFUYb9i6hRFN8g6QuzrZSkAPT82Cwv19FXZwjTQhqwbeQDoxEogQSp8GWtAv/byb614PLz30vhfGdCrJFQ9NNNtBZ/LrbrwtqXDA+s3X+f6uAWF7YbCrbkeqjbB7GxJGOVj1E4WOLniWaLEQwQ1RNE4iQP7Hhn8oDRJ+lVsFhwIGbrdNtEYJ1+mOfUORQtP71tJPA2oe+MdWGB+3VX6HSAwF+hnEmwk0X1Wt8YvLCXSnNZYLM81E9CrtCwABy8a4LXc2ha4UfqLEWJXkZxEjXNEt6UCNtm3yC6gRbv28MdbSAGsdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188199; c=relaxed/relaxed;
	bh=/68d2jRHIXwzdYdWgZQG+0mX5K+5CfoKIkS3N3rtcq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfbuLTttXpTUCZJr4mEeUFe8CTdAvDfhQsmMIZ86S4EJa3e5keOG8q0L5w1fkI/mX1NrIJgJveR6W0hYnxV6QvNbQH6vLsp9l7RaRVoEW0qCX+5fIk3Re9AEe5haYyNeBxNp6nU3tBY0OnfawhYZWoUK0uiwyEYpbl/aRhCMgjapkZ9MVOrFYPMI88TCVeXpGOnQZhSGg0HuQ3lW2ZKzrs4ClX/vd0V5z7vFIH1Pq1+7IBOy8JG8xF7/vBs+U3j5URD4vxJcKPmo0zxrNr4Rz8LWUeedpL9ZrPOaLVQBwvjaNBZ2PZXx290GMSM98ajRtIBBxd+U19NDgYjNw6lz7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RxPxyGeM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RxPxyGeM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlr636Hnz3048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:29:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGaFY53765689;
	Wed, 23 Sep 2026 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/68d2jRHIXwzdYdWg
	ZQG+0mX5K+5CfoKIkS3N3rtcq0=; b=RxPxyGeMkBUznQIxbBEq86GEGH2uLcNxw
	hRn16REu704PPj4XXlVm7HrJvoRzskdk03cJyLGGn8+drsR2oi+QFGmL7Jf7l3wD
	xdhuz4mqbjx1lK0tlAekS3OpvtIGgru17vTNxCz58RJbTeCZmKDK9Z02yLIORozU
	DOsWDy9O0HdbqXZpjRyt1SfE32AZvpPEeoY4/V7xxHa/oWKALWAGpjV13fgdsPlt
	anzp75wIegDOj1XNw7ctiu6dAKyTeKFgaEgJEUI8VjrvRqu6XnPM4nq2pglwRqQc
	Wys+am+YCCl86YR39ihY3NbZb+I2zrL5YpR/0DIF4+K6NNopc8EBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1mgnf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWmSs681758;
	Wed, 23 Sep 2026 18:29:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qj9w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NITguZ42074388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC2020043;
	Wed, 23 Sep 2026 18:29:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75FE020040;
	Wed, 23 Sep 2026 18:29:37 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:29:37 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 07/12] pseries/plpks: clear SED key data after use
Date: Wed, 23 Sep 2026 23:58:11 +0530
Message-ID: <20260923182816.151451-8-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: OaK4aawNOFcwnCv3Wa_qvEK8Jv15GudF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfXzPHcfBpH3PMz
 mWecZVLxRUnQotKQJNB5NsVfxFcgFEIHZERuY1+L/A2ngLIYqF7tslvLZWn8shLRPW2+Dh5m/Ll
 uSg84xXNvDT1ERcfj6aumnzH1R4Non+UPG7D7VGc2b/hI5yTNrFDsjAlm7VOB7cl+VNaKweuvgd
 ZPqkv2eoUqo3P6zkuEz9y0vSrQLjnvUIKzM3zouZUkNC0QrDytUKItZhV0xBSOT1mycGhnkB517
 5exA72hXpgJfClAboCSv+OAJ/E4+LtZesIoUMY2scRsDrAMbg4zFjdhiySd1FNG4K5XKkgZAdbL
 hAwMnTUCVu86oSA1aW1pZVBJWK99o8J9pVsjEOQNlidGw3Wu+ELlzMFK4GUuUQXjeBbFkGtmIzl
 0fowuYi4aWlBY68ABjzPSWbKQujf0PJqF6iGdGe+DYSToxWYkz13yz0o1CEtXLjFTNP6oFJr1AA
 AFY3kcvAUqyMMZOt4JQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab41a9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uQcaG2zeyhcm6AiLOIwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX+ssQjkiMYQF7
 dKyD6E8elWVdlkXCd8VTyzkKDsIgSfvxZZR7b4yAfSv8yygRIbkMXMiZhuCgZTRdiZIvwO2nnub
 HuU5g+oL0UzZRovjF+2kuFSt3laQDok=
X-Proofpoint-GUID: 8ZWD4pzB8hvzzxyI8mssDMUS0t-senxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

Explicitly clear the temporary buffer containing SED key data after read
and write operations.

Fixes: ec8cf230cecc ("powerpc/pseries: PLPKS SED Opal keystore support")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Greg Joyce <gjoyce@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks_sed_ops.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks_sed_ops.c b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
index 7c873c9589ef..ac3ec2ca7fbe 100644
--- a/arch/powerpc/platforms/pseries/plpks_sed_ops.c
+++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
@@ -84,14 +84,16 @@ int sed_read_key(char *keyname, char *key, u_int *keylen)
 
 	ret = plpks_read_os_var(&var);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	len = min_t(u16, be32_to_cpu(data.key_len), var.datalen);
 	memcpy(key, data.key, len);
 	key[len] = '\0';
 	*keylen = len;
 
-	return 0;
+out:
+	memzero_explicit(&data, sizeof(data));
+	return ret;
 }
 
 /*
@@ -102,6 +104,7 @@ int sed_write_key(char *keyname, char *key, u_int keylen)
 	struct plpks_var var;
 	struct plpks_sed_object_data data;
 	struct plpks_var_name vname;
+	int ret;
 
 	plpks_init_var(&var, keyname);
 
@@ -127,5 +130,8 @@ int sed_write_key(char *keyname, char *key, u_int keylen)
 	vname.name = var.name;
 	plpks_remove_var(var.component, var.os, vname);
 
-	return plpks_write_var(var);
+	ret = plpks_write_var(var);
+	memzero_explicit(&data, sizeof(data));
+
+	return ret;
 }
-- 
2.52.0


