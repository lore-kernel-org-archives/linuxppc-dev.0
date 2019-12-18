Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A8C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 22:47:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6CF20717
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 22:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bdF7Zv0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6CF20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dVWM306yzDqk5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 09:47:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=shutemov.name
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="bdF7Zv0V"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dVT52xnLzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 09:45:11 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id r14so2885181lfm.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YrrQW+o6yoR9HJnH1mwKSC9v5iWno6eigHp0EBk4LR0=;
 b=bdF7Zv0VTafIoorJswX48t2yxXJBYxcvjHgrT2SGIIMh8SxTaUWksloPDk4hj8pN+b
 8Wy7ZGVYH0fWsHmH/IMJnBSfIeVts/sOmiy4I/nlOeq68AiZoaQ1Mqh2e43FlXq9gRLG
 KshnO+IUvlyZD7e2bgfiCpZOkUn91XMsyCwRx9hGVqlfs3W1si7CDXXM3vtqSXuMWY78
 Tae1sOhSYoNDJLrJgal+3cpj+/6xa05u+pWrMRgdVnIo9FZyRNB0aI0+sHon8/zGouR0
 pqwpw4LUVoV4NK9FktzSrs+SeQWsHdxx0QqmCUwextJEn9FOXazhfjjyb53FWNWWcUXk
 GNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YrrQW+o6yoR9HJnH1mwKSC9v5iWno6eigHp0EBk4LR0=;
 b=sbsX3FQYyN0/srmJV7mhWbN+9TSYm5fe1WxtNzEqXNpWlFt9x3FaM5325EZGDKbwIA
 Z3a1yoKPXVizELpA8Mfb0JQmogUcZbZo/zo0qoilKX9ZP2NTR+W9sv40LfoHZVmXsMdm
 Nq5dlU+8FYpwdx6MXClVKMA8BxKh3h8yH/vi6DVVrCWHGyKAhGPz7gCV06xkzC8JMDXh
 cAAStmbXX10bK7PDPpUAWx4U7520jqeWXRDS5sgJYjCQ0vuHK+vCrkbnjeuEvUH/ZetJ
 hli3q6BwXJ7bjoY6uzjQfVkgSiO9TI0rOhwF56ldjFgZM/OucUeXCIy5hEaC6fWpp3Lm
 cDDw==
X-Gm-Message-State: APjAAAUhUcEqNllPSH9G09PVLa5Nt8CU4ntBm3pXQci344srdxdnIuXK
 LCOKIfhm8GPmkY6Q5y1yuoR7VQ==
X-Google-Smtp-Source: APXvYqwPbC3mnICecXB2mktdTfANDFTtD1oSKWMGw8lhRk6/u/eXjGq156/mWoszLGq/OpGErs59TQ==
X-Received: by 2002:a19:6a06:: with SMTP id u6mr3341913lfu.187.1576709107276; 
 Wed, 18 Dec 2019 14:45:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id t6sm1792834ljj.62.2019.12.18.14.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:45:06 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
 id 380451012E3; Thu, 19 Dec 2019 01:45:07 +0300 (+03)
Date: Thu, 19 Dec 2019 01:45:07 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 01/25] mm/gup: factor out duplicate code from four
 routines
Message-ID: <20191218224507.nayxmx7vvsjvyzsc@box>
References: <20191216222537.491123-1-jhubbard@nvidia.com>
 <20191216222537.491123-2-jhubbard@nvidia.com>
 <20191218155211.emcegdp5uqgorfwe@box>
 <5719efc4-e560-b3d9-8d1f-3ae289bed289@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5719efc4-e560-b3d9-8d1f-3ae289bed289@nvidia.com>
User-Agent: NeoMutt/20180716
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
 Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 18, 2019 at 02:15:53PM -0800, John Hubbard wrote:
> On 12/18/19 7:52 AM, Kirill A. Shutemov wrote:
> > On Mon, Dec 16, 2019 at 02:25:13PM -0800, John Hubbard wrote:
> > > +static void put_compound_head(struct page *page, int refs)
> > > +{
> > > +	/* Do a get_page() first, in case refs == page->_refcount */
> > > +	get_page(page);
> > > +	page_ref_sub(page, refs);
> > > +	put_page(page);
> > > +}
> > 
> > It's not terribly efficient. Maybe something like:
> > 
> > 	VM_BUG_ON_PAGE(page_ref_count(page) < ref, page);
> > 	if (refs > 2)
> > 		page_ref_sub(page, refs - 1);
> > 	put_page(page);
> > 
> > ?
> 
> OK, but how about this instead? I don't see the need for a "2", as that
> is a magic number that requires explanation. Whereas "1" is not a magic
> number--here it means: either there are "many" (>1) refs, or not.

Yeah, it's my thinko. Sure, it has to be '1' (or >= 2, which is less readable).

> And the routine won't be called with refs less than about 32 (2MB huge
> page, 64KB base page == 32 subpages) anyway.

It's hard to make predictions about future :P

> 	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> 	/*
> 	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> 	 * ref needs a put_page().
> 	 */
> 	if (refs > 1)
> 		page_ref_sub(page, refs - 1);
> 	put_page(page);

Looks good to me.

-- 
 Kirill A. Shutemov
