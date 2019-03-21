Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F463C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 04:37:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735FF218A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 04:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdEevMNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735FF218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PvC419r1zDqQs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 15:37:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="sdEevMNu"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pv9C0fFJzDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 15:35:26 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L0EXd8133934;
 Thu, 21 Mar 2019 00:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bvccEfpo5Wjfz3LV1exBLhkmYFtiTu0RNUPwAEWwPR0=;
 b=sdEevMNuY6TYnt8ADr6G0pim7hUUeY1prsPc+3A7AjfZEWwPV74OmpTGRnVSJYX7yl2D
 G1w6pyujQEOPCxNL3+S5R76QfKi0Ozfc2XuaA3iX+k3KFNv3AfWYMyGmq4S1FCSS7Wqa
 yCSK5Sw2qhRgE94HhpG0h7Kc2H2AMsuEo90nQ8zeG57ltf1SUXjJJeCDdw2ar90OBq66
 r3EqEETeyT/LcGwiEJB7n6ihQeDlahCTaDFDi1zNo4DCBVGIr5XHKbi/Q0u2Tz8dkou6
 XjeGTW80wLwH2HsX2Ny3kiJKPsFTZXXR3EfPI0Bd5g3VY3UpOGQRimUUG6lHBoFz9V2G oA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2r8ssrnne9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 00:14:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2L0E0qo015359
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2019 00:14:00 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L0Dxtc014123;
 Thu, 21 Mar 2019 00:13:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 Mar 2019 17:13:58 -0700
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ibmvscsi: Protect ibmvscsi_head from concurrent
 modificaiton
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320184151.31321-1-tyreld@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2019 20:13:56 -0400
In-Reply-To: <20190320184151.31321-1-tyreld@linux.vnet.ibm.com> (Tyrel
 Datwyler's message of "Wed, 20 Mar 2019 13:41:50 -0500")
Message-ID: <yq15zsd6q4b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=489 adultscore=0
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

> For each ibmvscsi host created during a probe or destroyed during a
> remove we either add or remove that host to/from the global
> ibmvscsi_head list. This runs the risk of concurrent modification.
>
> This patch adds a simple spinlock around the list modification calls
> to prevent concurrent updates as is done similarly in the ibmvfc
> driver and ipr driver.

Applied to 5.1/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
