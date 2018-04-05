Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HG0f0QVnzF1yR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 07:18:57 +1000 (AEST)
Message-ID: <1522963113.21446.211.camel@kernel.crashing.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, aik@ozlabs.ru,
 jasowang@redhat.com, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Date: Fri, 06 Apr 2018 07:18:33 +1000
In-Reply-To: <20180405213042-mutt-send-email-mst@kernel.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> > In this specific case, because that would make qemu expect an iommu,
> > and there isn't one.
> 
> 
> I think that you can set iommu_platform in qemu without an iommu.

No I mean the platform has one but it's not desirable for it to be used
due to the performance hit.

Cheers,
Ben.
> 
> > Anshuman, you need to provide more background here. I don't have time
> > right now it's late, but explain about the fact that this is for a
> > specific type of secure VM which has only a limited pool of (insecure)
> > memory that can be shared with qemu, so all IOs need to bounce via that
> > pool, which can be achieved by using swiotlb.
> > 
> > Note: this isn't urgent, we can discuss alternative approaches, this is
> > just to start the conversation.
> > 
> > Cheers,
> > Ben.
