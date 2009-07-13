Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 72D85B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 00:30:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: mmap() problem in own driver
Date: Mon, 13 Jul 2009 16:30:50 +0200
References: <24457031.post@talk.nabble.com>
In-Reply-To: <24457031.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907131630.50581.arnd@arndb.de>
Cc: "Sauce.Cheng" <chmhou@sina.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 13 July 2009, Sauce.Cheng wrote:

> I want to get data from kernel space to user space indirectly using mmap()
> but i dont know how I can do , anyone can give me some advices ?
> 
> firstly, fetch data by DMA to a memory allocated by "kmalloc"
> then i want to mmap it to user space and save the data as a file 

You first need to allocate full pages, e.g. using alloc_pages() instead
of kmalloc, which may not be aligned. To get a streaming mapping on
that memory, use dma_map_single(), which returns a DMA address you 
can pass to the device.
For user space access, the easiest is to have a character device,
which uses an mmap() file operation that calls remap_pfn_range()
on the page_to_pfn(pages).

	Arnd <><
