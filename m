Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D7141A1D73
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:40:53 +1000 (AEST)
Date: Thu, 13 Aug 2015 16:33:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Dan Williams <dan.j.williams@intel.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>,
 Michal Simek <monstr@monstr.eu>, the arch/x86 maintainers <x86@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>, grundler@parisc-linux.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-metag@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for
 page-less SG entries
Message-ID: <20150813143325.GB17183@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
 <1439363150-8661-32-git-send-email-hch@lst.de>
 <CA+55aFxfZM81HNfo2ysfhGwrhx6GX-+F--+jLFmMVv+Z0id2rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFxfZM81HNfo2ysfhGwrhx6GX-+F--+jLFmMVv+Z0id2rw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 09:05:15AM -0700, Linus Torvalds wrote:
> [ Again, I'm responding to one random patch - this pattern was in
> other patches too.  ]
> 
> A question: do we actually expect to mix page-less and pageful SG
> entries in the same SG list?
> 
> How does that happen?

Both for DAX and the video buffer case people could do direct I/O
spanning the boundary between such a VMA and a normal one unless
we add special code to prevent that.  Right now I don't think it's
all that useful, but then again it doesn't seem harmful either
and adding those checks might add up.
