Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9D88067B76
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 19:51:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Discontiguous Memory
Date: Sat, 16 Sep 2006 11:51:40 +0200
References: <6332580.post@talk.nabble.com>
	<1158368179.14473.203.camel@localhost.localdomain>
In-Reply-To: <1158368179.14473.203.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609161151.41294.arnd@arndb.de>
Cc: jbahr <jbahr@set-software-services.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 16 September 2006 02:56 schrieb Benjamin Herrenschmidt:
> =A0- A more annoying one is support for DMA since a lot of devices cannot
> DMA above 32 bits. A lot of 'sane' platforms that provide more memory
> than can be DMA'ed in 32 bits also provide an IOMMU that does page
> translation of incoming DMAs. This isn't your case however, thus you
> would have to implement some of the alternate solutions used on x86_64
> (Intel 64 bits platforms also lack an iommu). This essentially consist
> of defining a ZONE_DMA32 and possibly also using swiotlb to do bounce
> buffering for drivers that don't deal with ZONE_DMA32 yet.

On 32 bit platforms, you normally have ZONE_NORMAL for up to 4G and
ZONE_HIGHMEM beyond, so you don't need an extra ZONE_DMA32.

	Arnd <><
