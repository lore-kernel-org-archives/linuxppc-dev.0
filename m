Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 46129DDDA2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 00:37:39 +1100 (EST)
Message-ID: <49D4BB9F.8050903@harris.com>
Date: Thu, 02 Apr 2009 09:20:31 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hjk@linutronix.de,
	"Herrera-Bendezu, Luis" <lherrera@harris.com>
Subject: Re: UIO: uio_mem does not handle devices above 4 GB address
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, Apr 01, 2009 at 01:20:49PM -0400, Herrera-Bendezu, Luis wrote:
> >> I am working on a PPC440EPx board with some FPGAs located at
> >> addresses above 4 GB

Cc'ing the PPC list, since they have the most experience with this
CPU, and may have some useful insights.  The topic is "UIO on the
PPC440EPx - 36-bit physical addresses".

The PPC440EPx uses 36-bit addressing but is a 32-bit processor.
*All* peripherals are above the first 4 GB - that cannot be changed
if you use this CPU chip.

In general, the solution is to use "struct resource" to carry physical
addresses and sizes.  The basic type is:

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

and for this processor, we use u64 rather than u32.

So, if we want to make UIO usable on this class of CPU, we might
replace:

struct uio_mem {
	unsigned long		addr;
	unsigned long		size;
	int			memtype;
	void __iomem		*internal_addr;
	struct uio_map		*map;
};

with:

struct uio_mem {
	phys_addr_t		addr;
	phys_addr_t		size;
	int			memtype;
	void __iomem		*internal_addr;
	struct uio_map		*map;
};

A few other changes would be needed.  We'd have to use something
other than

	return sprintf(buf, "0x%lx\n", mem->addr);

because the format would be incorrect for a u64.  Also, I believe
we would get warnings in uio_vma_fault().  However, the phys_addr
is really only applicable to UIO_MEM_PHYS, so perhaps we want a
union of phys_addr_t and unsigned long for addr and size?

Anyway, this is a real problem for the PPC440EPx, that board 
designers cannot work around.

	Steve
