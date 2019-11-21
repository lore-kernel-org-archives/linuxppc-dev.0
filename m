Return-Path: <SRS0=V+RV=ZN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DAC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695F920656
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XkP12c/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JhyM2YLQzDr7m
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 01:38:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f43;
 helo=mail-qv1-xf43.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="XkP12c/i"; 
 dkim-atps=neutral
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Jhw236VczDr2N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2019 01:36:48 +1100 (AEDT)
Received: by mail-qv1-xf43.google.com with SMTP id w11so1457981qvu.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rv5c3PJEtM2ffNdfZuVl2p9Xs+FPDxJaOjEmQ2G8DAo=;
 b=XkP12c/ibS/aRyryTCd4qjn/PXxyYCusK1THaNAzNjypEGkjhmCt9LtT+qYEnSe3fB
 R0spZ8YqysCDI95uGLLvFVswmZUjEqJ9cNCyHcavEFwClRwZ6y4PKDy88MyzZlAfM967
 hisIg3vRQPZ469GZRWnqA3CNAZUY/hKDr+kXV7+2R0BibPU9CM1KGy5uODfMlNXxTJJo
 tHEs5mFWOzUwzAdEjcr2fH3dCNIBIBIgehoNt8ki1/1o3yu01BkPAihfF+3/v5R6c6NG
 mm7J2IKwvLhTCpGsMr85umCSjimcUeH9XgLjTylXIMq1THOPpUYiNcR9NxoGX25nyfzV
 YKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rv5c3PJEtM2ffNdfZuVl2p9Xs+FPDxJaOjEmQ2G8DAo=;
 b=fx1VLpcXB0qRlfxdHO5dsu/Q5wImm0yxsEeR2ZxNYIJtHD49R2bs3Dn/SwzVyYGAAF
 QansqNyWbDRSw5IeSjYGfndAgkBfj7Bx1CDn2DEV6h6cnJ/M1Ttw9UtoskJD5NYBebPD
 t/6APVFmQPZfsIUszzs2wOSTt8w1XpywR2rhbhRhTaeNpe6BITg/C/d2zXleT82oBNCw
 KU1y0S3UfZx/a6ecWWf/eiL8eCFYx0c7Rb8yeSPdd/9FSCGWxDW+j/eS4gWf5DQCUrcQ
 b5Cs1p+g2twq0hHstXGhecwn9xISuqafK2lU/lxp95C306Hc/q/9TbZphUmDGyHg1MKc
 bqfQ==
X-Gm-Message-State: APjAAAXMOGAAuDTfNTVg+GIseNDNynEU/J8B9LwjcoGei2l8IsB1AXGN
 alSzKDU0bqeNROtQ8ouotOiKRQ==
X-Google-Smtp-Source: APXvYqxiPTD6uqfSlGreW7CNwXwCXJOA4tNSbO40QzzV7IhKLzuaPAx4PWY7OQoHdNILaiGopmJlAA==
X-Received: by 2002:a0c:e74a:: with SMTP id g10mr8540002qvn.29.1574347005412; 
 Thu, 21 Nov 2019 06:36:45 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id 40sm1584912qtc.95.2019.11.21.06.36.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 06:36:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iXnZb-0004bF-SZ; Thu, 21 Nov 2019 10:36:43 -0400
Date: Thu, 21 Nov 2019 10:36:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 07/24] IB/umem: use get_user_pages_fast() to pin DMA
 pages
Message-ID: <20191121143643.GC7448@ziepe.ca>
References: <20191121071354.456618-1-jhubbard@nvidia.com>
 <20191121071354.456618-8-jhubbard@nvidia.com>
 <20191121080746.GC30991@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121080746.GC30991@infradead.org>
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
 Vlastimil Babka <vbabka@suse.cz>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
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

On Thu, Nov 21, 2019 at 12:07:46AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 20, 2019 at 11:13:37PM -0800, John Hubbard wrote:
> > And get rid of the mmap_sem calls, as part of that. Note
> > that get_user_pages_fast() will, if necessary, fall back to
> > __gup_longterm_unlocked(), which takes the mmap_sem as needed.
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Looks fine,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jason, can you queue this up for 5.5 to reduce this patch stack a bit?

Yes, I said I'd do this in an earlier revision. Now that it is clear this
won't go through Andrew's tree, applied to rdma for-next

Thanks,
Jason
