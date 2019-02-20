Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302CCC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60D820645
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60D820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444QcZ5bmdzDqCG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 05:10:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444QSM0xPzzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 05:02:57 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Feb 2019 10:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; d="scan'208";a="148440466"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2019 10:02:55 -0800
Date: Wed, 20 Feb 2019 10:02:56 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RESEND PATCH 0/7] Add FOLL_LONGTERM to GUP fast and use it
Message-ID: <20190220180255.GA12020@iweiny-DESK2.sc.intel.com>
References: <20190220053040.10831-1-ira.weiny@intel.com>
 <20190220151930.GB11695@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220151930.GB11695@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: linux-fbdev@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 linux-fpga@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, devel@lists.orangefs.org,
 linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 kvm-ppc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 07:19:30AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 19, 2019 at 09:30:33PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Resending these as I had only 1 minor comment which I believe we have covered
> > in this series.  I was anticipating these going through the mm tree as they
> > depend on a cleanup patch there and the IB changes are very minor.  But they
> > could just as well go through the IB tree.
> > 
> > NOTE: This series depends on my clean up patch to remove the write parameter
> > from gup_fast_permitted()[1]
> > 
> > HFI1, qib, and mthca, use get_user_pages_fast() due to it performance
> > advantages.  These pages can be held for a significant time.  But
> > get_user_pages_fast() does not protect against mapping of FS DAX pages.
> 
> This I don't get - if you do lock down long term mappings performance
> of the actual get_user_pages call shouldn't matter to start with.
> 
> What do I miss?

A couple of points.

First "longterm" is a relative thing and at this point is probably a misnomer.
This is really flagging a pin which is going to be given to hardware and can't
move.  I've thought of a couple of alternative names but I think we have to
settle on if we are going to use FL_LAYOUT or something else to solve the
"longterm" problem.  Then I think we can change the flag to a better name.

Second, It depends on how often you are registering memory.  I have spoken with
some RDMA users who consider MR in the performance path...  For the overall
application performance.  I don't have the numbers as the tests for HFI1 were
done a long time ago.  But there was a significant advantage.  Some of which is
probably due to the fact that you don't have to hold mmap_sem.

Finally, architecturally I think it would be good for everyone to use *_fast.
There are patches submitted to the RDMA list which would allow the use of
*_fast (they reworking the use of mmap_sem) and as soon as they are accepted
I'll submit a patch to convert the RDMA core as well.  Also to this point
others are looking to use *_fast.[2]

As an asside, Jasons pointed out in my previous submission that *_fast and
*_unlocked look very much the same.  I agree and I think further cleanup will
be coming.  But I'm focused on getting the final solution for DAX at the
moment.

Ira

