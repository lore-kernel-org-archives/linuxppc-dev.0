Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 2BB8C67F92
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2005 01:07:02 +1000 (EST)
Message-ID: <4308988C.1050804@icarus.com>
Date: Sun, 21 Aug 2005 08:06:52 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
References: <4305F7FE.7040709@icarus.com> <1124499963.5197.99.camel@gaston>
	<4307536E.4070800@icarus.com> <20050820180825.GG2736@tuxdriver.com>
In-Reply-To: <20050820180825.GG2736@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to map memory uncached on PPC.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John W. Linville wrote:
> On Sat, Aug 20, 2005 at 08:59:42AM -0700, Stephen Williams wrote:

>>I did an even simpler experiment: I commented out the pci_map_single,
>>which on a PPC only has the effect of calling invalidate_dcache_range
>>and returning the virt_to_bus of the address. Obviously, the cache
>>is still enabled for the processor, and the image data may get
>>corrupted, but this was a performance test, not a solution.
> 
> 
> If your purpose is to evaluate performance, doesn't having the cache
> enabled limit the usefulness of your test?  For example if your cache
> uses a write-back policy then your test will probably outperform the
> actual uncached accesses.  YMMV, I suppose...

No, it shouldn't. The setup is a driver for a PCI device that masters
its output to the buffer in question. What I'm measuring is not the
time to write the buffer (which is being done by the hardware, so
bypasses the cache anyhow) but the time it takes to *prepare the
buffer for the device*. The buffer is not written to or read from
by device or processor during this time, but it is mapped and DMA
pointers are collected. Also, the pci_map_single invalidates the cache
by walking through the entire buffer (many megabytes) with this loop
from invalidate_dcache_range:

1:	dcbi	0,r3
	addi	r3,r3,L1_CACHE_LINE_SIZE
	bdnz	1b
	sync				/* wait for dcbi's to get to ram */

This is what I believe is taking a long time.

Since nothing is touching that buffer during my test, and I'm mostly
dropping that code, I believe my test is valid.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
