Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822C0C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:02:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA10206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ys0DR8XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA10206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z9p05TDZzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 03:02:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="ys0DR8XZ"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z9m24QznzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 03:00:50 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Fs8Jg091591;
 Wed, 3 Apr 2019 15:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=m9/fVJl/h3Kd1KuK3z0lqXqKJeT7piCvZPAM9eU/c/8=;
 b=ys0DR8XZC0YAZvbuOkLQlwFLkYZiTCmf0p3sfDetash2oLWhcI/DR3BxXKfHBR8Nm//3
 tVFHQYx5jsLJT5Yyk+6QFKFYjUp6ogGxcSsGTFJ5pY19qW8pvvoWEpWXpEpx8Mq/vkgP
 wpiG5deCHbow6vkO4Ytxbzyp9tWUSxi+n0wkHkUGwv7CXLYfsyzFZR90Bc40Se8dbDff
 JqPcJ9GgzILz+SDLyYA4kxm8v6nt4e70O+4uIeaoBwmGEIwgzuLi2i8dATpEhIujJdni
 A59HJPonxahfIIwDj4rfR7muFqgtraJ11X0zNM8dWl4yD6MOnLR9rZDE0PU2bfoqDJFI tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 2rhwyda5fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 15:58:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Fw9pX179888;
 Wed, 3 Apr 2019 15:58:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2rm8f56372-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Apr 2019 15:58:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33FwDYU029010;
 Wed, 3 Apr 2019 15:58:13 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 03 Apr 2019 08:58:13 -0700
Date: Wed, 3 Apr 2019 11:58:39 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190403155839.m447czluxd74n5ad@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030108
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030108
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org,
 Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 02, 2019 at 03:04:24PM -0700, Andrew Morton wrote:
> On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
> >  {
> >  	long ret = 0;
> > +	s64 locked_vm;
> >  
> >  	if (!current || !current->mm)
> >  		return ret; /* process exited */
> >  
> >  	down_write(&current->mm->mmap_sem);
> >  
> > +	locked_vm = atomic64_read(&current->mm->locked_vm);
> >  	if (inc) {
> >  		unsigned long locked, lock_limit;
> >  
> > -		locked = current->mm->locked_vm + stt_pages;
> > +		locked = locked_vm + stt_pages;
> >  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >  			ret = -ENOMEM;
> >  		else
> > -			current->mm->locked_vm += stt_pages;
> > +			atomic64_add(stt_pages, &current->mm->locked_vm);
> >  	} else {
> > -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> > -			stt_pages = current->mm->locked_vm;
> > +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> > +			stt_pages = locked_vm;
> >  
> > -		current->mm->locked_vm -= stt_pages;
> > +		atomic64_sub(stt_pages, &current->mm->locked_vm);
> >  	}
> 
> With the current code, current->mm->locked_vm cannot go negative. 
> After the patch, it can go negative.  If someone else decreased
> current->mm->locked_vm between this function's atomic64_read() and
> atomic64_sub().
> 
> I guess this is a can't-happen in this case because the racing code
> which performed the modification would have taken it negative anyway.
> 
> But this all makes me rather queazy.

mmap_sem is still held in this patch, so updates to locked_vm are still
serialized and I don't think what you describe can happen.  A later patch
removes mmap_sem, of course, but it also rewrites the code to do something
different.  This first patch is just a mechanical type change from unsigned
long to atomic64_t.

So...does this alleviate your symptoms?

> Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
> thinking that the benefit of removing a few mmap_sem-takings from a few
> obscure drivers (sorry ;)) is pretty small.

Not sure about the other drivers, but vfio type1 isn't obscure.  We use it
extensively in our cloud, and from Andrea's __GFP_THISNODE thread a few months
back it seems Red Hat also uses it:

  https://lore.kernel.org/linux-mm/20180820032204.9591-3-aarcange@redhat.com/

> Also, the argument for switching 32-bit arches to a 64-bit counter was
> suspiciously vague.  What overflow issues?  Or are we just being lazy?

If user-controlled values are used to increase locked_vm, multiple threads
doing it at once on a 32-bit system could theoretically cause overflow, so in
the absence of atomic overflow checking, the 64-bit counter on 32b is defensive
programming.

I wouldn't have thought to do it, but Jason Gunthorpe raised the same issue in
the pinned_vm series:

  https://lore.kernel.org/linux-mm/20190115205311.GD22031@mellanox.com/

I'm fine with changing it to atomic_long_t if the scenario is too theoretical
for people.


Anyway, thanks for looking at this.
