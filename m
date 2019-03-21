Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1516FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:13:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793D020835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 01:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5auiC2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793D020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PphR48BMzDqF1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 12:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="H5auiC2Z"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ppfk5Dp1zDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 12:12:14 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L0EWN0133920;
 Thu, 21 Mar 2019 00:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yQQflfYGr1uvYBn4E6CpUgsHhMAJnBzweXkZ5t5gGp4=;
 b=H5auiC2Z0dji1/FyKIZQwIurOU5SqIxUy/nqUZ5gAVtL+IkfjDY+RNCdawphWqyaZfIb
 A5s0XBZ5xKIDGW0gz2Dnd2nXTCSwu+w79SqGPhGrN2ZhDCtmJlr9ybdUU+v7LlfH9gru
 M9z0TN+Z0l5kcAgPmmFP/bEaS5sF1Cpq2bT/ecB01DhQuImO9bphcB1N1HvYno7mtJ0m
 TRpkWd1MooqT0uxzDfou51T9z8dRCInlqHaHLvDFF0o+EUnTFl0X4dCc4hPy9osMngHy
 E6lOdVriU5zJ4EVlQbozVOrz/j3aHKrEGlcb6iGmTULtUdO8K9nVY+HW1ksjQiCUiMol 0w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2r8ssrnneg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 00:14:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L0EFBg016462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 00:14:16 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L0EFUG006115;
 Thu, 21 Mar 2019 00:14:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 Mar 2019 17:14:15 -0700
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ibmvscsi: Fix empty event pool access during host
 removal
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320184151.31321-1-tyreld@linux.vnet.ibm.com>
 <20190320184151.31321-2-tyreld@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2019 20:14:13 -0400
In-Reply-To: <20190320184151.31321-2-tyreld@linux.vnet.ibm.com> (Tyrel
 Datwyler's message of "Wed, 20 Mar 2019 13:41:51 -0500")
Message-ID: <yq11s316q3u.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210000
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
 stable@vger.kernel.org, james.bottomley@hansenpartnership.com,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Tyrel,

> The event pool used for queueing commands is destroyed fairly early in
> the ibmvscsi_remove() code path. Since, this happens prior to the call
> so scsi_remove_host() it is possible for further calls to queuecommand
> to be processed which manifest as a panic due to a NULL pointer
> dereference as seen here:

Applied to 5.1/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
