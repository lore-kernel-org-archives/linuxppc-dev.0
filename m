Return-Path: <SRS0=x21H=ZZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7ACC432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 16:21:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9594F2080A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boQXu3AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9594F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47S6gF0b1LzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 03:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="boQXu3AP"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47S6cv4kmPzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2019 03:19:27 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3G9101187017;
 Tue, 3 Dec 2019 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=C0csOh2IiwBU5rvm/p9C2Rx3FifNjZcosDBlbkKZ43o=;
 b=boQXu3APvvYLEv5xvZUy66ylMTjWdR8SQ8XqXS/bsfn4lRshgT6DmNGUWx475cUzj13b
 M5pssdl5Wudwqxkldan7mmqoPL+RfjvQtP6meKmRqnSnzsdJUIpV45NodVSYd0n+8W3+
 zt0LSUYI3j1GX7AZgBaWYFvKqq3beN+jJJXRy8tfORrs4hv8S0ymJyVAYq59fIB8rRsI
 VxEX2Alcz5CE4XB8RnIXuCPEWAYjZeVAPv3B/UZ8eLx185N+11H9ORIsmVYaty4igRV+
 8VIE3lmuyUn+VG+yQYJvuZv69TFc9dFDmLXOMp1r7XiPbc/m0WKF615cEs4eBF+alVeS 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2wkfuu8tgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Dec 2019 16:09:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3G8lZh034082;
 Tue, 3 Dec 2019 16:09:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2wn4qq6cg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Dec 2019 16:09:04 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3G8e93008786;
 Tue, 3 Dec 2019 16:08:40 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Dec 2019 08:08:40 -0800
Date: Tue, 3 Dec 2019 08:08:39 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Jan Stancek <jstancek@redhat.com>
Subject: Re: [bug] userspace hitting sporadic SIGBUS on xfs (Power9,
 ppc64le), v4.19 and later
Message-ID: <20191203160839.GJ7335@magnolia>
References: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
 <1738119916.14437244.1575151003345.JavaMail.zimbra@redhat.com>
 <8736e3ffen.fsf@mpe.ellerman.id.au>
 <1420623640.14527843.1575289859701.JavaMail.zimbra@redhat.com>
 <1766807082.14812757.1575377439007.JavaMail.zimbra@redhat.com>
 <20191203130757.GA2267@infradead.org>
 <433638211.14837331.1575383728189.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433638211.14837331.1575383728189.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030122
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
Cc: linux-xfs@vger.kernel.org, Memory Management <mm-qe@redhat.com>,
 Linux Stable maillist <stable@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, CKI Project <cki-project@redhat.com>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 LTP Mailing List <ltp@lists.linux.it>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 03, 2019 at 09:35:28AM -0500, Jan Stancek wrote:
> 
> ----- Original Message -----
> > On Tue, Dec 03, 2019 at 07:50:39AM -0500, Jan Stancek wrote:
> > > My theory is that there's a race in iomap. There appear to be
> > > interleaved calls to iomap_set_range_uptodate() for same page
> > > with varying offset and length. Each call sees bitmap as _not_
> > > entirely "uptodate" and hence doesn't call SetPageUptodate().
> > > Even though each bit in bitmap ends up uptodate by the time
> > > all calls finish.
> > 
> > Weird.  That should be prevented by the page lock that all callers
> > of iomap_set_range_uptodate.  But in case I miss something, does
> > the patch below trigger?  If not it is not jut a race, but might
> > be some weird ordering problem with the bitops, especially if it
> > only triggers on ppc, which is very weakly ordered.
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d33c7bc5ee92..25e942c71590 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -148,6 +148,8 @@ iomap_set_range_uptodate(struct page *page, unsigned off,
> > unsigned len)
> >  	unsigned int i;
> >  	bool uptodate = true;
> >  
> > +	WARN_ON_ONCE(!PageLocked(page));
> > +
> >  	if (iop) {
> >  		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> >  			if (i >= first && i <= last)
> > 
> 
> Hit it pretty quick this time:
> 
> # uptime
>  09:27:42 up 22 min,  2 users,  load average: 0.09, 13.38, 26.18
> 
> # /mnt/testarea/ltp/testcases/bin/genbessel                                                                                                                                     
> Bus error (core dumped)
> 
> # dmesg | grep -i -e warn -e call                                                                                                                                               
> [    0.000000] dt-cpu-ftrs: not enabling: system-call-vectored (disabled or unsupported by kernel)
> [    0.000000] random: get_random_u64 called from cache_random_seq_create+0x98/0x1e0 with crng_init=0
> [    0.000000] rcu:     Offload RCU callbacks from CPUs: (none).
> [    5.312075] megaraid_sas 0031:01:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
> [    5.357307] megaraid_sas 0031:01:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
> [    5.485126] megaraid_sas 0031:01:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
> 
> So, extra WARN_ON_ONCE applied on top of v5.4-8836-g81b6b96475ac
> did not trigger.
> 
> Is it possible for iomap code to submit multiple bio-s for same
> locked page and then receive callbacks in parallel?

Yes, if (say) you have 64k pages on a 4k-block filesystem and the extent
mapping for all 16 blocks aren't contiguous, then iomap will issue
separate bios for each physical fragment it finds.  iomap will call
submit_bio on those bios whenever it thinks it's done filling the bio,
so you can indeed get multiple callbacks in parallel.

--D
