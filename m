Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3SwP14L2zF06l
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 12:49:05 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id v21so26500176oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 17:49:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-5-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Dec 2017 17:49:01 -0800
Message-ID: <CAPcyv4jyjNM1nRskA5Q9Q6w69OeL1=mssyTYDqFXqW2X40Oc0g@mail.gmail.com>
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
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 403ab9cdb949..16456117a1b1 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -427,7 +427,7 @@ void *devm_memremap_pages(struct device *dev, struct resource *res,
>                 goto err_pfn_remap;
>
>         mem_hotplug_begin();
> -       error = arch_add_memory(nid, align_start, align_size, false);
> +       error = arch_add_memory(nid, align_start, align_size, altmap, false);
>         if (!error)
>                 move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>                                         align_start >> PAGE_SHIFT,

Subtle bug here. This altmap is the one that was passed in that we
copy into its permanent location in the pgmap, so it looks like this
patch needs to fold the following fix:

diff --git a/kernel/memremap.c b/kernel/memremap.c
index f277bf5b8c57..157a3756e1d5 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -382,6 +382,7 @@ void *devm_memremap_pages(struct device *dev,
struct resource *res,
        if (altmap) {
                memcpy(&page_map->altmap, altmap, sizeof(*altmap));
                pgmap->altmap = &page_map->altmap;
+               altmap = pgmap->altmap;
        }
        pgmap->ref = ref;
        pgmap->res = &page_map->res;
