Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: New DCR access methods
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061016081748.GA11677@lst.de>
References: <1160984698.22522.60.camel@localhost.localdomain>
	<20061016081748.GA11677@lst.de>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 18:21:52 +1000
Message-Id: <1160986912.22522.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +#ifdef CONFIG_PPC_DCR_NATIVE
> > +#include <asm/dcr-native.h>
> > +#else
> > +#include <asm/dcr-mmio.h>
> > +#endif
> 
> Having this as a compile-time switch seems broken.  I thought the plan was
> to support all different 64bit kernels with a single kernel binary?

"native" DCRs only exist in 32 bits 4xx / BookE processors as of today.

Basically, those processors have mtdcr and mfdcr instructions to access
those special "registers". They are in fact connected to a bus to
control various IOs. On AXON (and possibly other future chips), since
the host processor doesn't have those instructions, they are memory
mapped.

There is currently no way you can have both in the same kernel. If that
ever happens, then the "mmio" version could easily be tweaked to deal
with both. However, the "native only" implementation is useful for
embedded 4xx etc... as it resolves directly to mfdcr/mtdcr instructions,
dcr_map is an empty macro, etc... thus there is 0 overhead of switching
4xx code to the new dcr accessors.

Ben.
