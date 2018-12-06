Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C67C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 12:48:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65430208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 12:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KojmwpY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65430208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439b4g0RSXzDrDq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 23:48:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="KojmwpY6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="KojmwpY6"; 
 dkim-atps=neutral
X-Greylist: delayed 11389 seconds by postgrey-1.36 at bilbo;
 Thu, 06 Dec 2018 23:45:31 AEDT
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439b17252BzDrC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 23:45:30 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB69YOH6151652;
 Thu, 6 Dec 2018 09:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Cp0+x4p6e3OUjzb9cgZI6hrB7Sgzd/uS0aKRqnwBULo=;
 b=KojmwpY6I2fST7MG4MDH0R9R1q6nVnRlJhCZJ9Bw43/6SevAyblt/t77h8PaTF7M5sBK
 TDZQYxcoOEOgmO3uKRuIGYxq6lXzYo75UpFxuvV0tguwHhbjF2Bom8Z8dhkAxopemRma
 LT3fIgAvAPh+FlJyT9In37cCE2icYoi810tNb1EXIbB/dUneDZ5K6w45EmrLq1AlF2hk
 /VO5HRxe/gi1eaNLuUIkptaua97ZjQGl+DqNpMBx0Gw8d/C4vyOjwm7mk+Rx4ZxP9GP2
 YGSZLaLlmpGgseq+IvzOAlQmfl+UORTZSsqfqmG+DWrsSOGYAfmp6gdxqADrdzGtaJk1 fg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2130.oracle.com with ESMTP id 2p3ftfb1vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Dec 2018 09:35:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB69ZTJa008170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Dec 2018 09:35:29 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB69ZQ2k030385;
 Thu, 6 Dec 2018 09:35:26 GMT
Received: from unbuntlaptop (/197.157.0.28)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 06 Dec 2018 01:35:23 -0800
Date: Thu, 6 Dec 2018 12:34:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
Message-ID: <20181206093420.GL3073@unbuntlaptop>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgzchcw8.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060086
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
Cc: Kim Phillips <kim.phillips@freescale.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 02:26:47PM +1100, Michael Ellerman wrote:
> Can smatch help us find things like this that are defined non-static but
> never used?
> 

It's too tricky because it depends on the .config as well.

regards,
dan carpenter
