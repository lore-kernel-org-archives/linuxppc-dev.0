Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3T2k2pCBzDrSR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 12:54:36 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id q5so4167866oth.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 17:54:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-5-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Dec 2017 17:54:33 -0800
Message-ID: <CAPcyv4i-TWnQ-fRVLB9kaSxJ+2QwZUEEixkTSwYGF-73fmemvw@mail.gmail.com>
Subject: Re: [PATCH 04/17] mm: pass the vmem_altmap to arch_add_memory and
 __add_pages
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>,
 Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 6:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> We can just pass this on instead of having to do a radix tree lookup
> without proper locking 2 levels into the callchain.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[..]
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 8acdc35c2dfa..e26ade50ae18 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -772,12 +772,12 @@ static void update_end_of_memory_vars(u64 start, u64 size)
>         }
>  }
>
> -int add_pages(int nid, unsigned long start_pfn,
> -             unsigned long nr_pages, bool want_memblock)
> +int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
> +               struct vmem_altmap *altmap, bool want_memblock)
>  {
>         int ret;
>
> -       ret = __add_pages(nid, start_pfn, nr_pages, want_memblock);
> +       ret = __add_pages(nid, start_pfn, nr_pages, NULL, want_memblock);
>         WARN_ON_ONCE(ret);

Should be 'altmap' instead of NULL.
