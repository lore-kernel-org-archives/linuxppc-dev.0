Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 3CFBB2BF41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 08:16:19 +1100 (EST)
Date: Wed, 10 Nov 2004 08:13:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Neil Wilson <NWilson@Airspan.com>
Message-ID: <20041110081327.A20590@home.com>
References: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB71@fs5.airspan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3506EDCDEC47904CBE6FD2E1DEEA8984020CFB71@fs5.airspan.com>;
	from NWilson@Airspan.com on Wed, Nov 10, 2004 at 01:58:29PM -0000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mmap64/open64/pread etc on 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 10, 2004 at 01:58:29PM -0000, Neil Wilson wrote:
> Hi,
> 
> I am trying to write a command line utility for our dev board
> (440GX,2.6.9 kernel) in order to provide support for our hardware
> engineers.  As a test I am trying to dump the first few bytes of the
> U-boot header.
> 
> I though that this would work but using /dev/mem gives me a bad address
> error on the pread64, using /dev/kmem only reads back 0 bytes.  Is there
> something blindingly obvious that I am missing for using 36bit addresses
> ? I believe the address is correct as I can see the boot code from
> within the kernel. Thanks.

No, it's not blindingly obvious at all.  First, mmaping /dev/mem is
a completely non-portable way to get at devices in userspace. It
has no guarantees of working across architectures and is broken
in many ways.

One way is on PPC440 where we have a 36-bit physical address space.
The /dev/mem implementation simply allows you to mmap an offset
within a 32-bit physical address space. On PPC440, this means you can't
get to any of the useful devices since they are all above 4GB.
In post 2.6.9, remap_pfn_range() helps a bit but there is still a
local (arch/ppc/) problem...

I'm working on some patches to fix 36-bit support for
io_remap_page_range() and to fix some problems with set_pte()
and friends on 36-bit platforms. This is the first bit necessary
to make this work at all in 2.6. I should be posting something
RSN. ;)

-Matt
