Return-Path: <SRS0=4UjL=2K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADEBC43603
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Dec 2019 09:24:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8068B20716
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Dec 2019 09:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8068B20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47fNbk6vBtzDqwD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Dec 2019 20:24:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47fNYS5KnNzDqvg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2019 20:22:02 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 98BD2AE00;
 Fri, 20 Dec 2019 09:21:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 38E621E0B44; Fri, 20 Dec 2019 10:21:54 +0100 (CET)
Date: Fri, 20 Dec 2019 10:21:54 +0100
From: Jan Kara <jack@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 00/25] mm/gup: track dma-pinned pages: FOLL_PIN
Message-ID: <20191220092154.GA10068@quack2.suse.cz>
References: <20191216222537.491123-1-jhubbard@nvidia.com>
 <20191219132607.GA410823@unreal>
 <a4849322-8e17-119e-a664-80d9f95d850b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4849322-8e17-119e-a664-80d9f95d850b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 Maor Gottlieb <maorg@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 19-12-19 12:30:31, John Hubbard wrote:
> On 12/19/19 5:26 AM, Leon Romanovsky wrote:
> > On Mon, Dec 16, 2019 at 02:25:12PM -0800, John Hubbard wrote:
> > > Hi,
> > > 
> > > This implements an API naming change (put_user_page*() -->
> > > unpin_user_page*()), and also implements tracking of FOLL_PIN pages. It
> > > extends that tracking to a few select subsystems. More subsystems will
> > > be added in follow up work.
> > 
> > Hi John,
> > 
> > The patchset generates kernel panics in our IB testing. In our tests, we
> > allocated single memory block and registered multiple MRs using the single
> > block.
> > 
> > The possible bad flow is:
> >   ib_umem_geti() ->
> >    pin_user_pages_fast(FOLL_WRITE) ->
> >     internal_get_user_pages_fast(FOLL_WRITE) ->
> >      gup_pgd_range() ->
> >       gup_huge_pd() ->
> >        gup_hugepte() ->
> >         try_grab_compound_head() ->
> 
> Hi Leon,
> 
> Thanks very much for the detailed report! So we're overflowing...
> 
> At first look, this seems likely to be hitting a weak point in the
> GUP_PIN_COUNTING_BIAS-based design, one that I believed could be deferred
> (there's a writeup in Documentation/core-api/pin_user_page.rst, lines
> 99-121). Basically it's pretty easy to overflow the page->_refcount
> with huge pages if the pages have a *lot* of subpages.
> 
> We can only do about 7 pins on 1GB huge pages that use 4KB subpages.
> Do you have any idea how many pins (repeated pins on the same page, which
> it sounds like you have) might be involved in your test case,
> and the huge page and system page sizes? That would allow calculating
> if we're likely overflowing for that reason.
> 
> So, ideas and next steps:
> 
> 1. Assuming that you *are* hitting this, I think I may have to fall back to
> implementing the "deferred" part of this design, as part of this series, after
> all. That means:
> 
>   For the pin/unpin calls at least, stop treating all pages as if they are
>   a cluster of PAGE_SIZE pages; instead, retrieve a huge page as one page.
>   That's not how it works now, and the need to hand back a huge array of
>   subpages is part of the problem. This affects the callers too, so it's not
>   a super quick change to make. (I was really hoping not to have to do this
>   yet.)

Does that mean that you would need to make all GUP users huge page aware?
Otherwise I don't see how what you suggest would work... And I don't think
making all GUP users huge page aware is realistic (effort-wise) or even
wanted (maintenance overhead in all those places).

I believe there might be also a different solution for this: For
transparent huge pages, we could find a space in 'struct page' of the
second page in the huge page for proper pin counter and just account pins
there so we'd have full width of 32-bits for it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
