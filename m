Return-Path: <linuxppc-dev+bounces-29631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B3CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:39:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6VwM5tn1z2y8W;
	Sun, 18 Oct 2026 05:39:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262387;
	cv=none; b=U7hoXlq5ibQ5/wRBx9gnccnbAeAgf7/z4FiHYr/V977YXqWVCvlwWhUrZfGKY0KcOGbPQ/9MKhr41zBlt8lwD2QHkCkOxvTycdFSxyULaGbk5OeRbiHODFm9iHMYc8YJ3YszZ8xZ1XSgwDcShdyKof9PXugUhCC0JXqCWLqqgXoz2iC0UFibulpjcch1FYZJ02LjI6B5OsEbGrTUqd2YLc2o99dTzXN/dTaW3ItnCEqdaot0mxtyVureC0WaS8TpeAG0JlsyIu+GajMv4gFuDV1mO7kk2LEvvcCB7mgjDvj+ZQL4ip5uxXKDGMopcxPTHhwcPY5NkWG/5LXpOJpHog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262387; c=relaxed/relaxed;
	bh=KTLDFca2RUZggMNob4Mpw36J0eNj2WkttT/RfqgV0xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgnNVHrx6h9Oytf+9Xkz4FbOkL/1/YAN4TrREdro2fcvw9h31OebVvlpuqZKGt41dsktwrROxPiNr9H6497LA595FKaNJAispXPJQUl9oQ8TPP3oSuIe18CTvBhTaBoQ9X8z6fewCsiTbvSj5U/r+Y2r0iKdK9pCE7CL7LntidW1q1UXARJvPupPJw4ejtoloBdtrAHmRwlH1rzX+onr85NgzfDrnX8nnJmaNjSDqxj64wH+HyhAhsgJ6WL31iKWWVmWy+EL1UZwGL96t+fgQkq83GbBhqcN8Sis5sk0KGheeGYHvIewNgJEtYzK8DEPKhm0A4pt9uzz/B5i4hzdmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hT4jV8Xa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hT4jV8Xa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6VwM0m1lz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:39:46 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEMrG2982246;
	Sat, 17 Oct 2026 18:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KTLDFca2RUZggMNob
	4Mpw36J0eNj2WkttT/RfqgV0xo=; b=hT4jV8Xa+FChPKe6UTDKpG4JfaujO3oWB
	HLubhhIYjQGfWl6DI1BSjWf5FdDI36ZIi/Him3vQLM9PDzE0rmr9DHxIAvkWk4J+
	dvVOqqf3nwRSmPTNJ971L17JUT+XY2jEp3TlwkJKzYSddWF6MwgEK8nFgYyTNUWw
	z3ityyn7GyrDUZCijSVZ47XVS22kQ9EghN2LmQZBW70nUrhxfTMAk2Nnc/56yCm7
	6GwOWBYmUAbpdwe3dhekI4S7h3+y8vxeeNwjtfYuxd1/r1b1HxnRkpWrn/LKxhA0
	J7XmJdytR77FBRE4j6e+yUcZkqP5eYaqO8bhEeyrBkfqcOdDBC6ow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h52sga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJxhr1277496;
	Sat, 17 Oct 2026 18:39:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb2398uh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdGad14483960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD6D2004B;
	Sat, 17 Oct 2026 18:39:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AD3520040;
	Sat, 17 Oct 2026 18:39:09 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:09 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 1/9] pseries/plpks: fix double conversion of write and remove flush errors
Date: Sun, 18 Oct 2026 00:08:45 +0530
Message-ID: <20261017183853.596052-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX7drpqJaAwfRA
 er7xeYJm8In+sAkEx0/FOboIJi+nGWn1Rpbh+gDownPuoE4XsPQuT/2+PvRj4SHmV29tbH/Ufu0
 1KHXYwIQLmKZkatnCTiML8CeInaFJIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX33bMJgb9ZF5q
 6DXgybJo7PD+uG6VKbTkxErbxzUCdCmS6fgxw55cvj/1S4B9QuP8yeYwjNmxjx4khJQ+clEtT8D
 U1HPV/fM15mNZlA0HaaNY/4V2SLL38OVdfo+w8r7U0FAmPzvpEAGCXkWywFTBns2AhtUjAWY5iC
 Y8LN4wp3PkasSRd8Pn62G+hvTKjoJo8hGu8VDEtdbu5awuA3Le8wcFjtzeulS8ZyerATZlxzbDF
 gfnY79AQrObpRl1gLUbp4ZZb34S9TTW/chQvbx9fHDnsCuaTik9A4mEJVnVMi7SCxksM81B9qvB
 IhLAgJMFS5fa/k4etL6WVcJSifih46OPVGD+1ORLoc6ZIVFh3pQDjS8CoYgP5BO6/sGam4VOug1
 oV8dzQ+GfYdi7aGqkq+nNoHQcxuwlO2ee1xcViN3ULFxiAx5jz9f6ZN5JVuCQQ8vRKuhe6dPVzU
 X3WLWBD4o47ctxBfnoQ==
X-Proofpoint-ORIG-GUID: JG84z_HYhTBljq6dogfpTklVN9MXvF53
X-Proofpoint-GUID: _-5V1h0ZmWJdf3B01ZTnRXG4pgf2NIoS
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad3c0d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TJ-IsHwomnPjbSOrev0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_write_var() and plpks_remove_var() pass this return value
through pseries_status_to_err(), which treats it as a raw hypervisor status
and converts it again.

Convert only errors returned by the write and remove HCALLs, and propagate
errors from plpks_confirm_object_flushed() unchanged.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 240cd5632446..c86960f102dc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -750,8 +750,9 @@ int plpks_write_var(struct plpks_var var)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
@@ -808,8 +809,9 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
-- 
2.52.0


