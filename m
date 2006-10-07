Return-Path: <hch@lst.de>
Date: Sat, 7 Oct 2006 10:57:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: cell spu problem state mapping updates
Message-ID: <20061007085738.GB3421@lst.de>
References: <1159506605.15792.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1159506605.15792.24.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 03:10:05PM +1000, Benjamin Herrenschmidt wrote:
> This patch adds a new "psmap" file to spufs that allows mmap of all of
> the problem state mapping of SPEs. It is compatible with 64k pages. In
> addition, it removes mmap ability of individual files when using 64k
> pages, with the exception of signal1 and signal2 which will both map the
> entire 64k page holding both registers. It also removes
> CONFIG_SPUFS_MMAP as there is no point in not building mmap support in
> spufs.
> 
> It goes along a separate patch to libspe implementing usage of that new
> file to access problem state registers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

> Index: linux-cell/arch/powerpc/platforms/cell/spufs/file.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/platforms/cell/spufs/file.c	2006-09-29 15:04:30.000000000 +1000
> +++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2006-09-29 15:04:46.000000000 +1000
> @@ -36,6 +36,8 @@
>  
>  #include "spufs.h"
>  
> +#define SPUFS_MMAP_4K (PAGE_SIZE == 0x1000)

Here and later you specifiy the page size in hexadecimal which isn't all
that readable to the casual observer.
