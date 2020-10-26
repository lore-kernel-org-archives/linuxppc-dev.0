Return-Path: <SRS0=MBk5=EB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDDC4363A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2020 22:20:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D8120878
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2020 22:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HStaSDxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D8120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CKq5Y73qmzDqC5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 09:20:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2020-01-29 header.b=HStaSDxT; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CKq3L3FpbzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 09:18:05 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QMFdNg062108;
 Mon, 26 Oct 2020 22:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JBHC3Tv9jAUAHUjVj7llOjchS0J/AGl03MlghuwQQaE=;
 b=HStaSDxTpzgb0Cc0CwVDhnfoTRhJmadyKep1fyH9tXZ+SxsTB5t4ETIzuKwS3cHK/E7/
 JmCYqOtwAxdBNVjxro+Qq2tHjMg0QaFrsNFJNk6r9VbfQv8xSBqkK+Y7sfEaX+BVM2uy
 gwA4+peCsTQkp9qqKl83nP/s+XZSv2aPc5F91p/ViI5FLbo4tjy2ZhqdUrtoXmZ8hjuZ
 v9cJ8WH9JTGievC2RSDgrvTiE4sKBmy2TGNEhfgRN+bz0AMzxvVWU3A694F0SU5T6gPe
 XxmmvOhNxipY61ucDon1RbYlA7Mwx65c7c5GUCFIiIHYkoBWR+Le2onYg4dkrP8/ViPK qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 34c9saq6kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Oct 2020 22:17:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QMGEhr058299;
 Mon, 26 Oct 2020 22:17:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 34cx1q0r70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 22:17:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QMHro7032276;
 Mon, 26 Oct 2020 22:17:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 26 Oct 2020 15:17:52 -0700
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] ibmvscsi: fix race potential race after loss of transport
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9ew7hve.fsf@ca-mkp.ca.oracle.com>
References: <20201025001355.4527-1-tyreld@linux.ibm.com>
Date: Mon, 26 Oct 2020 18:17:50 -0400
In-Reply-To: <20201025001355.4527-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
 message of "Sat, 24 Oct 2020 19:13:55 -0500")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260144
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
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, james.bottomley@hansenpartnership.com,
 brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Tyrel,

> After a loss of tranport due to an adatper migration or
> crash/disconnect from the host partner there is a tiny window where we
> can race adjusting the request_limit of the adapter.

Applied to 5.10/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
