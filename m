Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C1C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:41:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C736620700
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wDb1seI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZBgH2XM2zDqFL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="wDb1seI9"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZBd90KvdzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 03:39:56 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33GY8DS123283;
 Wed, 3 Apr 2019 16:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=NjqszMs7E3gOIGdwaUNs0dj+AbjCWmOyC3cb7a2Lz70=;
 b=wDb1seI92hgo522RHXd4reMB9zkAqMls9VSvgcdjUxogKDD5J+hXR5nIQ6e1RF5nvfeJ
 yvo1WDLR0+cay945s5CowFcHd3jjzFZsf4NS8tDvswsKUon3j/9rmrDfnflM2DN40AQC
 p89U9xrMzz6NfdNVkdZKpfv+QO+E+XcrFHW3a3bW3Yscf6TYAeMXf/MfLJT019LJdBfK
 qdoyh/i9H5STZJHeLFWFhiumH7e2qsq6PZgeEevBUBevAR/O89c1IO+XNEmBYeTXoSRa
 fe8vgBSoITQUVaIUvHmDjdmDSMaVpIu9e2EuZje9U7/e6xrb5k3v7b3RkbJWxOWfEWrK Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2rhyvta869-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 16:39:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33GdLsm003451;
 Wed, 3 Apr 2019 16:39:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2rm9mj5jn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 16:39:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x33GdZSM008090;
 Wed, 3 Apr 2019 16:39:36 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 03 Apr 2019 09:39:35 -0700
Date: Wed, 3 Apr 2019 12:40:02 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Message-ID: <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
 <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030113
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 03, 2019 at 06:58:45AM +0200, Christophe Leroy wrote:
> Le 02/04/2019 à 22:41, Daniel Jordan a écrit :
> > With locked_vm now an atomic, there is no need to take mmap_sem as
> > writer.  Delete and refactor accordingly.
> 
> Could you please detail the change ?

Ok, I'll be more specific in the next version, using some of your language in
fact.  :)

> It looks like this is not the only
> change. I'm wondering what the consequences are.
> 
> Before we did:
> - lock
> - calculate future value
> - check the future value is acceptable
> - update value if future value acceptable
> - return error if future value non acceptable
> - unlock
> 
> Now we do:
> - atomic update with future (possibly too high) value
> - check the new value is acceptable
> - atomic update back with older value if new value not acceptable and return
> error
> 
> So if a concurrent action wants to increase locked_vm with an acceptable
> step while another one has temporarily set it too high, it will now fail.
> 
> I think we should keep the previous approach and do a cmpxchg after
> validating the new value.

That's a good idea, and especially worth doing considering that an arbitrary
number of threads that charge a low amount of locked_vm can fail just because
one thread charges lots of it.

pinned_vm appears to be broken the same way, so I can fix it too unless someone
beats me to it.
