Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 05:51:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCD92225E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 05:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCD92225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFxQx4RMxzDqw0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2020-01-29 header.b=LDehUlio; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFxMd3RSKzDqZF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 16:48:59 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D5hYdg166573;
 Wed, 13 Jan 2021 05:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=k17fpzZ91DAkQGNJ1v/pKHtocxznO0ZLyKca+jMjbr4=;
 b=LDehUlioiN+FaHbcbHzgIA3RkSZzN/OCiBWRAmW4LG6iSEsP3YQhLciCLi2u6J0H+1iw
 hl46N9246VzFJqgV5UCLm+G/Jvn0WwqKTAWoiXF35WzG8vi3CHEVaCqE+Lo4zQcWzeuf
 eJCWYoRGRebPuE8Ead5O/Y5JJG+RhKmk4oT4952Keb+uIh8scCgSP62bvovk/KFKNIBx
 ZzIzJRsMySuZTH0g2pkXpbcR36q2PEUukPGVYSAaa+LWBx+gWUa61sM9JT6ZEA3YLTPm
 bEG5aDvjWRycvjwnxofJKYgiT4wdvfHc8zTgoqmf29QsUsRP2jC/qTu0qQrDzAzf88XO BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 360kg1snsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Jan 2021 05:48:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D5dccN158991;
 Wed, 13 Jan 2021 05:48:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 360ke7rkq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Jan 2021 05:48:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10D5moli011666;
 Wed, 13 Jan 2021 05:48:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 Jan 2021 21:48:42 -0800
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
 james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 0/5] ibmvfc: MQ preparatory locking work
Date: Wed, 13 Jan 2021 00:48:28 -0500
Message-Id: <161050726819.14224.2836008453363437942.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106201835.1053593-1-tyreld@linux.ibm.com>
References: <20210106201835.1053593-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130034
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
Cc: brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 6 Jan 2021 14:18:30 -0600, Tyrel Datwyler wrote:

> The ibmvfc driver in its current form relies heavily on the host_lock. This
> patchset introduces a genric queue with its own queue lock and sent/free event
> list locks. This generic queue allows the driver to decouple the primary queue
> and future subordinate queues from the host lock reducing lock contention while
> also relaxing locking for submissions and completions to simply the list lock of
> the queue in question.
> 
> [...]

Applied to 5.12/scsi-queue, thanks!

[1/5] ibmvfc: define generic queue structure for CRQs
      https://git.kernel.org/mkp/scsi/c/f8968665af28
[2/5] ibmvfc: make command event pool queue specific
      https://git.kernel.org/mkp/scsi/c/e4b26f3db864
[3/5] ibmvfc: define per-queue state/list locks
      https://git.kernel.org/mkp/scsi/c/57e80e0bc108
[4/5] ibmvfc: complete commands outside the host/queue lock
      https://git.kernel.org/mkp/scsi/c/1f4a4a19508d
[5/5] ibmvfc: relax locking around ibmvfc_queuecommand
      https://git.kernel.org/mkp/scsi/c/654080d02edb

-- 
Martin K. Petersen	Oracle Linux Engineering
