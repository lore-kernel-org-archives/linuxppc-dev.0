Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Lkw0Y5PzDx5w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 02:03:36 +1100 (AEDT)
Date: Tue, 19 Dec 2017 16:03:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] memremap: simplify duplicate region handling in
 devm_memremap_pages
Message-ID: <20171219150332.GB13124@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-15-hch@lst.de>
 <CAPcyv4i2naLJjWzm+q0ORRfyHkT0f5dFBFKutuaXE3OgPcHX5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAPcyv4i2naLJjWzm+q0ORRfyHkT0f5dFBFKutuaXE3OgPcHX5g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 17, 2017 at 09:34:11AM -0800, Dan Williams wrote:
> This is not racy, we'll catch the error on insert, and I think the
> extra debug information is useful for debugging a broken memory map or
> alignment math.

We can check for -ЕEXIST and print the warning, but it's a weird pattern
for sure.
