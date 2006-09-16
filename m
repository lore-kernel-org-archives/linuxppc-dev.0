Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B086C67B8D
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2006 08:51:06 +1000 (EST)
Subject: Re: Discontiguous Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200609161151.41294.arnd@arndb.de>
References: <6332580.post@talk.nabble.com>
	<1158368179.14473.203.camel@localhost.localdomain>
	<200609161151.41294.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 08:50:47 +1000
Message-Id: <1158447047.14473.230.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jbahr <jbahr@set-software-services.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-09-16 at 11:51 +0200, Arnd Bergmann wrote:
> Am Saturday 16 September 2006 02:56 schrieb Benjamin Herrenschmidt:
> >  - A more annoying one is support for DMA since a lot of devices cannot
> > DMA above 32 bits. A lot of 'sane' platforms that provide more memory
> > than can be DMA'ed in 32 bits also provide an IOMMU that does page
> > translation of incoming DMAs. This isn't your case however, thus you
> > would have to implement some of the alternate solutions used on x86_64
> > (Intel 64 bits platforms also lack an iommu). This essentially consist
> > of defining a ZONE_DMA32 and possibly also using swiotlb to do bounce
> > buffering for drivers that don't deal with ZONE_DMA32 yet.
> 
> On 32 bit platforms, you normally have ZONE_NORMAL for up to 4G and
> ZONE_HIGHMEM beyond, so you don't need an extra ZONE_DMA32.

No, in fact, it's even worse :) Your example works only on platforms
that can do 4G/4G split. On ppc32, currently, we don't (though we could
with some freescale BookE and their new instructions to load/store cross
AS), thus we have a 3G/1G split, which limits ZONE_NORMAL to about
768Mb.

So ZONE_HIGHEMEM is actually most of your memory. But you -can- DMA from
highmem and can't have memory be both HIGHMEM and ZONE_DMA32 (though I
suppose devices requesting ZONE_DMA32 will hit ZONE_NORMAL). It's a
mess...

Ben.
