Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EBBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 20:57:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE964F21
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 20:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE964F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqqFg5Phjz3cZp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 07:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PUE7dv+w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sukadev@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=PUE7dv+w; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqqFB0q73z30N1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 07:57:01 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 122Ks9jV143629; Tue, 2 Mar 2021 15:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hVR23tAwSFO9yvx7WPzuNPiKXDrwlLnYZqNbmksQv74=;
 b=PUE7dv+wJIWuyK5t4GfQ4uUar5+qrH7xj7INM95mbiE7LCry68uTJdNPsZRu6//WEg3O
 oUR/wV8zZFqFfPV2ZXzx7caTT6xd4WbRZFA+22fvrwExxBvGCQXxqKg5nIroFWGijb6n
 MXO/A//B+AzQ1Cm6xOKhbWRbtOjePfgmG0ztpKcAAKq6s3xXOEQnqI8rYwItfmViNA0r
 Mt7K2r7x70oIvW4RfH426PWAbTIA5WPv0G1f2VXsTyliSnPcrX9KtzS+fcpXHJ6DwtQt
 TlKH7XOr5cq5i/5V1ptPg46AKLvOsaOqv1Y2UQQdxvtR/rlJ+pfmSW8raUEWfB6KH/iU MA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 371vnhge45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Mar 2021 15:56:48 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122KqXxx032371;
 Tue, 2 Mar 2021 20:55:26 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03wdc.us.ibm.com with ESMTP id 37128ga3f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Mar 2021 20:55:26 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 122KtPXK24576266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Mar 2021 20:55:25 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50FBA6E04E;
 Tue,  2 Mar 2021 20:55:25 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20B236E054;
 Tue,  2 Mar 2021 20:55:25 +0000 (GMT)
Received: from suka-w540.localdomain (unknown [9.85.154.76])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  2 Mar 2021 20:55:24 +0000 (GMT)
Received: by suka-w540.localdomain (Postfix, from userid 1000)
 id 009312E18A5; Tue,  2 Mar 2021 12:55:21 -0800 (PST)
Date: Tue, 2 Mar 2021 12:55:21 -0800
From: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] ibmvnic: Fix possibly uninitialized old_num_tx_queues
 variable warning.
Message-ID: <20210302205521.GA1260939@us.ibm.com>
References: <20210302194747.21704-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302194747.21704-1-msuchanek@suse.de>
X-Operating-System: Linux 2.0.32 on an i486
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-02_08:2021-03-01,
 2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020156
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Lijun Pan <ljp@linux.ibm.com>,
 Dany Madden <drt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Suchanek [msuchanek@suse.de] wrote:
> GCC 7.5 reports:
> ../drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_reset_init':
> ../drivers/net/ethernet/ibm/ibmvnic.c:5373:51: warning: 'old_num_tx_queues' may be used uninitialized in this function [-Wmaybe-uninitialized]
> ../drivers/net/ethernet/ibm/ibmvnic.c:5373:6: warning: 'old_num_rx_queues' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> The variable is initialized only if(reset) and used only if(reset &&
> something) so this is a false positive. However, there is no reason to
> not initialize the variables unconditionally avoiding the warning.

Yeah, its a false positive, but initializing doesn't hurt.
> 
> Fixes: 635e442f4a48 ("ibmvnic: merge ibmvnic_reset_init and ibmvnic_init")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
