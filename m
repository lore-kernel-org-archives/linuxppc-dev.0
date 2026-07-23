Return-Path: <linuxppc-dev+bounces-24667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7DDC44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 00:02:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5BBL33KSz2ygh;
	Thu, 23 Jul 2026 10:02:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784764922;
	cv=none; b=BH5AasPsv96+cZgcdAK0fkDdLpr20KjZUiSaioXrOM233fwYCh/sG0O2qqGBId3gvf6DYUahiZrCLssBHHlJ9/2GoDgdiz/+2XBEccsOGgxk/KTjJnYXAmpbTjjuuu7f566Y1XzkZHgG3xglIXD2/vA6xJvUSykcm1LDmdONmjmcqYCQeDMc22Hz9p9fC5H0QVjnTDORODNH4giUctrjpk9gRCaOV4/ys7TULrtgXxWrkgaWbZbJ/Nm3VI/M3EezW8OCLJyb9iHyBVviN78NaNsBm6/SAm+ouHVCgsgKofm1TpeojSGddPJhXLaY13ROKLTieojVstT8TOHwWMzfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784764922; c=relaxed/relaxed;
	bh=1Lz7oJ0FYsIcYPqScRr9iYBlx+edI7pmVOtn6kcMoUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuBDncfISTvrm2KeYgXWKdHLZSqB/OlBg0WMd85lK28vdaPbJXE3aPlO9FdPsRh8/as0uwgRpI4Z6d29p8KP01x3WMyUOKM2FGqxJmXQhdhqd/LhRc7f1qT4iL7eXJFrwlCblQBc1x6r5aBXvEj6j3r9VYZzZl5+01husCKHU9Khnx+U8CFR7l3lop8HsVk43xmtv7NrksE8Lww5xB3Ka8yvdsvzy3ya/x50piMSf5a8FqOppVogLiB6187hFTpBdT9YaEsE6p+vJZyPeTuig+p5OyTDVpITvI2Z8Zbl/v4l+jMGjEf0T87hYf2Q8SBg3UpoMRQZJRp1hZOVdzEpeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mFjZLlcT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mFjZLlcT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5BBK0wPpz2yYf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 10:02:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MIBex2712555;
	Thu, 23 Jul 2026 00:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1Lz7oJ0FYsIcYPqSc
	Rr9iYBlx+edI7pmVOtn6kcMoUo=; b=mFjZLlcTiIHfziubtH0X4OgiM7Do2jvjf
	mwEVEgqS/8ik1fT1+9tG6o3vEQYhD/woZs/C+DruSobtLWCl89YSoP3/1ZD/fTB0
	rz+jV4j6NHB/FMv1o8yhfQ9dsNYMHcvmVcf1Ho/rFnIxl15XiWsJCA+AK7yI21Qi
	uNWYrA2RYYX8RTLSxp82hUlqIyiPFtTY0TmTuW4bmGp+Lvlk5ojGGxwSU472oBRu
	CF723HcSL/vmYs75ALkB5r2Sucahw3FM1siMY2KgzGowq9oCSCwbSfX+wkvwq0zD
	1WmxczybxquGXcj68SJ6RGCILGPyJT2t+13+fZf/m7scB4ryCq3tw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7914xpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MNnbP4028169;
	Thu, 23 Jul 2026 00:01:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah9q24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:01:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N01tq710551912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 00:01:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0CB75806C;
	Thu, 23 Jul 2026 00:01:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4209858060;
	Thu, 23 Jul 2026 00:01:54 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.118.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 00:01:54 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 02/33] ibmvfc: flush rport_add_work_q during driver teardown
Date: Wed, 22 Jul 2026 17:01:18 -0700
Message-ID: <20260723000149.969416-3-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723000149.969416-1-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yzqOtq8TbEjUww9LYSZqN4JFUgwo-NEA
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a6159f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=SsuO-E3m-kVTftWxl74A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX8B31M3haJ6D5
 5rGfNw7WjJwlTmMA9mkjTCaXx+oIqom20DyFdtr6mWvVLH7p107wbp2qkXKoGGHAMxlMwCiAgBd
 iyf288ANZMdVSLXvurCKWL3TGomLj2Y=
X-Proofpoint-GUID: yzqOtq8TbEjUww9LYSZqN4JFUgwo-NEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIzNCBTYWx0ZWRfX5AwV9Ejwn5+K
 Q38Rfgd+vRcpr3mU9dnMK2ixQu3TrUxKhi321ouKSt0XsCBWbhB6+EfXVzk598lFbtTuunux0H/
 B6eYMJpum3JIIRztxJtwSBPrXGmJP03LXWOt0R44P87U63zRHxCI0W2nPLdg186R07O379EGDRH
 TmL6kreWqrQDCnlLzaN82PEQwBQYV6YrktLtMy9QvznvyJAmeqtrfdP2unpod01GrpZyb0O/JWS
 1CkmXKftoKvVvCcBaKhQE6QtVpu2GmZrV0RTyk++PcYwotUjjPJ/ilhJ6JTbttXkNf7jGbfYjmh
 pgOXi0108vJbTKmWvdb9AZZQd5c2TMZ+4E/VYz95cJ5BIWOMjH6HYTQ+Dc4XzXEevCYi49qQPIs
 nZmcg2WfW1QxInu5p2A0i527hzR7BiSCUm34QRMef5EzVMqpY6pfqHSLSTN6P9oDyngAU0i+WCX
 i8It2jx8twOArUOEquA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220234

INIT_WORK is called on rport_add_work_q during driver probe. When the
adapter is removed, ibmvfc_remove() stops the work thread and proceeds
to tear down the FC host, but any work item queued via schedule_work()
that raced the teardown could still be running or pending in the
system workqueue.

Add a flush_work() call after kthread_stop() and before fc_remove_host()
to drain any outstanding rport add work before the FC host and its rports
are torn down.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 0a5f73df8d7d..72317d7840a5 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -6443,6 +6443,7 @@ static void ibmvfc_remove(struct vio_dev *vdev)
 
 	ibmvfc_wait_while_resetting(vhost);
 	kthread_stop(vhost->work_thread);
+	flush_work(&vhost->rport_add_work_q);
 	fc_remove_host(vhost->host);
 	scsi_remove_host(vhost->host);
 
-- 
2.55.0


