Return-Path: <linuxppc-dev+bounces-22893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13419CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 01:31:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gknZn2mY4z2yvc;
	Tue, 23 Jun 2026 11:30:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782178256;
	cv=none; b=MyY2rZ3I70iBpZE1ArhftGoaQ8HrJm4y7Gm21Xt/tAgnNprC5Z8hhrgXsZgrh9ivbGpOGj8I/5Lh7YzSH75WuTMBITcJEfREjByHddVUu5j2Po74pcTffLCnjL1feb+5lsw+3hgRrCKRPDr4ilfam03FsLxOwRWb+w8hgibpszf+h1JpkStcHAcEvz0eZFoupUMOQR8eNuNBCIIIX3a6DJu2aqEJ50n1BHpgoauvMWgWK/v0R2VTjaXiRXCwLPj6CcBBLwFZey3TdBMbqoN24bh3Dbz1fA7ZruWaw61YTyGbtmWoX9gmkYFZoMLYsZUnM8XGqAqmF1brRuYK4NuF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782178256; c=relaxed/relaxed;
	bh=nMPyOQ7wvC7PkD7UNal5ikV4yzEt8mrNoQy/nLlVpKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5S9HklUB2Eb46ydlwL8tbwBSUEc+3ctYR7XqkwLB3UIFki8KT5+Ep2+6bh/oBtwRlmPfPC1iaMTrc9y9+v2BBGBsUVEW8Tp+FYWkUSdCIKCTznarGky82myLr+tlzrPjwTIJuqUTdCDWXMwwQZYPZETZCLgTi5cyleDOshTcNP4dcq/4LlsaDYEy3+n4fUg6qh7EW0iEtXGw1jtLaPlJVo3JEJNti2POlkzQLQcrILlcZq73NAe86iJHj2z4LVVuBNgQ+kN6ZR2ISi6cGUx055UxbWTGrOfW3c52QBkdI7KQnj9tafBodFVEZpfi9Qi3HahZysAleSWTkdy1R0fwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tI/BHP5W; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tI/BHP5W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gknZf0nh6z2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 11:30:49 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nBb8310006;
	Tue, 23 Jun 2026 01:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nMPyOQ7wvC7PkD7UN
	al5ikV4yzEt8mrNoQy/nLlVpKw=; b=tI/BHP5WoclgWAoJQTCOQuIYFGH7+QKT8
	AfugowCJhloapwvFGrsgQeo8+6+1naGIt/uSiTsc0vClP4oUK+gg1mCcoXp7TPI9
	GR5yO2fycIitZmTNvuBaakjMBgzAnZTqf8TdIsg9tBjI80ix9cFphAKzhkn65SNl
	ly3EKyZJho12y+cOQiue9L2VqKppS7X+UWHC9wraFiUgvnHxCem4vZM8QYR2uMXR
	zGQTPo5t1JdsnYvkrSesRmPCCvPOs7BBX4b0Ew2oAUfSY8iRTS8wsHKc0fACRXIY
	FsX3GgvznUff/jCp49xsPwOG5Oym8T1hbh6dIjL9rHBB94zUahpMQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hmbuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1JdNE018356;
	Tue, 23 Jun 2026 01:30:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vygn37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1Ui6U25625228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C50245805A;
	Tue, 23 Jun 2026 01:30:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E17A58056;
	Tue, 23 Jun 2026 01:30:44 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:44 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 09/29] ibmvfc: add helper to check NVMe/FC support with active channels
Date: Mon, 22 Jun 2026 18:30:15 -0700
Message-ID: <20260623013035.3436640-10-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623013035.3436640-1-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ijq4H93Hx1QxSRHr9-hy7J_wTHoxlxe8
X-Proofpoint-GUID: ijq4H93Hx1QxSRHr9-hy7J_wTHoxlxe8
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39e1c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9D5glHWTs2YOxXNpKTwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX7XABOTmqax+f
 gZ9z12PdDZFbs/6xC6NlTxJvechoq1yYbCrXKhAxh+58FKTkA5AkbtB0z/pvBddslEQkDuWtrZY
 esLvx5VX0F7Y3qcO01p29mzpCHVpvTNXa8wVTl5Ove7vjuNXi+txR9czNAgAKA23W8snsra7d5/
 Fxy0lE44J0yM9ygYnxwJHkSnshqKt26xYt/rCBs+LTmR43z//QtPBc/2Y4dCYi79HieZtJbqJ8V
 tbr9satPaaAvAVoDONdZpK7GPcrzCRKlQ1FoRDmJEWdyMU5sGLO8GALdqs7JGEj6LJvrhkSospf
 XpYdqz09G3+3ghrq0eibALguOuNq00v7NRnfQJWQz7gs1HPhEx9Q8InxoE30grJHOF+OEngQEA/
 1p39qqO6lkVHDajFxJv05D/Mh21avH36O/7h4bv3q/cZxJ50vgfNKIr+cx8ts4YSNC1gB1aFscr
 A5RYzaogLtTicOzPjAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX9zayhdriEoyp
 3DiI9MP3DVffIdYhPXeiXSeYD2Kbu3huFIRkd54/QvgEnqsALoRUxitDnRoTCldbbCwztchSY6B
 bz07LcnQEqCcnW0XxHjfP4fCo6KI5V8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008

It can be the case that NVMeoF is enabled on both the client and VIOS,
but no queues are configured making the need to do NVMe target discovery
pointless. Add a helper to short hand the capabilities check and active
NVMe queue check.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 8186e9321af5..9cd688762150 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -207,6 +207,12 @@ static int ibmvfc_check_caps(struct ibmvfc_host *vhost, unsigned long cap_flags)
 	return (host_caps & cap_flags) ? 1 : 0;
 }
 
+static int ibmvfc_nvme_active(struct ibmvfc_host *vhost)
+{
+	return (ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NVMEOF) &&
+		vhost->nvme_scrqs.active_queues);
+}
+
 static struct ibmvfc_fcp_cmd_iu *ibmvfc_get_fcp_iu(struct ibmvfc_host *vhost,
 						   struct ibmvfc_cmd *vfc_cmd)
 {
-- 
2.54.0


