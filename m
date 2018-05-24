Return-Path: <BATV+7c38cfb39597af86d9de+5387+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s1Zd33MWzF1Hj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 17:43:05 +1000 (AEST)
Date: Thu, 24 May 2018 00:17:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180524071759.GA624@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2018 at 08:27:04AM +1000, Benjamin Herrenschmidt wrote:
> - First qemu doesn't know that the guest will switch to "secure mode"
> in advance. There is no difference between a normal and a secure
> partition until the partition does the magic UV call to "enter secure
> mode" and qemu doesn't see any of it. So who can set the flag here ?
> 
> - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> vhost) go through the emulated MMIO for every access to the guest,
> which adds additional overhead.

Also this whole scheme is simply the wrong way around.  No driver should
opt out of the DMA API in general.  For legacy reasons we might have to
opt out of the dma API for some virtio cases due to qemu bugs, but
this should never have been the default, but a quirk for the affected
versions.

We need to fix this now and make the dma ops bypass the quirk instead of
the default, which will also solve the power issue.
