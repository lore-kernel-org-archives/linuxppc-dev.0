Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB29C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 01:37:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CF12070B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 01:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLBUTeaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CF12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44V6t72PjFzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="QLBUTeaD"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44V6rG22KbzDqPG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 12:35:25 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S1U4RN031896;
 Thu, 28 Mar 2019 01:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2MnvUOuV/sspT1tg2tp+WuLEeomlWkGSHd4wStPaXrU=;
 b=QLBUTeaD97JqAUJ6Tjo23WtxAtrJoQyCeehZW+9BXVuao5ayOwMk0Qj/n8fUHzAW6C0/
 hIkGpzO6sh96r6xZ0uMJ3pKhN66iKOZBYR8Iznfa4ARCAMsgu9NggAQGDu+efwCbSExQ
 EhtyyNMtWgOcA9Qs8RcGd2k0jMzoQ2metG+MXFeDDXxsu3bv8vh1NZ0/XCiwNi6bE2sW
 1QD8aKrIoiEehZDw84Tr1CuGQCda8UKjewmbm52YGMJKagkdj115XZoDt8WcvRjeE8vZ
 A4IUa8y2cjyQZDlfFI5Ak9tZZGb4D+gsnURbkTMFcWYoVhRvHOS1nJEuWluasjCSSvdr pA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2120.oracle.com with ESMTP id 2re6djkvmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2019 01:35:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2S1ZHUe006196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2019 01:35:17 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2S1ZEMW027934;
 Thu, 28 Mar 2019 01:35:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 27 Mar 2019 18:35:13 -0700
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] ibmvfc: Remove "failed" from logged errors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320195654.4364-1-tyreld@linux.vnet.ibm.com>
Date: Wed, 27 Mar 2019 21:35:11 -0400
In-Reply-To: <20190320195654.4364-1-tyreld@linux.vnet.ibm.com> (Tyrel
 Datwyler's message of "Wed, 20 Mar 2019 14:56:51 -0500")
Message-ID: <yq1bm1vvl0w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=921 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280010
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
Cc: james.bottomley@hansenpartnership.com, brking@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Tyrel,

> The text of messages logged with ibmvfc_log_error() always contain the
> term "failed". In the case of cancelled commands during EH they are
> reported back by the VIOS using error codes. This can be confusing to
> somebody looking at these log messages as to whether a command was
> successfully cancelled. The following real log message for example it
> is unclear if the transaction was actaully cancelled.

Applied to 5.1/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
