Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02E961A0410
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 10:40:25 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 17:40:24 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E516F3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 17:40:21 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9RNcwM362914626
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:38:58 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RNeKUA007321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 17:40:21 -0600
Date: Tue, 27 Oct 2015 16:40:19 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: David Miller <davem@davemloft.net>, willy@linux.intel.com,
 keith.busch@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, david@gibson.dropbear.id.au,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151027234018.GA48779@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.10.2015 [09:57:48 +1100], Julian Calaby wrote:
> Hi Nishanth,
> 
> On Wed, Oct 28, 2015 at 9:20 AM, Nishanth Aravamudan
> <nacc@linux.vnet.ibm.com> wrote:
> > On 26.10.2015 [18:27:46 -0700], David Miller wrote:
> >> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> >> Date: Fri, 23 Oct 2015 13:54:20 -0700
> >>
> >> > 1) add a generic dma_get_page_shift implementation that just returns
> >> > PAGE_SHIFT
> >>
> >> I won't object to this patch series, but if I had implemented this I
> >> would have required the architectures to implement this explicitly,
> >> one-by-one.  I think it is less error prone and more likely to end
> >> up with all the architectures setting this correctly.
> >
> > Well, looks like I should spin up a v4 anyways for the powerpc changes.
> > So, to make sure I understand your point, should I make the generic
> > dma_get_page_shift a compile-error kind of thing? It will only fail on
> > architectures that actually build the NVME driver (as the only caller).
> > But I'm not sure how exactly to achieve that, if you could give a bit
> > more detail I'd appreciate it!
> 
> He's suggesting that you _don't_ put a generic implementation in
> /include/linux/dma-mapping.h and instead add it to _every_
> architecture.

Ah, I see! Well, I don't know much about the DMA internals of most
architectures -- and my approach kept things functionally the same
everywhere (using PAGE_SHIFT) except:

a) Power, where I know it doesn't work as-is
and
b) sparc, where the code implied that a different value than PAGE_SHIFT
should be used.

Thanks,
Nish
