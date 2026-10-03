Return-Path: <linuxppc-dev+bounces-28789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE198CA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 01:58:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTLy3hBrz30DK;
	Sat, 03 Oct 2026 11:58:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790992682;
	cv=none; b=gngmmFlv6iuFfQwixVTgHH8rbc3jRm18Cz7QWxUzTVCDXtlIDgWIGzR668dfkKHksDJUT4DgOoUmwSshFP9hRgoQcRIHt7ekka/1AZXTj+iOgqTs2Gc3FSbbAvvI/v6ip8VBWG9RLnOAcBvKz8rDKoDdQHhcnMQJY80/95Y6EcKOKmS1ra2iKph1MLD44wt5lhqwXf/PzflQQOclF+abmOFYWD9HK4ajPnBz7JyMEbTL8UcazPFxwjd5pM8PucypdG8CdvnztZC49zDeejg0jFWuMnAJYub/50vokKqdpuKx/nITwIzn8l9w6Wze/IuJlebv7zS18ClPpdzLQpOKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790992682; c=relaxed/relaxed;
	bh=m/XcIQXHiE9kZt3eb06gsVLlxA/1GSiBg6JxnRrN/88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mshHHZU9us1GJwJ31j/JKjyflMBW9NszOyubuBLx/0yHid5fUUfyBICV+ha43eVQTYVXSkyG4ZWcRUGyE9aYbdHTUXVY3GplSbraa57Tx3/0l656W84HOnP+HqNAcIMn7elypyddbU2dlJH3sxzFUF04+5jcJSj27HYFUPv361fyMsQq4rMtWqbNwZTreLj0f+/nk9d7hXwzxNc/oPlVzFOGQKbx9Awh6O4pwUn5Je+fY31t1o21bOJQAjywVab8vU0UfKKTk0b5OwcNkA20vHK9dm1gNsoJgUoxgDOoElSNt2caP5j1LdNkkfL16fe/VJs1nh+tnrR4dBxov0sYNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DwNaALon; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DwNaALon;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTLx3m45z30B0
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:58:01 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69305sBa1903928;
	Sat, 3 Oct 2026 01:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m/XcIQXHiE9kZt3eb
	06gsVLlxA/1GSiBg6JxnRrN/88=; b=DwNaALonC14DfXOshvAR9goeqAAg6JqKc
	weXuvmdIlANzcdqqH8U920WsT1IZYAjZ2orfAnKkbXaazoInelxS+lVoHZrBMCvA
	05dgrtC4JPVA5fwbIiqzizfc8VmRXpWg6cohjAK68TXSHGK0a7YObZHmXvDVLc6w
	9kXp9nfjzYN+WP8+VvTV8FE2NACZHAVW5JbOSLUjEyGFpqRyjweGJ2LHHk0yVqyq
	8YJ88MpAxeeslEcq0OwFG8QYMJafWAAJkcGsQEHp1/NbyLlTxgo9WA1fTGsLcvVH
	uYkTfHEBkqSrVbtOi50H35yiyhQAhGH4Y2EAQmqZH3DpNMAFokcZQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pttv0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69302aaB3258438;
	Sat, 3 Oct 2026 01:57:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsn925-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vdYB32047634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788E958065;
	Sat,  3 Oct 2026 01:57:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB055804B;
	Sat,  3 Oct 2026 01:57:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:37 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 3/7] ibmveth: disable the reset work before unregister in remove
Date: Fri,  2 Oct 2026 18:57:15 -0700
Message-Id: <08e02c91dd359c030b04041e05be75397164daa0.1790991039.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790991039.git.mmc@linux.ibm.com>
References: <cover.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: R_5Mz5r8IFaipIyxJLDlT3JiBI2qquJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfXyPineXNt6a8P
 GWT2o7gesFM6vMztVzAZ2mf3XpEgOhQZVRjVjaMwloos8UDy+UHU2RupQ2eGhIV4cpN3l0ewerg
 6inTbwkhdTXCt5CWBZqlxEGaLI4zkx47efHw3iz44Q7Mbtgh5W6T1z86GsDUqrcMGalfNGI1HZO
 V98CIPpY50C0SS6NL0Df11gmdmFD54Iit8FN69F1ki/LZ503u1eXgvBJPTU1VLVaUCXH2linZP7
 avC/AwiC0hbp+mbRzc7vU4j6DFsciMviza8dbfv5EDihOXc/Mteg8cFQlalvphTxqKaVYJQCFB2
 9vqWKruisyLppYTJbznokaCtzhvF1hX+3ty5aop/HBUL4Gs+A3ZhUI5PYEhKPt+eDRwErT+fl6N
 7a9A/9i7KW7VXqWuGC0ojdgydkF6SVUKiDaJHgj1yptzA0AdT5MLL3Mluu5jVxNoVvmYV1C/lK9
 EAxaZF96jdaoTELgJrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX5Jid+8pXd4Ox
 5Tj9OCrtX0vnTyF7bWxmyUWRQDAWJQmHfIhNYgODYWQ389txky6rYRGZGjghi2uPEFt89fupNHP
 EqG6UXHgKG91lI4wAoc918HZOKGt+Oo=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6ac06116 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-GUID: vFa_RCyPj_tUQhO9k43zBWPTuvHSjeYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

It was not reproduced. Tested on a POWER10 LPAR with unbind and bind
cycles under traffic.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 00cee2916920..77d3740cc52a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1950,7 +1950,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.39.3 (Apple Git-146)


