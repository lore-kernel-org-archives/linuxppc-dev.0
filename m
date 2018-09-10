Return-Path: <BATV+0880c9c3d9be8b33d28f+5496+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427z000gc6zDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 16:38:39 +1000 (AEST)
Date: Sun, 9 Sep 2018 23:19:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jiandi An <jiandi@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com,
 thomas.lendacky@amd.com, brijesh.singh@amd.com, jiandi.an@amd.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180910061947.GA30666@infradead.org>
References: <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
 <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2018 at 07:09:09PM -0500, Jiandi An wrote:
> For virtio device we have to pass in iommu_platform=true flag for
> this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
> QEMU has the use of iommu_platform attribute disabled for virtio-gpu
> device.  So would also like to move towards not having to specify
> the VIRTIO_F_IOMMU_PLATFORM flag.

Specifying VIRTIO_F_IOMMU_PLATFORM is the right thing for your 
platform given that you can't directly use physical addresses.
Please fix qemu so that virtio-gpu works with VIRTIO_F_IOMMU_PLATFORM.

Also just as I said for the power folks: you should really work with
the qemu folks that VIRTIO_F_IOMMU_PLATFORM (or whatever we call the
properly documented flag) can be set by default, and no pointless
performance overhead is implied by having a sane and simple
implementation.
