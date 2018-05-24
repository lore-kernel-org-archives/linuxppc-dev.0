Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s15Z1Y8PzF1QY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 17:21:21 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4O7JNfb090025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:21:19 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5rnbrpmv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:21:17 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 24 May 2018 08:21:15 +0100
Date: Thu, 24 May 2018 00:21:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, robh@kernel.org,
 aik@ozlabs.ru, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180523213703-mutt-send-email-mst@kernel.org>
Message-Id: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2018 at 09:50:02PM +0300, Michael S. Tsirkin wrote:
> subj: s/virito/virtio/
> 
..snip..
> >  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> > +
> > +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > +{
> > +	/*
> > +	 * On protected guest platforms, force virtio core to use DMA
> > +	 * MAP API for all virtio devices. But there can also be some
> > +	 * exceptions for individual devices like virtio balloon.
> > +	 */
> > +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> > +}
> 
> Isn't this kind of slow?  vring_use_dma_api is on
> data path and supposed to be very fast.

Yes it is slow and not ideal. This won't be the final code. The final
code will cache the information in some global variable and used
in this function.

However this code was added to the RFC to illustrate the idea that dma
operation are needed only in a secure/protected environment.

RP
