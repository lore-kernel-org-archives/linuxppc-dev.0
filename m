Return-Path: <SRS0=Dwgl=2B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA11C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 20:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3239220836
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 20:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3239220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Y8Sl70XjzDqxl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 07:59:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net
 (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwn.net
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Y8QS0zYgzDqLY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2019 07:57:45 +1100 (AEDT)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 7D799739;
 Wed, 11 Dec 2019 20:57:38 +0000 (UTC)
Date: Wed, 11 Dec 2019 13:57:37 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v9 10/25] mm/gup: introduce pin_user_pages*() and FOLL_PIN
Message-ID: <20191211135737.581add2f@lwn.net>
In-Reply-To: <20191211025318.457113-11-jhubbard@nvidia.com>
References: <20191211025318.457113-1-jhubbard@nvidia.com>
 <20191211025318.457113-11-jhubbard@nvidia.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
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
 linux-rdma@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFQ=?= =?UTF-8?B?w7ZwZWw=?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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

On Tue, 10 Dec 2019 18:53:03 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> Introduce pin_user_pages*() variations of get_user_pages*() calls,
> and also pin_longterm_pages*() variations.

Just a couple of nits on the documentation patch

> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -0,0 +1,232 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================================
> +pin_user_pages() and related calls
> +====================================================
> +
> +.. contents:: :local:
> +
> +Overview
> +========
> +
> +This document describes the following functions: ::
> +
> + pin_user_pages
> + pin_user_pages_fast
> + pin_user_pages_remote

You could just say "the following functions::" and get the result you're
after with a slightly less alien plain-text reading experience.

Of course, you could also just say "This document describes
pin_user_pages(), pin_user_pages_fast(), and pin_user_pages_remote()." But
that's a matter of personal taste, I guess.  Using the function() notation
will cause the docs system to automatically link to the kerneldoc info,
though.  

> +Basic description of FOLL_PIN
> +=============================
> +
> +FOLL_PIN and FOLL_LONGTERM are flags that can be passed to the get_user_pages*()
> +("gup") family of functions. FOLL_PIN has significant interactions and
> +interdependencies with FOLL_LONGTERM, so both are covered here.
> +
> +FOLL_PIN is internal to gup, meaning that it should not appear at the gup call
> +sites. This allows the associated wrapper functions  (pin_user_pages*() and
> +others) to set the correct combination of these flags, and to check for problems
> +as well.
> +
> +FOLL_LONGTERM, on the other hand, *is* allowed to be set at the gup call sites.
> +This is in order to avoid creating a large number of wrapper functions to cover
> +all combinations of get*(), pin*(), FOLL_LONGTERM, and more. Also, the
> +pin_user_pages*() APIs are clearly distinct from the get_user_pages*() APIs, so
> +that's a natural dividing line, and a good point to make separate wrapper calls.
> +In other words, use pin_user_pages*() for DMA-pinned pages, and
> +get_user_pages*() for other cases. There are four cases described later on in
> +this document, to further clarify that concept.
> +
> +FOLL_PIN and FOLL_GET are mutually exclusive for a given gup call. However,
> +multiple threads and call sites are free to pin the same struct pages, via both
> +FOLL_PIN and FOLL_GET. It's just the call site that needs to choose one or the
> +other, not the struct page(s).
> +
> +The FOLL_PIN implementation is nearly the same as FOLL_GET, except that FOLL_PIN
> +uses a different reference counting technique.
> +
> +FOLL_PIN is a prerequisite to FOLL_LONGTGERM. Another way of saying that is,

FOLL_LONGTERM typoed there.

Thanks,

jon
