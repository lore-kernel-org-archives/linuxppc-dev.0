Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C6020863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SgKm55WBzDqDf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 03:52:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SgD25D7TzDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 03:47:29 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Mar 2019 09:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; d="scan'208";a="145091052"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 25 Mar 2019 09:47:25 -0700
Date: Mon, 25 Mar 2019 01:46:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND 1/7] mm/gup: Replace get_user_pages_longterm() with
 FOLL_LONGTERM
Message-ID: <20190325084614.GE16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-2-ira.weiny@intel.com>
 <CAA9_cmffz1VBOJ0ykBtcj+hiznn-kbbuotu1uUhPiJtXiFjJXg@mail.gmail.com>
 <20190325061941.GA16366@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hPxoX1+u=fjzCeVYOd9Bck9d=A9SQ-mjzeMA2tf9B9dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hPxoX1+u=fjzCeVYOd9Bck9d=A9SQ-mjzeMA2tf9B9dA@mail.gmail.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 linux-mips@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 09:45:12AM -0700, Dan Williams wrote:
> On Mon, Mar 25, 2019 at 7:21 AM Ira Weiny <ira.weiny@intel.com> wrote:
> [..]
> > > > @@ -1268,10 +1246,14 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
> > > >                                 putback_movable_pages(&cma_page_list);
> > > >                 }
> > > >                 /*
> > > > -                * We did migrate all the pages, Try to get the page references again
> > > > -                * migrating any new CMA pages which we failed to isolate earlier.
> > > > +                * We did migrate all the pages, Try to get the page references
> > > > +                * again migrating any new CMA pages which we failed to isolate
> > > > +                * earlier.
> > > >                  */
> > > > -               nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
> > > > +               nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
> > > > +                                                  pages, vmas, NULL,
> > > > +                                                  gup_flags);
> > > > +
> > >
> > > Why did this need to change to __get_user_pages_locked?
> >
> > __get_uer_pages_locked() is now the "internal call" for get_user_pages.
> >
> > Technically it did not _have_ to change but there is no need to call
> > get_user_pages() again because the FOLL_TOUCH flags is already set.  Also this
> > call then matches the __get_user_pages_locked() which was called on the pages
> > we migrated from.  Mostly this keeps the code "symmetrical" in that we called
> > __get_user_pages_locked() on the pages we are migrating from and the same call
> > on the pages we migrated to.
> >
> > While the change here looks funny I think the final code is better.
> 
> Agree, but I think that either needs to be noted in the changelog so
> it's not a surprise, or moved to a follow-on cleanup patch.
> 

Can do...

Thanks!
Ira

