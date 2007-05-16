Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 07105DDED0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 07:42:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Slab allocators: Define common size limitations
Date: Wed, 16 May 2007 23:42:07 +0200
References: <Pine.LNX.4.64.0705152313490.5832@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705160855470.24080@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705162342.08601.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 May 2007, Geert Uytterhoeven wrote:
> What are the changes a large allocation will actually succeed?
> Is there an alignment rule for large allocations?
> 
> E.g. for one of the PS3 drivers I need a physically contiguous 256 KiB-aligned
> block of 256 KiB. Currently I'm using __alloc_bootmem() for that, but maybe
> kmalloc() becomes a suitable alternative now?

kmalloc is limited to 128KiB on most architectures. Normally there is no
need to use it anyway, just use __get_free_pages(). It will generally
succeed at early boot time, but not after the system has been running
for some time.

	Arnd <><
