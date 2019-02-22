Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:46:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848A720818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5oN/Ulaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848A720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Sgr2WVGzDqVQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:46:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="5oN/Ulaf"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Sc74mKhzDqVj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 21:43:18 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1MAXRjU035211;
 Fri, 22 Feb 2019 10:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=1i5WQCUCPoPzUI1Cx/77kV+RikwrD0ABD4aQmyeJDRU=;
 b=5oN/Ulafd3sRdLdLZ0cQ8a79PT/Sjpv33pLl3yxoJEDex585pHD+xfFWObIKJwaPAkW4
 4D8IRHlDChBoNQcKJJof6jdDSv2WYFScj17z5/hx5bLEDs7BpngnybnTLLzC+CtgRW9v
 bkxYpGYsnwpSAZ+IdS7GoSP7KPFyOc9DXT9gYM07Yih7F4RLBwEzXmyY2nqg4nVPre9l
 AHlLvsGnGiE/pLVThzzhc5LMAra09D6zGaqTP9UReRKtbtuAXV7x9MSexiAoKEWB0p7G
 W+f7YmF6JgUlMiCdYA9Dqxarrx6v89JQ7rMvQmukhQ9YeKsUyTj0YkNRMQa0E95jbHYB rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2130.oracle.com with ESMTP id 2qp9xuekvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 10:43:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1MAh9ib021092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 10:43:10 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1MAh8Bv017302;
 Fri, 22 Feb 2019 10:43:09 GMT
Received: from kadam (/197.157.0.19) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 22 Feb 2019 02:43:08 -0800
Date: Fri, 22 Feb 2019 13:43:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: christophe.leroy@c-s.fr
Subject: [bug report] powerpc/mm: dump block address translation on book3s/32
Message-ID: <20190222104302.GA17252@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220075
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Christophe Leroy,

The patch 7c91efce1608: "powerpc/mm: dump block address translation
on book3s/32" from Dec 3, 2018, leads to the following static checker
warning:

	arch/powerpc/mm/dump_bats.c:20 pp_601()
	warn: both sides of ternary the same: '"RWX"'

arch/powerpc/mm/dump_bats.c
    13 static char *pp_601(int k, int pp)
    14 {
    15 	if (pp == 0)
    16 		return k ? "NA" : "RWX";
    17 	if (pp == 1)
    18 		return k ? "ROX" : "RWX";
    19 	if (pp == 2)
--> 20 		return k ? "RWX" : "RWX";
                            ^^^     ^^^
    21 	return k ? "ROX" : "ROX";
                    ^^^     ^^^

Was something else intended here?  Or we could make it simpler:

	if (pp == 2)
		return "RWX";
	return "ROX";


    22 }

regards,
dan carpenter
