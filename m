Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C167BC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 19:14:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C492A20B80
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 19:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="laTUnDha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C492A20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CXB9F38HBzDr1Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2020 06:14:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=tlfalcon@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=laTUnDha; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CXB561D1TzDqyd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2020 06:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0ACJ1xxu164610; Thu, 12 Nov 2020 14:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=VXpPdyYYDTumWZ0U/KLbzwTu7Lg97Hm9MsL5vfweJyM=;
 b=laTUnDhaGOFNUQqNv29xSdDLXj4qLmP+c9Iy7q4ITxMZ8NwddAd/7TqzaKb7I2ENiLXY
 iWXCu6YuZO93FaQ912CtRhMeSHW/HlJVuE3CGFhCnD/JQSnqURDkk69XHNXdrvWeHvKF
 ZesOy/YlOY69okyK+dRB+HPNnEEfZl1FgPXutczaXm5QBLSffbeI6qTrUsRKP0pbAKVp
 mWfM8rz3JlDfaV3roQ3XOzmfc45bSOcH3JRPmuAxQfo7jpxkUTND5aC8rQ0ZLg8kzVkJ
 GcmR2P0wlM5USEaXIdQeFZL0et5XUEeoO6gK1wwUS8i5Te16IwArdCKK8kJQsMfuTLsu PA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34s7pnqgec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 14:10:24 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACJ8AhJ016210;
 Thu, 12 Nov 2020 19:10:23 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 34nk7b0122-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 19:10:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0ACJALBl33751298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2020 19:10:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA606AE07B;
 Thu, 12 Nov 2020 19:10:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98D65AE07D;
 Thu, 12 Nov 2020 19:10:19 +0000 (GMT)
Received: from oc7186267434.ibm.com (unknown [9.160.10.22])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2020 19:10:19 +0000 (GMT)
From: Thomas Falcon <tlfalcon@linux.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 00/12] ibmvnic: Performance improvements and other
 updates
Date: Thu, 12 Nov 2020 13:09:55 -0600
Message-Id: <1605208207-1896-1-git-send-email-tlfalcon@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-12_10:2020-11-12,
 2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 mlxlogscore=823 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120104
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: cforno12@linux.ibm.com, ljp@linux.vnet.ibm.com, ricklind@linux.ibm.com,
 dnbanerg@us.ibm.com, tlfalcon@linux.ibm.com, drt@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

First, memory barrier protection of device queue reads to ensure RX
and TX buffer completions are not missed. The subsequent three
patches utilize a hypervisor call allowing multiple TX and RX buffer
replenishment descriptors to be sent in one operation, which
significantly reduces hypervisor call overhead. The xmit_more and
Byte Queue Limits API's are leveraged to provide this support
for TX descriptors.

The next four patches fix TX completion error handling, remove
superfluous code and members in TX completion handling function
and TX buffer structure respectively, update ndo_start_xmit error
handling and improve accuracy of statistics tracking, and remove
unused routines.

Finally, patches to ensure that device queue memory
is cache-line aligned, resolving slowdowns observed in PCI traces,
as well as optimizatons to the driver's NAPI polling function and 
to RX buffer replenishment are provided by Dwip Banerjee.

This series provides significant performance improvements, allowing
the driver to fully utilize 100Gb NIC's.

Dwip N. Banerjee (4):
  ibmvnic: Ensure that device queue memory is cache-line aligned
  ibmvnic: Correctly re-enable interrupts in NAPI polling routine
  ibmvnic: Use netdev_alloc_skb instead of alloc_skb to replenish RX
    buffers
  ibmvnic: Do not replenish RX buffers after every polling loop

Thomas Falcon (8):
  ibmvnic: Ensure that subCRQ entry reads are ordered
  ibmvnic: Introduce indirect subordinate Command Response Queue buffer
  ibmvnic: Introduce batched RX buffer descriptor transmission
  ibmvnic: Introduce xmit_more support using batched subCRQ hcalls
  ibmvnic: Fix TX completion error handling
  ibmvnic: Clean up TX code and TX buffer data structure
  ibmvnic: Clean up TX error handling and statistics tracking
  ibmvnic: Remove send_subcrq function

 drivers/net/ethernet/ibm/ibmvnic.c | 390 ++++++++++++++++-------------
 drivers/net/ethernet/ibm/ibmvnic.h |  30 +--
 2 files changed, 228 insertions(+), 192 deletions(-)

-- 
2.26.2

