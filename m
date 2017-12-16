Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz9rK5W8XzDqRQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 13:15:45 +1100 (AEDT)
Received: by mail-oi0-x22e.google.com with SMTP id r193so5709709oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 18:15:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215140947.26075-9-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-9-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Dec 2017 18:15:43 -0800
Message-ID: <CAPcyv4i6MvJ5X8potRT2nwFDXAGHNGEooxw_vV_h2+sHoRnUSg@mail.gmail.com>
Subject: Re: [PATCH 08/17] mm: pass the vmem_altmap to memmap_init_zone
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> Pass the vmem_altmap two levels down instead of needing a lookup.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Given the fact that HMM and now P2P are attracted to
devm_memremap_pages() I think this churn is worth it. vmem_altmap is
worth being considered a first class citizen of memory hotplug and not
a hidden hack.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
