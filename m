Return-Path: <kraxel@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4281zW5HY2zF380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:53:24 +1000 (AEST)
Date: Mon, 10 Sep 2018 10:53:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jiandi An <jiandi@amd.com>, brijesh.singh@amd.com,
 srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 elfring@users.sourceforge.net,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, robh@kernel.org,
 jean-philippe.brucker@arm.com, mpe@ellerman.id.au,
 thomas.lendacky@amd.com, marc.zyngier@arm.com, linuxram@us.ibm.com,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, joe@perches.com, jiandi.an@amd.com,
 robin.murphy@arm.com, haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180910085316.yzjbvoohqhdng2vb@sirius.home.kraxel.org>
References: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
 <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
 <20180910061947.GA30666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910061947.GA30666@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
> > QEMU has the use of iommu_platform attribute disabled for virtio-gpu
> > device.  So would also like to move towards not having to specify
> > the VIRTIO_F_IOMMU_PLATFORM flag.
> 
> Specifying VIRTIO_F_IOMMU_PLATFORM is the right thing for your 
> platform given that you can't directly use physical addresses.
> Please fix qemu so that virtio-gpu works with VIRTIO_F_IOMMU_PLATFORM.

This needs both host and guest side changes btw.

Guest side patch is in drm-misc (a3b815f09bb8) and should land in the
next merge window.

Host side patches are here:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/virtio-gpu-iommu

Should also land in the next qemu version.

cheers,
  Gerd
