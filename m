Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC58C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 14:52:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7325E2083B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jNNvSm+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7325E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zQcY0SD7zDqRP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 01:52:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=tom.hromatka@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="jNNvSm+F"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zQZD2WxRzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 01:50:43 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CEiZD4027996;
 Tue, 12 Feb 2019 14:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZEJzoXHO1GK9TrnQoSP1QXgZeuUAM5LZiwlsAVh9urQ=;
 b=jNNvSm+FWJaH46caF/9csyX7zdpzRUCUu21Y0KOR0v7UWUDkF/wnDLRxTsEaS2aUn77s
 ZTtWmrcfjrrAl1JkN7jae64JdY+fnvGCrLCNAB7wM3wwekBoIPd/75B2bQYdxaFzXRzF
 irc0+5+yi9YEqkDncNtYygoYleiJuBxgjr2jhEMnbEjkR/g0wOF0J/MUpEP2L0uhDNrs
 uOyAOlMdMeZS6yNpHALcwgeocgwAc5S4FK45wp1wooXpHU7MIrfqr8h685FKhT/iS7qO
 wMX9f7vZCAtFX06Fv9QuOslJWR6EB8XSEdo0UWqbfaybSbyuM3fDc/MLMw3/HQuIeTMY eQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2qhrekcau4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Feb 2019 14:50:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CEoYPk029845
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Feb 2019 14:50:34 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1CEoXt0006718;
 Tue, 12 Feb 2019 14:50:33 GMT
Received: from OracleL460.vogsphere (/10.65.172.252)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 Feb 2019 06:50:33 -0800
Subject: Re: [QUESTION] powerpc, libseccomp, and spu
To: linuxppc-dev@lists.ozlabs.org
References: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <89f699ca-e307-0714-2fdb-37b5307e1195@oracle.com>
Date: Tue, 12 Feb 2019 07:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=876 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120107
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
Cc: Paul Moore <paul@paul-moore.com>, Dhaval Giani <dhaval.giani@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/11/19 11:54 AM, Tom Hromatka wrote:
> PowerPC experts,
> 
> Paul Moore and I are working on the v2.4 release of libseccomp,
> and as part of this work I need to update the syscall table for
> each architecture.
> 
> I have incorporated the new ppc syscall.tbl into libseccomp, but
> I am not familiar with the value of "spu" in the ABI column.  For
> example:
> 
> 22    32    umount                sys_oldumount
> 22    64    umount                sys_ni_syscall
> 22    spu    umount                sys_ni_syscall
> 
> In libseccomp, we maintain a 32-bit ppc syscall table and a 64-bit
> ppc syscall table.  Do we also need to add a "spu" ppc syscall
> table?  Some clarification on the syscalls marked "spu" and "nospu"
> would be greatly appreciated.
> 
> Thanks.
> 
> Tom


Thanks for the awesome responses, Ben and Michael.  I'll definitely
get Paul's input as well, but it sounds reasonable to exclude SPUs
from the newest libseccomp release.

Michael's recommendation to replace "nospu" with common" and ignore
"spu" entirely has allowed ppc and ppc64 to pass all of our internal
checks.

Thanks again!

Tom

