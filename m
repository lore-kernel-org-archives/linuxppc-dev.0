Return-Path: <SRS0=PO5t=ZF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0499CC432C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 22:58:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB54C206EE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 22:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pCpoe/mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB54C206EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47D0QG1tlZzF1mS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:58:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::244;
 helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="pCpoe/mN"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D0Mk3lnzzF7CH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 09:56:02 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id i185so3423299oif.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2019 14:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1bJ2iQSSM6xcSelzNGAxbFz3I+vbpZT1i7brWNNqBkM=;
 b=pCpoe/mNOZz7kf3BriV6FO1vlXqTtiMMjAyo1q9EkOVhYkaiAqjCUuZi8sR+VQiBUA
 tepmQBglxY1OyOFgLzLhHdxfydFb30a1T5RkieXCkBFnd+r3jlYUpcVkeItPqd8k1TpH
 QuhVbvlkeE58Xf1ZF8OpCLmfeJPI9CouiPQucJ+3FTXLyAwrqgBL1Jq/bDxYNQJ1pm0t
 QwUZhi1PIoqdyrkPynzAPysfVDAz8iXycZT/frJ4ZqyEjG7GG1vaypwpuBBW6+YfO+vS
 yAWIhvE5Ewgu6JZ+miOrKnhJdqk41OXN/rGjK6CG6z8BEEbcMZ3o541dr2Qk8nqK1nMV
 nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1bJ2iQSSM6xcSelzNGAxbFz3I+vbpZT1i7brWNNqBkM=;
 b=YmUnJP7mNlE46xXLr2d1j7xRCYyNYcvaKTiEpj5Vl22yKUPvPFCdz//0Tmpaqwdwiq
 2wTewhjHy7RZg91/uy/m5fATXQARue3UFrXUfofnCAXVPGxkp6O2cIsH0uyyxOknoORS
 0ot5mm/DTEPyxAa1/PyX1P6wqSrb1Qw4Qc2Fdbx5g4tq/pQUILMgnKhUQhXCdKRjs2ui
 XuQN1oEXREGS4L0p2WVj1Nn+mGHd7bzj4tKskiwfwvm1WhOXcN7jSjYnGJ31of6PH2Ne
 S0aZJIDsGHSOZ9gpbEe+vJzv3HOAFKYJ7DsMBKUHtpJjNfZx+6ZzDGGFu7NWXKFgdykg
 TqzA==
X-Gm-Message-State: APjAAAXT+8wCFB//v2QXJjd1Oa9wwVmc3ZRQUeCGCrykmDkwKagpLwyR
 J4M/UH+yev9jtlnXwgIVGuTLg88VfEwk2QJ5rS5/Yw==
X-Google-Smtp-Source: APXvYqyJeu0oEnEbiksmKmpQyhxc2gHeYTp6WMlUX+9IHLnztuXVhLxAlHQ8+r67EFGUZS3SArHRAAMqXvaEz+sSmQk=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr868531oih.73.1573685758691;
 Wed, 13 Nov 2019 14:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113042710.3997854-1-jhubbard@nvidia.com>
 <20191113042710.3997854-5-jhubbard@nvidia.com>
 <CAPcyv4gGu=G-c1czSAYJ3joTYS_ZYOJ6i9umKzCQEFzpwZMiiA@mail.gmail.com>
 <CAPcyv4hr64b-k4j7ZY796+k-+Dy11REMcvPJ+QjTsyJ3vSdfKg@mail.gmail.com>
 <00148078-1795-da3e-916e-3ae2dcdd553d@nvidia.com>
In-Reply-To: <00148078-1795-da3e-916e-3ae2dcdd553d@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Nov 2019 14:55:47 -0800
Message-ID: <CAPcyv4iwG4V+sNLcOX4x-TA7W8MWNSEaZzupDgKh8btZMytoqg@mail.gmail.com>
Subject: Re: [PATCH v4 04/23] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To: John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
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
 KVM list <kvm@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Netdev <netdev@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 13, 2019 at 2:49 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/13/19 2:00 PM, Dan Williams wrote:
> ...
> >> Ugh, when did all this HMM specific manipulation sneak into the
> >> generic ZONE_DEVICE path? It used to be gated by pgmap type with its
> >> own put_zone_device_private_page(). For example it's certainly
> >> unnecessary and might be broken (would need to check) to call
> >> mem_cgroup_uncharge() on a DAX page. ZONE_DEVICE users are not a
> >> monolith and the HMM use case leaks pages into code paths that DAX
> >> explicitly avoids.
> >
> > It's been this way for a while and I did not react previously,
> > apologies for that. I think __ClearPageActive, __ClearPageWaiters, and
> > mem_cgroup_uncharge, belong behind a device-private conditional. The
> > history here is:
> >
> > Move some, but not all HMM specifics to hmm_devmem_free():
> >      2fa147bdbf67 mm, dev_pagemap: Do not clear ->mapping on final put
> >
> > Remove the clearing of mapping since no upstream consumers needed it:
> >      b7a523109fb5 mm: don't clear ->mapping in hmm_devmem_free
> >
> > Add it back in once an upstream consumer arrived:
> >      7ab0ad0e74f8 mm/hmm: fix ZONE_DEVICE anon page mapping reuse
> >
> > We're now almost entirely free of ->page_free callbacks except for
> > that weird nouveau case, can that FIXME in nouveau_dmem_page_free()
> > also result in killing the ->page_free() callback altogether? In the
> > meantime I'm proposing a cleanup like this:
>
>
> OK, assuming this is acceptable (no obvious problems jump out at me,
> and we can also test it with HMM), then how would you like to proceed, as
> far as patches go: add such a patch as part of this series here, or as a
> stand-alone patch either before or after this series? Or something else?
> And did you plan on sending it out as such?

