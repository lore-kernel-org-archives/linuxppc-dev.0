Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B01B51007D7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 19:35:51 +1000 (EST)
Subject: Re: [PATCH 12/13] kvm/powerpc: Accelerate H_PUT_TCE by
	implementing it in real mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <E483EC5C-5F4A-4783-88D2-1728BD902037@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104615.GM2837@brick.ozlabs.ibm.com>
	<E9A07C6B-00BC-490F-95E7-5B025A626C98@suse.de>
	<1305623510.2781.20.camel@pasglop>
	<E483EC5C-5F4A-4783-88D2-1728BD902037@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 May 2011 19:35:45 +1000
Message-ID: <1305624945.2781.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-17 at 11:31 +0200, Alexander Graf wrote:
> On 17.05.2011, at 11:11, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2011-05-17 at 10:01 +0200, Alexander Graf wrote:
> >> I'm not sure I fully understand how this is supposed to work. If the
> >> tables are kept inside the kernel, how does userspace get to know
> >> where to DMA to?
> > 
> > The guest gets a dma range from the device-tree which is the range of
> > device-side dma addresses it can use that correspond to the table.
> > 
> > The guest kernel uses the normal linux iommu space allocator to allocate
> > space in that region and uses H_PUT_TCE to populate the corresponding
> > table entries.
> > 
> > This is the same interface that is used for "real" iommu's with PCI
> > devices btw.
> 
> I'm still slightly puzzled here :). IIUC the main point of an IOMMU is for the kernel
> to change where device accesses actually go to. So device DMAs address A, goes through
> the IOMMU, in reality accesses address B.

Right :-)

> Now, how do we tell the devices implemented in qemu that they're supposed to DMA to
> address B instead of A if the mapping table is kept in-kernel?

Oh, bcs qemu mmaps the table :-)

Cheers,
Ben.
