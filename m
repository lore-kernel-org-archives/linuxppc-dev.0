Return-Path: <BATV+2e2b7d69833f9a8d01a8+5461+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41khJp0c48zF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 01:24:25 +1000 (AEST)
Date: Mon, 6 Aug 2018 08:24:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, robh@kernel.org,
 srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806152406.GA29020@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
 <20180806163440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806163440-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2018 at 04:36:43PM +0300, Michael S. Tsirkin wrote:
> On Mon, Aug 06, 2018 at 02:32:28PM +0530, Anshuman Khandual wrote:
> > On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> > > On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
> > >> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
> > >>>>>> Please go through these patches and review whether this approach broadly
> > >>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
> > >>>>>> the patches or the approach in general. Thank you.
> > >>>>>
> > >>>>> Jason did some work on profiling this. Unfortunately he reports
> > >>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
> > >>>>
> > >>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
> > >>>> guest and measure PPS on tap on host.
> > >>>>
> > >>>> Thanks
> > >>>
> > >>> Could you supply host configuration involved please?
> > >>
> > >> I wonder how much of that could be caused by Spectre mitigations
> > >> blowing up indirect function calls...
> > >>
> > >> Cheers,
> > >> Ben.
> > > 
> > > I won't be surprised. If yes I suggested a way to mitigate the overhead.
> > 
> > Did we get better results (lower regression due to indirect calls) with
> > the suggested mitigation ? Just curious.
> 
> I'm referring to this:
> 	I wonder whether we can support map_sg and friends being NULL, then use
> 	that when mapping is an identity. A conditional branch there is likely
> 	very cheap.
> 
> I don't think anyone tried implementing this yes.

I've done something very similar in the thread I posted a few years
ago. I plan to get a version of that upstream for 4.20, but it won't
cover the virtio case, just the real direct mapping.
