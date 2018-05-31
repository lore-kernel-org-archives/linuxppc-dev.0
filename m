Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xCsl19RpzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 13:40:42 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4V3ecAB010564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 23:40:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ja6q74u14-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 23:40:39 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 31 May 2018 04:39:32 +0100
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
To: Ram Pai <linuxram@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Cc: robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 09:09:24 +0530
MIME-Version: 1.0
In-Reply-To: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2018 12:51 PM, Ram Pai wrote:
> On Wed, May 23, 2018 at 09:50:02PM +0300, Michael S. Tsirkin wrote:
>> subj: s/virito/virtio/
>>
> ..snip..
>>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>>> +
>>> +bool platform_forces_virtio_dma(struct virtio_device *vdev)
>>> +{
>>> +	/*
>>> +	 * On protected guest platforms, force virtio core to use DMA
>>> +	 * MAP API for all virtio devices. But there can also be some
>>> +	 * exceptions for individual devices like virtio balloon.
>>> +	 */
>>> +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
>>> +}
>>
>> Isn't this kind of slow?  vring_use_dma_api is on
>> data path and supposed to be very fast.
> 
> Yes it is slow and not ideal. This won't be the final code. The final
> code will cache the information in some global variable and used
> in this function.

Right this will be a simple check based on a global variable.
