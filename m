Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jhNz31rBzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 10:24:35 +1000 (AEST)
Date: Sun, 5 Aug 2018 03:24:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jason Wang <jasowang@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 mpe@ellerman.id.au, hch@infradead.org, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180805032355-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
> > > > > Please go through these patches and review whether this approach broadly
> > > > > makes sense. I will appreciate suggestions, inputs, comments regarding
> > > > > the patches or the approach in general. Thank you.
> > > > 
> > > > Jason did some work on profiling this. Unfortunately he reports
> > > > about 4% extra overhead from this switch on x86 with no vIOMMU.
> > > 
> > > The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
> > > guest and measure PPS on tap on host.
> > > 
> > > Thanks
> > 
> > Could you supply host configuration involved please?
> 
> I wonder how much of that could be caused by Spectre mitigations
> blowing up indirect function calls...
> 
> Cheers,
> Ben.

I won't be surprised. If yes I suggested a way to mitigate the overhead.

-- 
MSR 
