Return-Path: <BATV+e70a4c9cfe7deb4f1558+2171+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4AEC6B7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 23:14:11 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249199437.12047.11.camel@pasglop>
References: <1249069310.20192.220.camel@macbook.infradead.org>
	<1249079105.1509.95.camel@pasglop>
	<1249113285.20192.961.camel@macbook.infradead.org>
	<1249113656.1509.125.camel@pasglop>
	<1249117220.20192.1083.camel@macbook.infradead.org>
	<1249199437.12047.11.camel@pasglop>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 14:14:04 +0100
Message-Id: <1249305244.15714.3.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-08-02 at 17:50 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2009-08-01 at 10:00 +0100, David Woodhouse wrote:
> > I'm not sure. Losing 16MiB on a machine which only has 512MiB anyway
> > doesn't seem ideal, and we'll want to make the no-iommu code DTRT
> > _anyway_, surely?
> >
> > So we might as well let the DART keep its existing logic (which is
> > only
> > to bother if we have more than 1GiB of RAM; 
> 
> Ah right, so when do we enable the DART ? Above 1G ? I though it was
> above 2G but we may well have moved that down to 1G just for b43 indeed.

void __init alloc_dart_table(void)
{
        /* Only reserve DART space if machine has more than 1GB of RAM
         * or if requested with iommu=on on cmdline.
         *
         * 1GB of RAM is picked as limit because some default devices
         * (i.e. Airport Extreme) have 30 bit address range limits.
         */

        if (iommu_is_off)
                return;

        if (!iommu_force_on && lmb_end_of_DRAM() <= 0x40000000ull)
                return;


> I definitely agree on the fix to the mask so it only compares to the
> available RAM. I'll check that in when I'm back from the snow fields 
> on tuesday :-)

I see one potential failure mode with this. You need:
 - No IOMMU
 - Crappy devices
 - Hotpluggable memory
 - Boot with only "low" memory, and allow a pci_set_dma_mask() to
   succeed because you don't have that much memory anyway.
 - Hotplug some "high" memory that the crappy device can't reach.

Do we care about that scenario? I think we might be able to "fix" it by
setting the memory_limit when we allow pci_set_dma_mask() to succeed?
That will effectively prevent the addition of memory that our crappy
device can't reach, won't it?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