I think it makes sense to include it in your series since you're
looking to refactor the implementation. I can send you one based on
current linux-next as a lead-in cleanup before the refactor. Does that
work for you?

>
> Also, the diffs didn't quite make it through intact to my "git apply", so
> I'm re-posting the diff in hopes that this time it survives:

Apologies for that. For quick "how about this" patch examples, I just
copy and paste into gmail and it sometimes clobbers it.

>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..21db1ce8c0ae 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
>         put_disk(pmem->disk);
>   }
>
> -static void pmem_pagemap_page_free(struct page *page)
> -{
> -       wake_up_var(&page->_refcount);
> -}
> -
>   static const struct dev_pagemap_ops fsdax_pagemap_ops = {
> -       .page_free              = pmem_pagemap_page_free,
>         .kill                   = pmem_pagemap_kill,
>         .cleanup                = pmem_pagemap_cleanup,
>   };
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03ccbdfeb697..157edb8f7cf8 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -419,12 +419,6 @@ void __put_devmap_managed_page(struct page *page)
>          * holds a reference on the page.
>          */
>         if (count == 1) {
> -               /* Clear Active bit in case of parallel mark_page_accessed */
> -               __ClearPageActive(page);
> -               __ClearPageWaiters(page);
> -
> -               mem_cgroup_uncharge(page);
> -
>                 /*
>                  * When a device_private page is freed, the page->mapping field
>                  * may still contain a (stale) mapping value. For example, the
> @@ -446,10 +440,17 @@ void __put_devmap_managed_page(struct page *page)
>                  * handled differently or not done at all, so there is no need
>                  * to clear page->mapping.
>                  */
> -               if (is_device_private_page(page))
> -                       page->mapping = NULL;
> +               if (is_device_private_page(page)) {
> +                       /* Clear Active bit in case of parallel mark_page_accessed */
> +                       __ClearPageActive(page);
> +                       __ClearPageWaiters(page);
>
> -               page->pgmap->ops->page_free(page);
> +                       mem_cgroup_uncharge(page);
> +
> +                       page->mapping = NULL;
> +                       page->pgmap->ops->page_free(page);
> +               } else
> +                       wake_up_var(&page->_refcount);
>         } else if (!count)
>                 __put_page(page);
>   }
> --
> 2.24.0
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index ad8e4df1282b..4eae441f86c9 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -337,13 +337,7 @@ static void pmem_release_disk(void *__pmem)
> >          put_disk(pmem->disk);
> >   }
> >
> > -static void pmem_pagemap_page_free(struct page *page)
> > -{
> > -       wake_up_var(&page->_refcount);
> > -}
> > -
> >   static const struct dev_pagemap_ops fsdax_pagemap_ops = {
> > -       .page_free              = pmem_pagemap_page_free,
> >          .kill                   = pmem_pagemap_kill,
> >          .cleanup                = pmem_pagemap_cleanup,
> >   };
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 03ccbdfeb697..157edb8f7cf8 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -419,12 +419,6 @@ void __put_devmap_managed_page(struct page *page)
> >           * holds a reference on the page.
> >           */
> >          if (count == 1) {
> > -               /* Clear Active bit in case of parallel mark_page_accessed */
> > -               __ClearPageActive(page);
> > -               __ClearPageWaiters(page);
> > -
> > -               mem_cgroup_uncharge(page);
> > -
> >                  /*
> >                   * When a device_private page is freed, the page->mapping field
> >                   * may still contain a (stale) mapping value. For example, the
> > @@ -446,10 +440,17 @@ void __put_devmap_managed_page(struct page *page)
> >                   * handled differently or not done at all, so there is no need
> >                   * to clear page->mapping.
> >                   */
> > -               if (is_device_private_page(page))
> > -                       page->mapping = NULL;
> > +               if (is_device_private_page(page)) {
> > +                       /* Clear Active bit in case of parallel
> > mark_page_accessed */
> > +                       __ClearPageActive(page);
> > +                       __ClearPageWaiters(page);
> >
> > -               page->pgmap->ops->page_free(page);
> > +                       mem_cgroup_uncharge(page);
> > +
> > +                       page->mapping = NULL;
> > +                       page->pgmap->ops->page_free(page);
> > +               } else
> > +                       wake_up_var(&page->_refcount);
> >          } else if (!count)
> >                  __put_page(page);
> >   }
> >
