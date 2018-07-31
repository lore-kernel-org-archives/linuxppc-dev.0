Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fnQJ2fXLzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 17:00:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6V6xFDl019702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 03:00:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjhf5u8ax-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 03:00:37 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 31 Jul 2018 08:00:35 +0100
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To: Christoph Hellwig <hch@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <20180730092551.GB26245@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, aik@ozlabs.ru,
 jasowang@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2018 12:30:19 +0530
MIME-Version: 1.0
In-Reply-To: <20180730092551.GB26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <1e197586-4e11-48e1-a0dd-c2c440c64f9e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2018 02:55 PM, Christoph Hellwig wrote:
>> +const struct dma_map_ops virtio_direct_dma_ops;
> 
> This belongs into a header if it is non-static.  If you only
> use it in this file anyway please mark it static and avoid a forward
> declaration.

Sure, will make it static, move the definition up in the file to avoid
forward declaration.
 
> 
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (virtio_has_iommu_quirk(dev))
>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> 
> This needs a big fat comment explaining what is going on here.

Sure, will do. Also talk about the XEN domain exception as well once
that goes into this conditional statement.

> 
> Also not new, but I find the existance of virtio_has_iommu_quirk and its
> name horribly confusing.  It might be better to open code it here once
> only a single caller is left.

Sure will do. There is one definition in the tools directory which can
be removed and then this will be the only one left.
