Return-Path: <SRS0=P9+W=Y4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B86FCA9EB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 20:38:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C012206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 20:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Syo1tAT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C012206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 476PlY2wstzF47n
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 07:38:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::843;
 helo=mail-qt1-x843.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Syo1tAT9"; 
 dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476Pdp0cDHzF468
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2019 07:33:50 +1100 (AEDT)
Received: by mail-qt1-x843.google.com with SMTP id t8so25983110qtc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2019 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hy6S1CxSVssj2bkIKuMTAq97xRRQuAGtFwjKjIDSs4I=;
 b=Syo1tAT9HuH4VB5wWMiltn4K6pnLe9wn5bqONEck4zS9JKeiP8TJVYPKQw5ntGO0lO
 Y3jt4UCMH5h1noX1i5QYvgSRGj2xtl4EWsxMUf0qc20g0RvT8UUUzWn0HVswCZXk3AHb
 ewnZ/jON7bJM2qzwTcb9I0s/fHzYB6OUc+9nqxJXF9HS/7VFw2laSQrNtFyVopG8WtQX
 NCFlYEO6FvcqM9dRvuDJLZvUtP9rNpuSVWBBYCT6gAhsX9aZcpDHsP7ohxZiroP0M4+r
 rETOvZb7k+FSw/5xszaImrvpA4a1gkAgGfJ7YkwSD/5z7jV4eZZYF2MBQy/fzICGGpXU
 8Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hy6S1CxSVssj2bkIKuMTAq97xRRQuAGtFwjKjIDSs4I=;
 b=LRGGQwfmLpN/lQCfJul3NPLqe+zdwKebXaLNwxou1LeuV0o9h6CXLElV3vHKSPA+HV
 8dglht6wmqX59wVuvCZ4pnr1MogXXfL/MY5Gy4ZDlzn+M+p0bjg+v3gdTtXf7YLnSsAC
 SGMwYOV0Ug0D3jI7fZk4JLs8ymQkE+ZlwH9XlHQYhfDencTdfxDK+rShlzuMJ4W6S+Tx
 XnXvb6eM6UphOBsu75h6IgFldiWwu5/KupShLuYJelwIlBBUb6k1BOS7hrSeN++IFLDl
 cd3O8tMF/Qp/R6qnD3DHKL6BfXolgl+oRKRkR+uBi8AtgIYOo7nOxgPM/fJI7db/3R+D
 tlwA==
X-Gm-Message-State: APjAAAX/wxGS3m+ZayArHQd0/mOnkYGwGFNmaoJmvYCJjvfRed4pp7yZ
 Z0UoxtiDCZ3X6GPSDug04VjvoA==
X-Google-Smtp-Source: APXvYqzVc13GhfjjgDTIcNfG7UlfIQ4Qj6KKRSXLf1fyFAffIYvvpHXLmVL3LHiF/HBtv2PsaaOkHw==
X-Received: by 2002:ac8:2432:: with SMTP id c47mr14284906qtc.74.1572899627734; 
 Mon, 04 Nov 2019 12:33:47 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id h185sm9953104qkc.7.2019.11.04.12.33.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 12:33:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iRj2o-0005Hx-QL; Mon, 04 Nov 2019 16:33:46 -0400
Date: Mon, 4 Nov 2019 16:33:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 07/18] infiniband: set FOLL_PIN, FOLL_LONGTERM via
 pin_longterm_pages*()
Message-ID: <20191104203346.GF30938@ziepe.ca>
References: <20191103211813.213227-1-jhubbard@nvidia.com>
 <20191103211813.213227-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103211813.213227-8-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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

On Sun, Nov 03, 2019 at 01:18:02PM -0800, John Hubbard wrote:
> Convert infiniband to use the new wrapper calls, and stop
> explicitly setting FOLL_LONGTERM at the call sites.
> 
> The new pin_longterm_*() calls replace get_user_pages*()
> calls, and set both FOLL_LONGTERM and a new FOLL_PIN
> flag. The FOLL_PIN flag requires that the caller must
> return the pages via put_user_page*() calls, but
> infiniband was already doing that as part of an earlier
> commit.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>  drivers/infiniband/core/umem.c              |  5 ++---
>  drivers/infiniband/core/umem_odp.c          | 10 +++++-----
>  drivers/infiniband/hw/hfi1/user_pages.c     |  4 ++--
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  3 +--
>  drivers/infiniband/hw/qib/qib_user_pages.c  |  8 ++++----
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  2 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  9 ++++-----
>  drivers/infiniband/sw/siw/siw_mem.c         |  5 ++---
>  8 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 24244a2f68cc..c5a78d3e674b 100644
> +++ b/drivers/infiniband/core/umem.c
> @@ -272,11 +272,10 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>  
>  	while (npages) {
>  		down_read(&mm->mmap_sem);
> -		ret = get_user_pages(cur_base,
> +		ret = pin_longterm_pages(cur_base,
>  				     min_t(unsigned long, npages,
>  					   PAGE_SIZE / sizeof (struct page *)),
> -				     gup_flags | FOLL_LONGTERM,
> -				     page_list, NULL);
> +				     gup_flags, page_list, NULL);

FWIW, this one should be converted to fast as well, I think we finally
got rid of all the blockers for that?

Jason
