Return-Path: <linuxppc-dev+bounces-29425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D8DCC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 18:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j42v73pvmz3byT;
	Wed, 14 Oct 2026 05:30:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791916211;
	cv=none; b=XlAM0v1oLbfaErzLIW1nBdJdy5+85WsyBTt4yozRqJM80yCjdSD9C3Omx1BQ78pNG2EYlb7SS+yUKL1/dryWsSAJyGxhij1SPJk4+TkC3Q4NRYfwBn0K5N6jPtzhB63ncmHNaLc/cloTuRoeU+Trc9th2sdMrBteTRM4Jeiz8YaUg5RsYt6HlTxFBQ4l0TujxzboOyT2sy+sdZ8A3CTNPd3OxbqlYpF/3CsVpV5FMs0J8It1l1ga64c1LBA7DcJ4cA7+Khz28GdjOADOJ42Wu7FM3bglRBefJxxbWdiGWw1DDN8c4vruDs0vYLZjwtvAhUqyGVTZhWb2Xw3bxwMUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791916211; c=relaxed/relaxed;
	bh=S3SzXUHhDWldWmpPmYxF0Oh++q8Ha7tJ+47jh3T09tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E15cyaOMZC4C0uh4yEl6lXenLvms7KKWj/8BVAv9ScIkr1Eyl2nZ72BXXE81ZJ8jVWgriDzUHbr1teGYgOsueMgg4cyjr14OnJvqHF3vyNJvi8e9fw+i0oI6y9xhVwa+xko/j/1Pdw4F1ueWo2LZ6ZNCW81a90XouF0Xe7mcm239By0Ph6+6LN+cvi+BciX364u1TUEFvS79b0D6Uk7eawgxv6NfgF65A74O7IVsL70xh3K9NSdLYC3/8cIrkq3CmxinuIvOJsySYZGrIF1HnZOHuJDl82OxRgrVRvYkPnHl5upfTavdtllHPUAu3vDFJjBTBvaANZfG7AUwovMy7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L3hyyg2P; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L3hyyg2P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j42v64xPgz3bxC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 05:30:10 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDgsRD1932099;
	Tue, 13 Oct 2026 18:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S3SzXUHhDWldWmpPm
	YxF0Oh++q8Ha7tJ+47jh3T09tw=; b=L3hyyg2P5AvB5r1UD9XKeUDCMjEQ9Ohot
	KwrBJvs6iNtsBpOAesToiFVVcwjkg+Ws9QlERMzn4FI2ITdNp5yk9w2gAhrmF4y5
	5xXkk1RoBvY0DusnFLciDFCoXr6G9IqBXaYf8jXZBCImaV8gRZD141V7O+Tuj7nj
	MXcxYgUQ2r5OnEY6/an6lNj6HmiILuBpcfleFvyXTbCwqqiJgin+hdi9d4deJhwt
	rEqgiMfZz5jGi2gx/C8vVwsSo2/MszwWDj3Qzc056zWjaBlmC9SKzN2I54s9ZDci
	ARNkFlRKHPsFta84UGALyWMa2AkjDQQ6rlYCPSlaf5/qQ3c7+W2MA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w7p1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:29:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DHuTtM3211854;
	Tue, 13 Oct 2026 18:29:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2yh28d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:29:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DITqgW41419448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:29:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3677B5805D;
	Tue, 13 Oct 2026 18:29:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6755C58054;
	Tue, 13 Oct 2026 18:29:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:29:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v5 3/9] ibmveth: disable the reset work before unregister in remove
Date: Tue, 13 Oct 2026 11:29:20 -0700
Message-Id: <20261013182926.30417-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
References: <20261013182926.30417-1-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX1tGGyHhul4SZ
 g+MA6tohYfG1hMzVcRHOxxQFxqzg3NCzs/ZHpA9NbIpivlOtPqSBM4bRfL0XwocWvkPlIryQBII
 EMt7KeMYzjEEit70dOCfqqEPw54Qfkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX3ylfeLhO7gFZ
 tuFZw0OsRxPFGoLzDqHzSQN2LccB7QqaTzEZqggbvhF1tfLUTKsZCgEThsY6ZnMjJq2HkdRGjU+
 mgwsMzhJpJGP96jzw7g6WCC0Uw6Oz6zS43dZ7y8e98Aj5TXi6pnEGWpHr5iEfrBmwXgA7L/yd5D
 0FAI62xMGYpDS8iGiQG7ZYDeeyMD88lnD5kJePzJ3uWPzZBo+BATX7FAdoEtKQiqNwgMf2MsrrP
 pSlzJvcBVA2HbuACuj3XoufF9CfzZTAXiJP/PcbYOqeOARia1y9uEhQjvGDJ7BQO0fvZsv4JS0U
 3xAWc2Gi8Qn4iVmfPa3dvuywT5fwKivBQkKvGQlHNyjcEpY9uoL1hRbg5dWY57jIaqiJFVUkqR6
 ySxx9Zcw7K802EscuDarqVNB8i+PAuuPZ89OjQIKTD6xVp7uD1t0rMosWufLHnPi2brRU/l53sz
 u2Qqpot9G/G1KNBKezQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace78a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-ORIG-GUID: RmBSwEevjbIeEQC7hAK2o1vZitVOPuG5
X-Proofpoint-GUID: uIAOp32DlpuYQZx0xy6fa7w7MJcSExdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130072

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection; it was not reproduced. Tested on a POWER10 LPAR with
unbind and bind cycles under traffic. No kernel selftests cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4665447997ea..cee0e9783b2a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1956,7 +1956,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.50.1 (Apple Git-155)


