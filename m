Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: carsteno@de.ibm.com
Subject: Re: [Cbe-oss-dev] [patch 3/5] cell: updated driver for DDR2 memory on
	AXON
Date: Tue, 26 Jun 2007 19:38:06 +0200
References: <OF39A5D2DB.6FC50A30-ONC1257306.0051B925-C1257306.0052040B@de.ibm.com>
	<200706261821.06516.arnd@arndb.de> <46815286.1010808@de.ibm.com>
In-Reply-To: <46815286.1010808@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706261938.07112.arnd@arndb.de>
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 26 June 2007, Carsten Otte wrote:
> 
> Arnd Bergmann wrote:
> > What will actually happen if you try to mount an axonram device with ext2?
> > I suppose mount should fail with a proper error code if the block size is
> > larger than 4kb, but does that happen?
> > 
> > If you have a 4k block size axonram device, the ext2 really should work
> > using XIP as expected, including the mmap() operation.
> > 
> Absolutely. What's the symptom if you try mount -o xip? I am willing 
> to fix any bugs that show in the ext2/xip code in that scenario...

The real problem is that the ->direct_access function is supposed to return
a kernel virtual address in the linear mapping, which does not make any
sense for axonram. The physical address of the underlying device is
outside of the kernel mapping, and gets mapped into the kernel virtual
space using ioremap, with flags to disallow caching.

If ->direct_access returns a physical address, the file system cannot
access the data through the kernel mapping, but if it returns the
ioremapped address, it cannot know what address to map into the
user page tables, because virt_to_page() is not defined for the
ioremap space.

Maximchose to return the physical address, which is what he needs in
his file system, but that's just not how the interface was designed
to be used.

One way to change fix the problem might be to give a flag to the
->direct_access function to ask for either the page frame number,
or the virtual address (from ioremap or the linear mapping).
It's rather ugly though, so if you have a better idea, let us
know.

Another problem is that the mmap, or no_page, function really
needs to know about the pgprot value it should use. If we add
a field to struct block_device for this, the drivers could set
it there.

	Arnd <><
