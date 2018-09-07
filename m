Return-Path: <Jiandi.An@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0084.outbound.protection.outlook.com [104.47.36.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425yVL3XkGzF3SK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 10:09:27 +1000 (AEST)
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To: Christoph Hellwig <hch@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com,
 thomas.lendacky@amd.com, brijesh.singh@amd.com, jiandi.an@amd.com
References: <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
 <20180809054013.GA20507@infradead.org>
From: Jiandi An <jiandi@amd.com>
Message-ID: <f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
Date: Thu, 6 Sep 2018 19:09:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180809054013.GA20507@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/09/2018 12:40 AM, Christoph Hellwig wrote:
> On Thu, Aug 09, 2018 at 08:13:32AM +1000, Benjamin Herrenschmidt wrote:
>>>> -	if (xen_domain())
>>>> +	if (xen_domain() || pseries_secure_vm())
>>>> 		return true;
>>>
>>> I don't think it's pseries specific actually. E.g. I suspect AMD SEV
>>> might benefit from the same kind of hack.
>>
>> As long as they can provide the same guarantee that the DMA ops are
>> completely equivalent between virtio and other PCI devices, at least on
>> the same bus, ie, we don't have to go hack special DMA ops.
>>
>> I think the latter is really what Christoph wants to avoid for good
>> reasons.
> 
> Yes.  I also generally want to avoid too much arch specific magic.
> 
> FYI, I'm off to a week-long vacation today, don't expect quick replies.
> 
> 
> 

I've been following this RFC series as this has impact on AMD SEV.
Could you guys keep us in the loop on this (thomas.lendacky@amd.com,
brijesh.singh@amd.com, jiandi.an@amd.com are on cc).

AMD SEV today sets swiotlb_force to SWIOTLB_FORCE early on in
x86_64_start_kernel.  During start_kernel, mem_encrypt_init() sets
dma_ops to swiotlb_dma_ops if SEV is on as it uses SWIOTLB to bounce
buffer DMA operation and it's marked as decrypted.

For virtio device we have to pass in iommu_platform=true flag for
this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
QEMU has the use of iommu_platform attribute disabled for virtio-gpu
device.  So would also like to move towards not having to specify
the VIRTIO_F_IOMMU_PLATFORM flag.

Anshuman's patch [RFC,2/4] virtio: Override device's DMA OPS with
virtio_direct_dma_ops selectively sets the default dma ops of
virtio device's parent pci to direct_dma_ops if VIRTIO_F_IOMMU_PLATFORM
is set.  And later platform specific code can override the dma ops again.

 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@  int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;

Would like to be in the loop and put in the platform specific code for
AMD SEV at the same time along with this.  Or does it make sense that if
swiotlb force is set don't override virtio device's parent dma_ops to
direct_dma_ops?  What if someone passes in swiotlb=force from kernel
boot command line parameter, this would override the parent pci device's
dma ops to direct_dma_ops.

So where is this RFC standing currently.  I saw Michael's comment mentioning
this RFC is blocked by its performance overhead for now for switching to
using DMA ops unconditionally.

-Jiandi
