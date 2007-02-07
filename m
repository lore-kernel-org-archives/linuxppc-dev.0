Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] spufs: remove need for struct page for SPEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070207045055.295F3DDE46@ozlabs.org>
References: <20070207045055.295F3DDE46@ozlabs.org>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 15:55:29 +1100
Message-Id: <1170824129.2620.275.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-07 at 15:50 +1100, Benjamin Herrenschmidt wrote:
> This patch removes the need for struct page for SPE local store
> and registers from spufs. It also makes the locking much more
> obvious and no longer relying on the truncate logic black magic
> for protecting against races between unmap_mapping_range() and
> new pages faulted in. It does so by switching to a nopfn() handler
> and using the new vm_insert_pfn() to setup the PTEs itself while
> holding a lock on the SPE.
> 
> The nice thing is that this patch actually removes a lot more code
> than it adds :-)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  Kconfig                         |    2

Hrm... diffstat got screwed up by my script, should be:

 Kconfig                         |    2
 platforms/cell/spu_priv1_mmio.c |   65 +----------------------
 platforms/cell/spufs/file.c     |  111 ++++++++++++++++++----------------------
 3 files changed, 55 insertions(+), 123 deletions(-)

Ben.
