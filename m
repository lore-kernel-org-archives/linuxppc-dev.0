Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z09wq04YxzDrhr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 04:22:54 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id w125so9221899oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 09:22:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g_6izDX780Fqv=zx=aYrASivwYpQcNkRmZW3iSZfKQHQ@mail.gmail.com>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-5-hch@lst.de>
 <CAPcyv4g_6izDX780Fqv=zx=aYrASivwYpQcNkRmZW3iSZfKQHQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 17 Dec 2017 09:22:52 -0800
Message-ID: <CAPcyv4h2EsZO2g+YVyVVJFx_Cv3wiZH+xNj=koAux1+_uuF1UA@mail.gmail.com>
Subject: Re: [PATCH 04/17] mm: pass the vmem_altmap to arch_add_memory and
 __add_pages
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

On Fri, Dec 15, 2017 at 5:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Dec 15, 2017 at 6:09 AM, Christoph Hellwig <hch@lst.de> wrote:
>> We can just pass this on instead of having to do a radix tree lookup
>> without proper locking 2 levels into the callchain.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Yeah, the lookup of vmem_altmap is too magical and surprising this is better.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll also note that the locking is not necessary in the memory map
init path because we can't possibly be racing mutations of the radix
as everyone who might touch the radix is serialized by the
mem_hotplug_begin() lock. It's only accesses outside of the
arch_{add,remove}_memory() that need the rcu lock. However, that is
another subtle/magic assumption of this code and its better to pass
the altmap down through the call chain. I just don't want people
thinking that -stable needs to pick any of this up, because afaics the
locking is fine as is, and we can drop that mention from the
changelog.
