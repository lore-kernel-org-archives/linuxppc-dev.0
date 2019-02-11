Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A2C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:13:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E734A217D9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h69/8aLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E734A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1n72lxjzDqcW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 10:13:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="h69/8aLc"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z1l40s1ZzDqbt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 10:11:59 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BN8lYP097599;
 Mon, 11 Feb 2019 23:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ga+yuNAdN5EDRIg9ZPoAnKRUBklhIkTaF8GwpER6yuw=;
 b=h69/8aLchyz1bOEzsVbEL12ex24x41iHgKUkVrwI2tdVl2pvNgzF2CVbB+9+XUW4pN4d
 bl9vR+y4J9EMrCCQ5llzSpmryKAwte5EQnwEnawq2ien/vrHLSsd6JOMlls3kU+lvsJW
 PT08I9Q2N5KweZXEp+4rSAVoD77ka9orD/Q+b1yO1ccO1PNqK8ykHoP+Wdo1s4kHAPHB
 IsrtNH7jey307PkgCXznIEFiBmEZ6WVutPqCFE6Q7xfImKruBX2+e/+J5Zf73XeaHABu
 aE1PZmOGQ6oN+gnBJUtGRlrqCl3mGAj+YbEuaazQ/okXBVk3PhEEnlqDhkKd1fuI8M66 9w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2qhredrtp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 23:11:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BNBZgL029359
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 23:11:36 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BNBX8o019495;
 Mon, 11 Feb 2019 23:11:33 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 15:11:32 -0800
Date: Mon, 11 Feb 2019 18:11:53 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211225620.GO24692@ziepe.ca>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110164
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, alex.williamson@redhat.com, mdf@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, cl@linux.com,
 hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:
> > @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> >  	if (!mm)
> >  		return -ESRCH; /* process exited */
> >  
> > -	ret = down_write_killable(&mm->mmap_sem);
> > -	if (!ret) {
> > -		if (npage > 0) {
> > -			if (!dma->lock_cap) {
> > -				unsigned long limit;
> > -
> > -				limit = task_rlimit(dma->task,
> > -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
> >  
> > -				if (mm->locked_vm + npage > limit)
> > -					ret = -ENOMEM;
> > -			}
> > +	if (npage > 0 && !dma->lock_cap) {
> > +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> > +
> > -					PAGE_SHIFT;
> 
> I haven't looked at this super closely, but how does this stuff work?
> 
> do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> 
> Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
>
> Otherwise MEMLOCK is really doubled..

So this has been a problem for some time, but it's not as easy as adding them
together, see [1][2] for a start.

The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
trying to do is account to the right counter.

Daniel

[1] http://lkml.kernel.org/r/20130523104154.GA23650@twins.programming.kicks-ass.net
[2] http://lkml.kernel.org/r/20130524140114.GK23650@twins.programming.kicks-ass.net
