Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 90D82DE2CE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 04:31:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Fri, 18 Jul 2008 17:39:10 +0200
References: <18503022.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com>
In-Reply-To: <18525063.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807181739.10268.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 18 July 2008, Misbah khan wrote:

> Now my concern is How can i map SDRAM one to one to circular buffer of such
> a huge size ???? 

As I mentioned, use vmalloc to get the memory, and provide an mmap function
that uses remap_vmalloc_range to put it into the user address space.

> My idea is that i will ioreamp SDRAM and do memcpy_toio() when ever i am
> writing to the the circular buffer which is dma allocated and pages are set
> reserved . and read the frame from user space .

ioremap and memcpy_toio style accesses only make sense for stuff that is
*not* your main memory. Memory is alrady directly accessible in the kernel
after allocating with get_free_pages, kmalloc or vmalloc. No need to
play with __iomem pointers for this.

	Arnd <><
