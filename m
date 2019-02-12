Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2147C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:42:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CC52190B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC52190B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zWk73w0DzDqQC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 05:42:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zWhC4SmKzDqM2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 05:41:15 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5D75E6A7D;
 Tue, 12 Feb 2019 18:41:12 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B1275D973;
 Tue, 12 Feb 2019 18:41:11 +0000 (UTC)
Date: Tue, 12 Feb 2019 11:41:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190212114110.17bc8a14@w520.home>
In-Reply-To: <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 12 Feb 2019 18:41:13 +0000 (UTC)
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, linux-mm@kvack.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, atull@kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019 18:11:53 -0500
Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Mon, Feb 11, 2019 at 03:56:20PM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:  
> > > @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> > >  	if (!mm)
> > >  		return -ESRCH; /* process exited */
> > >  
> > > -	ret = down_write_killable(&mm->mmap_sem);
> > > -	if (!ret) {
> > > -		if (npage > 0) {
> > > -			if (!dma->lock_cap) {
> > > -				unsigned long limit;
> > > -
> > > -				limit = task_rlimit(dma->task,
> > > -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
> > >  
> > > -				if (mm->locked_vm + npage > limit)
> > > -					ret = -ENOMEM;
> > > -			}
> > > +	if (npage > 0 && !dma->lock_cap) {
> > > +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> > > +
> > > -					PAGE_SHIFT;  
> > 
> > I haven't looked at this super closely, but how does this stuff work?
> > 
> > do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...
> > 
> > Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?
> >
> > Otherwise MEMLOCK is really doubled..  
> 
> So this has been a problem for some time, but it's not as easy as adding them
> together, see [1][2] for a start.
> 
> The locked_vm/pinned_vm issue definitely needs fixing, but all this series is
> trying to do is account to the right counter.

This still makes me nervous because we have userspace dependencies on
setting process locked memory.  There's a user visible difference if we
account for them in the same bucket vs separate.  Perhaps we're
counting in the wrong bucket now, but if we "fix" that and userspace
adapts, how do we ever go back to accounting both mlocked and pinned
memory combined against rlimit?  Thanks,

Alex
