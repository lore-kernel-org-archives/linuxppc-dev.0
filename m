Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C21C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 00:25:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6B8205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 00:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6B8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440HHR0386zDqWg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 11:25:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440GXb4LbZzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:52:14 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2019 15:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; d="scan'208";a="134118611"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2019 15:52:08 -0800
Date: Wed, 13 Feb 2019 15:52:01 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V2 3/7] mm/gup: Change GUP fast to use flags rather than
 a write 'bool'
Message-ID: <20190213235200.GA1151@iweiny-DESK2.sc.intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190213230455.5605-1-ira.weiny@intel.com>
 <20190213230455.5605-4-ira.weiny@intel.com>
 <20190213231110.GD24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213231110.GD24692@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Mailman-Approved-At: Thu, 14 Feb 2019 11:24:24 +1100
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
Cc: Martin Brandenburg <martin@omnibond.com>, linux-fbdev@vger.kernel.org,
 Rich Felker <dalias@libc.org>, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Hildenbrand <david@redhat.com>, Rob Springer <rspringer@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Jason Wang <jasowang@redhat.com>,
 devel@lists.orangefs.org, linux-media@vger.kernel.org,
 Ben Chan <benchan@chromium.org>, Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexandre Bounine <alex.bou9@gmail.com>, Todd Poynor <toddpoynor@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Moritz Fischer <mdf@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Wu Hao <hao.wu@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Christian Benvenuti <benve@cisco.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 04:11:10PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 13, 2019 at 03:04:51PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > To facilitate additional options to get_user_pages_fast() change the
> > singular write parameter to be gup_flags.
> 
> So now we have:
> 
> long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> 		    struct page **pages, unsigned int gup_flags);
> 
> and 
> 
> int get_user_pages_fast(unsigned long start, int nr_pages,
> 			unsigned int gup_flags, struct page **pages)
> 
> Does this make any sense? At least the arguments should be in the same
> order, I think.

Yes...  and no.  see below.

> 
> Also this comment:
> /*
>  * get_user_pages_unlocked() is suitable to replace the form:
>  *
>  *      down_read(&mm->mmap_sem);
>  *      get_user_pages(tsk, mm, ..., pages, NULL);
>  *      up_read(&mm->mmap_sem);
>  *
>  *  with:
>  *
>  *      get_user_pages_unlocked(tsk, mm, ..., pages);
>  *
>  * It is functionally equivalent to get_user_pages_fast so
>  * get_user_pages_fast should be used instead if specific gup_flags
>  * (e.g. FOLL_FORCE) are not required.
>  */
> 
> Needs some attention as the recommendation is now nonsense.

IMO they are not functionally equivalent.

We can't remove *_unlocked() as it is used as both a helper for the arch
specific *_fast() calls, _and_ in drivers.  Again I don't know the history here
but it could be that the drivers should never have used the call in the first
place???  Or been converted at some point?

I could change the comment to be something like

/*
 * get_user_pages_unlocked() is only to be used by arch specific
 * get_user_pages_fast() calls.  Drivers should be calling
 * get_user_pages_fast()
 */

Instead of the current comment.

And change the drivers to get_user_pages_fast().

However, I'm not sure if these drivers need the FOLL_TOUCH flag which
*_unlocked() adds for them.  And adding FOLL_TOUCH to *_fast() is not going to
give the same functionality.

It _looks_ like we can add FOLL_TOUCH functionality to the fast path in the
generic code.  I'm not sure about the arch's.

If we did that then we can have those drivers use FOLL_TOUCH or not in *_fast()
if they want/need.

> 
> Honestly a proper explanation of why two functions exist would be
> great at this point :)

I've not researched it.  I do agree that there seems to be a lot of calls in
this file and the differences are subtle.

Ira

> 
> Jason
