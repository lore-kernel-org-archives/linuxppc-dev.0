Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B65C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 20:29:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876DF218A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 20:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rHzXgdt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876DF218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yy773BmjzDqbW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=tom.hromatka@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="rHzXgdt4"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yw244bxwzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 05:54:30 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BIs73N086296;
 Mon, 11 Feb 2019 18:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=cc : from : subject :
 to : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=4ByW/4xuYeZpU6Ji5zEdXp2SfHWcqBWdhqSPdBUYdmU=;
 b=rHzXgdt42rE9vK+wdVhMIYFRXE3OXCllJ451Kg7OiOju7kptlPQUlByCaZ3rx82eAbk2
 v+S7UrUSm1AT87drQqqq4LQotiRUZ0U5XWugIWM3ze7IAszmXWXiiJMcZFrkudYilI/q
 11mpggscYJ3zeQXYfoVeS6OFcx2Vvd/xzJFqexhC3zdJULWU1hDAUWOoV3R/oEHV8UlV
 5Xm3WMvN9V+5izqraxSAYkKmkzbuRXvG6HxDhy1Fycv+lNqL9lDpigdvdP+j1Q7AHGi1
 bgvdEgWbYljDhPyI/BAK/lyEjE/yJSj7w4AXEgDzUibnnefdPwufUh2oYTVWtTl5yeI0 ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2130.oracle.com with ESMTP id 2qhre57kkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 18:54:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1BIsQmf022408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 18:54:26 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BIsP9n007814;
 Mon, 11 Feb 2019 18:54:25 GMT
Received: from OracleL460.vogsphere (/10.65.172.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 10:54:25 -0800
From: Tom Hromatka <tom.hromatka@oracle.com>
Subject: [QUESTION] powerpc, libseccomp, and spu
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
Date: Mon, 11 Feb 2019 11:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=736 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110138
X-Mailman-Approved-At: Tue, 12 Feb 2019 07:27:32 +1100
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
Cc: Paul Moore <paul@paul-moore.com>, Dhaval Giani <dhaval.giani@oracle.com>,
 tom.hromatka@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerPC experts,

Paul Moore and I are working on the v2.4 release of libseccomp,
and as part of this work I need to update the syscall table for
each architecture.

I have incorporated the new ppc syscall.tbl into libseccomp, but
I am not familiar with the value of "spu" in the ABI column.  For
example:

22	32	umount				sys_oldumount
22	64	umount				sys_ni_syscall
22	spu	umount				sys_ni_syscall

In libseccomp, we maintain a 32-bit ppc syscall table and a 64-bit
ppc syscall table.  Do we also need to add a "spu" ppc syscall
table?  Some clarification on the syscalls marked "spu" and "nospu"
would be greatly appreciated.

Thanks.

Tom
